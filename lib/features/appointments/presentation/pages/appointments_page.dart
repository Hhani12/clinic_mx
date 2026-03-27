import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/enums/visit_status.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/routing/route_paths.dart';
import '../../../../core/utils/date_formats.dart';
import '../../../../core/widgets/clinic_scaffold.dart';
import '../../../../core/widgets/glass_badge.dart';
import '../../../../core/widgets/glass_button.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/glass_icon_button.dart';
import '../../../../core/widgets/glass_segmented_control.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../domain/entities/appointment.dart';
import '../providers/appointments_providers.dart';
import '../widgets/appointment_form_sheet.dart';

class AppointmentsPage extends ConsumerWidget {
  const AppointmentsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedCalendarDateProvider);
    final viewMode = ref.watch(calendarViewModeProvider);
    final appointmentsAsync = ref.watch(selectedViewAppointmentsProvider);
    final clinicId = ref.watch(currentClinicIdProvider);
    final tr = context.l10n.tr;

    return ClinicScaffold(
      title: tr('appointments'),
      selectedRoute: RoutePaths.appointments,
      floatingActionButton: GlassButton(
        onPressed: () => _openForm(context),
        icon: Icons.add_rounded,
        label: tr('createAppointment'),
      ),
      body: Column(
        children: [
          GlassCard(
            child: Column(
              children: [
                TableCalendar(
                  firstDay: DateTime.utc(2020),
                  lastDay: DateTime.utc(2100),
                  focusedDay: selectedDate,
                  selectedDayPredicate: (day) => isSameDay(day, selectedDate),
                  calendarFormat: CalendarFormat.month,
                  onDaySelected: (selected, focused) {
                    ref.read(selectedCalendarDateProvider.notifier).state =
                        DateTime(selected.year, selected.month, selected.day);
                    ref.read(calendarViewModeProvider.notifier).state =
                        CalendarViewMode.day;
                  },
                ),
                const SizedBox(height: 10),
                GlassSegmentedControl<CalendarViewMode>(
                  segments: [
                    GlassSegment(
                      value: CalendarViewMode.day,
                      label: tr('day'),
                      icon: Icons.calendar_view_day_rounded,
                    ),
                    GlassSegment(
                      value: CalendarViewMode.week,
                      label: tr('week'),
                      icon: Icons.calendar_view_week_rounded,
                    ),
                    GlassSegment(
                      value: CalendarViewMode.month,
                      label: tr('month'),
                      icon: Icons.calendar_month_rounded,
                    ),
                  ],
                  selectedValue: viewMode,
                  onChanged: (value) =>
                      ref.read(calendarViewModeProvider.notifier).state = value,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: appointmentsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text(error.toString())),
              data: (appointments) {
                if (appointments.isEmpty) {
                  return Center(child: Text(tr('noData')));
                }
                final sorted = [...appointments]
                  ..sort((a, b) => a.startAt.compareTo(b.startAt));
                return ListView.builder(
                  itemCount: sorted.length,
                  itemBuilder: (context, index) {
                    final appointment = sorted[index];
                    return _AppointmentTile(
                      appointment: appointment,
                      onEdit: () =>
                          _openForm(context, appointment: appointment),
                      onDelete: clinicId == null
                          ? null
                          : () => ref
                                .read(
                                  appointmentEditorControllerProvider.notifier,
                                )
                                .delete(
                                  clinicId: clinicId,
                                  appointmentId: appointment.id,
                                ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openForm(BuildContext context, {Appointment? appointment}) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => AppointmentFormSheet(appointment: appointment),
    );
  }
}

class _AppointmentTile extends StatelessWidget {
  const _AppointmentTile({
    required this.appointment,
    this.onEdit,
    this.onDelete,
  });

  final Appointment appointment;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appointment.patientName,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  '${DateFormats.full.format(appointment.startAt)} - ${appointment.durationMinutes}m',
                ),
                if (appointment.doctorName.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text('الطبيب: ${appointment.doctorName}'),
                ],
                const SizedBox(height: 6),
                GlassBadge(
                  label: appointment.status.labelAr,
                  type: _statusBadgeType(appointment.status),
                ),
                const SizedBox(height: 6),
                Text(
                  appointment.reason,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GlassIconButton(
                icon: Icons.edit_rounded,
                tooltip: 'Edit',
                onPressed: onEdit,
              ),
              const SizedBox(width: 8),
              GlassIconButton(
                icon: Icons.delete_outline_rounded,
                tooltip: 'Delete',
                onPressed: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

GlassBadgeType _statusBadgeType(VisitStatus status) {
  return switch (status) {
    VisitStatus.completed => GlassBadgeType.success,
    VisitStatus.cancelled || VisitStatus.noShow => GlassBadgeType.error,
    VisitStatus.checkedIn || VisitStatus.inTreatment => GlassBadgeType.info,
    VisitStatus.scheduled => GlassBadgeType.warning,
  };
}
