import 'package:cloud_firestore/cloud_firestore.dart';

class DentalPlanItem {
  const DentalPlanItem({
    required this.id,
    required this.clinicId,
    required this.patientId,
    required this.toothId,
    required this.numberingSystem,
    required this.actionLabel,
    required this.note,
    required this.timestamp,
    required this.doctorId,
  });

  final String id;
  final String clinicId;
  final String patientId;
  final String toothId;
  final String numberingSystem;
  final String actionLabel;
  final String note;
  final DateTime timestamp;
  final String doctorId;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clinicId': clinicId,
      'patientId': patientId,
      'toothId': toothId,
      'numberingSystem': numberingSystem,
      'actionLabel': actionLabel,
      'note': note,
      'timestamp': Timestamp.fromDate(timestamp),
      'doctorId': doctorId,
    };
  }

  factory DentalPlanItem.fromMap({
    required String id,
    required Map<String, dynamic> map,
  }) {
    return DentalPlanItem(
      id: id,
      clinicId: map['clinicId'] as String? ?? '',
      patientId: map['patientId'] as String? ?? '',
      toothId: map['toothId'] as String? ?? '',
      numberingSystem: map['numberingSystem'] as String? ?? 'fdi',
      actionLabel: map['actionLabel'] as String? ?? '',
      note: map['note'] as String? ?? '',
      timestamp: _asDateTime(map['timestamp']) ?? DateTime.now(),
      doctorId: map['doctorId'] as String? ?? '',
    );
  }

  static DateTime? _asDateTime(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    return null;
  }
}
