import 'package:drift/drift.dart';

import '../../../features/doctors/domain/entities/doctor_profile.dart';
import '../app_database.dart';

class DoctorMapper {
  const DoctorMapper._();

  static LocalDoctorsCompanion toCompanion(
    DoctorProfile d, {
    bool synced = false,
  }) {
    return LocalDoctorsCompanion.insert(
      id: d.id,
      clinicId: d.clinicId,
      fullName: Value(d.fullName),
      phone: Value(d.phone),
      specialty: Value(d.specialty),
      address: Value(d.address),
      notes: Value(d.notes),
      profilePictureUrl: Value(d.profilePictureUrl),
      monthlySalaryIqd: Value(d.monthlySalaryIqd),
      commissionPercent: Value(d.commissionPercent),
      paymentType: Value(d.paymentType.value),
      createdAt: d.createdAt,
      updatedAt: d.updatedAt,
      isActive: Value(d.isActive),
      isSynced: Value(synced),
    );
  }

  static DoctorProfile fromRow(LocalDoctor row) {
    return DoctorProfile(
      id: row.id,
      clinicId: row.clinicId,
      fullName: row.fullName,
      phone: row.phone,
      specialty: row.specialty,
      address: row.address,
      notes: row.notes,
      profilePictureUrl: row.profilePictureUrl,
      monthlySalaryIqd: row.monthlySalaryIqd,
      commissionPercent: row.commissionPercent,
      paymentType: DoctorPaymentTypeX.fromString(row.paymentType),
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      isActive: row.isActive,
    );
  }

  static Map<String, dynamic> toPayload(DoctorProfile d) {
    return {
      'id': d.id,
      'clinicId': d.clinicId,
      'fullName': d.fullName,
      'phone': d.phone,
      'specialty': d.specialty,
      'address': d.address,
      'notes': d.notes,
      'profilePictureUrl': d.profilePictureUrl,
      'monthlySalaryIqd': d.monthlySalaryIqd,
      'commissionPercent': d.commissionPercent,
      'isActive': d.isActive,
      'paymentType': d.paymentType.value,
      'createdAt': d.createdAt.toIso8601String(),
      'updatedAt': d.updatedAt.toIso8601String(),
    };
  }
}
