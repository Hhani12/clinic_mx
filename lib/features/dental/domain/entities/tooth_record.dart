import 'package:cloud_firestore/cloud_firestore.dart';

class ToothProcedure {
  const ToothProcedure({
    required this.id,
    required this.actionLabel,
    required this.doctorId,
    this.doctorName,
    this.note,
    required this.performedAt,
  });

  final String id;
  final String actionLabel;
  final String doctorId;
  final String? doctorName;
  final String? note;
  final DateTime performedAt;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'actionLabel': actionLabel,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'note': note,
      'performedAt': Timestamp.fromDate(performedAt),
    };
  }

  factory ToothProcedure.fromMap(Map<String, dynamic> map) {
    return ToothProcedure(
      id: map['id'] as String? ?? '',
      actionLabel: map['actionLabel'] as String? ?? '',
      doctorId: map['doctorId'] as String? ?? '',
      doctorName: map['doctorName'] as String?,
      note: map['note'] as String?,
      performedAt: _asDateTime(map['performedAt']) ?? DateTime.now(),
    );
  }

  static DateTime? _asDateTime(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    return null;
  }
}

class ToothRecord {
  const ToothRecord({
    required this.patientId,
    required this.toothId,
    required this.status,
    required this.procedures,
    this.notes,
    required this.updatedAt,
  });

  final String patientId;
  final String toothId;
  final String status;
  final List<ToothProcedure> procedures;
  final String? notes;
  final DateTime updatedAt;

  /// Firestore document ID = patientId_toothId
  String get docId => '${patientId}_$toothId';

  ToothRecord copyWith({
    String? status,
    List<ToothProcedure>? procedures,
    String? notes,
    DateTime? updatedAt,
  }) {
    return ToothRecord(
      patientId: patientId,
      toothId: toothId,
      status: status ?? this.status,
      procedures: procedures ?? this.procedures,
      notes: notes ?? this.notes,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'patientId': patientId,
      'toothId': toothId,
      'status': status,
      'procedures': procedures.map((p) => p.toMap()).toList(),
      'notes': notes,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  factory ToothRecord.fromMap(Map<String, dynamic> map) {
    final rawProcedures = map['procedures'] as List<dynamic>? ?? [];
    return ToothRecord(
      patientId: map['patientId'] as String? ?? '',
      toothId: map['toothId'] as String? ?? '',
      status: map['status'] as String? ?? 'healthy',
      procedures: rawProcedures
          .whereType<Map<String, dynamic>>()
          .map(ToothProcedure.fromMap)
          .toList(),
      notes: map['notes'] as String?,
      updatedAt: _asDateTime(map['updatedAt']) ?? DateTime.now(),
    );
  }

  static DateTime? _asDateTime(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    return null;
  }

  /// Maps action labels to tooth status values
  static String statusFromAction(String actionLabel) {
    final normalized = actionLabel.trim();
    const mapping = <String, String>{
      'قلع': 'extracted',
      'خلع': 'extracted',
      'حشو': 'filled',
      'حشوة': 'filled',
      'تنظيف': 'healthy',
      'عصب': 'root_canal',
      'علاج عصب': 'root_canal',
      'تقويم': 'braces',
      'تركيب': 'crowned',
    };
    return mapping[normalized] ?? 'treated';
  }

  static const validStatuses = [
    'healthy',
    'filled',
    'extracted',
    'root_canal',
    'crowned',
    'braces',
    'treated',
    'decayed',
    'missing',
  ];
}
