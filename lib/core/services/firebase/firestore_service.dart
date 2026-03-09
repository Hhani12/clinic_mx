import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_providers.dart';
import 'firestore_paths.dart';

class FirestoreService {
  FirestoreService(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> usersCollection() {
    return _firestore.collection(FirestorePaths.users);
  }

  CollectionReference<Map<String, dynamic>> clinicCollection(
    String clinicId,
    String collection,
  ) {
    return _firestore.collection(FirestorePaths.clinics).doc(clinicId).collection(
          collection,
        );
  }

  DocumentReference<Map<String, dynamic>> clinicDocument(String clinicId) {
    return _firestore.collection(FirestorePaths.clinics).doc(clinicId);
  }

  DocumentReference<Map<String, dynamic>> clinicSettingsDocument(
    String clinicId,
  ) {
    return _firestore
        .doc(FirestorePaths.clinicSettingsDoc(clinicId));
  }
}

final firestoreServiceProvider = Provider<FirestoreService>((ref) {
  return FirestoreService(ref.watch(firestoreProvider));
});
