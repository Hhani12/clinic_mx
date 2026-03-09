import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/services/firebase/firestore_paths.dart';
import '../../../../core/services/firebase/firestore_service.dart';
import '../../../../core/services/firebase/storage_service.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../domain/entities/investigation.dart';

final patientInvestigationsProvider =
    StreamProvider.family<List<Investigation>, String>((ref, patientId) {
      final clinicId = ref.watch(currentClinicIdProvider);
      if (clinicId == null || clinicId.isEmpty) return const Stream.empty();

      return ref
          .watch(firestoreServiceProvider)
          .clinicCollection(clinicId, FirestorePaths.investigations)
          .where('patientId', isEqualTo: patientId)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) {
            return snapshot.docs
                .map(
                  (doc) => Investigation.fromMap(id: doc.id, map: doc.data()),
                )
                .toList();
          })
          .handleError((Object error) {
            if (error is FirebaseException) {
              throw AppException.fromFirebase(error);
            }
            throw error;
          });
    });

class InvestigationUploadController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> upload({
    required String patientId,
    required String fileName,
    required Uint8List bytes,
    required String contentType,
    required InvestigationCategory category,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      try {
        final clinicId = ref.read(currentClinicIdProvider);
        final userId = ref.read(currentUserIdProvider);
        if (clinicId == null || clinicId.isEmpty || userId == null) {
          throw const AppException(
            'لا يوجد سياق عيادة أو مستخدم، أعد تسجيل الدخول',
          );
        }

        final downloadUrl = await ref
            .read(storageServiceProvider)
            .uploadInvestigationFile(
              clinicId: clinicId,
              patientId: patientId,
              fileName: fileName,
              bytes: bytes,
              contentType: contentType,
            );

        final investigation = Investigation(
          id: const Uuid().v4(),
          clinicId: clinicId,
          patientId: patientId,
          uploadedBy: userId,
          fileUrl: downloadUrl,
          fileName: fileName,
          fileType: contentType,
          category: category,
          createdAt: DateTime.now(),
        );

        await ref
            .read(firestoreServiceProvider)
            .clinicCollection(clinicId, FirestorePaths.investigations)
            .doc(investigation.id)
            .set(investigation.toMap());
      } on FirebaseException catch (e) {
        if (e.code == 'object-not-found') {
          throw const AppException(
            'حدث تأخر في تثبيت الملف على الخادم، أعد المحاولة.',
            code: 'object-not-found',
          );
        }
        throw AppException.fromFirebase(e);
      }
    });
  }

  Future<void> delete(Investigation investigation) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(storageServiceProvider).deleteByUrl(investigation.fileUrl);
      await ref
          .read(firestoreServiceProvider)
          .clinicCollection(
            investigation.clinicId,
            FirestorePaths.investigations,
          )
          .doc(investigation.id)
          .delete();
    });
  }
}

final investigationUploadControllerProvider =
    AutoDisposeAsyncNotifierProvider<InvestigationUploadController, void>(
      InvestigationUploadController.new,
    );
