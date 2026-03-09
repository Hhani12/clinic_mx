import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/enums/visit_status.dart';

class Appointment {
  const Appointment({
    required this.id,
    required this.clinicId,
    required this.patientId,
    required this.patientName,
    required this.patientPhone,
    required this.startAt,
    required this.durationMinutes,
    required this.reason,
    required this.status,
    required this.doctorId,
    required this.createdAt,
    required this.updatedAt,
    this.reminderSent = false,
  });

  final String id;
  final String clinicId;
  final String patientId;
  final String patientName;
  final String patientPhone;
  final DateTime startAt;
  final int durationMinutes;
  final String reason;
  final VisitStatus status;
  final String doctorId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool reminderSent;

  DateTime get endAt => startAt.add(Duration(minutes: durationMinutes));

  Appointment copyWith({
    String? id,
    String? clinicId,
    String? patientId,
    String? patientName,
    String? patientPhone,
    DateTime? startAt,
    int? durationMinutes,
    String? reason,
    VisitStatus? status,
    String? doctorId,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? reminderSent,
  }) {
    return Appointment(
      id: id ?? this.id,
      clinicId: clinicId ?? this.clinicId,
      patientId: patientId ?? this.patientId,
      patientName: patientName ?? this.patientName,
      patientPhone: patientPhone ?? this.patientPhone,
      startAt: startAt ?? this.startAt,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      reason: reason ?? this.reason,
      status: status ?? this.status,
      doctorId: doctorId ?? this.doctorId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      reminderSent: reminderSent ?? this.reminderSent,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clinicId': clinicId,
      'patientId': patientId,
      'patientName': patientName,
      'patientPhone': patientPhone,
      'startAt': Timestamp.fromDate(startAt),
      'durationMinutes': durationMinutes,
      'reason': reason,
      'status': status.value,
      'doctorId': doctorId,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'reminderSent': reminderSent,
    };
  }

  factory Appointment.fromMap({
    required String id,
    required Map<String, dynamic> map,
  }) {
    return Appointment(
      id: id,
      clinicId: map['clinicId'] as String? ?? '',
      patientId: map['patientId'] as String? ?? '',
      patientName: map['patientName'] as String? ?? '',
      patientPhone: map['patientPhone'] as String? ?? '',
      startAt: _asDateTime(map['startAt']) ?? DateTime.now(),
      durationMinutes: (map['durationMinutes'] as num?)?.toInt() ?? 30,
      reason: map['reason'] as String? ?? '',
      status: VisitStatusX.fromString(map['status'] as String?),
      doctorId: map['doctorId'] as String? ?? '',
      createdAt: _asDateTime(map['createdAt']) ?? DateTime.now(),
      updatedAt: _asDateTime(map['updatedAt']) ?? DateTime.now(),
      reminderSent: map['reminderSent'] as bool? ?? false,
    );
  }

  static DateTime? _asDateTime(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    return null;
  }
}
