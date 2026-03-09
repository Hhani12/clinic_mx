import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class FcmService {
  FcmService._();

  static final FcmService instance = FcmService._();

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;
    if (kIsWeb || Platform.isWindows || Platform.isLinux) {
      _initialized = true;
      return;
    }

    final messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    final token = await messaging.getToken();
    await _upsertToken(token);

    FirebaseMessaging.instance.onTokenRefresh.listen(_upsertToken);

    _initialized = true;
  }

  Future<void> _upsertToken(String? token) async {
    if (token == null || token.isEmpty) return;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'fcmToken': token,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}
