import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/services/firebase/firestore_service.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/datasources/patients_remote_data_source.dart';
import '../../data/repositories/patients_repository_impl.dart';
import '../../domain/entities/patient.dart';
import '../../domain/repositories/patients_repository.dart';
import '../../domain/usecases/patient_usecases.dart';

final patientsRemoteDataSourceProvider = Provider<PatientsRemoteDataSource>((
  ref,
) {
  return PatientsRemoteDataSource(ref.watch(firestoreServiceProvider));
});

final patientsRepositoryProvider = Provider<PatientsRepository>((ref) {
  return PatientsRepositoryImpl(ref.watch(patientsRemoteDataSourceProvider));
});

final watchPatientsUseCaseProvider = Provider<WatchPatientsUseCase>((ref) {
  return WatchPatientsUseCase(ref.watch(patientsRepositoryProvider));
});

final getPatientUseCaseProvider = Provider<GetPatientUseCase>((ref) {
  return GetPatientUseCase(ref.watch(patientsRepositoryProvider));
});

final createPatientUseCaseProvider = Provider<CreatePatientUseCase>((ref) {
  return CreatePatientUseCase(ref.watch(patientsRepositoryProvider));
});

final updatePatientUseCaseProvider = Provider<UpdatePatientUseCase>((ref) {
  return UpdatePatientUseCase(ref.watch(patientsRepositoryProvider));
});

final deletePatientUseCaseProvider = Provider<DeletePatientUseCase>((ref) {
  return DeletePatientUseCase(ref.watch(patientsRepositoryProvider));
});

final patientsSearchQueryProvider = StateProvider<String>((ref) => '');

final patientsStreamProvider = StreamProvider<List<Patient>>((ref) {
  final clinicId = ref.watch(currentClinicIdProvider);
  if (clinicId == null || clinicId.isEmpty) {
    return const Stream.empty();
  }
  return ref.watch(watchPatientsUseCaseProvider)(clinicId);
});

final filteredPatientsProvider = Provider<List<Patient>>((ref) {
  final query = ref.watch(patientsSearchQueryProvider).trim().toLowerCase();
  final patients = ref.watch(patientsStreamProvider).value ?? const <Patient>[];

  if (query.isEmpty) return patients;
  return patients.where((patient) {
    return patient.displayNameLower.contains(query) ||
        patient.phoneNumber.toLowerCase().contains(query);
  }).toList();
});

final patientByIdProvider = FutureProvider.family<Patient?, String>((
  ref,
  patientId,
) {
  final clinicId = ref.watch(currentClinicIdProvider);
  if (clinicId == null || clinicId.isEmpty) return null;
  return ref
      .watch(getPatientUseCaseProvider)
      .call(clinicId: clinicId, patientId: patientId);
});

class PatientFormController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<String> create({
    required String firstName,
    required String fatherName,
    required String lastName,
    required String phoneNumber,
    String? city,
    String? district,
    String? detailedAddress,
    DateTime? dob,
    PatientGender? gender,
    String? nationalId,
    String? reasonForVisit,
    String? medicalNotes,
    List<String> allergies = const [],
    List<String> chronicDiseases = const [],
  }) async {
    state = const AsyncLoading();
    final id = const Uuid().v4();

    state = await AsyncValue.guard(() async {
      final clinicId = ref.read(currentClinicIdProvider);
      if (clinicId == null || clinicId.isEmpty) {
        throw const AppException('لا يوجد سياق عيادة، أعد تسجيل الدخول');
      }

      final displayName = '$firstName $fatherName $lastName'.trim();
      final now = DateTime.now();
      final patient = Patient(
        id: id,
        clinicId: clinicId,
        firstName: firstName.trim(),
        fatherName: fatherName.trim(),
        lastName: lastName.trim(),
        displayName: displayName,
        displayNameLower: displayName.toLowerCase(),
        phoneNumber: phoneNumber.trim(),
        city: _clean(city),
        district: _clean(district),
        detailedAddress: _clean(detailedAddress),
        dob: dob,
        gender: gender,
        nationalId: _clean(nationalId),
        reasonForVisit: _clean(reasonForVisit),
        medicalNotes: _clean(medicalNotes),
        allergies: _cleanList(allergies),
        chronicDiseases: _cleanList(chronicDiseases),
        createdAt: now,
        updatedAt: now,
      );

      await ref.read(createPatientUseCaseProvider).call(patient);
    });
    return id;
  }

  Future<void> updatePatient(Patient existing, {
    required String firstName,
    required String fatherName,
    required String lastName,
    required String phoneNumber,
    String? city,
    String? district,
    String? detailedAddress,
    DateTime? dob,
    PatientGender? gender,
    String? nationalId,
    String? reasonForVisit,
    String? medicalNotes,
    List<String> allergies = const [],
    List<String> chronicDiseases = const [],
  }) async {
    state = const AsyncLoading();

    final displayName = '$firstName $fatherName $lastName'.trim();
    final updated = existing.copyWith(
      firstName: firstName.trim(),
      fatherName: fatherName.trim(),
      lastName: lastName.trim(),
      displayName: displayName,
      displayNameLower: displayName.toLowerCase(),
      phoneNumber: phoneNumber.trim(),
      city: _clean(city),
      district: _clean(district),
      detailedAddress: _clean(detailedAddress),
      dob: dob,
      gender: gender,
      nationalId: _clean(nationalId),
      reasonForVisit: _clean(reasonForVisit),
      medicalNotes: _clean(medicalNotes),
      allergies: _cleanList(allergies),
      chronicDiseases: _cleanList(chronicDiseases),
      updatedAt: DateTime.now(),
    );

    state = await AsyncValue.guard(
      () => ref.read(updatePatientUseCaseProvider).call(updated),
    );
  }

  Future<void> delete({
    required String clinicId,
    required String patientId,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(deletePatientUseCaseProvider)
          .call(clinicId: clinicId, patientId: patientId),
    );
  }

  static String? _clean(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) return null;
    return trimmed;
  }

  static List<String> _cleanList(List<String> values) {
    return values
        .map((value) => value.trim())
        .where((value) => value.isNotEmpty)
        .toList();
  }
}

final patientFormControllerProvider =
    AutoDisposeAsyncNotifierProvider<PatientFormController, void>(
  PatientFormController.new,
);
