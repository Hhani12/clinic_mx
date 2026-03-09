import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/services/firebase/firestore_service.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/repositories/payments_repository_impl.dart';
import '../../domain/entities/payment_transaction.dart';
import '../../domain/repositories/payments_repository.dart';

final paymentsRepositoryProvider = Provider<PaymentsRepository>((ref) {
  return PaymentsRepositoryImpl(ref.watch(firestoreServiceProvider));
});

final allPaymentsProvider = StreamProvider<List<PaymentTransaction>>((ref) {
  final clinicId = ref.watch(currentClinicIdProvider);
  if (clinicId == null || clinicId.isEmpty) return const Stream.empty();
  return ref.watch(paymentsRepositoryProvider).watchClinicPayments(clinicId);
});

final patientPaymentsProvider = StreamProvider.family<List<PaymentTransaction>, String>((
  ref,
  patientId,
) {
  final clinicId = ref.watch(currentClinicIdProvider);
  if (clinicId == null || clinicId.isEmpty) return const Stream.empty();
  return ref.watch(paymentsRepositoryProvider).watchPatientPayments(
        clinicId: clinicId,
        patientId: patientId,
      );
});

final paymentsTotalsProvider = Provider<Map<String, double>>((ref) {
  final payments = ref.watch(allPaymentsProvider).value ?? const [];
  final now = DateTime.now();
  final dayStart = DateTime(now.year, now.month, now.day);
  final weekStart = dayStart.subtract(Duration(days: now.weekday - 1));
  final monthStart = DateTime(now.year, now.month, 1);

  double day = 0;
  double week = 0;
  double month = 0;

  for (final payment in payments) {
    if (payment.date.isAfter(dayStart)) {
      day += payment.paid;
    }
    if (payment.date.isAfter(weekStart)) {
      week += payment.paid;
    }
    if (payment.date.isAfter(monthStart)) {
      month += payment.paid;
    }
  }

  return {
    'day': day,
    'week': week,
    'month': month,
  };
});

class PaymentEditorController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> create({
    required String patientId,
    required String patientName,
    required double amount,
    required double paid,
    required PaymentMethod method,
    required DateTime date,
    String? notes,
    String? appointmentId,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final clinicId = ref.read(currentClinicIdProvider);
      final userId = ref.read(currentUserIdProvider);
      if (clinicId == null || clinicId.isEmpty || userId == null) {
        throw const AppException('لا يوجد سياق عيادة أو مستخدم، أعد تسجيل الدخول');
      }

      final payment = PaymentTransaction(
        id: const Uuid().v4(),
        clinicId: clinicId,
        patientId: patientId,
        patientName: patientName,
        appointmentId: appointmentId,
        amount: amount,
        paid: paid,
        remaining: amount - paid,
        method: method,
        date: date,
        notes: notes?.trim().isEmpty ?? true ? null : notes?.trim(),
        createdBy: userId,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await ref.read(paymentsRepositoryProvider).upsertPayment(payment);
    });
  }

  Future<void> delete({
    required String clinicId,
    required String paymentId,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(paymentsRepositoryProvider).deletePayment(
            clinicId: clinicId,
            paymentId: paymentId,
          ),
    );
  }
}

final paymentEditorControllerProvider =
    AutoDisposeAsyncNotifierProvider<PaymentEditorController, void>(
  PaymentEditorController.new,
);
