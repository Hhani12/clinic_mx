import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

/// Replace placeholder values by running:
/// flutterfire configure --project=YOUR_PROJECT_ID
class DefaultFirebaseOptions {
  const DefaultFirebaseOptions._();

  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        return linux;
      default:
        throw UnsupportedError('Unsupported platform for Firebase options');
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDxZ1E6BAYousGh7iRgprw0Yxzbeq4zqVc',
    appId: '1:84831891270:web:71191754b35e032f003f47',
    messagingSenderId: '84831891270',
    projectId: 'clinic-4d17f',
    authDomain: 'clinic-4d17f.firebaseapp.com',
    storageBucket: 'clinic-4d17f.firebasestorage.app',
    measurementId: 'G-J6KRGR52MG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAziwLYUILMpnBW1t97ZLsnuGG_YI3U9uA',
    appId: '1:84831891270:android:b914ffaf7d181a58003f47',
    messagingSenderId: '84831891270',
    projectId: 'clinic-4d17f',
    storageBucket: 'clinic-4d17f.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAGDm928uhD1QHlzqCDX0mUUp1jc6zRYZY',
    appId: '1:84831891270:ios:9817b77d07f0a55a003f47',
    messagingSenderId: '84831891270',
    projectId: 'clinic-4d17f',
    storageBucket: 'clinic-4d17f.firebasestorage.app',
    iosBundleId: 'com.example.clinic',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAGDm928uhD1QHlzqCDX0mUUp1jc6zRYZY',
    appId: '1:84831891270:ios:9817b77d07f0a55a003f47',
    messagingSenderId: '84831891270',
    projectId: 'clinic-4d17f',
    storageBucket: 'clinic-4d17f.firebasestorage.app',
    iosBundleId: 'com.example.clinic',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDxZ1E6BAYousGh7iRgprw0Yxzbeq4zqVc',
    appId: '1:84831891270:web:52fed967e548292d003f47',
    messagingSenderId: '84831891270',
    projectId: 'clinic-4d17f',
    authDomain: 'clinic-4d17f.firebaseapp.com',
    storageBucket: 'clinic-4d17f.firebasestorage.app',
    measurementId: 'G-DJ2PER0D6N',
  );

  static const FirebaseOptions linux = FirebaseOptions(
    apiKey: 'LINUX_API_KEY',
    appId: '1:000000000000:web:replace',
    messagingSenderId: '000000000000',
    projectId: 'clinic-mx-project',
    authDomain: 'clinic-mx-project.firebaseapp.com',
    storageBucket: 'clinic-mx-project.firebasestorage.app',
  );
}