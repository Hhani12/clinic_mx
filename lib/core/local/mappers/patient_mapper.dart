import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../features/patients/domain/entities/patient.dart';
import '../app_database.dart';

class PatientMapper {
  const PatientMapper._();

  static LocalPatientsCompanion toCompanion(Patient p, {bool synced = false}) {
    return LocalPatientsCompanion.insert(
      id: p.id,
      clinicId: p.clinicId,
      firstName: p.firstName,
      fatherName: p.fatherName,
      lastName: p.lastName,
      displayName: p.displayName,
      displayNameLower: p.displayNameLower,
      phoneNumber: p.phoneNumber,
      city: Value(p.city),
      district: Value(p.district),
      detailedAddress: Value(p.detailedAddress),
      dob: Value(p.dob),
      gender: Value(p.gender?.value),
      nationalId: Value(p.nationalId),
      reasonForVisit: Value(p.reasonForVisit),
      medicalNotes: Value(p.medicalNotes),
      allergiesJson: Value(jsonEncode(p.allergies)),
      chronicDiseasesJson: Value(jsonEncode(p.chronicDiseases)),
      attachmentUrlsJson: Value(jsonEncode(p.attachmentUrls)),
      createdAt: p.createdAt,
      updatedAt: p.updatedAt,
      isSynced: Value(synced),
    );
  }

  static Patient fromRow(LocalPatient row) {
    return Patient(
      id: row.id,
      clinicId: row.clinicId,
      firstName: row.firstName,
      fatherName: row.fatherName,
      lastName: row.lastName,
      displayName: row.displayName,
      displayNameLower: row.displayNameLower,
      phoneNumber: row.phoneNumber,
      city: row.city,
      district: row.district,
      detailedAddress: row.detailedAddress,
      dob: row.dob,
      gender: PatientGenderX.fromString(row.gender),
      nationalId: row.nationalId,
      reasonForVisit: row.reasonForVisit,
      medicalNotes: row.medicalNotes,
      allergies: _decodeStringList(row.allergiesJson),
      chronicDiseases: _decodeStringList(row.chronicDiseasesJson),
      attachmentUrls: _decodeStringList(row.attachmentUrlsJson),
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  /// Payload for the sync queue — pure Map, no Firestore types.
  static Map<String, dynamic> toPayload(Patient p) {
    return {
      'id': p.id,
      'clinicId': p.clinicId,
      'firstName': p.firstName,
      'fatherName': p.fatherName,
      'lastName': p.lastName,
      'displayName': p.displayName,
      'displayNameLower': p.displayNameLower,
      'phoneNumber': p.phoneNumber,
      'city': p.city,
      'district': p.district,
      'detailedAddress': p.detailedAddress,
      'dob': p.dob?.toIso8601String(),
      'gender': p.gender?.value,
      'nationalId': p.nationalId,
      'reasonForVisit': p.reasonForVisit,
      'medicalNotes': p.medicalNotes,
      'allergies': p.allergies,
      'chronicDiseases': p.chronicDiseases,
      'attachmentUrls': p.attachmentUrls,
      'createdAt': p.createdAt.toIso8601String(),
      'updatedAt': p.updatedAt.toIso8601String(),
    };
  }

  static List<String> _decodeStringList(String json) {
    final list = jsonDecode(json) as List<dynamic>;
    return list.whereType<String>().toList();
  }
}
