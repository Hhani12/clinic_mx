import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/services/firebase/firebase_providers.dart';
import '../../../../core/services/firebase/firestore_service.dart';
import '../../../auth/domain/entities/app_user_profile.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/repositories/settings_repository_impl.dart';
import '../../domain/entities/clinic.dart';
import '../../domain/entities/clinic_settings.dart';
import '../../domain/repositories/settings_repository.dart';

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepositoryImpl(
    firestoreService: ref.watch(firestoreServiceProvider),
    firestore: ref.watch(firestoreProvider),
  );
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

final clinicUsersProvider = StreamProvider<List<AppUserProfile>>((ref) {
  final clinicId = ref.watch(currentClinicIdProvider);
  if (clinicId == null || clinicId.isEmpty) return const Stream.empty();
  return ref.watch(settingsRepositoryProvider).watchClinicUsers(clinicId);
});

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
          .read(settingsRepositoryProvider)
          .updateUserRole(userId: userId, role: role),
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
