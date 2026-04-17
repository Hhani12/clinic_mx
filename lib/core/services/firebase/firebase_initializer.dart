import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../../../firebase_options.dart';

class FirebaseInitializer {
  const FirebaseInitializer._();

  static Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Firestore persistence causes native crashes on Windows desktop
    // (Firebase C++ SDK / LevelDB issue). Only enable on mobile / web.
    final enablePersistence =
        kIsWeb || (!Platform.isWindows && !Platform.isLinux);
    FirebaseFirestore.instance.settings = Settings(
      persistenceEnabled: enablePersistence,
    );
  }
}
