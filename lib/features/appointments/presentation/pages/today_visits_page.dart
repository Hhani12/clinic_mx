import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/enums/visit_status.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/routing/route_paths.dart';
import '../../../../core/utils/date_formats.dart';
import '../../../../core/widgets/clinic_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../domain/entities/appointment.dart';
import '../providers/appointments_providers.dart';
import '../widgets/appointment_form_sheet.dart';

class TodayVisitsPage extends ConsumerWidget {
  const TodayVisitsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointmentsAsync = ref.watch(todayAppointmentsProvider);
    final clinicId = ref.watch(currentClinicIdProvider);
    final tr = context.l10n.tr;

    return ClinicScaffold(
      title: tr('todayVisits'),
      selectedRoute: RoutePaths.todayVisits,
      body: appointmentsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text(error.toString())),
        data: (appointments) {
          final sorted = [...appointments]..sort((a, b) => a.startAt.compareTo(b.startAt));
          return Column(
            children: [
              GlassCard(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${tr('totalTodayPatients')}: ${sorted.length}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: sorted.isEmpty
                    ? Center(child: Text(tr('noData')))
                    : ListView.builder(
                        itemCount: sorted.length,
                        itemBuilder: (context, index) {
                          final item = sorted[index];
                          return _TodayVisitTile(
                            appointment: item,
                            onCall: () => _launchPhone(item.patientPhone),
                            onWhatsApp: () => _launchWhatsApp(item.patientPhone),
                            onMarkArrived: clinicId == null
                                ? null
                                : () => ref
                                      .read(
                                        appointmentEditorControllerProvider
                                            .notifier,
                                      )
                                      .updateStatus(
                                        clinicId: clinicId,
                                        appointmentId: item.id,
                                        status: VisitStatus.checkedIn,
                                      ),
                            onReschedule: () => showModalBottomSheet<void>(
                              context: context,
                              isScrollControlled: true,
                              builder: (_) => AppointmentFormSheet(
                                appointment: item,
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _launchPhone(String phone) async {
    final uri = Uri.parse('tel:$phone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _launchWhatsApp(String phone) async {
    final normalized = phone.replaceAll('+', '');
    final uri = Uri.parse('https://wa.me/$normalized');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _TodayVisitTile extends StatelessWidget {
  const _TodayVisitTile({
    required this.appointment,
    this.onCall,
    this.onWhatsApp,
    this.onMarkArrived,
    this.onReschedule,
  });

  final Appointment appointment;
  final VoidCallback? onCall;
  final VoidCallback? onWhatsApp;
  final VoidCallback? onMarkArrived;
  final VoidCallback? onReschedule;

  @override
  Widget build(BuildContext context) {
    final tr = context.l10n.tr;
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  appointment.patientName,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Text(DateFormats.hourMinute.format(appointment.startAt)),
            ],
          ),
          const SizedBox(height: 6),
          Text(appointment.reason),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              OutlinedButton.icon(
                onPressed: onCall,
                icon: const Icon(Icons.call_rounded),
                label: Text(tr('callPatient')),
              ),
              OutlinedButton.icon(
                onPressed: onWhatsApp,
                icon: const Icon(Icons.chat_rounded),
                label: Text(tr('whatsapp')),
              ),
              FilledButton.tonalIcon(
                onPressed: onMarkArrived,
                icon: const Icon(Icons.check_circle_outline_rounded),
                label: Text(tr('markArrived')),
              ),
              TextButton.icon(
                onPressed: onReschedule,
                icon: const Icon(Icons.update_rounded),
                label: Text(tr('reschedule')),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
