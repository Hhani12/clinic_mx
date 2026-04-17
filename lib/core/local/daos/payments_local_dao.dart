import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../features/payments/domain/entities/payment_transaction.dart';
import '../app_database.dart';
import '../mappers/payment_mapper.dart';

class PaymentsLocalDao {
  final AppDatabase _db;
  PaymentsLocalDao(this._db);

  Stream<List<PaymentTransaction>> watchClinicPayments(String clinicId) {
    return (_db.select(_db.localPayments)
          ..where((t) => t.clinicId.equals(clinicId))
          ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .watch()
        .map((rows) => rows.map(PaymentMapper.fromRow).toList());
  }

  Stream<List<PaymentTransaction>> watchPatientPayments({
    required String clinicId,
    required String patientId,
  }) {
    return (_db.select(_db.localPayments)
          ..where((t) =>
              t.clinicId.equals(clinicId) &
              t.patientId.equals(patientId))
          ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .watch()
        .map((rows) => rows.map(PaymentMapper.fromRow).toList());
  }

  Future<void> upsertPayment(PaymentTransaction payment) async {
    await _db.transaction(() async {
      await _db.into(_db.localPayments).insertOnConflictUpdate(
            PaymentMapper.toCompanion(payment, synced: false),
          );
      await _db.into(_db.syncQueue).insert(SyncQueueCompanion.insert(
            targetTable: 'payments',
            recordId: payment.id,
            operation: 'update',
            payload: jsonEncode(PaymentMapper.toPayload(payment)),
            createdAt: DateTime.now(),
          ));
    });
  }

  Future<void> deletePayment({
    required String clinicId,
    required String paymentId,
  }) async {
    await _db.transaction(() async {
      await (_db.delete(_db.localPayments)
            ..where((t) =>
                t.id.equals(paymentId) & t.clinicId.equals(clinicId)))
          .go();
      await _db.into(_db.syncQueue).insert(SyncQueueCompanion.insert(
            targetTable: 'payments',
            recordId: paymentId,
            operation: 'delete',
            payload: jsonEncode({'id': paymentId, 'clinicId': clinicId}),
            createdAt: DateTime.now(),
          ));
    });
  }

  Future<void> upsertFromRemote(PaymentTransaction payment) async {
    await _db.into(_db.localPayments).insertOnConflictUpdate(
          PaymentMapper.toCompanion(payment, synced: true),
        );
  }

  Future<void> deleteFromRemote(String paymentId) async {
    await (_db.delete(_db.localPayments)
          ..where((t) => t.id.equals(paymentId)))
        .go();
  }

  Future<bool> isLocalPending(String recordId) async {
    final row = await (_db.select(_db.localPayments)
          ..where((t) => t.id.equals(recordId)))
        .getSingleOrNull();
    return row != null && !row.isSynced;
  }

  Future<void> markSynced(String recordId) async {
    await (_db.update(_db.localPayments)
          ..where((t) => t.id.equals(recordId)))
        .write(const LocalPaymentsCompanion(isSynced: Value(true)));
  }
}
