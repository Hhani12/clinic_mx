import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import '../local/tables.dart';
import '../services/firebase/firebase_providers.dart';
import '../services/firebase/firestore_paths.dart';

/// Sync operation types
enum SyncOperation {
  create,
  update,
  delete,
}

/// Sync status for local entities
enum SyncStatus {
  synced,
  pending,
  conflicting,
  failed,
}

/// Represents a pending mutation in the sync queue
class SyncMutation {
  final String entityType;
  final String entityId;
  final SyncOperation operation;
  final Map<String, dynamic> payload;
  final DateTime createdAt;
  final int retryCount;

  SyncMutation({
    required this.entityType,
    required this.entityId,
    required this.operation,
    required this.payload,
    required this.createdAt,
    this.retryCount = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'entityType': entityType,
      'entityId': entityId,
      'operation': operation.name,
      'payload': payload,
      'createdAt': createdAt.toIso8601String(),
      'retryCount': retryCount,
    };
  }

  factory SyncMutation.fromMap(Map<String, dynamic> map) {
    return SyncMutation(
      entityType: map['entityType'] as String,
      entityId: map['entityId'] as String,
      operation: SyncOperation.values.firstWhere(
        (e) => e.name == map['operation'],
        orElse: () => SyncOperation.update,
      ),
      payload: Map<String, dynamic>.from(map['payload'] as Map),
      createdAt: DateTime.parse(map['createdAt'] as String),
      retryCount: map['retryCount'] as int? ?? 0,
    );
  }
}

/// Sync engine for offline-first data synchronization
///
/// Manages local Drift database and syncs with Firebase Firestore
class SyncEngine {
  SyncEngine({
    required AppDatabase database,
    required FirebaseFirestore firestore,
  }) : _database = database,
       _firestore = firestore {
    _startConnectivityListener();
  }

  final AppDatabase _database;
  final FirebaseFirestore _firestore;
  bool _isOnline = true;
  Timer? _syncTimer;

  /// Check current connectivity status
  Future<bool> checkConnectivity() async {
    try {
      final results = await Connectivity().checkConnectivity();
      return results.any((r) => r != ConnectivityResult.none);
    } catch (e) {
      debugPrint('Connectivity check failed: $e');
      return false;
    }
  }

