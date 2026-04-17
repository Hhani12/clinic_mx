import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/enums/user_role.dart';
import '../../../../core/local/local_providers.dart';
import '../../../../core/services/firebase/firebase_providers.dart';
import '../../../../core/services/firebase/firestore_service.dart';
import '../../../auth/domain/entities/app_user_profile.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/repositories/settings_local_repository_impl.dart';
import '../../data/repositories/settings_repository_impl.dart';
import '../../domain/entities/clinic.dart';
import '../../domain/entities/clinic_settings.dart';
import '../../domain/entities/staff_profile.dart';
import '../../domain/repositories/settings_repository.dart';

/// Firestore-only repository for user management (staff, roles, reactivation).
/// Used on all platforms — these operations require live Firestore access.
final _settingsFirestoreRepoProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepositoryImpl(
    firestoreService: ref.watch(firestoreServiceProvider),
    firestore: ref.watch(firestoreProvider),
  );
});

final staffProfilesProvider = StreamProvider<List<StaffProfile>>((ref) {
  final clinicId = ref.watch(currentClinicIdProvider);
  if (clinicId == null || clinicId.isEmpty) return Stream.value([]);
  return ref.watch(_settingsFirestoreRepoProvider).watchStaffProfiles(clinicId);
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  if (kIsWeb) {
    return ref.watch(_settingsFirestoreRepoProvider);
  }
  return SettingsLocalRepositoryImpl(ref.watch(clinicLocalDaoProvider));
});

final clinicInfoProvider = StreamProvider<Clinic?>((ref) {
  final clinicId = ref.watch(currentClinicIdProvider);
  if (clinicId == null || clinicId.isEmpty) return Stream.value(null);
  return ref.watch(settingsRepositoryProvider).watchClinic(clinicId);
});

final clinicSettingsProvider = StreamProvider<ClinicSettings>((ref) {
  final clinicId = ref.watch(currentClinicIdProvider);
  if (clinicId == null || clinicId.isEmpty) {
    return Stream.value(ClinicSettings.fromMap(null));
  }
  return ref.watch(settingsRepositoryProvider).watchClinicSettings(clinicId);
});

final teethNumberingProvider = Provider<TeethNumberingSystem>((ref) {
  return ref.watch(clinicSettingsProvider).value?.teethNumberingSystem ??
      AppConfig.defaultTeethNumbering;
});

final toothActionsProvider = Provider<List<String>>((ref) {
  return ref.watch(clinicSettingsProvider).value?.toothActions ??
      const ['قلع', 'حشو', 'تنظيف', 'تقويم', 'عصب'];
});

/// Whether the current clinic subscription is expired
final clinicExpiredProvider = Provider<bool>((ref) {
  final clinic = ref.watch(clinicInfoProvider).valueOrNull;
  if (clinic == null) return false;
  return clinic.isExpired;
});

final clinicUsersProvider = StreamProvider<List<AppUserProfile>>((ref) {
  final clinicId = ref.watch(currentClinicIdProvider);
  if (clinicId == null || clinicId.isEmpty) return const Stream.empty();
  // Always use Firestore for user management.
  return ref.watch(_settingsFirestoreRepoProvider).watchClinicUsers(clinicId);
});

/// Notifier for user management operations
class ClinicUsersNotifier extends AutoDisposeAsyncNotifier<List<AppUserProfile>> {
  @override
  Future<List<AppUserProfile>> build() async {
    final clinicId = ref.watch(currentClinicIdProvider);
    if (clinicId == null || clinicId.isEmpty) return [];

    // Return empty list initially, stream will update
    return [];
  }

