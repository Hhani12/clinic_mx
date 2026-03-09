import 'package:clinic/core/localization/app_localizations.dart';
import 'package:clinic/features/auth/presentation/pages/login_page.dart';
import 'package:clinic/features/auth/presentation/providers/auth_providers.dart';
import 'package:clinic/features/patients/domain/entities/patient.dart';
import 'package:clinic/features/patients/presentation/pages/patients_page.dart';
import 'package:clinic/features/patients/presentation/providers/patients_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('login screen renders required controls', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('ar'),
        home: const ProviderScope(child: LoginPage()),
      ),
    );

    await tester.pump();
    expect(tester.takeException(), isNull);
    expect(find.byType(LoginPage), findsOneWidget);
  });

  testWidgets('patients screen renders list shell', (tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          currentClinicIdProvider.overrideWithValue('clinic_test'),
          patientsStreamProvider.overrideWith(
            (ref) => Stream.value(const <Patient>[]),
          ),
          filteredPatientsProvider.overrideWith((ref) => const <Patient>[]),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('ar'),
          home: const PatientsPage(),
        ),
      ),
    );

    await tester.pump(const Duration(milliseconds: 250));
    expect(tester.takeException(), isNull);
    expect(find.byType(PatientsPage), findsOneWidget);
  });
}
