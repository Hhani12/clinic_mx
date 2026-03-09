import 'package:firebase_auth/firebase_auth.dart';

import '../entities/app_user_profile.dart';

abstract class AuthRepository {
  User? get currentUser;

  Stream<User?> authStateChanges();
  Stream<AppUserProfile?> watchCurrentUserProfile();

  Future<void> signInWithEmailPassword({
    required String email,
    required String password,
  });

  Future<void> signUpWithEmailPassword({
    required String email,
    required String password,
    required AppUserProfile profile,
  });

  Future<void> sendPasswordResetEmail(String email);
  Future<void> signOut();
}
