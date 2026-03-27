import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/services/firebase/firestore_paths.dart';
import '../../../../core/services/firebase/firestore_service.dart';
import '../../../auth/domain/entities/app_user_profile.dart';
import '../../domain/entities/clinic.dart';
import '../../domain/entities/clinic_settings.dart';
import '../../domain/entities/staff_profile.dart';
import '../../domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl({
    required FirestoreService firestoreService,
    required FirebaseFirestore firestore,
  }) : _firestoreService = firestoreService,
       _firestore = firestore;

  final FirestoreService _firestoreService;
  final FirebaseFirestore _firestore;

  @override
  Stream<Clinic?> watchClinic(String clinicId) {
    return _firestoreService
        .clinicDocument(clinicId)
        .snapshots()
        .map((snapshot) {
          if (!snapshot.exists || snapshot.data() == null) return null;
          return Clinic.fromMap(id: snapshot.id, map: snapshot.data()!);
        })
        .handleError((Object error) {
          if (error is FirebaseException) {
            throw AppException.fromFirebase(error);
          }
          throw error;
        });
  }

  @override
  Future<void> saveClinic(Clinic clinic) async {
    try {
      await _firestoreService
          .clinicDocument(clinic.id)
          .set(clinic.toMap(), SetOptions(merge: true));
    } on FirebaseException catch (e) {
      throw AppException.fromFirebase(e);
    }
  }

  @override
  Stream<ClinicSettings> watchClinicSettings(String clinicId) {
    return _firestoreService
        .clinicSettingsDocument(clinicId)
        .snapshots()
        .map((snapshot) => ClinicSettings.fromMap(snapshot.data()))
        .handleError((Object error) {
          if (error is FirebaseException) {
            throw AppException.fromFirebase(error);
          }
          throw error;
        });
  }

  @override
  Future<void> saveClinicSettings({
    required String clinicId,
    required ClinicSettings settings,
  }) async {
    try {
      await _firestoreService
          .clinicSettingsDocument(clinicId)
          .set(settings.toMap(), SetOptions(merge: true));
    } on FirebaseException catch (e) {
      throw AppException.fromFirebase(e);
    }
  }

  @override
  Stream<List<AppUserProfile>> watchClinicUsers(String clinicId) {
    return _firestore
        .collection(FirestorePaths.users)
        .where('clinicId', isEqualTo: clinicId)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => AppUserProfile.fromMap(doc.data()))
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
  Future<void> updateUserRole({
    required String userId,
    required String role,
  }) async {
    try {
      await _firestore.collection(FirestorePaths.users).doc(userId).update({
        'role': role,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      throw AppException.fromFirebase(e);
    }
  }

  @override
  Future<void> reactivateClinic({
    required String clinicId,
    required String reactivatedBy,
  }) async {
    try {
      final now = DateTime.now();
      final newExpiresAt = DateTime(now.year + 1, now.month, now.day);
      await _firestoreService.clinicDocument(clinicId).update({
        'active': true,
        'expiresAt': Timestamp.fromDate(newExpiresAt),
        'updatedAt': FieldValue.serverTimestamp(),
        'reactivationHistory': FieldValue.arrayUnion([
          {
            'reactivatedAt': Timestamp.fromDate(now),
            'reactivatedBy': reactivatedBy,
            'newExpiresAt': Timestamp.fromDate(newExpiresAt),
          },
        ]),
      });
    } on FirebaseException catch (e) {
      throw AppException.fromFirebase(e);
    }
  }

  @override
  Stream<List<StaffProfile>> watchStaffProfiles(String clinicId) {
    return _firestoreService
        .clinicCollection(clinicId, 'staff')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => StaffProfile.fromMap(doc.id, doc.data()))
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
  Future<void> saveStaffProfile({
    required String clinicId,
    required StaffProfile profile,
  }) async {
    try {
      await _firestoreService
          .clinicCollection(clinicId, 'staff')
          .doc(profile.id)
          .set(profile.toMap(), SetOptions(merge: true));
    } on FirebaseException catch (e) {
      throw AppException.fromFirebase(e);
    }
  }

  @override
  Future<void> deleteStaffProfile({
    required String clinicId,
    required String profileId,
  }) async {
    try {
      await _firestoreService
          .clinicCollection(clinicId, 'staff')
          .doc(profileId)
          .delete();
    } on FirebaseException catch (e) {
      throw AppException.fromFirebase(e);
    }
  }
}
