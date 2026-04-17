import '../../../../core/local/daos/patients_local_dao.dart';
import '../../domain/entities/patient.dart';
import '../../domain/repositories/patients_repository.dart';

class PatientsLocalRepositoryImpl implements PatientsRepository {
  final PatientsLocalDao _dao;
  PatientsLocalRepositoryImpl(this._dao);

  @override
  Stream<List<Patient>> watchPatients(String clinicId) =>
      _dao.watchPatients(clinicId);

  @override
  Future<Patient?> getPatientById({
    required String clinicId,
    required String patientId,
  }) =>
      _dao.getPatientById(clinicId: clinicId, patientId: patientId);

  @override
  Future<void> createPatient(Patient patient) => _dao.upsertPatient(patient);

  @override
  Future<void> updatePatient(Patient patient) => _dao.upsertPatient(patient);

  @override
  Future<void> deletePatient({
    required String clinicId,
    required String patientId,
  }) =>
      _dao.deletePatient(clinicId: clinicId, patientId: patientId);
}
