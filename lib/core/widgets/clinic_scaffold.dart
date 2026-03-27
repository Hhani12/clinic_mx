import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/controllers/auth_controller.dart';
import '../localization/app_localizations.dart';
import '../routing/route_paths.dart';
import '../theme/theme_controller.dart';
import '../theme/theme_tokens.dart';
import 'glass_app_bar.dart';
import 'glass_button.dart';
import 'glass_card.dart';
import 'glass_container.dart';
import 'liquid_background.dart';

class ClinicScaffold extends ConsumerWidget {
  const ClinicScaffold({
    super.key,
    required this.title,
    required this.selectedRoute,
    required this.body,
    this.actions,
    this.floatingActionButton,
  });

  final String title;
  final String selectedRoute;
  final Widget body;
  final List<Widget>? actions;
  final Widget? floatingActionButton;

  static final List<_NavigationItem> _items = [
    _NavigationItem(RoutePaths.dashboard, Icons.dashboard_rounded, 'dashboard'),
    _NavigationItem(RoutePaths.patients, Icons.people_alt_rounded, 'patients'),
    _NavigationItem(
      RoutePaths.appointments,
      Icons.event_available_rounded,
      'appointments',
    ),
    _NavigationItem(RoutePaths.doctors, Icons.badge_rounded, 'doctors'),
    _NavigationItem(RoutePaths.todayVisits, Icons.today_rounded, 'todayVisits'),
    _NavigationItem(
      RoutePaths.dental,
      Icons.medical_services_rounded,
      'dentalChart',
    ),
    _NavigationItem(RoutePaths.payments, Icons.payments_rounded, 'payments'),
    _NavigationItem(RoutePaths.settings, Icons.settings_rounded, 'settings'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 900;
    final isCompactDesktop = screenWidth < 1280;
    final sideNavWidth = (screenWidth * 0.24).clamp(220.0, 300.0).toDouble();
    final mobileContentPadding = screenWidth < 480 ? 12.0 : 16.0;
    final desktopPadding = isCompactDesktop ? 12.0 : 16.0;
    final appearance = ref.watch(themeControllerProvider);
    final glass = context.glassTheme;
    final currentIndex = _items.indexWhere(
      (item) => item.route == selectedRoute,
    );
    final selectedIndex = currentIndex < 0 ? 0 : currentIndex;

    if (isMobile) {
      return LiquidBackground(
        animate: appearance.animatedBackground,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: GlassAppBar(
            title: title,
            actions: [
              ...(actions ?? const <Widget>[]),
              IconButton(
                tooltip: context.l10n.tr('signOut'),
                onPressed: () {
                  ref.read(authControllerProvider.notifier).signOut();
                },
                icon: const Icon(Icons.logout_rounded),
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                mobileContentPadding,
                8,
                mobileContentPadding,
                mobileContentPadding,
              ),
              child: body,
            ),
          ),
          floatingActionButton: floatingActionButton,
          bottomNavigationBar: SafeArea(
            minimum: EdgeInsets.fromLTRB(
              mobileContentPadding - 2,
              0,
              mobileContentPadding - 2,
              mobileContentPadding - 2,
            ),
            child: GlassContainer(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              borderRadius: 26,
              blurSigma: glass.blurIntensity * 0.75,
              child: SizedBox(
                height: 52,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _items.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 6),
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    return _MobileNavChip(
                      selected: index == selectedIndex,
                      icon: item.icon,
                      label: context.l10n.tr(item.labelKey),
                      onTap: () => context.go(item.route),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );
    }

    return LiquidBackground(
      animate: appearance.animatedBackground,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Row(
            children: [
              SizedBox(
                width: sideNavWidth,
                child: Padding(
                  padding: EdgeInsets.all(desktopPadding),
                  child: GlassCard(
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 14,
                    ),
                    child: Column(
                      children: [
                        GlassContainer(
                          borderRadius: 18,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 34,
                                height: 34,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: context.glassTheme.buttonGradient,
                                ),
                                child: const Icon(
                                  Icons.local_hospital_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  context.l10n.tr('appName'),
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              final item = _items[index];
                              final selected = selectedRoute == item.route;
                              return _DesktopNavTile(
                                selected: selected,
                                icon: item.icon,
                                label: context.l10n.tr(item.labelKey),
                                onTap: () => context.go(item.route),
                              );
                            },
                            separatorBuilder: (_, index) =>
                                const SizedBox(height: 6),
                            itemCount: _items.length,
                          ),
                        ),
                        const SizedBox(height: 10),
                        GlassButton(
                          label: context.l10n.tr('signOut'),
                          icon: Icons.logout_rounded,
                          expanded: true,
                          variant: GlassButtonVariant.neutral,
                          onPressed: () {
                            ref.read(authControllerProvider.notifier).signOut();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: desktopPadding,
                    right: desktopPadding,
                    bottom: desktopPadding,
                  ),
                  child: GlassCard(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isCompactDesktop ? 16 : 20,
                            vertical: isCompactDesktop ? 12 : 14,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                ),
                              ),
                              ...(actions ?? const <Widget>[]),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: glass.border.withValues(alpha: 0.7),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(isCompactDesktop ? 12 : 16),
                            child: body,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}

class _DesktopNavTile extends StatelessWidget {
  const _DesktopNavTile({
    required this.selected,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final bool selected;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final glass = context.glassTheme;
    final primary = Theme.of(context).colorScheme.primary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: selected
                ? primary.withValues(alpha: 0.14)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: selected
                ? Border.all(color: primary.withValues(alpha: 0.35), width: 0.9)
                : Border.all(color: Colors.transparent),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: selected ? primary : glass.textSecondary,
                size: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: selected ? primary : glass.textSecondary,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileNavChip extends StatelessWidget {
  const _MobileNavChip({
    required this.selected,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final bool selected;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final glass = context.glassTheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.symmetric(
            horizontal: selected ? 12 : 10,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: selected
                ? primary.withValues(alpha: 0.16)
                : Colors.white.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selected
                  ? primary.withValues(alpha: 0.35)
                  : Colors.white.withValues(alpha: 0.08),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 18,
                color: selected ? primary : glass.textSecondary,
              ),
              if (selected) ...[
                const SizedBox(width: 6),
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationItem {
  const _NavigationItem(this.route, this.icon, this.labelKey);

  final String route;
  final IconData icon;
  final String labelKey;
}