  /// Start listening to connectivity changes
  void _startConnectivityListener() {
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      final wasOnline = _isOnline;
      _isOnline = result != ConnectivityResult.none;

      debugPrint('Connectivity changed: ${_isOnline ? 'online' : 'offline'}');

      // Start sync when coming back online
      if (_isOnline && !wasOnline) {
        _processSyncQueue();
      }
    });
  }

  /// Add a mutation to the sync queue
  Future<void> enqueueMutation({
    required String entityType,
    required String entityId,
    required SyncOperation operation,
    required Map<String, dynamic> payload,
  }) async {
    await (await _database).into(_database.syncQueue).insert(
      SyncQueueCompanion.insert(
        entityType: entityType,
        entityId: entityId,
        operation: operation.name,
        payload: jsonEncode(payload),
      ),
    );

    debugPrint('Enqueued $operation $entityType/$entityId');

    // Try to sync immediately if online
    if (_isOnline) {
      _processSyncQueue();
    }
  }

  /// Process all pending mutations in the sync queue
  Future<void> _processSyncQueue() async {
    if (!_isOnline) {
      debugPrint('Sync skipped: offline');
      return;
    }

    final queue = await (await _database).select(_database.syncQueue).get();
    if (queue.isEmpty) {
      debugPrint('Sync queue empty');
      return;
    }

    debugPrint('Processing ${queue.length} mutations');

    for (final item in queue) {
      await _processMutation(item);
    }
  }

  /// Process a single mutation from the queue
  Future<void> _processMutation(SyncQueue item) async {
    final mutation = SyncMutation.fromMap({
      'entityType': item.entityType,
      'entityId': item.entityId,
      'operation': item.operation,
      'payload': jsonDecode(item.payload) as Map<String, dynamic>,
      'retryCount': item.retryCount,
    });

    try {
      final collectionPath = _getCollectionPath(mutation.entityType);
      final docRef = _firestore.collection(collectionPath).doc(mutation.entityId);

      switch (mutation.operation) {
        case SyncOperation.create:
          await docRef.set(mutation.payload);
          break;
        case SyncOperation.update:
          await docRef.update(mutation.payload);
          break;
        case SyncOperation.delete:
          await docRef.delete();
          break;
      }

      // Success - remove from queue
      await (await _database).delete(_database.syncQueue)
        ..where((t) => t.id.equals(item.id));

      debugPrint('Synced ${mutation.operation} ${mutation.entityType}/${mutation.entityId}');
    } catch (e) {
      debugPrint('Sync failed for ${mutation.entityType}/${mutation.entityId}: $e');

      // Increment retry count
      final newRetryCount = mutation.retryCount + 1;
      if (newRetryCount >= 5) {
        // Max retries reached - mark as failed
        await (await _database).delete(_database.syncQueue)
          ..where((t) => t.id.equals(item.id));
        debugPrint('Max retries reached, marking as failed');
      } else {
        // Update retry count
        await (await _database).update(_database.syncQueue)(
          (o) => SyncQueueCompanion(
            retryCount: Value(newRetryCount),
          ),
        );
      }
    }
  }

  /// Get Firestore collection path for entity type
  String _getCollectionPath(String entityType) {
    switch (entityType) {
      case 'patient':
        return FirestorePaths.patients;
      case 'appointment':
        return FirestorePaths.appointments;
      case 'doctor':
        return FirestorePaths.doctors;
      case 'payment':
        return FirestorePaths.payments;
      case 'dentalPlan':
        return FirestorePaths.dentalPlans;
      case 'toothRecord':
        return FirestorePaths.toothRecords;
      default:
        throw ArgumentError('Unknown entity type: $entityType');
    }
  }

  /// Pull latest changes from Firestore for a specific entity type
  Future<void> pullChanges({
    required String clinicId,
    required String entityType,
    required DateTime lastSyncTime,
  }) async {
    if (!_isOnline) return;

    try {
      final collectionPath = _getCollectionPath(entityType);
      final query = _firestore
          .collection(FirestorePaths.clinics)
          .doc(clinicId)
          .collection(collectionPath)
          .where('updatedAt', isGreaterThan: Timestamp.fromDate(lastSyncTime));

      final snapshot = await query.get();

      for (final doc in snapshot.docs) {
        // Update local cache with latest data
        await _updateLocalCache(entityType, doc.id, doc.data());
      }

      debugPrint('Pulled ${snapshot.docs.length} $entityType changes');
    } catch (e) {
      debugPrint('Pull failed for $entityType: $e');
    }
  }

  /// Update local Drift cache with Firestore data
  Future<void> _updateLocalCache(
    String entityType,
    String entityId,
    Map<String, dynamic> data,
  ) async {
    final db = await _database;

    switch (entityType) {
      case 'patient':
        await (db).into(db.localPatients).insertOnConflictUpdate(
          LocalPatientsCompanion(
            id: Value(entityId),
            // Add other fields as needed
            syncStatus: Value('synced'),
            lastSyncedAt: Value(DateTime.now().millisecondsSinceEpoch),
          ),
        );
        break;
      case 'appointment':
        await (db).into(db.localAppointments).insertOnConflictUpdate(
          LocalAppointmentsCompanion(
            id: Value(entityId),
            syncStatus: Value('synced'),
            lastSyncedAt: Value(DateTime.now().millisecondsSinceEpoch),
          ),
        );
        break;
      // Add other entity types as needed
    }
  }

  /// Start periodic sync timer
  void startPeriodicSync({Duration interval = const Duration(minutes: 5)}) {
    _syncTimer?.cancel();
    _syncTimer = Timer.periodic(interval, (_) {
      if (_isOnline) {
        _processSyncQueue();
      }
    });
    debugPrint('Periodic sync started with interval: ${interval.inMinutes} min');
  }

  /// Stop periodic sync
  void stopPeriodicSync() {
    _syncTimer?.cancel();
    _syncTimer = null;
  }

  /// Get sync status
  Future<SyncStatusInfo> getSyncStatus() async {
    final queue = await (await _database).select(_database.syncQueue).get();
    final lastSyncMeta = await (await _database)
        .select(_database.syncMeta)
        .where((t) => t.key.equals('last_sync_time'))
        .getSingleOrNull();

    return SyncStatusInfo(
      isOnline: _isOnline,
      pendingMutations: queue.length,
      lastSyncTime: lastSyncMeta != null
          ? DateTime.fromMillisecondsSinceEpoch(int.parse(lastSyncMeta.value))
          : null,
    );
  }

  /// Dispose resources
  void dispose() {
    _syncTimer?.cancel();
  }
}

/// Sync status information
class SyncStatusInfo {
  final bool isOnline;
  final int pendingMutations;
  final DateTime? lastSyncTime;

  SyncStatusInfo({
    required this.isOnline,
    required this.pendingMutations,
    this.lastSyncTime,
  });

  bool get hasUnsyncedChanges => pendingMutations > 0;
  bool get isSynced => isOnline && pendingMutations == 0;
}
