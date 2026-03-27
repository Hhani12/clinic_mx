import 'package:cloud_firestore/cloud_firestore.dart';

class ReactivationRecord {
  const ReactivationRecord({
    required this.reactivatedAt,
    required this.reactivatedBy,
    required this.newExpiresAt,
  });

  final DateTime reactivatedAt;
  final String reactivatedBy;
  final DateTime newExpiresAt;

  Map<String, dynamic> toMap() => {
    'reactivatedAt': Timestamp.fromDate(reactivatedAt),
    'reactivatedBy': reactivatedBy,
    'newExpiresAt': Timestamp.fromDate(newExpiresAt),
  };

  factory ReactivationRecord.fromMap(Map<String, dynamic> map) {
    return ReactivationRecord(
      reactivatedAt: _asDateTime(map['reactivatedAt']) ?? DateTime.now(),
      reactivatedBy: map['reactivatedBy'] as String? ?? '',
      newExpiresAt: _asDateTime(map['newExpiresAt']) ?? DateTime.now(),
    );
  }

  static DateTime? _asDateTime(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    return null;
  }
}

class Clinic {
  const Clinic({
    required this.id,
    required this.name,
    this.phone,
    this.city,
    this.district,
    this.address,
    required this.updatedAt,
    this.createdAt,
    this.expiresAt,
    this.active = true,
    this.reactivationHistory = const [],
  });

  final String id;
  final String name;
  final String? phone;
  final String? city;
  final String? district;
  final String? address;
  final DateTime updatedAt;
  final DateTime? createdAt;
  final DateTime? expiresAt;
  final bool active;
  final List<ReactivationRecord> reactivationHistory;

  bool get isExpired {
    if (!active) return true;
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }

  int? get daysRemaining {
    if (expiresAt == null) return null;
    final diff = expiresAt!.difference(DateTime.now()).inDays;
    return diff < 0 ? 0 : diff;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'city': city,
      'district': district,
      'address': address,
      'updatedAt': Timestamp.fromDate(updatedAt),
      if (createdAt != null) 'createdAt': Timestamp.fromDate(createdAt!),
      if (expiresAt != null) 'expiresAt': Timestamp.fromDate(expiresAt!),
      'active': active,
      'reactivationHistory':
          reactivationHistory.map((r) => r.toMap()).toList(),
    };
  }

  factory Clinic.fromMap({
    required String id,
    required Map<String, dynamic> map,
  }) {
    final rawHistory =
        map['reactivationHistory'] as List<dynamic>? ?? [];
    return Clinic(
      id: id,
      name: map['name'] as String? ?? '',
      phone: map['phone'] as String?,
      city: map['city'] as String?,
      district: map['district'] as String?,
      address: map['address'] as String?,
      updatedAt: _asDateTime(map['updatedAt']) ?? DateTime.now(),
      createdAt: _asDateTime(map['createdAt']),
      expiresAt: _asDateTime(map['expiresAt']),
      active: map['active'] as bool? ?? true,
      reactivationHistory: rawHistory
          .whereType<Map<String, dynamic>>()
          .map(ReactivationRecord.fromMap)
          .toList(),
    );
  }

  static DateTime? _asDateTime(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    return null;
  }
}
