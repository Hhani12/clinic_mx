import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/config/env_config.dart';
import '../../../../core/services/session_manager.dart';
import '../../domain/entities/app_user_profile.dart';
import '../providers/auth_providers.dart';

class AuthController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  /// Sign in with email and password
  ///
  /// Supports:
  /// - Root admin bypass for development
  /// - Session creation with "Remember Me" option
  /// - Automatic session extension on successful login
  Future<void> signIn({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    // Root Admin Bypass (configured in .env file)
    if (EnvConfig.isRootAdmin(email, password)) {
      ref.read(devAdminLoggedInProvider.notifier).state = true;
      // Create session for root admin
      await SessionManager.instance.createSession(
        email: email,
        rememberMe: rememberMe,
      );
      debugPrint('Root admin logged in: $email');
      return;
    }

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      // Sign in with Firebase Auth
      await ref
          .read(authRepositoryProvider)
          .signInWithEmailPassword(email: email, password: password);

      // Create session after successful authentication
      await SessionManager.instance.createSession(
        email: email,
        rememberMe: rememberMe,
      );

      // Extend session on activity
      await SessionManager.instance.extendSession();
    });
  }

  /// Sign up with email and password
  ///
  /// Creates a new user account and clinic
  Future<void> signUp({
    required String email,
    required String password,
    required AppUserProfile profile,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(authRepositoryProvider)
          .signUpWithEmailPassword(
            email: email,
            password: password,
            profile: profile,
          );

      // Create session after successful registration
      await SessionManager.instance.createSession(
        email: email,
        rememberMe: true, // Auto-remember for new registrations
      );
    });
  }

  /// Send password reset email
  Future<void> resetPassword(String email) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(authRepositoryProvider).sendPasswordResetEmail(email),
    );
  }

  /// Sign out and clear session
  ///
  /// Clears all session data and navigates to login page
  Future<void> signOut() async {
    ref.read(devAdminLoggedInProvider.notifier).state = false;
    await SessionManager.instance.clearSession();
    await ref.read(authRepositoryProvider).signOut();
    debugPrint('User signed out');
  }

  /// Check if user has valid session on app start
  Future<bool> restoreSession() async {
    final hasSession = await SessionManager.instance.hasValidSession();
    if (hasSession) {
      // Session exists, user will be authenticated via Firebase Auth state
      debugPrint('Restored valid session');
    }
    return hasSession;
  }

  /// Get last login email for "Remember Me" feature
  Future<String?> getLastLoginEmail() async {
    return await SessionManager.instance.getLastLoginEmail();
  }

  /// Check if "Remember Me" was previously selected
  Future<bool> shouldRememberMe() async {
    return await SessionManager.instance.shouldRememberMe();
  }
}

final authControllerProvider = AsyncNotifierProvider<AuthController, void>(
  AuthController.new,
);
