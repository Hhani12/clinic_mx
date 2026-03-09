import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/services/firebase/firestore_paths.dart';
import '../../../../core/services/firebase/firestore_service.dart';
import '../../domain/entities/patient.dart';

class PatientsRemoteDataSource {
  PatientsRemoteDataSource(this._firestoreService);

  final FirestoreService _firestoreService;

  Stream<List<Patient>> watchPatients(String clinicId) {
    return _firestoreService
        .clinicCollection(clinicId, FirestorePaths.patients)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Patient.fromMap(id: doc.id, map: doc.data()))
              .toList(),
        )
        .handleError((Object error) {
          if (error is FirebaseException) {
            throw AppException.fromFirebase(error);
          }
          throw error;
        });
  }

  Future<Patient?> getPatientById({
    required String clinicId,
    required String patientId,
  }) async {
    try {
      final snapshot = await _firestoreService
          .clinicCollection(clinicId, FirestorePaths.patients)
          .doc(patientId)
          .get();
      if (!snapshot.exists || snapshot.data() == null) {
        return null;
      }
      return Patient.fromMap(id: snapshot.id, map: snapshot.data()!);
    } on FirebaseException catch (e) {
      throw AppException.fromFirebase(e);
    }
  }

  Future<void> createPatient(Patient patient) async {
    try {
      await _firestoreService
          .clinicCollection(patient.clinicId, FirestorePaths.patients)
          .doc(patient.id)
          .set(patient.toMap());
    } on FirebaseException catch (e) {
      throw AppException.fromFirebase(e);
    }
  }

  Future<void> updatePatient(Patient patient) async {
    try {
      await _firestoreService
          .clinicCollection(patient.clinicId, FirestorePaths.patients)
          .doc(patient.id)
          .update(patient.toMap());
    } on FirebaseException catch (e) {
      throw AppException.fromFirebase(e);
    }
  }

  Future<void> deletePatient({
    required String clinicId,
    required String patientId,
  }) async {
    try {
      await _firestoreService
          .clinicCollection(clinicId, FirestorePaths.patients)
          .doc(patientId)
          .delete();
    } on FirebaseException catch (e) {
      throw AppException.fromFirebase(e);
    }
  }
}
