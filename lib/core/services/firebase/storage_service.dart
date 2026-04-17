import 'dart:async';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_providers.dart';
import '../../exceptions/app_exception.dart';

class StorageService {
  StorageService(this._storage);

  final FirebaseStorage _storage;

  /// Uploads a file to Firebase Storage under the clinic/patient path.
  /// Returns the download URL on success.
  Future<String> uploadInvestigationFile({
    required String clinicId,
    required String patientId,
    required String fileName,
    required Uint8List bytes,
    required String contentType,
  }) async {
    try {
      final safeFileName = _sanitizeFileName(fileName);
      final path =
          'clinics/$clinicId/patients/$patientId/investigations/${DateTime.now().millisecondsSinceEpoch}_$safeFileName';
      final ref = _storage.ref(path);
      final metadata = SettableMetadata(contentType: contentType);

      // Upload with progress tracking and timeout
      final uploadTask = ref.putData(bytes, metadata);

      // Wait for upload to complete
      final snapshot = await uploadTask;

      // Verify upload state
      if (snapshot.state != TaskState.success) {
        throw const AppException('فشل رفع الملف - الحالة غير مكتملة');
      }

      // In some environments, getDownloadURL can briefly fail with
      // object-not-found immediately after upload. Retry a few times.
      const maxAttempts = 5;
      for (var attempt = 1; attempt <= maxAttempts; attempt++) {
        try {
          return await ref.getDownloadURL();
        } on FirebaseException catch (e) {
          final isRetryable =
              e.code == 'object-not-found' && attempt < maxAttempts;
          if (!isRetryable) {
            throw _mapFirebaseStorageException(e);
          }
          await Future<void>.delayed(const Duration(milliseconds: 350));
        }
      }

      throw const AppException('لم يتم العثور على الملف بعد الرفع');
    } on FirebaseException catch (e) {
      throw _mapFirebaseStorageException(e);
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException('حدث خطأ غير متوقع أثناء رفع الملف: ${e.toString()}');
    }
  }

  /// Maps Firebase Storage exceptions to user-friendly Arabic messages.
  AppException _mapFirebaseStorageException(FirebaseException e) {
    // Log detailed error for debugging
    debugPrint('Firebase Storage Error: code=${e.code}, message=${e.message}');

    return switch (e.code) {
      'permission-denied' => AppException(
          'ليس لديك صلاحية لرفع الملفات. تأكد من أن قواعد الأمان مفعّلة\nتفاصيل: ${e.message}',
          code: 'permission-denied',
        ),
      'unauthenticated' => const AppException(
          'يجب تسجيل الدخول أولاً',
          code: 'unauthenticated',
        ),
      'unauthorized' => AppException(
          'غير مصرح. يرجى التحقق من صلاحيات المستخدم\nتفاصيل: ${e.message}',
          code: 'unauthorized',
        ),
      'canceled' => const AppException(
          'تم إلغاء رفع الملف',
          code: 'canceled',
        ),
      'quota-exceeded' => const AppException(
          'تم تجاوز سعة التخزين المتاحة',
          code: 'quota-exceeded',
        ),
      'unavailable' => const AppException(
          'خدمة التخزين غير متاحة، تحقق من الاتصال بالإنترنت',
          code: 'unavailable',
        ),
      'invalid-argument' => const AppException(
          'نوع الملف غير مدعوم',
          code: 'invalid-argument',
        ),
      'not-found' => const AppException(
          'لم يتم العثور على مساحة التخزين. تأكد من تفعيل Firebase Storage',
          code: 'not-found',
        ),
      _ => AppException(
          'حدث خطأ أثناء رفع الملف: ${_getFriendlyErrorMessage(e.code)}\n${e.message}',
          code: e.code,
        ),
    };
  }

  String _getFriendlyErrorMessage(String code) {
    return switch (code) {
      'unknown' => 'خطأ غير معروف',
      'timeout' => 'انتهت مهلة الرفع',
      'network-error' => 'خطأ في الشبكة',
      _ => code,
    };
  }

  /// Deletes a file from Firebase Storage by its full URL.
  Future<void> deleteByUrl(String url) async {
    try {
      final ref = _storage.refFromURL(url);
      await ref.delete();
    } on FirebaseException catch (e) {
      // File may already be deleted; ignore
      if (e.code != 'not-found') {
        // Log but don't fail the operation
        debugPrint('Warning: Failed to delete file: ${e.message}');
      }
    }
  }

  static String _sanitizeFileName(String value) {
    final cleaned = value
        .trim()
        .replaceAll(RegExp(r'[\\/:*?"<>|]'), '_')
        .replaceAll(RegExp(r'\s+'), '_');
    if (cleaned.isEmpty) return 'file.jpg';
    return cleaned;
  }
}

final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService(ref.watch(firebaseStorageProvider));
});
