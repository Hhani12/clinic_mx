import '../entities/appointment.dart';

abstract class AppointmentsRepository {
  Stream<List<Appointment>> watchAppointmentsInRange({
    required String clinicId,
    required DateTime from,
    required DateTime to,
  });

  Stream<List<Appointment>> watchTodayAppointments(String clinicId);

  Future<void> upsertAppointment(Appointment appointment);

  Future<void> updateStatus({
    required String clinicId,
    required String appointmentId,
    required String status,
  });

  Future<void> deleteAppointment({
    required String clinicId,
    required String appointmentId,
  });
}
