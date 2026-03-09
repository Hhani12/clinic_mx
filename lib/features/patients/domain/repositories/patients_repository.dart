import '../entities/patient.dart';

abstract class PatientsRepository {
  Stream<List<Patient>> watchPatients(String clinicId);
  Future<Patient?> getPatientById({
    required String clinicId,
    required String patientId,
  });
  Future<void> createPatient(Patient patient);
  Future<void> updatePatient(Patient patient);
  Future<void> deletePatient({
    required String clinicId,
    required String patientId,
  });
}
