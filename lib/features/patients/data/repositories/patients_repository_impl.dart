import '../../domain/entities/patient.dart';
import '../../domain/repositories/patients_repository.dart';
import '../datasources/patients_remote_data_source.dart';

class PatientsRepositoryImpl implements PatientsRepository {
  PatientsRepositoryImpl(this._remoteDataSource);

  final PatientsRemoteDataSource _remoteDataSource;

  @override
  Stream<List<Patient>> watchPatients(String clinicId) {
    return _remoteDataSource.watchPatients(clinicId);
  }

  @override
  Future<Patient?> getPatientById({
    required String clinicId,
    required String patientId,
  }) {
    return _remoteDataSource.getPatientById(
      clinicId: clinicId,
      patientId: patientId,
    );
  }

  @override
  Future<void> createPatient(Patient patient) {
    return _remoteDataSource.createPatient(patient);
  }

  @override
  Future<void> updatePatient(Patient patient) {
    return _remoteDataSource.updatePatient(patient);
  }

  @override
  Future<void> deletePatient({
    required String clinicId,
    required String patientId,
  }) {
    return _remoteDataSource.deletePatient(
      clinicId: clinicId,
      patientId: patientId,
    );
  }
}
