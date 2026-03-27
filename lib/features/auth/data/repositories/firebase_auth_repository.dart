import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/services/firebase/firestore_paths.dart';
import '../../domain/entities/app_user_profile.dart';
import '../../domain/repositories/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  }) : _auth = auth,
       _firestore = firestore;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  @override
  User? get currentUser => _auth.currentUser;

  @override
  Stream<User?> authStateChanges() => _auth.authStateChanges();

  @override
  Stream<AppUserProfile?> watchCurrentUserProfile() async* {
    await for (final user in _auth.authStateChanges()) {
      if (user == null) {
        yield null;
        continue;
      }

      yield* _firestore
          .collection(FirestorePaths.users)
          .doc(user.uid)
          .snapshots()
          .map((snapshot) {
            if (!snapshot.exists || snapshot.data() == null) {
              return null;
            }
            return AppUserProfile.fromMap(snapshot.data()!);
          })
          .handleError((Object error) {
            if (error is FirebaseException) {
              throw AppException.fromFirebase(error);
            }
            throw error;
          });
    }
  }

  @override
  Future<void> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw AppException.fromAuth(e);
    }
  }

  @override
  Future<void> signUpWithEmailPassword({
    required String email,
    required String password,
    required AppUserProfile profile,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        final uid = userCredential.user!.uid;
        final batch = _firestore.batch();

        // Create user profile
        batch.set(
          _firestore.collection(FirestorePaths.users).doc(uid),
          profile.copyWith(uid: uid).toMap(),
        );

        // Create clinic document with 1-year expiry if it doesn't exist
        final clinicRef = _firestore
            .collection(FirestorePaths.clinics)
            .doc(profile.clinicId);
        final clinicSnap = await clinicRef.get();
        if (!clinicSnap.exists) {
          final now = DateTime.now();
          final expiresAt = DateTime(now.year + 1, now.month, now.day);
          batch.set(clinicRef, {
            'id': profile.clinicId,
            'name': profile.clinicId,
            'createdAt': Timestamp.fromDate(now),
            'expiresAt': Timestamp.fromDate(expiresAt),
            'active': true,
            'reactivationHistory': [],
            'updatedAt': Timestamp.fromDate(now),
          });
        }

        await batch.commit();
      }
    } on FirebaseAuthException catch (e) {
      throw AppException.fromAuth(e);
    } on FirebaseException catch (e) {
      throw AppException.fromFirebase(e);
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw AppException.fromAuth(e);
    }
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
