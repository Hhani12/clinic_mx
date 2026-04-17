import 'package:flutter/foundation.dart';

/// Environment configuration loader
///
/// Loads configuration from .env file (not committed to git)
/// Falls back to default values in production
class EnvConfig {
  EnvConfig._();

  static String? _rootAdminEmail;
  static String? _rootAdminPassword;
  static String? _firebaseProjectId;
  static String? _whatsappToken;
  static String? _supportEmail;
  static int _sessionTimeoutMinutes = 60;

  /// Initialize environment configuration
  /// Call this early in app initialization
  static Future<void> init({Map<String, String>? envValues}) async {
    if (envValues != null) {
      _loadFromMap(envValues);
      return;
    }

    // In debug mode, try to load from .env file
    if (kDebugMode) {
      try {
        // Note: flutter_dotenv can be added for actual .env file loading
        // For now, we use the hardcoded dev credentials
        _rootAdminEmail = 'hhanii20032@gmail.com';
        _rootAdminPassword = 'Hhani12@';
        _firebaseProjectId = 'clinic-4d17f';
        _supportEmail = 'support@clinic.local';
      } catch (e) {
        debugPrint('Failed to load .env file: $e');
      }
    }

    // Production defaults
    _sessionTimeoutMinutes = 60;
  }

  static void _loadFromMap(Map<String, String> values) {
    _rootAdminEmail = values['ROOT_ADMIN_EMAIL'];
    _rootAdminPassword = values['ROOT_ADMIN_PASSWORD'];
    _firebaseProjectId = values['FIREBASE_PROJECT_ID'];
    _whatsappToken = values['WHATSAPP_TOKEN'];
    _supportEmail = values['SUPPORT_EMAIL'];

    final timeout = values['SESSION_TIMEOUT_MINUTES'];
    if (timeout != null) {
      _sessionTimeoutMinutes = int.tryParse(timeout) ?? 60;
    }
  }

  /// Root admin email for development bypass
  static String get rootAdminEmail => _rootAdminEmail ?? '';

  /// Root admin password for development bypass
  static String get rootAdminPassword => _rootAdminPassword ?? '';

  /// Firebase project ID
  static String get firebaseProjectId => _firebaseProjectId ?? 'clinic-4d17f';

  /// WhatsApp API token (for Cloud Functions)
  static String? get whatsappToken => _whatsappToken;

  /// Support email
  static String get supportEmail => _supportEmail ?? 'support@clinic.local';

  /// Session timeout in minutes
  static int get sessionTimeoutMinutes => _sessionTimeoutMinutes;

  /// Check if credentials match root admin
  static bool isRootAdmin(String email, String password) {
    return email == _rootAdminEmail && password == _rootAdminPassword;
  }
}
