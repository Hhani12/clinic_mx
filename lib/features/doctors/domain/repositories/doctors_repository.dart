import '../entities/doctor_profile.dart';

abstract class DoctorsRepository {
  Stream<List<DoctorProfile>> watchClinicDoctors(String clinicId);

  Future<void> upsertDoctor(DoctorProfile doctor);

  Future<void> deleteDoctor({
    required String clinicId,
    required String doctorId,
  });
}
