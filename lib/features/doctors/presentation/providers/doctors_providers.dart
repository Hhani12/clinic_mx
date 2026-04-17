import 'dart:async';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/local/local_providers.dart';
import '../../../../core/services/firebase/firestore_paths.dart';
import '../../../../core/services/firebase/firestore_service.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/repositories/doctors_local_repository_impl.dart';
import '../../data/repositories/doctors_repository_impl.dart';
import '../../domain/entities/doctor_profile.dart';
import '../../domain/repositories/doctors_repository.dart';

class DoctorMonthlyStats {
  const DoctorMonthlyStats({
    required this.totalProcedures,
    required this.actionCounts,
  });

  final int totalProcedures;
  final Map<String, int> actionCounts;

  static const empty = DoctorMonthlyStats(
    totalProcedures: 0,
    actionCounts: <String, int>{},
  );
}

final doctorsRepositoryProvider = Provider<DoctorsRepository>((ref) {
  if (kIsWeb) {
    return DoctorsRepositoryImpl(ref.watch(firestoreServiceProvider));
  }
  return DoctorsLocalRepositoryImpl(ref.watch(doctorsLocalDaoProvider));
});

final doctorsStreamProvider = StreamProvider<List<DoctorProfile>>((ref) {
  final clinicId = ref.watch(currentClinicIdProvider);
  if (clinicId == null || clinicId.isEmpty) return const Stream.empty();
  return ref.watch(doctorsRepositoryProvider).watchClinicDoctors(clinicId);
});

final activeDoctorsProvider = Provider<List<DoctorProfile>>((ref) {
  final doctors =
      ref.watch(doctorsStreamProvider).value ?? const <DoctorProfile>[];
  return doctors.where((doctor) => doctor.isActive).toList();
});

final monthlyDoctorStatsProvider =
    StreamProvider<Map<String, DoctorMonthlyStats>>((ref) {
      final clinicId = ref.watch(currentClinicIdProvider);
      if (clinicId == null || clinicId.isEmpty) return const Stream.empty();

      final now = DateTime.now();
      final from = DateTime(now.year, now.month, 1);
      final to = DateTime(now.year, now.month + 1, 1);

      return ref
          .watch(firestoreServiceProvider)
          .clinicCollection(clinicId, FirestorePaths.dentalPlans)
          .where('timestamp', isGreaterThanOrEqualTo: from)
          .where('timestamp', isLessThan: to)
          .snapshots()
          .map((snapshot) {
            final perDoctor = <String, Map<String, int>>{};
            for (final doc in snapshot.docs) {
              final data = doc.data();
              final doctorId = (data['doctorId'] as String? ?? '').trim();
              if (doctorId.isEmpty) continue;
              final action = (data['actionLabel'] as String? ?? 'Other').trim();
              final actions = perDoctor.putIfAbsent(
                doctorId,
                () => <String, int>{},
              );
              actions[action] = (actions[action] ?? 0) + 1;
            }

            return perDoctor.map((doctorId, counts) {
              final total = counts.values.fold<int>(
                0,
                (sum, item) => sum + item,
              );
              return MapEntry(
                doctorId,
                DoctorMonthlyStats(
                  totalProcedures: total,
                  actionCounts: counts,
                ),
              );
            });
          })
          .handleError((Object error) {
            if (error is Exception) {
              throw error;
            }
            throw AppException('حدث خطأ غير متوقع');
          });
    });

class DoctorsEditorController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> create({
    String fullName = '',
    String? phone,
    String? specialty,
    String? address,
    String? notes,
    String? profilePictureUrl,
    double monthlySalaryIqd = 0,
    double commissionPercent = 0,
    DoctorPaymentType paymentType = DoctorPaymentType.commission,
    bool isActive = true,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final clinicId = ref.read(currentClinicIdProvider);
      if (clinicId == null || clinicId.isEmpty) {
        throw const AppException('لا يوجد سياق عيادة، أعد تسجيل الدخول');
      }
      final now = DateTime.now();
      final doctor = DoctorProfile(
        id: const Uuid().v4(),
        clinicId: clinicId,
        fullName: fullName.trim(),
        phone: _clean(phone),
        specialty: _clean(specialty),
        address: _clean(address),
        notes: _clean(notes),
        profilePictureUrl: _clean(profilePictureUrl),
        monthlySalaryIqd: monthlySalaryIqd,
        commissionPercent: commissionPercent,
        paymentType: paymentType,
        createdAt: now,
        updatedAt: now,
        isActive: isActive,
      );
      await ref.read(doctorsRepositoryProvider).upsertDoctor(doctor);
    });
  }

  Future<void> updateDoctor(DoctorProfile doctor) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(doctorsRepositoryProvider)
          .upsertDoctor(doctor.copyWith(updatedAt: DateTime.now())),
    );
  }

  Future<void> delete({
    required String clinicId,
    required String doctorId,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(doctorsRepositoryProvider)
          .deleteDoctor(clinicId: clinicId, doctorId: doctorId),
    );
  }

  static String? _clean(String? value) {
    if (value == null) return null;
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
}

final doctorsEditorControllerProvider =
    AutoDisposeAsyncNotifierProvider<DoctorsEditorController, void>(
      DoctorsEditorController.new,
    );
