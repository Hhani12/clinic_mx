import 'package:drift/drift.dart';

import '../../enums/visit_status.dart';
import '../../../features/appointments/domain/entities/appointment.dart';
import '../app_database.dart';

class AppointmentMapper {
  const AppointmentMapper._();

  static LocalAppointmentsCompanion toCompanion(
    Appointment a, {
    bool synced = false,
  }) {
    return LocalAppointmentsCompanion.insert(
      id: a.id,
      clinicId: a.clinicId,
      patientId: a.patientId,
      patientName: a.patientName,
      patientPhone: a.patientPhone,
      startAt: a.startAt,
      durationMinutes: a.durationMinutes,
      reason: a.reason,
      status: a.status.value,
      doctorId: a.doctorId,
      doctorName: a.doctorName,
      createdAt: a.createdAt,
      updatedAt: a.updatedAt,
      reminderSent: Value(a.reminderSent),
      isSynced: Value(synced),
    );
  }

  static Appointment fromRow(LocalAppointment row) {
    return Appointment(
      id: row.id,
      clinicId: row.clinicId,
      patientId: row.patientId,
      patientName: row.patientName,
      patientPhone: row.patientPhone,
      startAt: row.startAt,
      durationMinutes: row.durationMinutes,
      reason: row.reason,
      status: VisitStatusX.fromString(row.status),
      doctorId: row.doctorId,
      doctorName: row.doctorName,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      reminderSent: row.reminderSent,
    );
  }

  static Map<String, dynamic> toPayload(Appointment a) {
    return {
      'id': a.id,
      'clinicId': a.clinicId,
      'patientId': a.patientId,
      'patientName': a.patientName,
      'patientPhone': a.patientPhone,
      'startAt': a.startAt.toIso8601String(),
      'durationMinutes': a.durationMinutes,
      'reason': a.reason,
      'status': a.status.value,
      'doctorId': a.doctorId,
      'doctorName': a.doctorName,
      'createdAt': a.createdAt.toIso8601String(),
      'updatedAt': a.updatedAt.toIso8601String(),
      'reminderSent': a.reminderSent,
    };
  }
}
