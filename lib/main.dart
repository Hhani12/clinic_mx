import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/services/firebase/firebase_initializer.dart';
import 'core/services/notifications/fcm_service.dart';
import 'core/services/notifications/local_notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseInitializer.initialize();
  await LocalNotificationService.instance.initialize();
  await FcmService.instance.initialize();
  runApp(const ProviderScope(child: ClinicMxApp()));
}
