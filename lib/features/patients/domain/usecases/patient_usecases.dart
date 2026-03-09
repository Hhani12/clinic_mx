import '../entities/patient.dart';
import '../repositories/patients_repository.dart';

class WatchPatientsUseCase {
  WatchPatientsUseCase(this._repository);
  final PatientsRepository _repository;

  Stream<List<Patient>> call(String clinicId) {
    return _repository.watchPatients(clinicId);
  }
}

class GetPatientUseCase {
  GetPatientUseCase(this._repository);
  final PatientsRepository _repository;

  Future<Patient?> call({
    required String clinicId,
    required String patientId,
  }) {
    return _repository.getPatientById(clinicId: clinicId, patientId: patientId);
  }
}

class CreatePatientUseCase {
  CreatePatientUseCase(this._repository);
  final PatientsRepository _repository;

  Future<void> call(Patient patient) => _repository.createPatient(patient);
}

class UpdatePatientUseCase {
  UpdatePatientUseCase(this._repository);
  final PatientsRepository _repository;

  Future<void> call(Patient patient) => _repository.updatePatient(patient);
}

class DeletePatientUseCase {
  DeletePatientUseCase(this._repository);
  final PatientsRepository _repository;

  Future<void> call({
    required String clinicId,
    required String patientId,
  }) {
    return _repository.deletePatient(clinicId: clinicId, patientId: patientId);
  }
}
