import 'dart:async';

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
import '../local/daos/appointments_local_dao.dart';
import '../local/daos/clinic_local_dao.dart';
import '../local/daos/dental_plans_local_dao.dart';
import '../local/daos/doctors_local_dao.dart';
import '../local/daos/patients_local_dao.dart';
import '../local/daos/payments_local_dao.dart';
import '../local/daos/tooth_records_local_dao.dart';
import '../services/firebase/firestore_paths.dart';

class PullService {
  final FirebaseFirestore _firestore;
  final PatientsLocalDao _patientsDao;
  final AppointmentsLocalDao _appointmentsDao;
  final DoctorsLocalDao _doctorsDao;
  final PaymentsLocalDao _paymentsDao;
  final ToothRecordsLocalDao _toothRecordsDao;
  final DentalPlansLocalDao _dentalPlansDao;
  final ClinicLocalDao _clinicDao;

  final List<StreamSubscription<dynamic>> _subs = [];

  PullService(
    this._firestore,
    this._patientsDao,
    this._appointmentsDao,
    this._doctorsDao,
    this._paymentsDao,
    this._toothRecordsDao,
    this._dentalPlansDao,
    this._clinicDao,
  );

  void startListening(String clinicId) {
    _listenCollection<Patient>(
      collection: _clinicCol(clinicId, FirestorePaths.patients),
      fromDoc: (id, data) => Patient.fromMap(id: id, map: data),
      isLocalPending: _patientsDao.isLocalPending,
      upsert: _patientsDao.upsertFromRemote,
      delete: _patientsDao.deleteFromRemote,
    );

    _listenCollection<Appointment>(
      collection: _clinicCol(clinicId, FirestorePaths.appointments),
      fromDoc: (id, data) => Appointment.fromMap(id: id, map: data),
      isLocalPending: _appointmentsDao.isLocalPending,
      upsert: _appointmentsDao.upsertFromRemote,
      delete: _appointmentsDao.deleteFromRemote,
    );

    _listenCollection<DoctorProfile>(
      collection: _clinicCol(clinicId, FirestorePaths.doctors),
      fromDoc: (id, data) => DoctorProfile.fromMap(id: id, map: data),
      isLocalPending: _doctorsDao.isLocalPending,
      upsert: _doctorsDao.upsertFromRemote,
      delete: _doctorsDao.deleteFromRemote,
    );

    _listenCollection<PaymentTransaction>(
      collection: _clinicCol(clinicId, FirestorePaths.payments),
      fromDoc: (id, data) =>
          PaymentTransaction.fromMap(id: id, map: data),
      isLocalPending: _paymentsDao.isLocalPending,
      upsert: _paymentsDao.upsertFromRemote,
      delete: _paymentsDao.deleteFromRemote,
    );

    _listenCollection<ToothRecord>(
      collection: _clinicCol(clinicId, FirestorePaths.toothRecords),
      fromDoc: (id, data) => ToothRecord.fromMap(data),
      isLocalPending: (id) => _toothRecordsDao.isLocalPending(id),
      upsert: (record) =>
          _toothRecordsDao.upsertFromRemote(record, clinicId),
      delete: _toothRecordsDao.deleteFromRemote,
      idFromDoc: (doc) => doc.id, // docId = {patientId}_{toothId}
    );

    _listenCollection<DentalPlanItem>(
      collection: _clinicCol(clinicId, FirestorePaths.dentalPlans),
      fromDoc: (id, data) => DentalPlanItem.fromMap(id: id, map: data),
      isLocalPending: _dentalPlansDao.isLocalPending,
      upsert: _dentalPlansDao.upsertFromRemote,
      delete: _dentalPlansDao.deleteFromRemote,
    );

    // Clinic document (single doc, not a collection).
    _listenClinicDoc(clinicId);
    _listenClinicSettings(clinicId);
  }

  void stopListening() {
    for (final sub in _subs) {
      sub.cancel();
    }
    _subs.clear();
  }

  CollectionReference<Map<String, dynamic>> _clinicCol(
      String clinicId, String col) {
    return _firestore
        .collection(FirestorePaths.clinics)
        .doc(clinicId)
        .collection(col);
  }

  void _listenCollection<T>({
    required CollectionReference<Map<String, dynamic>> collection,
    required T Function(String id, Map<String, dynamic> data) fromDoc,
    required Future<bool> Function(String id) isLocalPending,
    required Future<void> Function(T entity) upsert,
    required Future<void> Function(String id) delete,
    String Function(DocumentSnapshot doc)? idFromDoc,
  }) {
    final sub = collection.snapshots().listen(
      (snapshot) async {
        for (final change in snapshot.docChanges) {
          final docId = idFromDoc?.call(change.doc) ?? change.doc.id;
          try {
            if (change.type == DocumentChangeType.removed) {
              if (!await isLocalPending(docId)) {
                await delete(docId);
              }
              continue;
            }
            final data = change.doc.data();
            if (data == null) continue;
            if (await isLocalPending(docId)) continue;
            final entity = fromDoc(change.doc.id, data);
            await upsert(entity);
          } catch (e) {
            debugPrint('Pull error on ${collection.path}/$docId: $e');
          }
        }
      },
      onError: (e) =>
          debugPrint('Pull listener error on ${collection.path}: $e'),
    );
    _subs.add(sub);
  }

  void _listenClinicDoc(String clinicId) {
    final sub = _firestore
        .collection(FirestorePaths.clinics)
        .doc(clinicId)
        .snapshots()
        .listen(
      (snapshot) async {
        if (!snapshot.exists) return;
        try {
          if (await _clinicDao.isClinicPending(clinicId)) return;
          final clinic =
              Clinic.fromMap(id: snapshot.id, map: snapshot.data()!);
          await _clinicDao.upsertClinicFromRemote(clinic);
        } catch (e) {
          debugPrint('Pull error on clinic doc $clinicId: $e');
        }
      },
      onError: (e) =>
          debugPrint('Pull listener error on clinic doc: $e'),
    );
    _subs.add(sub);
  }

  void _listenClinicSettings(String clinicId) {
    final sub = _firestore
        .collection(FirestorePaths.clinics)
        .doc(clinicId)
        .collection(FirestorePaths.settingsCollection)
        .doc(FirestorePaths.settingsDoc)
        .snapshots()
        .listen(
      (snapshot) async {
        try {
          if (await _clinicDao.isSettingsPending(clinicId)) return;
          final settings = ClinicSettings.fromMap(snapshot.data());
          await _clinicDao.upsertSettingsFromRemote(clinicId, settings);
        } catch (e) {
          debugPrint('Pull error on clinic settings: $e');
        }
      },
      onError: (e) =>
          debugPrint('Pull listener error on clinic settings: $e'),
    );
    _subs.add(sub);
  }
}
