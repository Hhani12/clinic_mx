import 'package:cloud_firestore/cloud_firestore.dart';

class ReminderLog {
  const ReminderLog({
    required this.id,
    required this.clinicId,
    required this.appointmentId,
    required this.patientId,
    required this.channel,
    required this.status,
    required this.providerResponse,
    required this.scheduledFor,
    required this.executedAt,
  });

  final String id;
  final String clinicId;
  final String appointmentId;
  final String patientId;
  final String channel;
  final String status;
  final String providerResponse;
  final DateTime scheduledFor;
  final DateTime executedAt;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clinicId': clinicId,
      'appointmentId': appointmentId,
      'patientId': patientId,
      'channel': channel,
      'status': status,
      'providerResponse': providerResponse,
      'scheduledFor': Timestamp.fromDate(scheduledFor),
      'executedAt': Timestamp.fromDate(executedAt),
    };
  }

  factory ReminderLog.fromMap({
    required String id,
    required Map<String, dynamic> map,
  }) {
    return ReminderLog(
      id: id,
      clinicId: map['clinicId'] as String? ?? '',
      appointmentId: map['appointmentId'] as String? ?? '',
      patientId: map['patientId'] as String? ?? '',
      channel: map['channel'] as String? ?? '',
      status: map['status'] as String? ?? '',
      providerResponse: map['providerResponse'] as String? ?? '',
      scheduledFor: _asDateTime(map['scheduledFor']) ?? DateTime.now(),
      executedAt: _asDateTime(map['executedAt']) ?? DateTime.now(),
    );
  }

  static DateTime? _asDateTime(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    return null;
  }
}
