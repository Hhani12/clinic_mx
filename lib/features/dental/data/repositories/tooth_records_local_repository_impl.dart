import '../../../../core/local/daos/tooth_records_local_dao.dart';
import '../../domain/entities/tooth_record.dart';
import '../../domain/repositories/tooth_records_repository.dart';

class ToothRecordsLocalRepositoryImpl implements ToothRecordsRepository {
  final ToothRecordsLocalDao _dao;
  ToothRecordsLocalRepositoryImpl(this._dao);

  @override
  Stream<List<ToothRecord>> watchPatientTeeth({
    required String clinicId,
    required String patientId,
  }) =>
      _dao.watchPatientTeeth(clinicId: clinicId, patientId: patientId);

  @override
  Future<ToothRecord?> getToothRecord({
    required String clinicId,
    required String patientId,
    required String toothId,
  }) =>
      _dao.getToothRecord(
          clinicId: clinicId, patientId: patientId, toothId: toothId);

  @override
  Future<void> saveToothRecord({
    required String clinicId,
    required ToothRecord record,
  }) =>
      _dao.saveToothRecord(clinicId: clinicId, record: record);

  @override
  Future<void> deleteProcedure({
    required String clinicId,
    required String patientId,
    required String toothId,
    required String procedureId,
  }) =>
      _dao.deleteProcedure(
        clinicId: clinicId,
        patientId: patientId,
        toothId: toothId,
        procedureId: procedureId,
      );
}
