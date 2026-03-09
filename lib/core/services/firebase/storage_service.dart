import 'dart:async';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_providers.dart';

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
    final safeFileName = _sanitizeFileName(fileName);
    final path =
        'clinics/$clinicId/patients/$patientId/investigations/${DateTime.now().millisecondsSinceEpoch}_$safeFileName';
    final ref = _storage.ref(path);
    final metadata = SettableMetadata(contentType: contentType);
    await ref.putData(bytes, metadata);

    // In some environments, getDownloadURL can briefly fail with
    // object-not-found immediately after upload. Retry a few times.
    const maxAttempts = 5;
    for (var attempt = 1; attempt <= maxAttempts; attempt++) {
      try {
        return await ref.getDownloadURL();
      } on FirebaseException catch (e) {
        final isRetryable =
            e.code == 'object-not-found' && attempt < maxAttempts;
        if (!isRetryable) rethrow;
        await Future<void>.delayed(const Duration(milliseconds: 350));
      }
    }

    throw FirebaseException(
      plugin: 'firebase_storage',
      code: 'object-not-found',
      message: 'Uploaded file was not found after retries.',
    );
  }

  /// Deletes a file from Firebase Storage by its full URL.
  Future<void> deleteByUrl(String url) async {
    try {
      final ref = _storage.refFromURL(url);
      await ref.delete();
    } on FirebaseException {
      // File may already be deleted; ignore
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
