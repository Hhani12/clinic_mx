import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../features/appointments/domain/entities/appointment.dart';
import '../../enums/visit_status.dart';
import '../app_database.dart';
import '../mappers/appointment_mapper.dart';

class AppointmentsLocalDao {
  final AppDatabase _db;
  AppointmentsLocalDao(this._db);

  Stream<List<Appointment>> watchAppointmentsInRange({
    required String clinicId,
    required DateTime from,
    required DateTime to,
  }) {
    return (_db.select(_db.localAppointments)
          ..where((t) =>
              t.clinicId.equals(clinicId) &
              t.startAt.isBiggerOrEqualValue(from) &
              t.startAt.isSmallerOrEqualValue(to))
          ..orderBy([(t) => OrderingTerm.asc(t.startAt)]))
        .watch()
        .map((rows) => rows.map(AppointmentMapper.fromRow).toList());
  }

  Stream<List<Appointment>> watchTodayAppointments(String clinicId) {
    final now = DateTime.now();
    final from = DateTime(now.year, now.month, now.day);
    final to =
        from.add(const Duration(days: 1)).subtract(const Duration(milliseconds: 1));
    return watchAppointmentsInRange(clinicId: clinicId, from: from, to: to);
  }

  Future<void> upsertAppointment(Appointment appointment) async {
    await _db.transaction(() async {
      await _db.into(_db.localAppointments).insertOnConflictUpdate(
            AppointmentMapper.toCompanion(appointment, synced: false),
          );
      await _db.into(_db.syncQueue).insert(SyncQueueCompanion.insert(
            targetTable: 'appointments',
            recordId: appointment.id,
            operation: 'update',
            payload: jsonEncode(AppointmentMapper.toPayload(appointment)),
            createdAt: DateTime.now(),
          ));
    });
  }

  Future<void> updateStatus({
    required String clinicId,
    required String appointmentId,
    required String status,
  }) async {
    final now = DateTime.now();
    await _db.transaction(() async {
      // Read current row to build full payload for sync.
      final row = await (_db.select(_db.localAppointments)
            ..where((t) => t.id.equals(appointmentId)))
          .getSingleOrNull();
      if (row == null) return;

      await (_db.update(_db.localAppointments)
            ..where((t) => t.id.equals(appointmentId)))
          .write(LocalAppointmentsCompanion(
        status: Value(status),
        updatedAt: Value(now),
        isSynced: const Value(false),
      ));

      final updated = AppointmentMapper.fromRow(row).copyWith(
        status: VisitStatusX.fromString(status),
        updatedAt: now,
      );
      await _db.into(_db.syncQueue).insert(SyncQueueCompanion.insert(
            targetTable: 'appointments',
            recordId: appointmentId,
            operation: 'update',
            payload: jsonEncode(AppointmentMapper.toPayload(updated)),
            createdAt: now,
          ));
    });
  }

  Future<void> deleteAppointment({
    required String clinicId,
    required String appointmentId,
  }) async {
    await _db.transaction(() async {
      await (_db.delete(_db.localAppointments)
            ..where((t) =>
                t.id.equals(appointmentId) & t.clinicId.equals(clinicId)))
          .go();
      await _db.into(_db.syncQueue).insert(SyncQueueCompanion.insert(
            targetTable: 'appointments',
            recordId: appointmentId,
            operation: 'delete',
            payload:
                jsonEncode({'id': appointmentId, 'clinicId': clinicId}),
            createdAt: DateTime.now(),
          ));
    });
  }

  Future<void> upsertFromRemote(Appointment appointment) async {
    await _db.into(_db.localAppointments).insertOnConflictUpdate(
          AppointmentMapper.toCompanion(appointment, synced: true),
        );
  }

  Future<void> deleteFromRemote(String appointmentId) async {
    await (_db.delete(_db.localAppointments)
          ..where((t) => t.id.equals(appointmentId)))
        .go();
  }

  Future<bool> isLocalPending(String recordId) async {
    final row = await (_db.select(_db.localAppointments)
          ..where((t) => t.id.equals(recordId)))
        .getSingleOrNull();
    return row != null && !row.isSynced;
  }

  Future<void> markSynced(String recordId) async {
    await (_db.update(_db.localAppointments)
          ..where((t) => t.id.equals(recordId)))
        .write(const LocalAppointmentsCompanion(isSynced: Value(true)));
  }
}
