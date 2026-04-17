import '../../../../core/local/daos/doctors_local_dao.dart';
import '../../domain/entities/doctor_profile.dart';
import '../../domain/repositories/doctors_repository.dart';

class DoctorsLocalRepositoryImpl implements DoctorsRepository {
  final DoctorsLocalDao _dao;
  DoctorsLocalRepositoryImpl(this._dao);

  @override
  Stream<List<DoctorProfile>> watchClinicDoctors(String clinicId) =>
      _dao.watchClinicDoctors(clinicId);

  @override
  Future<void> upsertDoctor(DoctorProfile doctor) =>
      _dao.upsertDoctor(doctor);

  @override
  Future<void> deleteDoctor({
    required String clinicId,
    required String doctorId,
  }) =>
      _dao.deleteDoctor(clinicId: clinicId, doctorId: doctorId);
}
