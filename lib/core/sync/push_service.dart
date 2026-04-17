import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import '../local/app_database.dart';
import '../local/daos/appointments_local_dao.dart';
import '../local/daos/clinic_local_dao.dart';
import '../local/daos/dental_plans_local_dao.dart';
import '../local/daos/doctors_local_dao.dart';
import '../local/daos/patients_local_dao.dart';
import '../local/daos/payments_local_dao.dart';
import '../local/daos/tooth_records_local_dao.dart';
import '../services/firebase/firestore_paths.dart';

class PushService {
  final AppDatabase _db;
  final FirebaseFirestore _firestore;
  final PatientsLocalDao _patientsDao;
  final AppointmentsLocalDao _appointmentsDao;
  final DoctorsLocalDao _doctorsDao;
  final PaymentsLocalDao _paymentsDao;
  final ToothRecordsLocalDao _toothRecordsDao;
  final DentalPlansLocalDao _dentalPlansDao;
  final ClinicLocalDao _clinicDao;

  PushService(
    this._db,
    this._firestore,
    this._patientsDao,
    this._appointmentsDao,
    this._doctorsDao,
    this._paymentsDao,
    this._toothRecordsDao,
    this._dentalPlansDao,
    this._clinicDao,
  );

  /// Pushes all pending sync queue items to Firestore. Returns count pushed.
  Future<int> pushAll() async {
    final pending = await (_db.select(_db.syncQueue)
          ..orderBy([(t) => OrderingTerm.asc(t.createdAt)])
          ..limit(50))
        .get();

    if (pending.isEmpty) return 0;

    int pushed = 0;

    for (final item in pending) {
      try {
        await _pushItem(item);
        // Remove from queue on success.
        await (_db.delete(_db.syncQueue)
              ..where((t) => t.id.equals(item.id)))
            .go();
        await _markSynced(item.targetTable, item.recordId);
        pushed++;
      } on FirebaseException catch (e) {
        debugPrint(
            'Push failed ${item.targetTable}/${item.recordId}: ${e.code}');
      } catch (e) {
        debugPrint(
            'Push error ${item.targetTable}/${item.recordId}: $e');
      }
    }

    return pushed;
  }

  Future<void> _pushItem(SyncQueueData item) async {
    final payload = jsonDecode(item.payload) as Map<String, dynamic>;
    final clinicId = payload['clinicId'] as String?;

    // Resolve Firestore document reference.
    final docRef = _resolveDocRef(item.targetTable, item.recordId, clinicId);
    if (docRef == null) return;

    // Strip fields that should not go to Firestore.
    payload.remove('id');

    // Convert ISO date strings back to Firestore Timestamps.
    final firestorePayload = _convertDatesToTimestamps(payload);

    switch (item.operation) {
      case 'update' || 'create':
        await docRef.set({
          ...firestorePayload,
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      case 'delete':
        await docRef.delete();
    }
  }

  DocumentReference? _resolveDocRef(
    String targetTable,
    String recordId,
    String? clinicId,
  ) {
    if (clinicId == null || clinicId.isEmpty) return null;

    switch (targetTable) {
      case 'patients':
        return _firestore
            .collection(FirestorePaths.clinics)
            .doc(clinicId)
            .collection(FirestorePaths.patients)
            .doc(recordId);
      case 'appointments':
        return _firestore
            .collection(FirestorePaths.clinics)
            .doc(clinicId)
            .collection(FirestorePaths.appointments)
            .doc(recordId);
      case 'doctors':
        return _firestore
            .collection(FirestorePaths.clinics)
            .doc(clinicId)
            .collection(FirestorePaths.doctors)
            .doc(recordId);
      case 'payments':
        return _firestore
            .collection(FirestorePaths.clinics)
            .doc(clinicId)
            .collection(FirestorePaths.payments)
            .doc(recordId);
      case 'toothRecords':
        return _firestore
            .collection(FirestorePaths.clinics)
            .doc(clinicId)
            .collection(FirestorePaths.toothRecords)
            .doc(recordId);
      case 'dentalPlans':
        return _firestore
            .collection(FirestorePaths.clinics)
            .doc(clinicId)
            .collection(FirestorePaths.dentalPlans)
            .doc(recordId);
      case '_clinic_doc':
        return _firestore
            .collection(FirestorePaths.clinics)
            .doc(clinicId);
      case '_clinic_settings':
        return _firestore
            .collection(FirestorePaths.clinics)
            .doc(clinicId)
            .collection(FirestorePaths.settingsCollection)
            .doc(FirestorePaths.settingsDoc);
      default:
        debugPrint('Unknown sync target table: $targetTable');
        return null;
    }
  }

  Future<void> _markSynced(String targetTable, String recordId) async {
    switch (targetTable) {
      case 'patients':
        await _patientsDao.markSynced(recordId);
      case 'appointments':
        await _appointmentsDao.markSynced(recordId);
      case 'doctors':
        await _doctorsDao.markSynced(recordId);
      case 'payments':
        await _paymentsDao.markSynced(recordId);
      case 'toothRecords':
        await _toothRecordsDao.markSynced(recordId);
      case 'dentalPlans':
        await _dentalPlansDao.markSynced(recordId);
      case '_clinic_doc':
        await _clinicDao.markClinicSynced(recordId);
      case '_clinic_settings':
        await _clinicDao.markSettingsSynced(recordId);
    }
  }

  /// Convert ISO 8601 date strings in payload to Firestore Timestamps.
  Map<String, dynamic> _convertDatesToTimestamps(Map<String, dynamic> data) {
    const dateKeys = {
      'createdAt', 'updatedAt', 'dob', 'startAt', 'date',
      'timestamp', 'expiresAt', 'performedAt',
    };
    final result = <String, dynamic>{};
    for (final entry in data.entries) {
      if (dateKeys.contains(entry.key) && entry.value is String) {
        final dt = DateTime.tryParse(entry.value as String);
        result[entry.key] = dt != null ? Timestamp.fromDate(dt) : entry.value;
      } else if (entry.key == 'procedures' && entry.value is List) {
        // Convert nested procedure dates.
        result[entry.key] = (entry.value as List).map((p) {
          if (p is Map<String, dynamic>) {
            return _convertDatesToTimestamps(p);
          }
          return p;
        }).toList();
      } else if (entry.key == 'reactivationHistory' && entry.value is List) {
        result[entry.key] = (entry.value as List).map((r) {
          if (r is Map<String, dynamic>) {
            return _convertDatesToTimestamps({
              ...r,
              // These keys are date strings in reactivation records.
            });
          }
          return r;
        }).toList();
      } else {
        result[entry.key] = entry.value;
      }
    }
    return result;
  }
}
