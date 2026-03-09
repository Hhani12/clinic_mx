import '../entities/dental_plan_item.dart';

abstract class DentalRepository {
  Stream<List<DentalPlanItem>> watchPatientItems({
    required String clinicId,
    required String patientId,
  });

  Future<void> saveItems(List<DentalPlanItem> items);
}
