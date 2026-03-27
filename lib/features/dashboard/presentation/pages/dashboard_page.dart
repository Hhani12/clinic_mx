import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/routing/route_paths.dart';
import '../../../../core/utils/currency_format.dart';
import '../../../../core/widgets/clinic_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';
import '../providers/dashboard_providers.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayVisits = ref.watch(todayVisitsCountProvider);
    final upcomingVisits = ref.watch(upcomingVisitsCountProvider);
    final pendingPayments = ref.watch(pendingPaymentsTotalProvider);
    final tr = context.l10n.tr;

    return ClinicScaffold(
      title: tr('dashboard'),
      selectedRoute: RoutePaths.dashboard,
      body: ListView(
        children: [
          Text(
            tr('dashboardSubtitle'),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 14),
          LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = _kpiCardWidth(constraints.maxWidth);
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _KpiCard(
                    width: cardWidth,
                    title: tr('totalTodayPatients'),
                    value: '$todayVisits',
                    icon: Icons.today_rounded,
                    onTap: () => context.go(RoutePaths.todayVisits),
                  ),
                  _KpiCard(
                    width: cardWidth,
                    title: tr('upcomingVisits'),
                    value: '$upcomingVisits',
                    icon: Icons.event_available_rounded,
                    onTap: () => context.go(RoutePaths.appointments),
                  ),
                  _KpiCard(
                    width: cardWidth,
                    title: tr('pendingPayments'),
                    value: CurrencyFormat.iqd(pendingPayments),
                    icon: Icons.payments_rounded,
                    onTap: () => context.go(RoutePaths.payments),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          GlassCard(
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                FilledButton.tonalIcon(
                  onPressed: () => context.go(RoutePaths.patients),
                  icon: const Icon(Icons.people_alt_rounded),
                  label: Text(tr('patients')),
                ),
                FilledButton.tonalIcon(
                  onPressed: () => context.go(RoutePaths.appointments),
                  icon: const Icon(Icons.event_note_rounded),
                  label: Text(tr('appointments')),
                ),
                FilledButton.tonalIcon(
                  onPressed: () => context.go(RoutePaths.doctors),
                  icon: const Icon(Icons.badge_rounded),
                  label: Text(tr('doctors')),
                ),
                FilledButton.tonalIcon(
                  onPressed: () => context.go(RoutePaths.dental),
                  icon: const Icon(Icons.medical_services_rounded),
                  label: Text(tr('dentalChart')),
                ),
                FilledButton.tonalIcon(
                  onPressed: () => context.go(RoutePaths.settings),
                  icon: const Icon(Icons.settings_rounded),
                  label: Text(tr('settings')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _KpiCard extends StatelessWidget {
  const _KpiCard({
    required this.width,
    required this.title,
    required this.value,
    required this.icon,
    this.onTap,
  });

  final double width;
  final String title;
  final String value;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: GlassCard(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 8),
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 6),
            Text(value, style: Theme.of(context).textTheme.headlineSmall),
          ],
        ),
      ),
    );
  }
}

double _kpiCardWidth(double availableWidth) {
  const spacing = 12.0;
  final columns = availableWidth >= 1080
      ? 3
      : availableWidth >= 700
      ? 2
      : 1;
  final totalSpacing = spacing * (columns - 1);
  return ((availableWidth - totalSpacing) / columns).clamp(
    220.0,
    availableWidth,
  );
}
