import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../features/settings/domain/entities/clinic.dart';
import '../../../features/settings/domain/entities/clinic_settings.dart';
import '../app_database.dart';
import '../mappers/clinic_mapper.dart';
import '../mappers/clinic_settings_mapper.dart';

class ClinicLocalDao {
  final AppDatabase _db;
  ClinicLocalDao(this._db);

  // ─── Clinic ───

  Stream<Clinic?> watchClinic(String clinicId) {
    return (_db.select(_db.localClinics)
          ..where((t) => t.id.equals(clinicId)))
        .watchSingleOrNull()
        .map((row) => row == null ? null : ClinicMapper.fromRow(row));
  }

  Future<void> saveClinic(Clinic clinic) async {
    await _db.transaction(() async {
      await _db.into(_db.localClinics).insertOnConflictUpdate(
            ClinicMapper.toCompanion(clinic, synced: false),
          );
      await _db.into(_db.syncQueue).insert(SyncQueueCompanion.insert(
            targetTable: '_clinic_doc',
            recordId: clinic.id,
            operation: 'update',
            payload: jsonEncode(ClinicMapper.toPayload(clinic)),
            createdAt: DateTime.now(),
          ));
    });
  }

  Future<void> upsertClinicFromRemote(Clinic clinic) async {
    await _db.into(_db.localClinics).insertOnConflictUpdate(
          ClinicMapper.toCompanion(clinic, synced: true),
        );
  }

  // ─── Clinic Settings ───

  Stream<ClinicSettings> watchClinicSettings(String clinicId) {
    return (_db.select(_db.localClinicSettings)
          ..where((t) => t.clinicId.equals(clinicId)))
        .watchSingleOrNull()
        .map((row) => row == null
            ? ClinicSettings.fromMap(null)
            : ClinicSettingsMapper.fromRow(row));
  }

  Future<void> saveClinicSettings({
    required String clinicId,
    required ClinicSettings settings,
  }) async {
    await _db.transaction(() async {
      await _db.into(_db.localClinicSettings).insertOnConflictUpdate(
            ClinicSettingsMapper.toCompanion(clinicId, settings,
                synced: false),
          );
      await _db.into(_db.syncQueue).insert(SyncQueueCompanion.insert(
            targetTable: '_clinic_settings',
            recordId: clinicId,
            operation: 'update',
            payload: jsonEncode({
              'clinicId': clinicId,
              ...ClinicSettingsMapper.toPayload(settings),
            }),
            createdAt: DateTime.now(),
          ));
    });
  }

  Future<void> upsertSettingsFromRemote(
      String clinicId, ClinicSettings settings) async {
    await _db.into(_db.localClinicSettings).insertOnConflictUpdate(
          ClinicSettingsMapper.toCompanion(clinicId, settings, synced: true),
        );
  }

  Future<bool> isClinicPending(String clinicId) async {
    final row = await (_db.select(_db.localClinics)
          ..where((t) => t.id.equals(clinicId)))
        .getSingleOrNull();
    return row != null && !row.isSynced;
  }

  Future<bool> isSettingsPending(String clinicId) async {
    final row = await (_db.select(_db.localClinicSettings)
          ..where((t) => t.clinicId.equals(clinicId)))
        .getSingleOrNull();
    return row != null && !row.isSynced;
  }

  Future<void> markClinicSynced(String clinicId) async {
    await (_db.update(_db.localClinics)
          ..where((t) => t.id.equals(clinicId)))
        .write(const LocalClinicsCompanion(isSynced: Value(true)));
  }

  Future<void> markSettingsSynced(String clinicId) async {
    await (_db.update(_db.localClinicSettings)
          ..where((t) => t.clinicId.equals(clinicId)))
        .write(
            const LocalClinicSettingsCompanion(isSynced: Value(true)));
  }
}
