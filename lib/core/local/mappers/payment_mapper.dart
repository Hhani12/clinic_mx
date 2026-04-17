import 'package:drift/drift.dart';

import '../../../features/payments/domain/entities/payment_transaction.dart';
import '../app_database.dart';

class PaymentMapper {
  const PaymentMapper._();

  static LocalPaymentsCompanion toCompanion(
    PaymentTransaction p, {
    bool synced = false,
  }) {
    return LocalPaymentsCompanion.insert(
      id: p.id,
      clinicId: p.clinicId,
      patientId: p.patientId,
      patientName: p.patientName,
      doctorId: Value(p.doctorId),
      doctorName: Value(p.doctorName),
      doctorShare: Value(p.doctorShare),
      appointmentId: Value(p.appointmentId),
      amount: p.amount,
      paid: p.paid,
      remaining: p.remaining,
      method: p.method.value,
      date: p.date,
      paymentNotes: Value(p.notes),
      createdBy: p.createdBy,
      createdAt: p.createdAt,
      updatedAt: p.updatedAt,
      isSynced: Value(synced),
    );
  }

  static PaymentTransaction fromRow(LocalPayment row) {
    return PaymentTransaction(
      id: row.id,
      clinicId: row.clinicId,
      patientId: row.patientId,
      patientName: row.patientName,
      doctorId: row.doctorId,
      doctorName: row.doctorName,
      doctorShare: row.doctorShare,
      appointmentId: row.appointmentId,
      amount: row.amount,
      paid: row.paid,
      remaining: row.remaining,
      method: PaymentMethodX.fromString(row.method),
      date: row.date,
      notes: row.paymentNotes,
      createdBy: row.createdBy,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  static Map<String, dynamic> toPayload(PaymentTransaction p) {
    return {
      'id': p.id,
      'clinicId': p.clinicId,
      'patientId': p.patientId,
      'patientName': p.patientName,
      'doctorId': p.doctorId,
      'doctorName': p.doctorName,
      'doctorShare': p.doctorShare,
      'appointmentId': p.appointmentId,
      'amount': p.amount,
      'paid': p.paid,
      'remaining': p.remaining,
      'method': p.method.value,
      'date': p.date.toIso8601String(),
      'notes': p.notes,
      'createdBy': p.createdBy,
      'createdAt': p.createdAt.toIso8601String(),
      'updatedAt': p.updatedAt.toIso8601String(),
    };
  }
}
