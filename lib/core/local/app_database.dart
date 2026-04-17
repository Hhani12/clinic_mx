import 'package:drift/drift.dart';

import 'connection/open_connection.dart';
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  // Phase 1
  LocalPatients,
  LocalAppointments,
  // Phase 2
  LocalDoctors,
  LocalPayments,
  // Phase 3
  LocalToothRecords,
  LocalDentalPlans,
  LocalClinics,
  LocalClinicSettings,
  // Sync infrastructure
  SyncQueue,
  SyncMeta,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  /// For unit tests — pass `NativeDatabase.memory()`.
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          // Indexes for common sync / query patterns.
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_patients_clinic '
            'ON local_patients (clinic_id)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_patients_synced '
            'ON local_patients (is_synced) WHERE is_synced = 0',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_appointments_clinic_start '
            'ON local_appointments (clinic_id, start_at)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_appointments_synced '
            'ON local_appointments (is_synced) WHERE is_synced = 0',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_doctors_clinic '
            'ON local_doctors (clinic_id)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_payments_clinic_date '
            'ON local_payments (clinic_id, date)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_payments_patient '
            'ON local_payments (clinic_id, patient_id)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_tooth_records_patient '
            'ON local_tooth_records (clinic_id, patient_id)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_dental_plans_patient '
            'ON local_dental_plans (clinic_id, patient_id)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_sync_queue_created '
            'ON sync_queue (created_at)',
          );
        },
      );
}
