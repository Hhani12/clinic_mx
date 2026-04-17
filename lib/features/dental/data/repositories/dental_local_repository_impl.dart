import '../../../../core/local/daos/dental_plans_local_dao.dart';
import '../../domain/entities/dental_plan_item.dart';
import '../../domain/repositories/dental_repository.dart';

class DentalLocalRepositoryImpl implements DentalRepository {
  final DentalPlansLocalDao _dao;
  DentalLocalRepositoryImpl(this._dao);

  @override
  Stream<List<DentalPlanItem>> watchPatientItems({
    required String clinicId,
    required String patientId,
  }) =>
      _dao.watchPatientItems(clinicId: clinicId, patientId: patientId);

  @override
  Future<void> saveItems(List<DentalPlanItem> items) => _dao.saveItems(items);
}
