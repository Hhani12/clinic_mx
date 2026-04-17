import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../features/patients/domain/entities/patient.dart';
import '../app_database.dart';
import '../mappers/patient_mapper.dart';

class PatientsLocalDao {
  final AppDatabase _db;
  PatientsLocalDao(this._db);

  Stream<List<Patient>> watchPatients(String clinicId) {
    return (_db.select(_db.localPatients)
          ..where((t) => t.clinicId.equals(clinicId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch()
        .map((rows) => rows.map(PatientMapper.fromRow).toList());
  }

  Future<Patient?> getPatientById({
    required String clinicId,
    required String patientId,
  }) async {
    final row = await (_db.select(_db.localPatients)
          ..where(
              (t) => t.id.equals(patientId) & t.clinicId.equals(clinicId)))
        .getSingleOrNull();
    return row == null ? null : PatientMapper.fromRow(row);
  }

  Future<void> upsertPatient(Patient patient) async {
    await _db.transaction(() async {
      await _db.into(_db.localPatients).insertOnConflictUpdate(
            PatientMapper.toCompanion(patient, synced: false),
          );
      await _db.into(_db.syncQueue).insert(SyncQueueCompanion.insert(
            targetTable: 'patients',
            recordId: patient.id,
            operation: 'update',
            payload: jsonEncode(PatientMapper.toPayload(patient)),
            createdAt: DateTime.now(),
          ));
    });
  }

  Future<void> deletePatient({
    required String clinicId,
    required String patientId,
  }) async {
    await _db.transaction(() async {
      await (_db.delete(_db.localPatients)
            ..where((t) =>
                t.id.equals(patientId) & t.clinicId.equals(clinicId)))
          .go();
      await _db.into(_db.syncQueue).insert(SyncQueueCompanion.insert(
            targetTable: 'patients',
            recordId: patientId,
            operation: 'delete',
            payload: jsonEncode({'id': patientId, 'clinicId': clinicId}),
            createdAt: DateTime.now(),
          ));
    });
  }

  /// Used by pull service — writes without enqueuing to sync queue.
  Future<void> upsertFromRemote(Patient patient) async {
    await _db.into(_db.localPatients).insertOnConflictUpdate(
          PatientMapper.toCompanion(patient, synced: true),
        );
  }

  Future<void> deleteFromRemote(String patientId) async {
    await (_db.delete(_db.localPatients)
          ..where((t) => t.id.equals(patientId)))
        .go();
  }

  Future<bool> isLocalPending(String recordId) async {
    final row = await (_db.select(_db.localPatients)
          ..where((t) => t.id.equals(recordId)))
        .getSingleOrNull();
    return row != null && !row.isSynced;
  }

  Future<void> markSynced(String recordId) async {
    await (_db.update(_db.localPatients)
          ..where((t) => t.id.equals(recordId)))
        .write(const LocalPatientsCompanion(isSynced: Value(true)));
  }
}
