import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

import 'initial_import_service.dart';
import 'pull_service.dart';
import 'push_service.dart';

enum SyncStatus { offline, syncing, online, error }

class SyncOrchestrator {
  final PushService _pushService;
  final PullService _pullService;
  final InitialImportService _importService;
  final Connectivity _connectivity;

  Timer? _pushTimer;
  StreamSubscription<List<ConnectivityResult>>? _connSub;
  bool _isOnline = false;
  String? _clinicId;

  final _statusNotifier = ValueNotifier<SyncStatus>(SyncStatus.offline);
  ValueListenable<SyncStatus> get status => _statusNotifier;

  SyncOrchestrator(
    this._pushService,
    this._pullService,
    this._importService,
    this._connectivity,
  );

  Future<void> start(String clinicId) async {
    _clinicId = clinicId;

    _connSub = _connectivity.onConnectivityChanged.listen((results) {
      final online = results.any((r) => r != ConnectivityResult.none);
      if (online && !_isOnline) {
        _goOnline();
      } else if (!online && _isOnline) {
        _goOffline();
      }
      _isOnline = online;
    });

    final results = await _connectivity.checkConnectivity();
    _isOnline = results.any((r) => r != ConnectivityResult.none);
    if (_isOnline) {
      await _goOnline();
    }
  }

  void stop() {
    _pushTimer?.cancel();
    _pullService.stopListening();
    _connSub?.cancel();
    _statusNotifier.value = SyncStatus.offline;
    _clinicId = null;
  }

  Future<void> _goOnline() async {
    final clinicId = _clinicId;
    if (clinicId == null) return;

    _statusNotifier.value = SyncStatus.syncing;

    try {
      // Run initial import if needed.
      await _importService.importIfNeeded(clinicId);

      // Start real-time pull listeners.
      _pullService.startListening(clinicId);

      // Flush pending local changes.
      await _pushService.pushAll();

      // Periodic push every 30 seconds.
      _pushTimer?.cancel();
      _pushTimer = Timer.periodic(
        const Duration(seconds: 30),
        (_) => _pushService.pushAll(),
      );

      _statusNotifier.value = SyncStatus.online;
    } catch (e) {
      debugPrint('Sync startup error: $e');
      _statusNotifier.value = SyncStatus.error;
    }
  }

  void _goOffline() {
    _pushTimer?.cancel();
    _pullService.stopListening();
    _statusNotifier.value = SyncStatus.offline;
  }

  /// Force-push all pending changes (e.g., before app exit).
  Future<int> forcePush() => _pushService.pushAll();
}
