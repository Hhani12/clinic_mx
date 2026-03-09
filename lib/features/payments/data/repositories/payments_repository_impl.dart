import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/services/firebase/firestore_paths.dart';
import '../../../../core/services/firebase/firestore_service.dart';
import '../../domain/entities/payment_transaction.dart';
import '../../domain/repositories/payments_repository.dart';

class PaymentsRepositoryImpl implements PaymentsRepository {
  PaymentsRepositoryImpl(this._firestoreService);

  final FirestoreService _firestoreService;

  @override
  Stream<List<PaymentTransaction>> watchClinicPayments(String clinicId) {
    return _firestoreService
        .clinicCollection(clinicId, FirestorePaths.payments)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) =>
                  PaymentTransaction.fromMap(id: doc.id, map: doc.data()))
              .toList();
        })
        .handleError((Object error) {
          if (error is FirebaseException) {
            throw AppException.fromFirebase(error);
          }
          throw error;
        });
  }

  @override
  Stream<List<PaymentTransaction>> watchPatientPayments({
    required String clinicId,
    required String patientId,
  }) {
    return _firestoreService
        .clinicCollection(clinicId, FirestorePaths.payments)
        .where('patientId', isEqualTo: patientId)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) =>
                  PaymentTransaction.fromMap(id: doc.id, map: doc.data()))
              .toList();
        })
        .handleError((Object error) {
          if (error is FirebaseException) {
            throw AppException.fromFirebase(error);
          }
          throw error;
        });
  }

  @override
  Future<void> upsertPayment(PaymentTransaction payment) async {
    try {
      await _firestoreService
          .clinicCollection(payment.clinicId, FirestorePaths.payments)
          .doc(payment.id)
          .set(payment.toMap());
    } on FirebaseException catch (e) {
      throw AppException.fromFirebase(e);
    }
  }

  @override
  Future<void> deletePayment({
    required String clinicId,
    required String paymentId,
  }) async {
    try {
      await _firestoreService
          .clinicCollection(clinicId, FirestorePaths.payments)
          .doc(paymentId)
          .delete();
    } on FirebaseException catch (e) {
      throw AppException.fromFirebase(e);
    }
  }
}
