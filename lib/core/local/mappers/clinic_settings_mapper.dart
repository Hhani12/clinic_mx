import 'dart:convert';

import 'package:drift/drift.dart';

import '../../config/app_config.dart';
import '../../../features/settings/domain/entities/clinic_settings.dart';
import '../app_database.dart';

class ClinicSettingsMapper {
  const ClinicSettingsMapper._();

  static LocalClinicSettingsCompanion toCompanion(
    String clinicId,
    ClinicSettings s, {
    bool synced = false,
  }) {
    return LocalClinicSettingsCompanion.insert(
      clinicId: clinicId,
      reminderOffsetHours: Value(s.reminderOffsetHours),
      teethNumberingSystem: Value(s.teethNumberingSystem.name),
      toothActionsJson: Value(jsonEncode(s.toothActions)),
      whatsAppEnabled: Value(s.whatsAppEnabled),
      whatsAppSenderNumber: Value(s.whatsAppSenderNumber),
      whatsAppPhoneNumberId: Value(s.whatsAppPhoneNumberId),
      smsEnabled: Value(s.smsEnabled),
      emailEnabled: Value(s.emailEnabled),
      phoneAuthEnabled: Value(s.phoneAuthEnabled),
      isSynced: Value(synced),
    );
  }

  static ClinicSettings fromRow(LocalClinicSetting row) {
    return ClinicSettings(
      reminderOffsetHours: row.reminderOffsetHours,
      teethNumberingSystem: _parseTeethSystem(row.teethNumberingSystem),
      toothActions: _decodeStringList(row.toothActionsJson),
      whatsAppEnabled: row.whatsAppEnabled,
      whatsAppSenderNumber: row.whatsAppSenderNumber,
      whatsAppPhoneNumberId: row.whatsAppPhoneNumberId,
      smsEnabled: row.smsEnabled,
      emailEnabled: row.emailEnabled,
      phoneAuthEnabled: row.phoneAuthEnabled,
    );
  }

  static Map<String, dynamic> toPayload(ClinicSettings s) {
    return {
      'reminderOffsetHours': s.reminderOffsetHours,
      'teethNumberingSystem': s.teethNumberingSystem.name,
      'toothActions': s.toothActions,
      'whatsAppEnabled': s.whatsAppEnabled,
      'whatsAppSenderNumber': s.whatsAppSenderNumber,
      'whatsAppPhoneNumberId': s.whatsAppPhoneNumberId,
      'smsEnabled': s.smsEnabled,
      'emailEnabled': s.emailEnabled,
      'phoneAuthEnabled': s.phoneAuthEnabled,
    };
  }

  static TeethNumberingSystem _parseTeethSystem(String value) {
    if (value == TeethNumberingSystem.universal.name) {
      return TeethNumberingSystem.universal;
    }
    return TeethNumberingSystem.fdi;
  }

  static List<String> _decodeStringList(String json) {
    final list = jsonDecode(json) as List<dynamic>;
    return list.whereType<String>().toList();
  }
}
