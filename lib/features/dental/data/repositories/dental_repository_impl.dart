import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/services/firebase/firestore_paths.dart';
import '../../../../core/services/firebase/firestore_service.dart';
import '../../domain/entities/dental_plan_item.dart';
import '../../domain/repositories/dental_repository.dart';

class DentalRepositoryImpl implements DentalRepository {
  DentalRepositoryImpl({
    required FirestoreService firestoreService,
    required FirebaseFirestore firestore,
  })  : _firestoreService = firestoreService,
        _firestore = firestore;

  final FirestoreService _firestoreService;
  final FirebaseFirestore _firestore;

  @override
  Stream<List<DentalPlanItem>> watchPatientItems({
    required String clinicId,
    required String patientId,
  }) {
    return _firestoreService
        .clinicCollection(clinicId, FirestorePaths.dentalPlans)
        .where('patientId', isEqualTo: patientId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => DentalPlanItem.fromMap(id: doc.id, map: doc.data()))
              .toList();
        })
        .handleError((Object error) {
          if (error is FirebaseException) {
            throw AppException.fromFirebase(error);
          }
          throw error;
        });
  }

  @override
  Future<void> saveItems(List<DentalPlanItem> items) async {
    if (items.isEmpty) return;
    try {
      final batch = _firestore.batch();
      for (final item in items) {
        final doc = _firestoreService
            .clinicCollection(item.clinicId, FirestorePaths.dentalPlans)
            .doc(item.id);
        batch.set(doc, item.toMap());
      }
      await batch.commit();
    } on FirebaseException catch (e) {
      throw AppException.fromFirebase(e);
    }
  }
}
