class FirestorePaths {
  const FirestorePaths._();

  static const users = 'users';
  static const clinics = 'clinics';
  static const patients = 'patients';
  static const appointments = 'appointments';
  static const doctors = 'doctors';
  static const payments = 'payments';
  static const dentalPlans = 'dentalPlans';
  static const reminderLogs = 'reminderLogs';
  static const investigations = 'investigations';
  static const toothRecords = 'toothRecords';
  static const settingsCollection = 'settings';
  static const settingsDoc = 'config';

  static String clinicDoc(String clinicId) => '$clinics/$clinicId';
  static String clinicUsers(String clinicId) => '${clinicDoc(clinicId)}/users';
  static String clinicPatients(String clinicId) =>
      '${clinicDoc(clinicId)}/$patients';
  static String clinicAppointments(String clinicId) =>
      '${clinicDoc(clinicId)}/$appointments';
  static String clinicDoctors(String clinicId) =>
      '${clinicDoc(clinicId)}/$doctors';
  static String clinicPayments(String clinicId) =>
      '${clinicDoc(clinicId)}/$payments';
  static String clinicDentalPlans(String clinicId) =>
      '${clinicDoc(clinicId)}/$dentalPlans';
  static String clinicReminderLogs(String clinicId) =>
      '${clinicDoc(clinicId)}/$reminderLogs';
  static String clinicToothRecords(String clinicId) =>
      '${clinicDoc(clinicId)}/$toothRecords';
  static String clinicSettingsDoc(String clinicId) =>
      '${clinicDoc(clinicId)}/$settingsCollection/$settingsDoc';
}
