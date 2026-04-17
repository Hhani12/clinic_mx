import '../../../../core/local/daos/payments_local_dao.dart';
import '../../domain/entities/payment_transaction.dart';
import '../../domain/repositories/payments_repository.dart';

class PaymentsLocalRepositoryImpl implements PaymentsRepository {
  final PaymentsLocalDao _dao;
  PaymentsLocalRepositoryImpl(this._dao);

  @override
  Stream<List<PaymentTransaction>> watchClinicPayments(String clinicId) =>
      _dao.watchClinicPayments(clinicId);

  @override
  Stream<List<PaymentTransaction>> watchPatientPayments({
    required String clinicId,
    required String patientId,
  }) =>
      _dao.watchPatientPayments(clinicId: clinicId, patientId: patientId);

  @override
  Future<void> upsertPayment(PaymentTransaction payment) =>
      _dao.upsertPayment(payment);

  @override
  Future<void> deletePayment({
    required String clinicId,
    required String paymentId,
  }) =>
      _dao.deletePayment(clinicId: clinicId, paymentId: paymentId);
}
