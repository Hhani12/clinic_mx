import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/app_user_profile.dart';
import '../providers/auth_providers.dart';

class AuthController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> signIn({required String email, required String password}) async {
    // Root Admin Bypass for the requested credentials
    if (email == 'hhanii20032@gmail.com' && password == 'Hhani12@') {
      ref.read(devAdminLoggedInProvider.notifier).state = true;
      return;
    }

    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(authRepositoryProvider)
          .signInWithEmailPassword(email: email, password: password),
    );
  }

  Future<void> signUp({
    required String email,
    required String password,
    required AppUserProfile profile,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(authRepositoryProvider)
          .signUpWithEmailPassword(
            email: email,
            password: password,
            profile: profile,
          ),
    );
  }

  Future<void> resetPassword(String email) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(authRepositoryProvider).sendPasswordResetEmail(email),
    );
  }

  Future<void> signOut() async {
    ref.read(devAdminLoggedInProvider.notifier).state = false;
    await ref.read(authRepositoryProvider).signOut();
  }
}

final authControllerProvider = AsyncNotifierProvider<AuthController, void>(
  AuthController.new,
);
