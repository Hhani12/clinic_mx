import 'package:drift/drift.dart';

// ─── Phase 1: Patients & Appointments ───

class LocalPatients extends Table {
  TextColumn get id => text()();
  TextColumn get clinicId => text()();
  TextColumn get firstName => text()();
  TextColumn get fatherName => text()();
  TextColumn get lastName => text()();
  TextColumn get displayName => text()();
  TextColumn get displayNameLower => text()();
  TextColumn get phoneNumber => text()();
  TextColumn get city => text().nullable()();
  TextColumn get district => text().nullable()();
  TextColumn get detailedAddress => text().nullable()();
  DateTimeColumn get dob => dateTime().nullable()();
  TextColumn get gender => text().nullable()(); // male | female
  TextColumn get nationalId => text().nullable()();
  TextColumn get reasonForVisit => text().nullable()();
  TextColumn get medicalNotes => text().nullable()();
  TextColumn get allergiesJson => text().withDefault(const Constant('[]'))();
  TextColumn get chronicDiseasesJson =>
      text().withDefault(const Constant('[]'))();
  TextColumn get attachmentUrlsJson =>
      text().withDefault(const Constant('[]'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get isSynced =>
      boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

class LocalAppointments extends Table {
  TextColumn get id => text()();
  TextColumn get clinicId => text()();
  TextColumn get patientId => text()();
  TextColumn get patientName => text()();
  TextColumn get patientPhone => text()();
  DateTimeColumn get startAt => dateTime()();
  IntColumn get durationMinutes => integer()();
  TextColumn get reason => text()();
  TextColumn get status => text()(); // VisitStatus string value
  TextColumn get doctorId => text()();
  TextColumn get doctorName => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get reminderSent =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get isSynced =>
      boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

// ─── Phase 2: Doctors & Payments ───

class LocalDoctors extends Table {
  TextColumn get id => text()();
  TextColumn get clinicId => text()();
  TextColumn get fullName => text().withDefault(const Constant(''))();
  TextColumn get phone => text().nullable()();
  TextColumn get specialty => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get profilePictureUrl => text().nullable()();
  RealColumn get monthlySalaryIqd =>
      real().withDefault(const Constant(0))();
  RealColumn get commissionPercent =>
      real().withDefault(const Constant(0))();
  TextColumn get paymentType =>
      text().withDefault(const Constant('commission'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get isActive =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get isSynced =>
      boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

class LocalPayments extends Table {
  TextColumn get id => text()();
  TextColumn get clinicId => text()();
  TextColumn get patientId => text()();
  TextColumn get patientName => text()();
  TextColumn get doctorId => text().nullable()();
  TextColumn get doctorName => text().nullable()();
  RealColumn get doctorShare => real().withDefault(const Constant(0))();
  TextColumn get appointmentId => text().nullable()();
  RealColumn get amount => real()();
  RealColumn get paid => real()();
  RealColumn get remaining => real()();
  TextColumn get method => text()(); // cash | card | transfer
  DateTimeColumn get date => dateTime()();
  TextColumn get paymentNotes => text().nullable()();
  TextColumn get createdBy => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get isSynced =>
      boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

// ─── Phase 3: Dental, Clinic, Settings ───

class LocalToothRecords extends Table {
  TextColumn get docId => text()(); // {patientId}_{toothId}
  TextColumn get patientId => text()();
  TextColumn get toothId => text()();
  TextColumn get clinicId => text()();
  TextColumn get status => text().withDefault(const Constant('healthy'))();
  TextColumn get proceduresJson =>
      text().withDefault(const Constant('[]'))();
  TextColumn get toothNotes => text().nullable()();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get isSynced =>
      boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {docId};
}

class LocalDentalPlans extends Table {
  TextColumn get id => text()();
  TextColumn get clinicId => text()();
  TextColumn get patientId => text()();
  TextColumn get toothId => text()();
  TextColumn get numberingSystem => text()();
  TextColumn get actionLabel => text()();
  TextColumn get note => text()();
  DateTimeColumn get timestamp => dateTime()();
  TextColumn get doctorId => text()();
  BoolColumn get isSynced =>
      boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

class LocalClinics extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get phone => text().nullable()();
  TextColumn get city => text().nullable()();
  TextColumn get district => text().nullable()();
  TextColumn get address => text().nullable()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get expiresAt => dateTime().nullable()();
  BoolColumn get active =>
      boolean().withDefault(const Constant(true))();
  TextColumn get reactivationHistoryJson =>
      text().withDefault(const Constant('[]'))();
  BoolColumn get isSynced =>
      boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

class LocalClinicSettings extends Table {
  TextColumn get clinicId => text()();
  IntColumn get reminderOffsetHours =>
      integer().withDefault(const Constant(2))();
  TextColumn get teethNumberingSystem =>
      text().withDefault(const Constant('fdi'))();
  TextColumn get toothActionsJson => text().withDefault(const Constant(
      '["Extraction","Filling","Cleaning","Orthodontics","Root canal"]'))();
  BoolColumn get whatsAppEnabled =>
      boolean().withDefault(const Constant(true))();
  TextColumn get whatsAppSenderNumber => text().nullable()();
  TextColumn get whatsAppPhoneNumberId => text().nullable()();
  BoolColumn get smsEnabled =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get emailEnabled =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get phoneAuthEnabled =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get isSynced =>
      boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {clinicId};
}

// ─── Sync infrastructure ───

class SyncQueue extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get targetTable => text()();
  TextColumn get recordId => text()();
  TextColumn get operation => text()(); // create | update | delete
  TextColumn get payload => text()(); // JSON snapshot
  DateTimeColumn get createdAt => dateTime()();
}

class SyncMeta extends Table {
  TextColumn get collectionName => text()();
  DateTimeColumn get lastPullAt => dateTime()();

  @override
  Set<Column> get primaryKey => {collectionName};
}
