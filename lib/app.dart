import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/localization/app_localizations.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';

class ClinicMxApp extends ConsumerWidget {
  const ClinicMxApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final appearance = ref.watch(themeControllerProvider);

    return MaterialApp.router(
      title: 'Locas Clinic',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: AppTheme.buildTheme(
        brightness: Brightness.light,
        settings: appearance,
      ),
      darkTheme: AppTheme.buildTheme(
        brightness: Brightness.dark,
        settings: appearance,
      ),
      themeMode: appearance.themeMode,
      locale: appearance.locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
    );
  }
}
