import '../../../../core/local/daos/clinic_local_dao.dart';
import '../../../auth/domain/entities/app_user_profile.dart';
import '../../../settings/domain/entities/staff_profile.dart';
import '../../domain/entities/clinic.dart';
import '../../domain/entities/clinic_settings.dart';
import '../../domain/repositories/settings_repository.dart';

/// Local repository for Clinic + ClinicSettings.
///
/// User management methods (watchClinicUsers, updateUserRole, staffProfiles,
/// reactivateClinic) remain Firestore-only since they relate to auth/admin
/// and are not needed offline. Those methods throw [UnsupportedError] here —
/// the platform-switch provider delegates them to the Firestore impl.
class SettingsLocalRepositoryImpl implements SettingsRepository {
  final ClinicLocalDao _dao;
  SettingsLocalRepositoryImpl(this._dao);

  @override
  Stream<Clinic?> watchClinic(String clinicId) =>
      _dao.watchClinic(clinicId);

  @override
  Future<void> saveClinic(Clinic clinic) => _dao.saveClinic(clinic);

  @override
  Stream<ClinicSettings> watchClinicSettings(String clinicId) =>
      _dao.watchClinicSettings(clinicId);

  @override
  Future<void> saveClinicSettings({
    required String clinicId,
    required ClinicSettings settings,
  }) =>
      _dao.saveClinicSettings(clinicId: clinicId, settings: settings);

  // ─── Firestore-only operations (auth/admin) ───

  @override
  Stream<List<AppUserProfile>> watchClinicUsers(String clinicId) =>
      throw UnsupportedError(
          'watchClinicUsers is Firestore-only on desktop');

  @override
  Future<void> updateUserRole(
          {required String userId, required String role}) =>
      throw UnsupportedError('updateUserRole is Firestore-only on desktop');

  @override
  Future<void> reactivateClinic(
          {required String clinicId, required String reactivatedBy}) =>
      throw UnsupportedError(
          'reactivateClinic is Firestore-only on desktop');

  @override
  Stream<List<StaffProfile>> watchStaffProfiles(String clinicId) =>
      throw UnsupportedError(
          'watchStaffProfiles is Firestore-only on desktop');

  @override
  Future<void> saveStaffProfile(
          {required String clinicId, required StaffProfile profile}) =>
      throw UnsupportedError(
          'saveStaffProfile is Firestore-only on desktop');

  @override
  Future<void> deleteStaffProfile(
          {required String clinicId, required String profileId}) =>
      throw UnsupportedError(
          'deleteStaffProfile is Firestore-only on desktop');
}
