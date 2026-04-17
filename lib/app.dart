import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/localization/app_localizations.dart';
import 'core/routing/app_router.dart';
import 'core/services/app_initializer.dart';
import 'core/sync/sync_initializer.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';

class ClinicMxApp extends ConsumerWidget {
  const ClinicMxApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialization = ref.watch(appInitializerProvider);

    return initialization.when(
      data: (_) {
        // Start background sync engine on desktop platforms.
        if (!kIsWeb) {
          ref.watch(syncInitializerProvider);
        }

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
      },
      loading: () => const _SplashApp(),
      error: (error, stack) => MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('Error initializing app:\n$error'),
          ),
        ),
      ),
    );
  }
}

class _SplashApp extends StatelessWidget {
  const _SplashApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF0F172A),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.medical_services_rounded, size: 64, color: Color(0xFF00E5FF)),
              SizedBox(height: 24),
              CircularProgressIndicator(color: Color(0xFF00E5FF)),
            ],
          ),
        ),
      ),
    );
  }
}
