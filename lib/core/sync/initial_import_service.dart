import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../features/appointments/domain/entities/appointment.dart';
import '../../features/dental/domain/entities/dental_plan_item.dart';
import '../../features/dental/domain/entities/tooth_record.dart';
import '../../features/doctors/domain/entities/doctor_profile.dart';
import '../../features/patients/domain/entities/patient.dart';
import '../../features/payments/domain/entities/payment_transaction.dart';
import '../../features/settings/domain/entities/clinic.dart';
import '../../features/settings/domain/entities/clinic_settings.dart';
import '../local/app_database.dart';
import '../local/daos/appointments_local_dao.dart';
import '../local/daos/clinic_local_dao.dart';
import '../local/daos/dental_plans_local_dao.dart';
import '../local/daos/doctors_local_dao.dart';
import '../local/daos/patients_local_dao.dart';
import '../local/daos/payments_local_dao.dart';
import '../local/daos/tooth_records_local_dao.dart';
import '../services/firebase/firestore_paths.dart';

class InitialImportService {
  final AppDatabase _db;
  final FirebaseFirestore _firestore;
  final PatientsLocalDao _patientsDao;
  final AppointmentsLocalDao _appointmentsDao;
  final DoctorsLocalDao _doctorsDao;
  final PaymentsLocalDao _paymentsDao;
  final ToothRecordsLocalDao _toothRecordsDao;
  final DentalPlansLocalDao _dentalPlansDao;
  final ClinicLocalDao _clinicDao;

  InitialImportService(
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

  /// Imports all data if this is the first run (no SyncMeta entries).
  Future<void> importIfNeeded(String clinicId) async {
    final meta = await _db.select(_db.syncMeta).get();
    if (meta.isNotEmpty) return; // Already imported.

    debugPrint('Starting initial import for clinic $clinicId...');
    final now = DateTime.now();

    await _importClinicDoc(clinicId);
    await _importClinicSettings(clinicId);
    await _importCollection(
      clinicId: clinicId,
      collection: FirestorePaths.patients,
      fromDoc: (id, data) => Patient.fromMap(id: id, map: data),
      upsert: _patientsDao.upsertFromRemote,
    );
    await _importCollection(
      clinicId: clinicId,
      collection: FirestorePaths.appointments,
      fromDoc: (id, data) => Appointment.fromMap(id: id, map: data),
      upsert: _appointmentsDao.upsertFromRemote,
    );
    await _importCollection(
      clinicId: clinicId,
      collection: FirestorePaths.doctors,
      fromDoc: (id, data) => DoctorProfile.fromMap(id: id, map: data),
      upsert: _doctorsDao.upsertFromRemote,
    );
    await _importCollection(
      clinicId: clinicId,
      collection: FirestorePaths.payments,
      fromDoc: (id, data) =>
          PaymentTransaction.fromMap(id: id, map: data),
      upsert: _paymentsDao.upsertFromRemote,
    );
    await _importCollection(
      clinicId: clinicId,
      collection: FirestorePaths.toothRecords,
      fromDoc: (id, data) => ToothRecord.fromMap(data),
      upsert: (record) =>
          _toothRecordsDao.upsertFromRemote(record, clinicId),
    );
    await _importCollection(
      clinicId: clinicId,
      collection: FirestorePaths.dentalPlans,
      fromDoc: (id, data) => DentalPlanItem.fromMap(id: id, map: data),
      upsert: _dentalPlansDao.upsertFromRemote,
    );

    // Mark all collections as imported.
    for (final col in [
      'patients', 'appointments', 'doctors', 'payments',
      'toothRecords', 'dentalPlans', 'clinic', 'clinicSettings',
    ]) {
      await _db.into(_db.syncMeta).insertOnConflictUpdate(
            SyncMetaCompanion.insert(collectionName: col, lastPullAt: now),
          );
    }

    debugPrint('Initial import complete.');
  }

  Future<void> _importCollection<T>({
    required String clinicId,
    required String collection,
    required T Function(String id, Map<String, dynamic> data) fromDoc,
    required Future<void> Function(T entity) upsert,
  }) async {
    try {
      final snap = await _firestore
          .collection(FirestorePaths.clinics)
          .doc(clinicId)
          .collection(collection)
          .get();

      for (final doc in snap.docs) {
        try {
          final entity = fromDoc(doc.id, doc.data());
          await upsert(entity);
        } catch (e) {
          debugPrint('Import error on $collection/${doc.id}: $e');
        }
      }

      debugPrint('Imported ${snap.docs.length} $collection');
    } on FirebaseException catch (e) {
      debugPrint('Import failed for $collection: ${e.code}');
    }
  }

  Future<void> _importClinicDoc(String clinicId) async {
    try {
      final doc = await _firestore
          .collection(FirestorePaths.clinics)
          .doc(clinicId)
          .get();
      if (doc.exists && doc.data() != null) {
        final clinic = Clinic.fromMap(id: doc.id, map: doc.data()!);
        await _clinicDao.upsertClinicFromRemote(clinic);
      }
    } catch (e) {
      debugPrint('Import clinic doc failed: $e');
    }
  }

  Future<void> _importClinicSettings(String clinicId) async {
    try {
      final doc = await _firestore
          .collection(FirestorePaths.clinics)
          .doc(clinicId)
          .collection(FirestorePaths.settingsCollection)
          .doc(FirestorePaths.settingsDoc)
          .get();
      final settings = ClinicSettings.fromMap(doc.data());
      await _clinicDao.upsertSettingsFromRemote(clinicId, settings);
    } catch (e) {
      debugPrint('Import clinic settings failed: $e');
    }
  }
}
