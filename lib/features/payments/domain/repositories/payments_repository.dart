import '../entities/payment_transaction.dart';

abstract class PaymentsRepository {
  Stream<List<PaymentTransaction>> watchClinicPayments(String clinicId);
  Stream<List<PaymentTransaction>> watchPatientPayments({
    required String clinicId,
    required String patientId,
  });
  Future<void> upsertPayment(PaymentTransaction payment);
  Future<void> deletePayment({
    required String clinicId,
    required String paymentId,
  });
}
