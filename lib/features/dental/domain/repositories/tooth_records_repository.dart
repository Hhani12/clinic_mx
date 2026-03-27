import '../entities/tooth_record.dart';

abstract class ToothRecordsRepository {
  /// Watch all tooth records for a patient
  Stream<List<ToothRecord>> watchPatientTeeth({
    required String clinicId,
    required String patientId,
  });

  /// Get a single tooth record
  Future<ToothRecord?> getToothRecord({
    required String clinicId,
    required String patientId,
    required String toothId,
  });

  /// Save/update a tooth record (upsert)
  Future<void> saveToothRecord({
    required String clinicId,
    required ToothRecord record,
  });

  /// Delete a single procedure from a tooth record
  Future<void> deleteProcedure({
    required String clinicId,
    required String patientId,
    required String toothId,
    required String procedureId,
  });
}
