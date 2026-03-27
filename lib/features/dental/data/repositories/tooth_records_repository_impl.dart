import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/services/firebase/firestore_paths.dart';
import '../../../../core/services/firebase/firestore_service.dart';
import '../../domain/entities/tooth_record.dart';
import '../../domain/repositories/tooth_records_repository.dart';

class ToothRecordsRepositoryImpl implements ToothRecordsRepository {
  ToothRecordsRepositoryImpl({
    required FirestoreService firestoreService,
  })  : _firestoreService = firestoreService;

  final FirestoreService _firestoreService;

  CollectionReference<Map<String, dynamic>> _collection(String clinicId) {
    return _firestoreService.clinicCollection(
      clinicId,
      FirestorePaths.toothRecords,
    );
  }

  @override
  Stream<List<ToothRecord>> watchPatientTeeth({
    required String clinicId,
    required String patientId,
  }) {
    return _collection(clinicId)
        .where('patientId', isEqualTo: patientId)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => ToothRecord.fromMap(doc.data()))
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
  Future<ToothRecord?> getToothRecord({
    required String clinicId,
    required String patientId,
    required String toothId,
  }) async {
    try {
      final docId = '${patientId}_$toothId';
      final snapshot = await _collection(clinicId).doc(docId).get();
      if (!snapshot.exists || snapshot.data() == null) return null;
      return ToothRecord.fromMap(snapshot.data()!);
    } on FirebaseException catch (e) {
      throw AppException.fromFirebase(e);
    }
  }

  @override
  Future<void> saveToothRecord({
    required String clinicId,
    required ToothRecord record,
  }) async {
    try {
      await _collection(clinicId).doc(record.docId).set(
        record.toMap(),
        SetOptions(merge: false),
      );
    } on FirebaseException catch (e) {
      throw AppException.fromFirebase(e);
    }
  }

  @override
  Future<void> deleteProcedure({
    required String clinicId,
    required String patientId,
    required String toothId,
    required String procedureId,
  }) async {
    try {
      final docId = '${patientId}_$toothId';
      final docRef = _collection(clinicId).doc(docId);
      final snapshot = await docRef.get();
      if (!snapshot.exists || snapshot.data() == null) return;

      final record = ToothRecord.fromMap(snapshot.data()!);
      final updatedProcedures = record.procedures
          .where((p) => p.id != procedureId)
          .toList();

      // Determine new status: last procedure's status, or healthy if none
      final newStatus = updatedProcedures.isEmpty
          ? 'healthy'
          : ToothRecord.statusFromAction(updatedProcedures.last.actionLabel);

      final updatedRecord = record.copyWith(
        procedures: updatedProcedures,
        status: newStatus,
        updatedAt: DateTime.now(),
      );

      await docRef.set(updatedRecord.toMap(), SetOptions(merge: false));
    } on FirebaseException catch (e) {
      throw AppException.fromFirebase(e);
    }
  }
}
