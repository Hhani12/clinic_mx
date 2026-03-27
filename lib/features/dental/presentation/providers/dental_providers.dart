import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/services/firebase/firebase_providers.dart';
import '../../../../core/services/firebase/firestore_service.dart';
import '../../data/repositories/dental_repository_impl.dart';
import '../../domain/entities/dental_plan_item.dart';
import '../../domain/repositories/dental_repository.dart';
import '../../../auth/presentation/providers/auth_providers.dart';

final dentalRepositoryProvider = Provider<DentalRepository>((ref) {
  return DentalRepositoryImpl(
    firestoreService: ref.watch(firestoreServiceProvider),
    firestore: ref.watch(firestoreProvider),
  );
});

final selectedDentalPatientIdProvider = StateProvider<String?>((ref) => null);

final dentalItemsForSelectedPatientProvider =
    StreamProvider<List<DentalPlanItem>>((ref) {
      final clinicId = ref.watch(currentClinicIdProvider);
      final patientId = ref.watch(selectedDentalPatientIdProvider);
      if (clinicId == null || patientId == null || clinicId.isEmpty) {
        return const Stream.empty();
      }
      return ref
          .watch(dentalRepositoryProvider)
          .watchPatientItems(clinicId: clinicId, patientId: patientId);
    });

class DentalActionController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> saveToTeeth({
    required String patientId,
    required String doctorId,
    required List<String> toothIds,
    required String numberingSystem,
    required String actionLabel,
    required String note,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final clinicId = ref.read(currentClinicIdProvider);
      if (clinicId == null || clinicId.isEmpty) {
        throw const AppException('لا يوجد سياق عيادة، أعد تسجيل الدخول');
      }

      final now = DateTime.now();
      final items = toothIds
          .map(
            (toothId) => DentalPlanItem(
              id: const Uuid().v4(),
              clinicId: clinicId,
              patientId: patientId,
              toothId: toothId,
              numberingSystem: numberingSystem,
              actionLabel: actionLabel,
              note: note,
              timestamp: now,
              doctorId: doctorId,
            ),
          )
          .toList();

      await ref.read(dentalRepositoryProvider).saveItems(items);
    });
  }
}

final dentalActionControllerProvider =
    AutoDisposeAsyncNotifierProvider<DentalActionController, void>(
      DentalActionController.new,
    );
