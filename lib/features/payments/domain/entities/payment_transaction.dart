import 'package:cloud_firestore/cloud_firestore.dart';

enum PaymentMethod { cash, card, transfer }

extension PaymentMethodX on PaymentMethod {
  String get value {
    switch (this) {
      case PaymentMethod.cash:
        return 'cash';
      case PaymentMethod.card:
        return 'card';
      case PaymentMethod.transfer:
        return 'transfer';
    }
  }

  static PaymentMethod fromString(String? value) {
    switch (value) {
      case 'card':
        return PaymentMethod.card;
      case 'transfer':
        return PaymentMethod.transfer;
      case 'cash':
      default:
        return PaymentMethod.cash;
    }
  }
}

class PaymentTransaction {
  const PaymentTransaction({
    required this.id,
    required this.clinicId,
    required this.patientId,
    required this.patientName,
    required this.amount,
    required this.paid,
    required this.remaining,
    required this.method,
    required this.date,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.doctorId,
    this.doctorName,
    this.doctorShare = 0,
    this.appointmentId,
    this.notes,
  });

  final String id;
  final String clinicId;
  final String patientId;
  final String patientName;
  final String? doctorId;
  final String? doctorName;
  final double doctorShare;
  final String? appointmentId;
  final double amount;
  final double paid;
  final double remaining;
  final PaymentMethod method;
  final DateTime date;
  final String? notes;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  PaymentTransaction copyWith({
    String? id,
    String? clinicId,
    String? patientId,
    String? patientName,
    String? appointmentId,
    double? amount,
    double? paid,
    double? remaining,
    PaymentMethod? method,
    DateTime? date,
    String? notes,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? doctorId,
    String? doctorName,
    double? doctorShare,
  }) {
    return PaymentTransaction(
      id: id ?? this.id,
      clinicId: clinicId ?? this.clinicId,
      patientId: patientId ?? this.patientId,
      patientName: patientName ?? this.patientName,
      appointmentId: appointmentId ?? this.appointmentId,
      amount: amount ?? this.amount,
      paid: paid ?? this.paid,
      remaining: remaining ?? this.remaining,
      method: method ?? this.method,
      date: date ?? this.date,
      notes: notes ?? this.notes,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      doctorId: doctorId ?? this.doctorId,
      doctorName: doctorName ?? this.doctorName,
      doctorShare: doctorShare ?? this.doctorShare,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clinicId': clinicId,
      'patientId': patientId,
      'patientName': patientName,
      'appointmentId': appointmentId,
      'amount': amount,
      'paid': paid,
      'remaining': remaining,
      'method': method.value,
      'date': Timestamp.fromDate(date),
      'notes': notes,
      'createdBy': createdBy,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'doctorId': doctorId,
      'doctorName': doctorName,
      'doctorShare': doctorShare,
    };
  }

  factory PaymentTransaction.fromMap({
    required String id,
    required Map<String, dynamic> map,
  }) {
    return PaymentTransaction(
      id: id,
      clinicId: map['clinicId'] as String? ?? '',
      patientId: map['patientId'] as String? ?? '',
      patientName: map['patientName'] as String? ?? '',
      appointmentId: map['appointmentId'] as String?,
      amount: (map['amount'] as num?)?.toDouble() ?? 0,
      paid: (map['paid'] as num?)?.toDouble() ?? 0,
      remaining: (map['remaining'] as num?)?.toDouble() ?? 0,
      method: PaymentMethodX.fromString(map['method'] as String?),
      date: _asDateTime(map['date']) ?? DateTime.now(),
      notes: map['notes'] as String?,
      createdBy: map['createdBy'] as String? ?? '',
      createdAt: _asDateTime(map['createdAt']) ?? DateTime.now(),
      updatedAt: _asDateTime(map['updatedAt']) ?? DateTime.now(),
      doctorId: map['doctorId'] as String?,
      doctorName: map['doctorName'] as String?,
      doctorShare: (map['doctorShare'] as num?)?.toDouble() ?? 0,
    );
  }

  static DateTime? _asDateTime(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    return null;
  }
}
