import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../features/dental/domain/entities/tooth_record.dart';
import '../app_database.dart';
import '../mappers/tooth_record_mapper.dart';

class ToothRecordsLocalDao {
  final AppDatabase _db;
  ToothRecordsLocalDao(this._db);

  Stream<List<ToothRecord>> watchPatientTeeth({
    required String clinicId,
    required String patientId,
  }) {
    return (_db.select(_db.localToothRecords)
          ..where((t) =>
              t.clinicId.equals(clinicId) &
              t.patientId.equals(patientId)))
        .watch()
        .map((rows) => rows.map(ToothRecordMapper.fromRow).toList());
  }

  Future<ToothRecord?> getToothRecord({
    required String clinicId,
    required String patientId,
    required String toothId,
  }) async {
    final docId = '${patientId}_$toothId';
    final row = await (_db.select(_db.localToothRecords)
          ..where((t) => t.docId.equals(docId)))
        .getSingleOrNull();
    return row == null ? null : ToothRecordMapper.fromRow(row);
  }

  Future<void> saveToothRecord({
    required String clinicId,
    required ToothRecord record,
  }) async {
    await _db.transaction(() async {
      await _db.into(_db.localToothRecords).insertOnConflictUpdate(
            ToothRecordMapper.toCompanion(record,
                clinicId: clinicId, synced: false),
          );
      await _db.into(_db.syncQueue).insert(SyncQueueCompanion.insert(
            targetTable: 'toothRecords',
            recordId: record.docId,
            operation: 'update',
            payload: jsonEncode({
              ...ToothRecordMapper.toPayload(record),
              'clinicId': clinicId,
            }),
            createdAt: DateTime.now(),
          ));
    });
  }

  Future<void> deleteProcedure({
    required String clinicId,
    required String patientId,
    required String toothId,
    required String procedureId,
  }) async {
    final docId = '${patientId}_$toothId';
    await _db.transaction(() async {
      final row = await (_db.select(_db.localToothRecords)
            ..where((t) => t.docId.equals(docId)))
          .getSingleOrNull();
      if (row == null) return;

      final record = ToothRecordMapper.fromRow(row);
      final updatedProcedures =
          record.procedures.where((p) => p.id != procedureId).toList();

      final newStatus = updatedProcedures.isEmpty
          ? 'healthy'
          : ToothRecord.statusFromAction(updatedProcedures.last.actionLabel);

      final updated = record.copyWith(
        procedures: updatedProcedures,
        status: newStatus,
        updatedAt: DateTime.now(),
      );

      await _db.into(_db.localToothRecords).insertOnConflictUpdate(
            ToothRecordMapper.toCompanion(updated,
                clinicId: clinicId, synced: false),
          );
      await _db.into(_db.syncQueue).insert(SyncQueueCompanion.insert(
            targetTable: 'toothRecords',
            recordId: docId,
            operation: 'update',
            payload: jsonEncode({
              ...ToothRecordMapper.toPayload(updated),
              'clinicId': clinicId,
            }),
            createdAt: DateTime.now(),
          ));
    });
  }

  Future<void> upsertFromRemote(
      ToothRecord record, String clinicId) async {
    await _db.into(_db.localToothRecords).insertOnConflictUpdate(
          ToothRecordMapper.toCompanion(record,
              clinicId: clinicId, synced: true),
        );
  }

  Future<void> deleteFromRemote(String docId) async {
    await (_db.delete(_db.localToothRecords)
          ..where((t) => t.docId.equals(docId)))
        .go();
  }

  Future<bool> isLocalPending(String docId) async {
    final row = await (_db.select(_db.localToothRecords)
          ..where((t) => t.docId.equals(docId)))
        .getSingleOrNull();
    return row != null && !row.isSynced;
  }

  Future<void> markSynced(String docId) async {
    await (_db.update(_db.localToothRecords)
          ..where((t) => t.docId.equals(docId)))
        .write(
            const LocalToothRecordsCompanion(isSynced: Value(true)));
  }
}
