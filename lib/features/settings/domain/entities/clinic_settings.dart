import '../../../../core/config/app_config.dart';

class ClinicSettings {
  const ClinicSettings({
    required this.reminderOffsetHours,
    required this.teethNumberingSystem,
    required this.toothActions,
    required this.whatsAppEnabled,
    this.whatsAppSenderNumber,
    this.whatsAppPhoneNumberId,
    required this.smsEnabled,
    required this.emailEnabled,
    required this.phoneAuthEnabled,
  });

  final int reminderOffsetHours;
  final TeethNumberingSystem teethNumberingSystem;
  final List<String> toothActions;
  final bool whatsAppEnabled;
  final String? whatsAppSenderNumber;
  final String? whatsAppPhoneNumberId;
  final bool smsEnabled;
  final bool emailEnabled;
  final bool phoneAuthEnabled;

  ClinicSettings copyWith({
    int? reminderOffsetHours,
    TeethNumberingSystem? teethNumberingSystem,
    List<String>? toothActions,
    bool? whatsAppEnabled,
    String? whatsAppSenderNumber,
    String? whatsAppPhoneNumberId,
    bool? smsEnabled,
    bool? emailEnabled,
    bool? phoneAuthEnabled,
  }) {
    return ClinicSettings(
      reminderOffsetHours: reminderOffsetHours ?? this.reminderOffsetHours,
      teethNumberingSystem: teethNumberingSystem ?? this.teethNumberingSystem,
      toothActions: toothActions ?? this.toothActions,
      whatsAppEnabled: whatsAppEnabled ?? this.whatsAppEnabled,
      whatsAppSenderNumber: whatsAppSenderNumber ?? this.whatsAppSenderNumber,
      whatsAppPhoneNumberId:
          whatsAppPhoneNumberId ?? this.whatsAppPhoneNumberId,
      smsEnabled: smsEnabled ?? this.smsEnabled,
      emailEnabled: emailEnabled ?? this.emailEnabled,
      phoneAuthEnabled: phoneAuthEnabled ?? this.phoneAuthEnabled,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'reminderOffsetHours': reminderOffsetHours,
      'teethNumberingSystem': teethNumberingSystem.name,
      'toothActions': toothActions,
      'whatsAppEnabled': whatsAppEnabled,
      'whatsAppSenderNumber': whatsAppSenderNumber,
      'whatsAppPhoneNumberId': whatsAppPhoneNumberId,
      'smsEnabled': smsEnabled,
      'emailEnabled': emailEnabled,
      'phoneAuthEnabled': phoneAuthEnabled,
    };
  }

  factory ClinicSettings.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return const ClinicSettings(
        reminderOffsetHours: AppConfig.defaultReminderOffsetHours,
        teethNumberingSystem: AppConfig.defaultTeethNumbering,
        toothActions: [
          'Extraction',
          'Filling',
          'Cleaning',
          'Orthodontics',
          'Root canal',
        ],
        whatsAppEnabled: true,
        whatsAppSenderNumber: null,
        whatsAppPhoneNumberId: null,
        smsEnabled: false,
        emailEnabled: false,
        phoneAuthEnabled: AppConfig.phoneAuthEnabled,
      );
    }

    return ClinicSettings(
      reminderOffsetHours: (map['reminderOffsetHours'] as num?)?.toInt() ??
          AppConfig.defaultReminderOffsetHours,
      teethNumberingSystem: _parseTeethSystem(
        map['teethNumberingSystem'] as String?,
      ),
      toothActions: (map['toothActions'] as List<dynamic>? ?? const [
        'Extraction',
        'Filling',
        'Cleaning',
        'Orthodontics',
        'Root canal',
      ]).whereType<String>().toList(),
      whatsAppEnabled: map['whatsAppEnabled'] as bool? ?? true,
      whatsAppSenderNumber: _asTrimmedString(map['whatsAppSenderNumber']),
      whatsAppPhoneNumberId: _asTrimmedString(map['whatsAppPhoneNumberId']),
      smsEnabled: map['smsEnabled'] as bool? ?? false,
      emailEnabled: map['emailEnabled'] as bool? ?? false,
      phoneAuthEnabled: map['phoneAuthEnabled'] as bool? ?? false,
    );
  }

  static TeethNumberingSystem _parseTeethSystem(String? value) {
    if (value == TeethNumberingSystem.universal.name) {
      return TeethNumberingSystem.universal;
    }
    return TeethNumberingSystem.fdi;
  }

  static String? _asTrimmedString(dynamic value) {
    if (value is! String) return null;
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
}
