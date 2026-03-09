import 'package:cloud_firestore/cloud_firestore.dart';

enum InvestigationCategory { opg, xray, investigation, other }

extension InvestigationCategoryX on InvestigationCategory {
  String get value => name;
  String get labelAr {
    switch (this) {
      case InvestigationCategory.opg:
        return 'OPG بانوراما';
      case InvestigationCategory.xray:
        return 'أشعة سينية';
      case InvestigationCategory.investigation:
        return 'فحص';
      case InvestigationCategory.other:
        return 'أخرى';
    }
  }

  static InvestigationCategory fromString(String? value) {
    switch (value) {
      case 'opg':
        return InvestigationCategory.opg;
      case 'xray':
        return InvestigationCategory.xray;
      case 'investigation':
        return InvestigationCategory.investigation;
      default:
        return InvestigationCategory.other;
    }
  }
}

class Investigation {
  const Investigation({
    required this.id,
    required this.clinicId,
    required this.patientId,
    required this.uploadedBy,
    required this.fileUrl,
    required this.fileName,
    required this.fileType,
    required this.category,
    required this.createdAt,
  });

  final String id;
  final String clinicId;
  final String patientId;
  final String uploadedBy;
  final String fileUrl;
  final String fileName;
  final String fileType;
  final InvestigationCategory category;
  final DateTime createdAt;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clinicId': clinicId,
      'patientId': patientId,
      'uploadedBy': uploadedBy,
      'fileUrl': fileUrl,
      'fileName': fileName,
      'fileType': fileType,
      'category': category.value,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory Investigation.fromMap({
    required String id,
    required Map<String, dynamic> map,
  }) {
    return Investigation(
      id: id,
      clinicId: map['clinicId'] as String? ?? '',
      patientId: map['patientId'] as String? ?? '',
      uploadedBy: map['uploadedBy'] as String? ?? '',
      fileUrl: map['fileUrl'] as String? ?? '',
      fileName: map['fileName'] as String? ?? '',
      fileType: map['fileType'] as String? ?? '',
      category: InvestigationCategoryX.fromString(map['category'] as String?),
      createdAt: _asDateTime(map['createdAt']) ?? DateTime.now(),
    );
  }

  static DateTime? _asDateTime(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    return null;
  }
}
