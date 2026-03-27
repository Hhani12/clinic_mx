import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/appointments/presentation/pages/appointments_page.dart';
import '../../features/appointments/presentation/pages/today_visits_page.dart';
import '../../features/auth/presentation/pages/expired_clinic_page.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/providers/auth_providers.dart';
import '../../features/settings/presentation/providers/settings_providers.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/doctors/presentation/pages/doctors_page.dart';
import '../../features/dental/presentation/pages/dental_chart_page.dart';
import '../../features/patients/presentation/pages/patient_form_page.dart';
import '../../features/patients/presentation/pages/patient_profile_page.dart';
import '../../features/patients/presentation/pages/patients_page.dart';
import '../../features/payments/presentation/pages/payments_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../enums/user_role.dart';
import '../localization/app_localizations.dart';
import 'route_paths.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);

  final refreshStream = _GoRouterRefreshStream(
    authRepository.authStateChanges(),
    ref.watch(devAdminLoggedInProvider.select((v) => v)),
  );
  ref.onDispose(refreshStream.dispose);

  return GoRouter(
    initialLocation: RoutePaths.login,
    refreshListenable: refreshStream,
    redirect: (context, state) {
      final user = authRepository.currentUser;
      final isDev = ref.read(devAdminLoggedInProvider);
      final isLoggedIn = user != null || isDev;

      final location = state.matchedLocation;
      final isAuthRoute =
          location == RoutePaths.login ||
          location == RoutePaths.register ||
          location == RoutePaths.forgotPassword;
      final isExpiredRoute = location == RoutePaths.expired;

      if (!isLoggedIn && !isAuthRoute) {
        return RoutePaths.login;
      }

      if (isLoggedIn && isAuthRoute) {
        return RoutePaths.dashboard;
      }

      // Check clinic expiry for logged-in users on non-auth routes
      if (isLoggedIn && !isAuthRoute && !isExpiredRoute) {
        final isExpired = ref.read(clinicExpiredProvider);
        if (isExpired) {
          return RoutePaths.expired;
        }
      }

      // If clinic is no longer expired, redirect away from expired page
      if (isLoggedIn && isExpiredRoute) {
        final isExpired = ref.read(clinicExpiredProvider);
        if (!isExpired) {
          return RoutePaths.dashboard;
        }
      }

      if (user != null && location == RoutePaths.settings) {
        final role = ref.read(currentUserRoleProvider);
        if (role == UserRole.reception) {
          return RoutePaths.dashboard;
        }
      }

      return null;
    },
    routes: [
      GoRoute(
        path: RoutePaths.login,
        pageBuilder: (context, state) =>
            _fadeTransition(state: state, child: const LoginPage()),
      ),
      GoRoute(
        path: RoutePaths.register,
        pageBuilder: (context, state) =>
            _fadeTransition(state: state, child: const RegisterPage()),
      ),
      GoRoute(
        path: RoutePaths.forgotPassword,
        pageBuilder: (context, state) =>
            _fadeTransition(state: state, child: const ForgotPasswordPage()),
      ),
      GoRoute(
        path: RoutePaths.dashboard,
        pageBuilder: (context, state) =>
            _fadeTransition(state: state, child: const DashboardPage()),
      ),
      GoRoute(
        path: RoutePaths.patients,
        pageBuilder: (context, state) =>
            _fadeTransition(state: state, child: const PatientsPage()),
      ),
      GoRoute(
        path: RoutePaths.patientCreate,
        pageBuilder: (context, state) =>
            _fadeTransition(state: state, child: const PatientFormPage()),
      ),
      GoRoute(
        path: RoutePaths.patientProfile,
        pageBuilder: (context, state) => _fadeTransition(
          state: state,
          child: PatientProfilePage(
            patientId: state.pathParameters['patientId']!,
          ),
        ),
      ),
      GoRoute(
        path: RoutePaths.patientEdit,
        pageBuilder: (context, state) => _fadeTransition(
          state: state,
          child: PatientFormPage(patientId: state.pathParameters['patientId']),
        ),
      ),
      GoRoute(
        path: RoutePaths.appointments,
        pageBuilder: (context, state) =>
            _fadeTransition(state: state, child: const AppointmentsPage()),
      ),
      GoRoute(
        path: RoutePaths.todayVisits,
        pageBuilder: (context, state) =>
            _fadeTransition(state: state, child: const TodayVisitsPage()),
      ),
      GoRoute(
        path: RoutePaths.doctors,
        pageBuilder: (context, state) =>
            _fadeTransition(state: state, child: const DoctorsPage()),
      ),
      GoRoute(
        path: RoutePaths.dental,
        pageBuilder: (context, state) =>
            _fadeTransition(state: state, child: const DentalChartPage()),
      ),
      GoRoute(
        path: RoutePaths.payments,
        pageBuilder: (context, state) =>
            _fadeTransition(state: state, child: const PaymentsPage()),
      ),
      GoRoute(
        path: RoutePaths.settings,
        pageBuilder: (context, state) =>
            _fadeTransition(state: state, child: const SettingsPage()),
      ),
      GoRoute(
        path: RoutePaths.expired,
        pageBuilder: (context, state) =>
            _fadeTransition(state: state, child: const ExpiredClinicPage()),
      ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text(context.l10n.tr('noData')))),
  );
});

class _GoRouterRefreshStream extends ChangeNotifier {
  _GoRouterRefreshStream(Stream<dynamic> stream, [dynamic extra]) {
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
    if (extra is bool) {
      // Just a stub - we actually notify listeners when the provider changes
      // because we watch it in the builder.
    }
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

CustomTransitionPage<void> _fadeTransition({
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final slide = Tween<Offset>(
        begin: const Offset(0.03, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));
      return FadeTransition(
        opacity: animation,
        child: SlideTransition(position: slide, child: child),
      );
    },
  );
}
