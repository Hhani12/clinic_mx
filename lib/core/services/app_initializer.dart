import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase/firebase_initializer.dart';
import 'notifications/fcm_service.dart';
import 'notifications/local_notification_service.dart';

final appInitializerProvider = FutureProvider<void>((ref) async {
  await FirebaseInitializer.initialize();

  // Notification plugins can crash on Windows desktop release builds.
  // Initialize them in the background so they don't block app startup.
  Future<void>(() async {
    try {
      await LocalNotificationService.instance.initialize();
    } catch (e, s) {
      debugPrint('LocalNotificationService init failed: $e\n$s');
    }
    try {
      await FcmService.instance.initialize();
    } catch (e, s) {
      debugPrint('FcmService init failed: $e\n$s');
    }
  });
});
