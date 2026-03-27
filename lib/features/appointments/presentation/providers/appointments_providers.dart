import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/enums/visit_status.dart';
import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/services/firebase/firestore_service.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/repositories/appointments_repository_impl.dart';
import '../../domain/entities/appointment.dart';
import '../../domain/repositories/appointments_repository.dart';

enum CalendarViewMode { day, week, month }

final appointmentsRepositoryProvider = Provider<AppointmentsRepository>((ref) {
  return AppointmentsRepositoryImpl(ref.watch(firestoreServiceProvider));
});

final selectedCalendarDateProvider = StateProvider<DateTime>(
  (ref) => DateTime.now(),
);

final calendarViewModeProvider = StateProvider<CalendarViewMode>(
  (ref) => CalendarViewMode.day,
);

final todayAppointmentsProvider = StreamProvider<List<Appointment>>((ref) {
  final clinicId = ref.watch(currentClinicIdProvider);
  if (clinicId == null || clinicId.isEmpty) return const Stream.empty();
  return ref
      .watch(appointmentsRepositoryProvider)
      .watchTodayAppointments(clinicId);
});

final selectedViewAppointmentsProvider = StreamProvider<List<Appointment>>((
  ref,
) {
  final clinicId = ref.watch(currentClinicIdProvider);
  if (clinicId == null || clinicId.isEmpty) return const Stream.empty();

  final selectedDate = ref.watch(selectedCalendarDateProvider);
  final view = ref.watch(calendarViewModeProvider);

  late DateTime from;
  late DateTime to;
  switch (view) {
    case CalendarViewMode.day:
      from = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
      to = from
          .add(const Duration(days: 1))
          .subtract(const Duration(milliseconds: 1));
      break;
    case CalendarViewMode.week:
      final weekdayOffset = selectedDate.weekday - DateTime.monday;
      from = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
      ).subtract(Duration(days: weekdayOffset));
      to = from
          .add(const Duration(days: 7))
          .subtract(const Duration(milliseconds: 1));
      break;
    case CalendarViewMode.month:
      from = DateTime(selectedDate.year, selectedDate.month, 1);
      to = DateTime(selectedDate.year, selectedDate.month + 1, 0, 23, 59, 59);
      break;
  }

  return ref
      .watch(appointmentsRepositoryProvider)
      .watchAppointmentsInRange(clinicId: clinicId, from: from, to: to);
});

final upcomingWeekVisitsCountProvider = StreamProvider<int>((ref) {
  final clinicId = ref.watch(currentClinicIdProvider);
  if (clinicId == null || clinicId.isEmpty) return Stream.value(0);

  final now = DateTime.now();
  final to = now.add(const Duration(days: 7));
  return ref
      .watch(appointmentsRepositoryProvider)
      .watchAppointmentsInRange(clinicId: clinicId, from: now, to: to)
      .map((appointments) => appointments.length);
});

class AppointmentEditorController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> create({
    required String patientId,
    required String patientName,
    required String patientPhone,
    required String doctorId,
    required String doctorName,
    required DateTime startAt,
    required int durationMinutes,
    required String reason,
    required VisitStatus status,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final clinicId = ref.read(currentClinicIdProvider);
      final userId = ref.read(currentUserIdProvider);
      if (clinicId == null || clinicId.isEmpty || userId == null) {
        throw const AppException(
          'لا يوجد سياق عيادة أو مستخدم، أعد تسجيل الدخول',
        );
      }

      final now = DateTime.now();
      final appointment = Appointment(
        id: const Uuid().v4(),
        clinicId: clinicId,
        patientId: patientId,
        patientName: patientName,
        patientPhone: patientPhone,
        startAt: startAt,
        durationMinutes: durationMinutes,
        reason: reason.trim(),
        status: status,
        doctorId: doctorId,
        doctorName: doctorName,
        createdAt: now,
        updatedAt: now,
      );

      await ref
          .read(appointmentsRepositoryProvider)
          .upsertAppointment(appointment);
    });
  }

  Future<void> updateAppointment(Appointment appointment) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(appointmentsRepositoryProvider)
          .upsertAppointment(appointment.copyWith(updatedAt: DateTime.now())),
    );
  }

  Future<void> updateStatus({
    required String clinicId,
    required String appointmentId,
    required VisitStatus status,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(appointmentsRepositoryProvider)
          .updateStatus(
            clinicId: clinicId,
            appointmentId: appointmentId,
            status: status.value,
          ),
    );
  }

  Future<void> delete({
    required String clinicId,
    required String appointmentId,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(appointmentsRepositoryProvider)
          .deleteAppointment(clinicId: clinicId, appointmentId: appointmentId),
    );
  }
}

final appointmentEditorControllerProvider =
    AutoDisposeAsyncNotifierProvider<AppointmentEditorController, void>(
      AppointmentEditorController.new,
    );
