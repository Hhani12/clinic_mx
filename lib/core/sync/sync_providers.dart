import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../local/local_providers.dart';
import '../services/firebase/firebase_providers.dart';
import 'initial_import_service.dart';
import 'pull_service.dart';
import 'push_service.dart';
import 'sync_orchestrator.dart';

final pushServiceProvider = Provider<PushService>((ref) {
  return PushService(
    ref.watch(appDatabaseProvider),
    ref.watch(firestoreProvider),
    ref.watch(patientsLocalDaoProvider),
    ref.watch(appointmentsLocalDaoProvider),
    ref.watch(doctorsLocalDaoProvider),
    ref.watch(paymentsLocalDaoProvider),
    ref.watch(toothRecordsLocalDaoProvider),
    ref.watch(dentalPlansLocalDaoProvider),
    ref.watch(clinicLocalDaoProvider),
  );
});

final pullServiceProvider = Provider<PullService>((ref) {
  return PullService(
    ref.watch(firestoreProvider),
    ref.watch(patientsLocalDaoProvider),
    ref.watch(appointmentsLocalDaoProvider),
    ref.watch(doctorsLocalDaoProvider),
    ref.watch(paymentsLocalDaoProvider),
    ref.watch(toothRecordsLocalDaoProvider),
    ref.watch(dentalPlansLocalDaoProvider),
    ref.watch(clinicLocalDaoProvider),
  );
});

final initialImportServiceProvider = Provider<InitialImportService>((ref) {
  return InitialImportService(
    ref.watch(appDatabaseProvider),
    ref.watch(firestoreProvider),
    ref.watch(patientsLocalDaoProvider),
    ref.watch(appointmentsLocalDaoProvider),
    ref.watch(doctorsLocalDaoProvider),
    ref.watch(paymentsLocalDaoProvider),
    ref.watch(toothRecordsLocalDaoProvider),
    ref.watch(dentalPlansLocalDaoProvider),
    ref.watch(clinicLocalDaoProvider),
  );
});

final syncOrchestratorProvider = Provider<SyncOrchestrator>((ref) {
  final orchestrator = SyncOrchestrator(
    ref.watch(pushServiceProvider),
    ref.watch(pullServiceProvider),
    ref.watch(initialImportServiceProvider),
    Connectivity(),
  );
  ref.onDispose(orchestrator.stop);
  return orchestrator;
});
