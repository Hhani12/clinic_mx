import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Session manager for handling user authentication state
///
/// Provides secure storage for session tokens and persists
/// user session across app restarts
class SessionManager {
  SessionManager._();

  static final SessionManager _instance = SessionManager._();
  static SessionManager get instance => _instance;

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  static const String _sessionTokenKey = 'session_token';
  static const String _sessionExpiryKey = 'session_expiry';
  static const String _lastLoginEmailKey = 'last_login_email';
  static const String _rememberMeKey = 'remember_me';

  StreamController<bool> _sessionChangedController = StreamController<bool>.broadcast();
  Stream<bool> get sessionChangedStream => _sessionChangedController.stream;

  /// Initialize session manager
  Future<void> init() async {
    debugPrint('SessionManager initialized');
  }

  /// Check if user has a valid session
  Future<bool> hasValidSession() async {
    try {
      final expiryStr = await _secureStorage.read(key: _sessionExpiryKey);
      if (expiryStr == null) return false;

      final expiry = DateTime.parse(expiryStr);
      final isValid = expiry.isAfter(DateTime.now());

      if (!isValid) {
        await clearSession();
      }

      return isValid;
    } catch (e) {
      debugPrint('Error checking session: $e');
      return false;
    }
  }

  /// Create a new session after successful login
  Future<void> createSession({
    required String email,
    required bool rememberMe,
    Duration duration = const Duration(hours: 24),
  }) async {
    try {
      final now = DateTime.now();
      final expiry = now.add(duration);

      // Generate a session token (could be enhanced with actual JWT)
      final sessionToken = '${email}_$now';

      await _secureStorage.write(key: _sessionTokenKey, value: sessionToken);
      await _secureStorage.write(key: _sessionExpiryKey, value: expiry.toIso8601String());

      if (rememberMe) {
        await _secureStorage.write(key: _lastLoginEmailKey, value: email);
        await _secureStorage.write(key: _rememberMeKey, value: 'true');
      } else {
        await _secureStorage.delete(key: _lastLoginEmailKey);
        await _secureStorage.delete(key: _rememberMeKey);
      }

      _sessionChangedController.add(true);
      debugPrint('Session created for $email, expires at $expiry');
    } catch (e) {
      debugPrint('Error creating session: $e');
      rethrow;
    }
  }

  /// Clear the current session (logout)
  Future<void> clearSession() async {
    try {
      await _secureStorage.delete(key: _sessionTokenKey);
      await _secureStorage.delete(key: _sessionExpiryKey);
      // Keep last login email for convenience

      _sessionChangedController.add(false);
      debugPrint('Session cleared');
    } catch (e) {
      debugPrint('Error clearing session: $e');
    }
  }

  /// Get the last login email (for "Remember Me" feature)
  Future<String?> getLastLoginEmail() async {
    try {
      return await _secureStorage.read(key: _lastLoginEmailKey);
    } catch (e) {
      debugPrint('Error getting last login email: $e');
      return null;
    }
  }

  /// Check if "Remember Me" was selected
  Future<bool> shouldRememberMe() async {
    try {
      final value = await _secureStorage.read(key: _rememberMeKey);
      return value == 'true';
    } catch (e) {
      debugPrint('Error checking remember me: $e');
      return false;
    }
  }

  /// Get session expiry time
  Future<DateTime?> getSessionExpiry() async {
    try {
      final expiryStr = await _secureStorage.read(key: _sessionExpiryKey);
      if (expiryStr == null) return null;
      return DateTime.parse(expiryStr);
    } catch (e) {
      debugPrint('Error getting session expiry: $e');
      return null;
    }
  }

  /// Extend the current session
  Future<void> extendSession({Duration duration = const Duration(hours: 24)}) async {
    try {
      final currentToken = await _secureStorage.read(key: _sessionTokenKey);
      if (currentToken == null) return;

      final expiry = DateTime.now().add(duration);
      await _secureStorage.write(key: _sessionExpiryKey, value: expiry.toIso8601String());

      debugPrint('Session extended until $expiry');
    } catch (e) {
      debugPrint('Error extending session: $e');
    }
  }

  /// Dispose resources
  void dispose() {
    _sessionChangedController.close();
  }
}