  /// Create a new user in the clinic
  Future<void> createUser({
    required String email,
    required String password,
    required String displayName,
    required UserRole role,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final clinicId = ref.read(currentClinicIdProvider);
      if (clinicId == null) throw Exception('No clinic ID');

      // Create user with Firebase Auth
      final auth = ref.read(firebaseAuthProvider);
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create user profile in Firestore
      final firestore = ref.read(firestoreProvider);
      final profile = AppUserProfile(
        uid: userCredential.user!.uid,
        clinicId: clinicId,
        email: email,
        displayName: displayName,
        role: role,
        isActive: true,
        createdAt: DateTime.now(),
      );

      await firestore.collection('users').doc(userCredential.user!.uid).set(
        profile.toMap(),
      );

      return state.value ?? [];
    });
  }

  /// Update an existing user
  Future<void> updateUser(
    String userId, {
    String? displayName,
    UserRole? role,
    bool? isActive,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final firestore = ref.read(firestoreProvider);
      final updates = <String, dynamic>{};

      if (displayName != null) updates['displayName'] = displayName;
      if (role != null) updates['role'] = role.name;
      if (isActive != null) updates['isActive'] = isActive;

      if (updates.isNotEmpty) {
        await firestore.collection('users').doc(userId).update(updates);
      }

      return state.value ?? [];
    });
  }

  /// Toggle user active status
  Future<void> toggleUserActive(String userId) async {
    final currentUser = state.value?.firstWhere(
      (u) => u.uid == userId,
      orElse: () => AppUserProfile(
        uid: '',
        clinicId: '',
        email: '',
        displayName: '',
        role: UserRole.reception,
        isActive: true,
        createdAt: DateTime.now(),
      ),
    );

    if (currentUser != null) {
      await updateUser(userId, isActive: !currentUser.isActive);
    }
  }

  /// Delete a user
  Future<void> deleteUser(String userId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final firestore = ref.read(firestoreProvider);
      // Soft delete - mark as inactive
      await firestore.collection('users').doc(userId).update({
        'isActive': false,
        'deletedAt': FieldValue.serverTimestamp(),
      });
      return state.value ?? [];
    });
  }
}

final clinicUsersProviderNotifier =
    AsyncNotifierProvider.autoDispose<ClinicUsersNotifier, List<AppUserProfile>>(
      ClinicUsersNotifier.new,
    );

class SettingsEditorController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> saveClinic({
    required String clinicId,
    required String name,
    String? phone,
    String? city,
    String? district,
    String? address,
  }) async {
    state = const AsyncLoading();
    final clinic = Clinic(
      id: clinicId,
      name: name.trim(),
      phone: _clean(phone),
      city: _clean(city),
      district: _clean(district),
      address: _clean(address),
      updatedAt: DateTime.now(),
    );

    state = await AsyncValue.guard(
      () => ref.read(settingsRepositoryProvider).saveClinic(clinic),
    );
  }

  Future<void> saveClinicSettings({
    required String clinicId,
    required ClinicSettings settings,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(settingsRepositoryProvider)
          .saveClinicSettings(clinicId: clinicId, settings: settings),
    );
  }

  Future<void> updateRole({
    required String userId,
    required String role,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(_settingsFirestoreRepoProvider)
          .updateUserRole(userId: userId, role: role),
    );
  }

  Future<void> saveStaffProfile({
    required String clinicId,
    required StaffProfile profile,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(_settingsFirestoreRepoProvider)
          .saveStaffProfile(clinicId: clinicId, profile: profile),
    );
  }

  Future<void> deleteStaffProfile({
    required String clinicId,
    required String profileId,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(_settingsFirestoreRepoProvider)
          .deleteStaffProfile(clinicId: clinicId, profileId: profileId),
    );
  }

  Future<void> reactivateClinic({
    required String clinicId,
    required String reactivatedBy,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(_settingsFirestoreRepoProvider)
          .reactivateClinic(clinicId: clinicId, reactivatedBy: reactivatedBy),
    );
  }

  static String? _clean(String? value) {
    if (value == null) return null;
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
}

final settingsEditorControllerProvider =
    AutoDisposeAsyncNotifierProvider<SettingsEditorController, void>(
      SettingsEditorController.new,
    );
