import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/services/firebase/firestore_paths.dart';
import '../../../../core/services/firebase/firestore_service.dart';
import '../../domain/entities/appointment.dart';
import '../../domain/repositories/appointments_repository.dart';

class AppointmentsRepositoryImpl implements AppointmentsRepository {
  AppointmentsRepositoryImpl(this._firestoreService);

  final FirestoreService _firestoreService;

  @override
  Stream<List<Appointment>> watchAppointmentsInRange({
    required String clinicId,
    required DateTime from,
    required DateTime to,
  }) {
    return _firestoreService
        .clinicCollection(clinicId, FirestorePaths.appointments)
        .where('startAt', isGreaterThanOrEqualTo: Timestamp.fromDate(from))
        .where('startAt', isLessThanOrEqualTo: Timestamp.fromDate(to))
        .orderBy('startAt')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => Appointment.fromMap(id: doc.id, map: doc.data()))
              .toList();
        })
        .handleError((Object error) {
          if (error is FirebaseException) {
            throw AppException.fromFirebase(error);
          }
          throw error;
        });
  }

  @override
  Stream<List<Appointment>> watchTodayAppointments(String clinicId) {
    final now = DateTime.now();
    final from = DateTime(now.year, now.month, now.day);
    final to = from.add(const Duration(days: 1)).subtract(
          const Duration(milliseconds: 1),
        );
    return watchAppointmentsInRange(clinicId: clinicId, from: from, to: to);
  }

  @override
  Future<void> upsertAppointment(Appointment appointment) async {
    try {
      await _firestoreService
          .clinicCollection(appointment.clinicId, FirestorePaths.appointments)
          .doc(appointment.id)
          .set(appointment.toMap());
    } on FirebaseException catch (e) {
      throw AppException.fromFirebase(e);
    }
  }

  @override
  Future<void> updateStatus({
    required String clinicId,
    required String appointmentId,
    required String status,
  }) async {
    try {
      await _firestoreService
          .clinicCollection(clinicId, FirestorePaths.appointments)
          .doc(appointmentId)
          .update({
        'status': status,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      throw AppException.fromFirebase(e);
    }
  }

  @override
  Future<void> deleteAppointment({
    required String clinicId,
    required String appointmentId,
  }) async {
    try {
      await _firestoreService
          .clinicCollection(clinicId, FirestorePaths.appointments)
          .doc(appointmentId)
          .delete();
    } on FirebaseException catch (e) {
      throw AppException.fromFirebase(e);
    }
  }
}
