enum TeethNumberingSystem { fdi, universal }

class AppConfig {
  const AppConfig._();

  static const bool phoneAuthEnabled = false;
  static const int defaultReminderOffsetHours = 24;
  static const TeethNumberingSystem defaultTeethNumbering =
      TeethNumberingSystem.fdi;
}
