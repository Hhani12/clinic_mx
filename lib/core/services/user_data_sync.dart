import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Service to synchronize generic user data to Firestore.
class UserDataSync {
  UserDataSync({required this.firestore, required this.userId});

  final FirebaseFirestore firestore;
  final String userId;

  /// Saves a map of data under a user-specific collection.
  /// Example: collectionPath = 'patients', data = {'name': 'John'}
  Future<void> saveData({required String collectionPath, required Map<String, dynamic> data}) async {
    final docRef = firestore.collection('users').doc(userId).collection(collectionPath).doc();
    await docRef.set(data);
  }

  /// Retrieves a stream of documents from a user-specific collection.
  Stream<QuerySnapshot<Map<String, dynamic>>> streamData(String collectionPath) {
    return firestore.collection('users').doc(userId).collection(collectionPath).snapshots();
  }
}
