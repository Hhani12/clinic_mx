import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/presentation/providers/auth_providers.dart';
import 'sync_providers.dart';

/// Kicks off the sync engine on desktop platforms.
/// Watch this provider after auth resolves to start syncing.
final syncInitializerProvider = FutureProvider<void>((ref) async {
  // Only run on desktop (this provider should never be watched on web).
  if (kIsWeb) return;

  final clinicId = ref.watch(currentClinicIdProvider);
  if (clinicId == null || clinicId.isEmpty) return;

  final orchestrator = ref.watch(syncOrchestratorProvider);
  await orchestrator.start(clinicId);
});
