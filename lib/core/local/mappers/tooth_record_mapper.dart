import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../features/dental/domain/entities/tooth_record.dart';
import '../app_database.dart';

class ToothRecordMapper {
  const ToothRecordMapper._();

  static LocalToothRecordsCompanion toCompanion(
    ToothRecord r, {
    required String clinicId,
    bool synced = false,
  }) {
    return LocalToothRecordsCompanion.insert(
      docId: r.docId,
      patientId: r.patientId,
      toothId: r.toothId,
      clinicId: clinicId,
      status: Value(r.status),
      proceduresJson: Value(jsonEncode(
        r.procedures.map(_procedureToMap).toList(),
      )),
      toothNotes: Value(r.notes),
      updatedAt: r.updatedAt,
      isSynced: Value(synced),
    );
  }

  static ToothRecord fromRow(LocalToothRecord row) {
    final rawList = jsonDecode(row.proceduresJson) as List<dynamic>;
    return ToothRecord(
      patientId: row.patientId,
      toothId: row.toothId,
      status: row.status,
      procedures: rawList
          .whereType<Map<String, dynamic>>()
          .map(_procedureFromMap)
          .toList(),
      notes: row.toothNotes,
      updatedAt: row.updatedAt,
    );
  }

  static Map<String, dynamic> toPayload(ToothRecord r) {
    return {
      'patientId': r.patientId,
      'toothId': r.toothId,
      'status': r.status,
      'procedures': r.procedures.map(_procedureToMap).toList(),
      'notes': r.notes,
      'updatedAt': r.updatedAt.toIso8601String(),
    };
  }

  static Map<String, dynamic> _procedureToMap(ToothProcedure p) {
    return {
      'id': p.id,
      'actionLabel': p.actionLabel,
      'doctorId': p.doctorId,
      'doctorName': p.doctorName,
      'note': p.note,
      'performedAt': p.performedAt.toIso8601String(),
    };
  }

  static ToothProcedure _procedureFromMap(Map<String, dynamic> m) {
    return ToothProcedure(
      id: m['id'] as String? ?? '',
      actionLabel: m['actionLabel'] as String? ?? '',
      doctorId: m['doctorId'] as String? ?? '',
      doctorName: m['doctorName'] as String?,
      note: m['note'] as String?,
      performedAt: DateTime.tryParse(m['performedAt'] as String? ?? '') ??
          DateTime.now(),
    );
  }
}
