import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/routing/route_paths.dart';
import '../../../../core/utils/currency_format.dart';
import '../../../../core/utils/date_formats.dart';
import '../../../../core/widgets/clinic_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../payments/presentation/providers/payments_providers.dart';
import '../providers/patients_providers.dart';
import '../widgets/investigation_section.dart';

class PatientProfilePage extends ConsumerWidget {
  const PatientProfilePage({super.key, required this.patientId});

  final String patientId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientAsync = ref.watch(patientByIdProvider(patientId));
    final paymentsAsync = ref.watch(patientPaymentsProvider(patientId));

    return ClinicScaffold(
      title: context.l10n.tr('patientProfile'),
      selectedRoute: RoutePaths.patients,
      body: patientAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text(error.toString())),
        data: (patient) {
          if (patient == null) {
            return Center(child: Text(context.l10n.tr('noData')));
          }

          return ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      patient.displayName,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  FilledButton.tonalIcon(
                    onPressed: () => context.go(
                      RoutePaths.patientEdit.replaceFirst(
                        ':patientId',
                        patient.id,
                      ),
                    ),
                    icon: const Icon(Icons.edit_rounded),
                    label: Text(context.l10n.tr('editPatient')),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _InfoCard(
                    title: context.l10n.tr('phone'),
                    value: patient.phoneNumber,
                    width: 280,
                  ),
                  _InfoCard(
                    title: context.l10n.tr('city'),
                    value: patient.city ?? '-',
                    width: 220,
                  ),
                  _InfoCard(
                    title: context.l10n.tr('district'),
                    value: patient.district ?? '-',
                    width: 220,
                  ),
                  _InfoCard(
                    title: context.l10n.tr('dob'),
                    value: patient.dob == null
                        ? '-'
                        : DateFormats.dayMonthYear.format(patient.dob!),
                    width: 220,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _InfoCard(
                title: context.l10n.tr('reasonForVisit'),
                value: patient.reasonForVisit ?? '-',
                width: double.infinity,
              ),
              const SizedBox(height: 12),
              _InfoCard(
                title: context.l10n.tr('medicalNotes'),
                value: patient.medicalNotes ?? '-',
                width: double.infinity,
              ),
              const SizedBox(height: 12),
              _InfoCard(
                title: context.l10n.tr('allergies'),
                value: patient.allergies.isEmpty
                    ? '-'
                    : patient.allergies.join('، '),
                width: double.infinity,
              ),
              const SizedBox(height: 12),
              _InfoCard(
                title: context.l10n.tr('chronicDiseases'),
                value: patient.chronicDiseases.isEmpty
                    ? '-'
                    : patient.chronicDiseases.join('، '),
                width: double.infinity,
              ),
              const SizedBox(height: 12),
              // Investigation images section
              InvestigationSection(patientId: patient.id),
              const SizedBox(height: 12),
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.tr('payments'),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    paymentsAsync.when(
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (error, _) => Text(error.toString()),
                      data: (payments) {
                        if (payments.isEmpty) {
                          return Text(context.l10n.tr('noData'));
                        }
                        final total = payments.fold<double>(
                          0,
                          (sum, item) => sum + item.remaining,
                        );
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${context.l10n.tr('remaining')}: ${CurrencyFormat.iqd(total)}',
                            ),
                            const SizedBox(height: 6),
                            ...payments
                                .take(5)
                                .map(
                                  (payment) => Text(
                                    '${DateFormats.dayMonthYear.format(payment.date)} - '
                                    '${CurrencyFormat.iqd(payment.amount)}',
                                  ),
                                ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.title,
    required this.value,
    required this.width,
  });

  final String title;
  final String value;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: GlassCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 4),
            Text(value, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
