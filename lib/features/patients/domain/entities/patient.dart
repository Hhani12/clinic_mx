import 'package:cloud_firestore/cloud_firestore.dart';

enum PatientGender { male, female }

extension PatientGenderX on PatientGender {
  String get value => this == PatientGender.male ? 'male' : 'female';

  static PatientGender? fromString(String? value) {
    switch (value) {
      case 'male':
        return PatientGender.male;
      case 'female':
        return PatientGender.female;
      default:
        return null;
    }
  }
}

class Patient {
  const Patient({
    required this.id,
    required this.clinicId,
    required this.firstName,
    required this.fatherName,
    required this.lastName,
    required this.displayName,
    required this.displayNameLower,
    required this.phoneNumber,
    this.city,
    this.district,
    this.detailedAddress,
    this.dob,
    this.gender,
    this.nationalId,
    this.reasonForVisit,
    this.medicalNotes,
    this.allergies = const [],
    this.chronicDiseases = const [],
    this.attachmentUrls = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String clinicId;
  final String firstName;
  final String fatherName;
  final String lastName;
  final String displayName;
  final String displayNameLower;
  final String phoneNumber;
  final String? city;
  final String? district;
  final String? detailedAddress;
  final DateTime? dob;
  final PatientGender? gender;
  final String? nationalId;
  final String? reasonForVisit;
  final String? medicalNotes;
  final List<String> allergies;
  final List<String> chronicDiseases;
  final List<String> attachmentUrls;
  final DateTime createdAt;
  final DateTime updatedAt;

  String get fullAddress {
    final parts = [city, district, detailedAddress]
        .whereType<String>()
        .map((part) => part.trim())
        .where((part) => part.isNotEmpty)
        .toList();
    return parts.join(' - ');
  }

  Patient copyWith({
    String? id,
    String? clinicId,
    String? firstName,
    String? fatherName,
    String? lastName,
    String? displayName,
    String? displayNameLower,
    String? phoneNumber,
    String? city,
    String? district,
    String? detailedAddress,
    DateTime? dob,
    PatientGender? gender,
    String? nationalId,
    String? reasonForVisit,
    String? medicalNotes,
    List<String>? allergies,
    List<String>? chronicDiseases,
    List<String>? attachmentUrls,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Patient(
      id: id ?? this.id,
      clinicId: clinicId ?? this.clinicId,
      firstName: firstName ?? this.firstName,
      fatherName: fatherName ?? this.fatherName,
      lastName: lastName ?? this.lastName,
      displayName: displayName ?? this.displayName,
      displayNameLower: displayNameLower ?? this.displayNameLower,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      city: city ?? this.city,
      district: district ?? this.district,
      detailedAddress: detailedAddress ?? this.detailedAddress,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      nationalId: nationalId ?? this.nationalId,
      reasonForVisit: reasonForVisit ?? this.reasonForVisit,
      medicalNotes: medicalNotes ?? this.medicalNotes,
      allergies: allergies ?? this.allergies,
      chronicDiseases: chronicDiseases ?? this.chronicDiseases,
      attachmentUrls: attachmentUrls ?? this.attachmentUrls,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clinicId': clinicId,
      'firstName': firstName,
      'fatherName': fatherName,
      'lastName': lastName,
      'displayName': displayName,
      'displayNameLower': displayNameLower,
      'phoneNumber': phoneNumber,
      'city': city,
      'district': district,
      'detailedAddress': detailedAddress,
      'dob': dob == null ? null : Timestamp.fromDate(dob!),
      'gender': gender?.value,
      'nationalId': nationalId,
      'reasonForVisit': reasonForVisit,
      'medicalNotes': medicalNotes,
      'allergies': allergies,
      'chronicDiseases': chronicDiseases,
      'attachmentUrls': attachmentUrls,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  factory Patient.fromMap({
    required String id,
    required Map<String, dynamic> map,
  }) {
    return Patient(
      id: id,
      clinicId: map['clinicId'] as String? ?? '',
      firstName: map['firstName'] as String? ?? '',
      fatherName: map['fatherName'] as String? ?? '',
      lastName: map['lastName'] as String? ?? '',
      displayName: map['displayName'] as String? ?? '',
      displayNameLower: map['displayNameLower'] as String? ?? '',
      phoneNumber: map['phoneNumber'] as String? ?? '',
      city: map['city'] as String?,
      district: map['district'] as String?,
      detailedAddress: map['detailedAddress'] as String?,
      dob: _asDateTime(map['dob']),
      gender: PatientGenderX.fromString(map['gender'] as String?),
      nationalId: map['nationalId'] as String?,
      reasonForVisit: map['reasonForVisit'] as String?,
      medicalNotes: map['medicalNotes'] as String?,
      allergies: (map['allergies'] as List<dynamic>? ?? [])
          .whereType<String>()
          .toList(),
      chronicDiseases: (map['chronicDiseases'] as List<dynamic>? ?? [])
          .whereType<String>()
          .toList(),
      attachmentUrls: (map['attachmentUrls'] as List<dynamic>? ?? [])
          .whereType<String>()
          .toList(),
      createdAt: _asDateTime(map['createdAt']) ?? DateTime.now(),
      updatedAt: _asDateTime(map['updatedAt']) ?? DateTime.now(),
    );
  }

  static DateTime? _asDateTime(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    return null;
  }
}
