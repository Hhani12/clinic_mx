import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../services/firebase/firebase_providers.dart';
import '../services/firebase/firestore_paths.dart';

/// Audit log entry for tracking all data changes
class AuditLogEntry {
  final String id;
  final String clinicId;
  final String action; // 'create', 'update', 'delete'
  final String entityType; // 'patient', 'appointment', 'payment', etc.
  final String entityId;
  final Map<String, dynamic> changes; // {before, after}
  final String performedBy; // user uid
  final String performedByName; // user display name
  final DateTime timestamp;

  AuditLogEntry({
    required this.id,
    required this.clinicId,
    required this.action,
    required this.entityType,
    required this.entityId,
    required this.changes,
    required this.performedBy,
    required this.performedByName,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clinicId': clinicId,
      'action': action,
      'entityType': entityType,
      'entityId': entityId,
      'changes': changes,
      'performedBy': performedBy,
      'performedByName': performedByName,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }

  factory AuditLogEntry.fromMap(Map<String, dynamic> map) {
    return AuditLogEntry(
      id: map['id'] as String,
      clinicId: map['clinicId'] as String,
      action: map['action'] as String,
      entityType: map['entityType'] as String,
      entityId: map['entityId'] as String,
      changes: Map<String, dynamic>.from(map['changes'] as Map),
      performedBy: map['performedBy'] as String,
      performedByName: map['performedByName'] as String,
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }
}

/// Service for logging and retrieving audit trail entries
class AuditLogService {
  AuditLogService({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  /// Log an audit entry
  ///
  /// Call this method whenever a create/update/delete operation occurs
  Future<void> log({
    required String clinicId,
    required String action,
    required String entityType,
    required String entityId,
    Map<String, dynamic>? before,
    Map<String, dynamic>? after,
    required String performedBy,
    required String performedByName,
  }) async {
    try {
      final entry = AuditLogEntry(
        id: _firestore.collection('auditLogs').doc().id,
        clinicId: clinicId,
        action: action,
        entityType: entityType,
        entityId: entityId,
        changes: {
          if (before != null) 'before': before,
          if (after != null) 'after': after,
        },
        performedBy: performedBy,
        performedByName: performedByName,
        timestamp: DateTime.now(),
      );

      await _firestore
          .collection(FirestorePaths.clinics)
          .doc(clinicId)
          .collection('auditLogs')
          .doc(entry.id)
          .set(entry.toMap());

      debugPrint('Audit log: $action $entityType/$entityId by $performedByName');
    } catch (e) {
      debugPrint('Failed to log audit entry: $e');
      // Don't throw - audit logging should not block main operation
    }
  }

  /// Log a create operation
  Future<void> logCreate({
    required String clinicId,
    required String entityType,
    required String entityId,
    required Map<String, dynamic> data,
    required String performedBy,
    required String performedByName,
  }) {
    return log(
      clinicId: clinicId,
      action: 'create',
      entityType: entityType,
      entityId: entityId,
      after: data,
      performedBy: performedBy,
      performedByName: performedByName,
    );
  }

  /// Log an update operation with before/after diff
  Future<void> logUpdate({
    required String clinicId,
    required String entityType,
    required String entityId,
    required Map<String, dynamic> before,
    required Map<String, dynamic> after,
    required String performedBy,
    required String performedByName,
  }) {
    // Calculate diff
    final changes = _calculateDiff(before, after);
    if (changes.isEmpty) return; // No changes to log

    return log(
      clinicId: clinicId,
      action: 'update',
      entityType: entityType,
      entityId: entityId,
      before: before,
      after: after,
      performedBy: performedBy,
      performedByName: performedByName,
    );
  }

  /// Log a delete operation
  Future<void> logDelete({
    required String clinicId,
    required String entityType,
    required String entityId,
    required Map<String, dynamic> data,
    required String performedBy,
    required String performedByName,
  }) {
    return log(
      clinicId: clinicId,
      action: 'delete',
      entityType: entityType,
      entityId: entityId,
      before: data,
      performedBy: performedBy,
      performedByName: performedByName,
    );
  }

  /// Get audit logs for a clinic with optional filters
  Stream<List<AuditLogEntry>> getLogs({
    required String clinicId,
    String? entityType,
    String? action,
    DateTime? startDate,
    DateTime? endDate,
    int limit = 50,
  }) {
    Query query = _firestore
        .collection(FirestorePaths.clinics)
        .doc(clinicId)
        .collection('auditLogs')
        .orderBy('timestamp', descending: true)
        .limit(limit);

    if (entityType != null) {
      query = query.where('entityType', isEqualTo: entityType);
    }

    if (action != null) {
      query = query.where('action', isEqualTo: action);
    }

    if (startDate != null) {
      query = query.where('timestamp',
          isGreaterThanOrEqualTo: Timestamp.fromDate(startDate));
    }

    if (endDate != null) {
      query = query.where('timestamp',
          isLessThanOrEqualTo: Timestamp.fromDate(endDate));
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => AuditLogEntry.fromMap(doc.data()))
          .toList();
    });
  }

  /// Calculate diff between two maps
  Map<String, dynamic> _calculateDiff(
      Map<String, dynamic> before, Map<String, dynamic> after) {
    final diff = <String, dynamic>{};

    for (final entry in after.entries) {
      final beforeValue = before[entry.key];
      if (beforeValue != entry.value) {
        diff[entry.key] = {
          'old': beforeValue,
          'new': entry.value,
        };
      }
    }

    // Check for removed fields
    for (final entry in before.entries) {
      if (!after.containsKey(entry.key)) {
        diff[entry.key] = {
          'old': entry.value,
          'new': null,
        };
      }
    }

    return diff;
  }
}
