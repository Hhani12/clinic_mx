import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_database.dart';
import 'daos/appointments_local_dao.dart';
import 'daos/clinic_local_dao.dart';
import 'daos/dental_plans_local_dao.dart';
import 'daos/doctors_local_dao.dart';
import 'daos/patients_local_dao.dart';
import 'daos/payments_local_dao.dart';
import 'daos/tooth_records_local_dao.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

final patientsLocalDaoProvider = Provider<PatientsLocalDao>((ref) {
  return PatientsLocalDao(ref.watch(appDatabaseProvider));
});

final appointmentsLocalDaoProvider = Provider<AppointmentsLocalDao>((ref) {
  return AppointmentsLocalDao(ref.watch(appDatabaseProvider));
});

final doctorsLocalDaoProvider = Provider<DoctorsLocalDao>((ref) {
  return DoctorsLocalDao(ref.watch(appDatabaseProvider));
});

final paymentsLocalDaoProvider = Provider<PaymentsLocalDao>((ref) {
  return PaymentsLocalDao(ref.watch(appDatabaseProvider));
});

final toothRecordsLocalDaoProvider = Provider<ToothRecordsLocalDao>((ref) {
  return ToothRecordsLocalDao(ref.watch(appDatabaseProvider));
});

final dentalPlansLocalDaoProvider = Provider<DentalPlansLocalDao>((ref) {
  return DentalPlansLocalDao(ref.watch(appDatabaseProvider));
});

final clinicLocalDaoProvider = Provider<ClinicLocalDao>((ref) {
  return ClinicLocalDao(ref.watch(appDatabaseProvider));
});
