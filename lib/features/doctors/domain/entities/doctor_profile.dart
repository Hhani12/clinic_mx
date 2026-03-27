import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorProfile {
  const DoctorProfile({
    required this.id,
    required this.clinicId,
    required this.fullName,
    this.phone,
    this.specialty,
    this.address,
    this.notes,
    required this.monthlySalaryIqd,
    required this.commissionPercent,
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
  });

  final String id;
  final String clinicId;
  final String fullName;
  final String? phone;
  final String? specialty;
  final String? address;
  final String? notes;
  final double monthlySalaryIqd;
  final double commissionPercent;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;

  DoctorProfile copyWith({
    String? id,
    String? clinicId,
    String? fullName,
    String? phone,
    String? specialty,
    String? address,
    String? notes,
    double? monthlySalaryIqd,
    double? commissionPercent,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
  }) {
    return DoctorProfile(
      id: id ?? this.id,
      clinicId: clinicId ?? this.clinicId,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      specialty: specialty ?? this.specialty,
      address: address ?? this.address,
      notes: notes ?? this.notes,
      monthlySalaryIqd: monthlySalaryIqd ?? this.monthlySalaryIqd,
      commissionPercent: commissionPercent ?? this.commissionPercent,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clinicId': clinicId,
      'fullName': fullName,
      'phone': phone,
      'specialty': specialty,
      'address': address,
      'notes': notes,
      'monthlySalaryIqd': monthlySalaryIqd,
      'commissionPercent': commissionPercent,
      'isActive': isActive,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  factory DoctorProfile.fromMap({
    required String id,
    required Map<String, dynamic> map,
  }) {
    return DoctorProfile(
      id: id,
      clinicId: map['clinicId'] as String? ?? '',
      fullName: map['fullName'] as String? ?? '',
      phone: map['phone'] as String?,
      specialty: map['specialty'] as String?,
      address: map['address'] as String?,
      notes: map['notes'] as String?,
      monthlySalaryIqd: (map['monthlySalaryIqd'] as num?)?.toDouble() ?? 0,
      commissionPercent: (map['commissionPercent'] as num?)?.toDouble() ?? 0,
      isActive: map['isActive'] as bool? ?? true,
      createdAt: _asDateTime(map['createdAt']) ?? DateTime.now(),
      updatedAt: _asDateTime(map['updatedAt']) ?? DateTime.now(),
    );
  }

  static DateTime? _asDateTime(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    return null;
  }
}
