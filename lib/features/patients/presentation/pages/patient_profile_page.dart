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
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 640) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          patient.displayName,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
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
                    );
                  }
                  return Row(
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
                  );
                },
              ),
              const SizedBox(height: 12),
              LayoutBuilder(
                builder: (context, constraints) {
                  const spacing = 12.0;
                  final columns = constraints.maxWidth >= 1080
                      ? 4
                      : constraints.maxWidth >= 720
                      ? 2
                      : 1;
                  final cardWidth =
                      ((constraints.maxWidth - ((columns - 1) * spacing)) /
                              columns)
                          .clamp(220.0, constraints.maxWidth)
                          .toDouble();
                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: [
                      SizedBox(
                        width: cardWidth,
                        child: _InfoCard(
                          title: context.l10n.tr('phone'),
                          value: patient.phoneNumber,
                        ),
                      ),
                      SizedBox(
                        width: cardWidth,
                        child: _InfoCard(
                          title: context.l10n.tr('city'),
                          value: patient.city ?? '-',
                        ),
                      ),
                      SizedBox(
                        width: cardWidth,
                        child: _InfoCard(
                          title: context.l10n.tr('district'),
                          value: patient.district ?? '-',
                        ),
                      ),
                      SizedBox(
                        width: cardWidth,
                        child: _InfoCard(
                          title: context.l10n.tr('dob'),
                          value: patient.dob == null
                              ? '-'
                              : DateFormats.dayMonthYear.format(patient.dob!),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 12),
              _InfoCard(
                title: context.l10n.tr('reasonForVisit'),
                value: patient.reasonForVisit ?? '-',
              ),
              const SizedBox(height: 12),
              _InfoCard(
                title: context.l10n.tr('medicalNotes'),
                value: patient.medicalNotes ?? '-',
              ),
              const SizedBox(height: 12),
              _InfoCard(
                title: context.l10n.tr('allergies'),
                value: patient.allergies.isEmpty
                    ? '-'
                    : patient.allergies.join(', '),
              ),
              const SizedBox(height: 12),
              _InfoCard(
                title: context.l10n.tr('chronicDiseases'),
                value: patient.chronicDiseases.isEmpty
                    ? '-'
                    : patient.chronicDiseases.join(', '),
              ),
              const SizedBox(height: 12),
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
  const _InfoCard({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 4),
          Text(value, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}
