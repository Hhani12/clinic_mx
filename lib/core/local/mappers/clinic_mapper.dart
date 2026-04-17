import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../features/settings/domain/entities/clinic.dart';
import '../app_database.dart';

class ClinicMapper {
  const ClinicMapper._();

  static LocalClinicsCompanion toCompanion(
    Clinic c, {
    bool synced = false,
  }) {
    return LocalClinicsCompanion.insert(
      id: c.id,
      name: c.name,
      phone: Value(c.phone),
      city: Value(c.city),
      district: Value(c.district),
      address: Value(c.address),
      updatedAt: c.updatedAt,
      createdAt: Value(c.createdAt),
      expiresAt: Value(c.expiresAt),
      active: Value(c.active),
      reactivationHistoryJson: Value(jsonEncode(
        c.reactivationHistory.map(_reactivationToMap).toList(),
      )),
      isSynced: Value(synced),
    );
  }

  static Clinic fromRow(LocalClinic row) {
    final rawList =
        jsonDecode(row.reactivationHistoryJson) as List<dynamic>;
    return Clinic(
      id: row.id,
      name: row.name,
      phone: row.phone,
      city: row.city,
      district: row.district,
      address: row.address,
      updatedAt: row.updatedAt,
      createdAt: row.createdAt,
      expiresAt: row.expiresAt,
      active: row.active,
      reactivationHistory: rawList
          .whereType<Map<String, dynamic>>()
          .map(_reactivationFromMap)
          .toList(),
    );
  }

  static Map<String, dynamic> toPayload(Clinic c) {
    return {
      'id': c.id,
      'name': c.name,
      'phone': c.phone,
      'city': c.city,
      'district': c.district,
      'address': c.address,
      'updatedAt': c.updatedAt.toIso8601String(),
      'createdAt': c.createdAt?.toIso8601String(),
      'expiresAt': c.expiresAt?.toIso8601String(),
      'active': c.active,
      'reactivationHistory':
          c.reactivationHistory.map(_reactivationToMap).toList(),
    };
  }

  static Map<String, dynamic> _reactivationToMap(ReactivationRecord r) {
    return {
      'reactivatedAt': r.reactivatedAt.toIso8601String(),
      'reactivatedBy': r.reactivatedBy,
      'newExpiresAt': r.newExpiresAt.toIso8601String(),
    };
  }

  static ReactivationRecord _reactivationFromMap(Map<String, dynamic> m) {
    return ReactivationRecord(
      reactivatedAt:
          DateTime.tryParse(m['reactivatedAt'] as String? ?? '') ??
              DateTime.now(),
      reactivatedBy: m['reactivatedBy'] as String? ?? '',
      newExpiresAt:
          DateTime.tryParse(m['newExpiresAt'] as String? ?? '') ??
              DateTime.now(),
    );
  }
}
