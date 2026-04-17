import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../features/dental/domain/entities/dental_plan_item.dart';
import '../app_database.dart';
import '../mappers/dental_plan_mapper.dart';

class DentalPlansLocalDao {
  final AppDatabase _db;
  DentalPlansLocalDao(this._db);

  Stream<List<DentalPlanItem>> watchPatientItems({
    required String clinicId,
    required String patientId,
  }) {
    return (_db.select(_db.localDentalPlans)
          ..where((t) =>
              t.clinicId.equals(clinicId) &
              t.patientId.equals(patientId))
          ..orderBy([(t) => OrderingTerm.desc(t.timestamp)]))
        .watch()
        .map((rows) => rows.map(DentalPlanMapper.fromRow).toList());
  }

  Future<void> saveItems(List<DentalPlanItem> items) async {
    await _db.transaction(() async {
      for (final item in items) {
        await _db.into(_db.localDentalPlans).insertOnConflictUpdate(
              DentalPlanMapper.toCompanion(item, synced: false),
            );
        await _db.into(_db.syncQueue).insert(SyncQueueCompanion.insert(
              targetTable: 'dentalPlans',
              recordId: item.id,
              operation: 'update',
              payload: jsonEncode(DentalPlanMapper.toPayload(item)),
              createdAt: DateTime.now(),
            ));
      }
    });
  }

  Future<void> upsertFromRemote(DentalPlanItem item) async {
    await _db.into(_db.localDentalPlans).insertOnConflictUpdate(
          DentalPlanMapper.toCompanion(item, synced: true),
        );
  }

  Future<void> deleteFromRemote(String itemId) async {
    await (_db.delete(_db.localDentalPlans)
          ..where((t) => t.id.equals(itemId)))
        .go();
  }

  Future<bool> isLocalPending(String recordId) async {
    final row = await (_db.select(_db.localDentalPlans)
          ..where((t) => t.id.equals(recordId)))
        .getSingleOrNull();
    return row != null && !row.isSynced;
  }

  Future<void> markSynced(String recordId) async {
    await (_db.update(_db.localDentalPlans)
          ..where((t) => t.id.equals(recordId)))
        .write(const LocalDentalPlansCompanion(isSynced: Value(true)));
  }
}
