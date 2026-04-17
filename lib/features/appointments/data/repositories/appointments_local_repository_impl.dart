import '../../../../core/local/daos/appointments_local_dao.dart';
import '../../domain/entities/appointment.dart';
import '../../domain/repositories/appointments_repository.dart';

class AppointmentsLocalRepositoryImpl implements AppointmentsRepository {
  final AppointmentsLocalDao _dao;
  AppointmentsLocalRepositoryImpl(this._dao);

  @override
  Stream<List<Appointment>> watchAppointmentsInRange({
    required String clinicId,
    required DateTime from,
    required DateTime to,
  }) =>
      _dao.watchAppointmentsInRange(clinicId: clinicId, from: from, to: to);

  @override
  Stream<List<Appointment>> watchTodayAppointments(String clinicId) =>
      _dao.watchTodayAppointments(clinicId);

  @override
  Future<void> upsertAppointment(Appointment appointment) =>
      _dao.upsertAppointment(appointment);

  @override
  Future<void> updateStatus({
    required String clinicId,
    required String appointmentId,
    required String status,
  }) =>
      _dao.updateStatus(
          clinicId: clinicId, appointmentId: appointmentId, status: status);

  @override
  Future<void> deleteAppointment({
    required String clinicId,
    required String appointmentId,
  }) =>
      _dao.deleteAppointment(
          clinicId: clinicId, appointmentId: appointmentId);
}
