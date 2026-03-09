import 'package:clinic/core/localization/app_localizations.dart';
import 'package:clinic/features/auth/presentation/controllers/auth_controller.dart';
import 'package:clinic/features/auth/presentation/pages/login_page.dart';
import 'package:clinic/features/auth/presentation/providers/auth_providers.dart';
import 'package:clinic/features/patients/domain/entities/patient.dart';
import 'package:clinic/features/patients/presentation/pages/patient_form_page.dart';
import 'package:clinic/features/patients/presentation/providers/patients_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FakeAuthController extends AuthController {
  static bool signInCalled = false;

  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    signInCalled = true;
    state = const AsyncData(null);
  }

  @override
  Future<void> signOut() async {}

  @override
  Future<void> resetPassword(String email) async {}
}

class FakePatientFormController extends PatientFormController {
  static bool createCalled = false;

  @override
  Future<String> create({
    required String firstName,
    required String fatherName,
    required String lastName,
    required String phoneNumber,
    String? city,
    String? district,
    String? detailedAddress,
    DateTime? dob,
    PatientGender? gender,
    String? nationalId,
    String? reasonForVisit,
    String? medicalNotes,
    List<String> allergies = const [],
    List<String> chronicDiseases = const [],
  }) async {
    createCalled = true;
    return 'patient_integration';
  }

  @override
  Future<void> updatePatient(
    Patient existing, {
    required String firstName,
    required String fatherName,
    required String lastName,
    required String phoneNumber,
    String? city,
    String? district,
    String? detailedAddress,
    DateTime? dob,
    PatientGender? gender,
    String? nationalId,
    String? reasonForVisit,
    String? medicalNotes,
    List<String> allergies = const [],
    List<String> chronicDiseases = const [],
  }) async {}

  @override
  Future<void> delete({
    required String clinicId,
    required String patientId,
  }) async {}
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    FakeAuthController.signInCalled = false;
    FakePatientFormController.createCalled = false;
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('login then create patient', (tester) async {
    final router = GoRouter(
      initialLocation: '/login',
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/patients/new',
          builder: (context, state) => const PatientFormPage(),
        ),
        GoRoute(
          path: '/patients/:patientId',
          builder: (_, state) => Scaffold(
            body: Center(
              child: Text('profile:${state.pathParameters['patientId']}'),
            ),
          ),
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authControllerProvider.overrideWith(FakeAuthController.new),
          patientFormControllerProvider.overrideWith(
            FakePatientFormController.new,
          ),
          currentClinicIdProvider.overrideWithValue('clinic_test'),
        ],
        child: MaterialApp.router(
          routerConfig: router,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('ar'),
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField).first, 'doctor@test.com');
    await tester.enterText(find.byType(TextFormField).last, 'secret123');
    await tester.tap(find.text('دخول'));
    await tester.pumpAndSettle();
    expect(FakeAuthController.signInCalled, isTrue);

    router.go('/patients/new');
    await tester.pumpAndSettle();

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'محمد');
    await tester.enterText(fields.at(1), 'علي');
    await tester.enterText(fields.at(2), 'حسن');
    await tester.enterText(fields.at(3), '+9647712345678');
    await tester.tap(find.text('حفظ'));
    await tester.pumpAndSettle();

    expect(FakePatientFormController.createCalled, isTrue);
    expect(find.text('profile:patient_integration'), findsOneWidget);
  });
}
