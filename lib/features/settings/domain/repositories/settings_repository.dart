import '../../../auth/domain/entities/app_user_profile.dart';
import '../entities/clinic.dart';
import '../entities/clinic_settings.dart';
import '../entities/staff_profile.dart';

abstract class SettingsRepository {
  Stream<Clinic?> watchClinic(String clinicId);
  Future<void> saveClinic(Clinic clinic);

  Stream<ClinicSettings> watchClinicSettings(String clinicId);
  Future<void> saveClinicSettings({
    required String clinicId,
    required ClinicSettings settings,
  });

  Stream<List<AppUserProfile>> watchClinicUsers(String clinicId);
  Future<void> updateUserRole({required String userId, required String role});

  Future<void> reactivateClinic({
    required String clinicId,
    required String reactivatedBy,
  });

  Stream<List<StaffProfile>> watchStaffProfiles(String clinicId);
  Future<void> saveStaffProfile({
    required String clinicId,
    required StaffProfile profile,
  });
  Future<void> deleteStaffProfile({
    required String clinicId,
    required String profileId,
  });
}
