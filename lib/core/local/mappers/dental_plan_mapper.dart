import 'package:drift/drift.dart';

import '../../../features/dental/domain/entities/dental_plan_item.dart';
import '../app_database.dart';

class DentalPlanMapper {
  const DentalPlanMapper._();

  static LocalDentalPlansCompanion toCompanion(
    DentalPlanItem d, {
    bool synced = false,
  }) {
    return LocalDentalPlansCompanion.insert(
      id: d.id,
      clinicId: d.clinicId,
      patientId: d.patientId,
      toothId: d.toothId,
      numberingSystem: d.numberingSystem,
      actionLabel: d.actionLabel,
      note: d.note,
      timestamp: d.timestamp,
      doctorId: d.doctorId,
      isSynced: Value(synced),
    );
  }

  static DentalPlanItem fromRow(LocalDentalPlan row) {
    return DentalPlanItem(
      id: row.id,
      clinicId: row.clinicId,
      patientId: row.patientId,
      toothId: row.toothId,
      numberingSystem: row.numberingSystem,
      actionLabel: row.actionLabel,
      note: row.note,
      timestamp: row.timestamp,
      doctorId: row.doctorId,
    );
  }

  static Map<String, dynamic> toPayload(DentalPlanItem d) {
    return {
      'id': d.id,
      'clinicId': d.clinicId,
      'patientId': d.patientId,
      'toothId': d.toothId,
      'numberingSystem': d.numberingSystem,
      'actionLabel': d.actionLabel,
      'note': d.note,
      'timestamp': d.timestamp.toIso8601String(),
      'doctorId': d.doctorId,
    };
  }
}
