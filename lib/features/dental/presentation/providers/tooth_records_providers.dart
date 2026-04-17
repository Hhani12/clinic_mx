import 'dart:async';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/local/local_providers.dart';
import '../../../../core/services/firebase/firestore_service.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/repositories/tooth_records_local_repository_impl.dart';
import '../../data/repositories/tooth_records_repository_impl.dart';
import '../../domain/entities/tooth_record.dart';
import '../../domain/repositories/tooth_records_repository.dart';
import 'dental_providers.dart';

final toothRecordsRepositoryProvider = Provider<ToothRecordsRepository>((ref) {
  if (kIsWeb) {
    return ToothRecordsRepositoryImpl(
      firestoreService: ref.watch(firestoreServiceProvider),
    );
  }
  return ToothRecordsLocalRepositoryImpl(
      ref.watch(toothRecordsLocalDaoProvider));
});

/// Watch all tooth records for the currently selected dental patient
final toothRecordsForPatientProvider =
    StreamProvider<List<ToothRecord>>((ref) {
  final clinicId = ref.watch(currentClinicIdProvider);
  final patientId = ref.watch(selectedDentalPatientIdProvider);
  if (clinicId == null || patientId == null || clinicId.isEmpty) {
    return const Stream.empty();
  }
  return ref
      .watch(toothRecordsRepositoryProvider)
      .watchPatientTeeth(clinicId: clinicId, patientId: patientId);
});

/// Derives a map of toothId → status from tooth records
final toothStatusMapProvider = Provider<Map<String, String>>((ref) {
  final records = ref.watch(toothRecordsForPatientProvider).valueOrNull;
  if (records == null) return {};
  return {for (final r in records) r.toothId: r.status};
});

/// Derives a map of toothId → procedure count
final toothProcedureCountProvider = Provider<Map<String, int>>((ref) {
  final records = ref.watch(toothRecordsForPatientProvider).valueOrNull;
  if (records == null) return {};
  return {for (final r in records) r.toothId: r.procedures.length};
});

/// Controller for managing tooth records (add procedure, delete, update status)
class ToothRecordController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  /// Add a procedure to a tooth, creating or updating the tooth record
  Future<void> addProcedure({
    required String patientId,
    required String toothId,
    required String actionLabel,
    required String doctorId,
    String? doctorName,
    String? note,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final clinicId = ref.read(currentClinicIdProvider);
      if (clinicId == null || clinicId.isEmpty) {
        throw const AppException('لا يوجد سياق عيادة، أعد تسجيل الدخول');
      }

      final repo = ref.read(toothRecordsRepositoryProvider);
      final existing = await repo.getToothRecord(
        clinicId: clinicId,
        patientId: patientId,
        toothId: toothId,
      );

      final procedure = ToothProcedure(
        id: const Uuid().v4(),
        actionLabel: actionLabel,
        doctorId: doctorId,
        doctorName: doctorName,
        note: note,
        performedAt: DateTime.now(),
      );

      final newStatus = ToothRecord.statusFromAction(actionLabel);
      final procedures = <ToothProcedure>[
        ...(existing?.procedures ?? <ToothProcedure>[]),
        procedure,
      ];

      final record = ToothRecord(
        patientId: patientId,
        toothId: toothId,
        status: newStatus,
        procedures: procedures,
        notes: existing?.notes,
        updatedAt: DateTime.now(),
      );

      await repo.saveToothRecord(clinicId: clinicId, record: record);
    });
  }

  /// Delete a procedure from a tooth record
  Future<void> deleteProcedure({
    required String patientId,
    required String toothId,
    required String procedureId,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final clinicId = ref.read(currentClinicIdProvider);
      if (clinicId == null || clinicId.isEmpty) {
        throw const AppException('لا يوجد سياق عيادة، أعد تسجيل الدخول');
      }

      await ref.read(toothRecordsRepositoryProvider).deleteProcedure(
        clinicId: clinicId,
        patientId: patientId,
        toothId: toothId,
        procedureId: procedureId,
      );
    });
  }

  /// Update tooth notes
  Future<void> updateNotes({
    required String patientId,
    required String toothId,
    required String notes,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final clinicId = ref.read(currentClinicIdProvider);
      if (clinicId == null || clinicId.isEmpty) {
        throw const AppException('لا يوجد سياق عيادة، أعد تسجيل الدخول');
      }

      final repo = ref.read(toothRecordsRepositoryProvider);
      final existing = await repo.getToothRecord(
        clinicId: clinicId,
        patientId: patientId,
        toothId: toothId,
      );

      final record = (existing ?? ToothRecord(
        patientId: patientId,
        toothId: toothId,
        status: 'healthy',
        procedures: [],
        updatedAt: DateTime.now(),
      )).copyWith(notes: notes, updatedAt: DateTime.now());

      await repo.saveToothRecord(clinicId: clinicId, record: record);
    });
  }

  /// Manually set a tooth status
  Future<void> setStatus({
    required String patientId,
    required String toothId,
    required String status,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final clinicId = ref.read(currentClinicIdProvider);
      if (clinicId == null || clinicId.isEmpty) {
        throw const AppException('لا يوجد سياق عيادة، أعد تسجيل الدخول');
      }

      final repo = ref.read(toothRecordsRepositoryProvider);
      final existing = await repo.getToothRecord(
        clinicId: clinicId,
        patientId: patientId,
        toothId: toothId,
      );

      final record = (existing ?? ToothRecord(
        patientId: patientId,
        toothId: toothId,
        status: status,
        procedures: [],
        updatedAt: DateTime.now(),
      )).copyWith(status: status, updatedAt: DateTime.now());

      await repo.saveToothRecord(clinicId: clinicId, record: record);
    });
  }
}

final toothRecordControllerProvider =
    AutoDisposeAsyncNotifierProvider<ToothRecordController, void>(
  ToothRecordController.new,
);
