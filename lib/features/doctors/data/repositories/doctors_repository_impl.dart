import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/services/firebase/firestore_paths.dart';
import '../../../../core/services/firebase/firestore_service.dart';
import '../../domain/entities/doctor_profile.dart';
import '../../domain/repositories/doctors_repository.dart';

class DoctorsRepositoryImpl implements DoctorsRepository {
  DoctorsRepositoryImpl(this._firestoreService);

  final FirestoreService _firestoreService;

  @override
  Stream<List<DoctorProfile>> watchClinicDoctors(String clinicId) {
    return _firestoreService
        .clinicCollection(clinicId, FirestorePaths.doctors)
        .orderBy('fullName')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => DoctorProfile.fromMap(id: doc.id, map: doc.data()))
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
  Future<void> upsertDoctor(DoctorProfile doctor) async {
    try {
      await _firestoreService
          .clinicCollection(doctor.clinicId, FirestorePaths.doctors)
          .doc(doctor.id)
          .set(doctor.toMap());
    } on FirebaseException catch (e) {
      throw AppException.fromFirebase(e);
    }
  }

  @override
  Future<void> deleteDoctor({
    required String clinicId,
    required String doctorId,
  }) async {
    try {
      await _firestoreService
          .clinicCollection(clinicId, FirestorePaths.doctors)
          .doc(doctorId)
          .delete();
    } on FirebaseException catch (e) {
      throw AppException.fromFirebase(e);
    }
  }
}
