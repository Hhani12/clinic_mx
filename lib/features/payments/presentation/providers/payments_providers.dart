import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/local/local_providers.dart';
import '../../../../core/services/firebase/firestore_service.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/repositories/payments_local_repository_impl.dart';
import '../../data/repositories/payments_repository_impl.dart';
import '../../domain/entities/payment_transaction.dart';
import '../../domain/repositories/payments_repository.dart';
import '../../../doctors/domain/entities/doctor_profile.dart';
import '../../../doctors/presentation/providers/doctors_providers.dart';

final paymentsRepositoryProvider = Provider<PaymentsRepository>((ref) {
  if (kIsWeb) {
    return PaymentsRepositoryImpl(ref.watch(firestoreServiceProvider));
  }
  return PaymentsLocalRepositoryImpl(ref.watch(paymentsLocalDaoProvider));
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

final auditDateRangeProvider = StateProvider<DateTimeRange>((ref) {
  final now = DateTime.now();
  return DateTimeRange(
    start: DateTime(now.year, now.month, 1),
    end: DateTime(now.year, now.month, now.day, 23, 59, 59),
  );
});

final selectedAuditDoctorIdProvider = StateProvider<String?>((ref) => null);

final paymentSearchQueryProvider = StateProvider<String>((ref) => '');

final auditStatsProvider = Provider<Map<String, double>>((ref) {
  final payments = ref.watch(allPaymentsProvider).value ?? const [];
  final doctors = ref.watch(doctorsStreamProvider).value ?? const [];
  final range = ref.watch(auditDateRangeProvider);
  final selectedDoctorId = ref.watch(selectedAuditDoctorIdProvider);

  double collected = 0;
  double pending = 0;
  double doctorsShare = 0;

  // Monthly range for doctor-specific calculations
  final monthStart = DateTime(range.start.year, range.start.month, 1);
  final monthEnd = DateTime(range.start.year, range.start.month + 1, 0, 23, 59, 59);

  // Filter payments by date range for PATIENT stats (Collected/Pending)
  final filteredByDate = payments.where((payment) =>
      payment.date.isAfter(range.start.subtract(const Duration(seconds: 1))) &&
      payment.date.isBefore(range.end.add(const Duration(seconds: 1))));

  // Filter payments by MONTH for COMMISSION-based doctor shares
  final monthlyPayments = payments.where((payment) =>
      payment.date.isAfter(monthStart.subtract(const Duration(seconds: 1))) &&
      payment.date.isBefore(monthEnd.add(const Duration(seconds: 1))));

  if (selectedDoctorId != null) {
    // Audit for a specific doctor
    final doctor = doctors.cast<DoctorProfile?>().firstWhere(
          (d) => d?.id == selectedDoctorId,
          orElse: () => null,
        );
    
    // Patient stats for this doctor in the SELECTED range
    final doctorPaymentsInRange = filteredByDate.where((p) => p.doctorId == selectedDoctorId);
    for (final p in doctorPaymentsInRange) {
      collected += p.paid;
      pending += p.remaining;
    }

    // Doctor share is ALWAYS monthly
    if (doctor?.paymentType == DoctorPaymentType.commission) {
      final doctorMonthlyPayments = monthlyPayments.where((p) => p.doctorId == selectedDoctorId);
      for (final p in doctorMonthlyPayments) {
        doctorsShare += p.doctorShare;
      }
    } else if (doctor?.paymentType == DoctorPaymentType.fixed) {
      doctorsShare = doctor?.monthlySalaryIqd ?? 0;
    }
  } else {
    // Global clinic audit
    for (final payment in filteredByDate) {
      collected += payment.paid;
      pending += payment.remaining;
    }

    // Monthly Doctor Shares (Global)
    for (final doc in doctors) {
      if (doc.paymentType == DoctorPaymentType.fixed) {
        doctorsShare += doc.monthlySalaryIqd;
      } else {
        final docMonthlyPayments = monthlyPayments.where((p) => p.doctorId == doc.id);
        for (final p in docMonthlyPayments) {
          doctorsShare += p.doctorShare;
        }
      }
    }
  }

  return {
    'collected': collected,
    'pending': pending,
    'doctorsShare': doctorsShare,
    'clinicNet': collected - doctorsShare,
  };
});

final filteredPaymentsProvider =
    Provider<AsyncValue<List<PaymentTransaction>>>((ref) {
  final paymentsAsync = ref.watch(allPaymentsProvider);
  final range = ref.watch(auditDateRangeProvider);
  final doctorId = ref.watch(selectedAuditDoctorIdProvider);
  final query = ref.watch(paymentSearchQueryProvider).trim().toLowerCase();

  return paymentsAsync.whenData((payments) {
    return payments.where((p) {
      // Date filter
      final inDateRange =
          p.date.isAfter(range.start.subtract(const Duration(seconds: 1))) &&
          p.date.isBefore(range.end.add(const Duration(seconds: 1)));
      if (!inDateRange) return false;

      // Doctor filter
      if (doctorId != null && p.doctorId != doctorId) return false;

      // Search query filter
      if (query.isNotEmpty) {
        final matchPatient = p.patientName.toLowerCase().contains(query);
        final matchDoctor = (p.doctorName ?? '').toLowerCase().contains(query);
        final matchNotes = (p.notes ?? '').toLowerCase().contains(query);
        if (!matchPatient && !matchDoctor && !matchNotes) return false;
      }

      return true;
    }).toList();
  });
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
    String? doctorId,
    String? doctorName,
    double doctorCommissionPercent = 0,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final clinicId = ref.read(currentClinicIdProvider);
      final userId = ref.read(currentUserIdProvider);
      if (clinicId == null || clinicId.isEmpty || userId == null) {
        throw const AppException('لا يوجد سياق عيادة أو مستخدم، أعد تسجيل الدخول');
      }

      final doctorShare = (paid * doctorCommissionPercent) / 100;

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
        doctorId: doctorId,
        doctorName: doctorName,
        doctorShare: doctorShare,
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
