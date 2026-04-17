import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../features/doctors/domain/entities/doctor_profile.dart';
import '../app_database.dart';
import '../mappers/doctor_mapper.dart';

class DoctorsLocalDao {
  final AppDatabase _db;
  DoctorsLocalDao(this._db);

  Stream<List<DoctorProfile>> watchClinicDoctors(String clinicId) {
    return (_db.select(_db.localDoctors)
          ..where((t) => t.clinicId.equals(clinicId))
          ..orderBy([(t) => OrderingTerm.asc(t.fullName)]))
        .watch()
        .map((rows) => rows.map(DoctorMapper.fromRow).toList());
  }

  Future<void> upsertDoctor(DoctorProfile doctor) async {
    await _db.transaction(() async {
      await _db.into(_db.localDoctors).insertOnConflictUpdate(
            DoctorMapper.toCompanion(doctor, synced: false),
          );
      await _db.into(_db.syncQueue).insert(SyncQueueCompanion.insert(
            targetTable: 'doctors',
            recordId: doctor.id,
            operation: 'update',
            payload: jsonEncode(DoctorMapper.toPayload(doctor)),
            createdAt: DateTime.now(),
          ));
    });
  }

  Future<void> deleteDoctor({
    required String clinicId,
    required String doctorId,
  }) async {
    await _db.transaction(() async {
      await (_db.delete(_db.localDoctors)
            ..where(
                (t) => t.id.equals(doctorId) & t.clinicId.equals(clinicId)))
          .go();
      await _db.into(_db.syncQueue).insert(SyncQueueCompanion.insert(
            targetTable: 'doctors',
            recordId: doctorId,
            operation: 'delete',
            payload: jsonEncode({'id': doctorId, 'clinicId': clinicId}),
            createdAt: DateTime.now(),
          ));
    });
  }

  Future<void> upsertFromRemote(DoctorProfile doctor) async {
    await _db.into(_db.localDoctors).insertOnConflictUpdate(
          DoctorMapper.toCompanion(doctor, synced: true),
        );
  }

  Future<void> deleteFromRemote(String doctorId) async {
    await (_db.delete(_db.localDoctors)
          ..where((t) => t.id.equals(doctorId)))
        .go();
  }

  Future<bool> isLocalPending(String recordId) async {
    final row = await (_db.select(_db.localDoctors)
          ..where((t) => t.id.equals(recordId)))
        .getSingleOrNull();
    return row != null && !row.isSynced;
  }

  Future<void> markSynced(String recordId) async {
    await (_db.update(_db.localDoctors)
          ..where((t) => t.id.equals(recordId)))
        .write(const LocalDoctorsCompanion(isSynced: Value(true)));
  }
}
