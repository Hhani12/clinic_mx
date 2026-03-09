enum UserRole { admin, doctor, reception }

extension UserRoleX on UserRole {
  String get value {
    switch (this) {
      case UserRole.admin:
        return 'admin';
      case UserRole.doctor:
        return 'doctor';
      case UserRole.reception:
        return 'reception';
    }
  }

  String get labelAr {
    switch (this) {
      case UserRole.admin:
        return 'مدير';
      case UserRole.doctor:
        return 'طبيب';
      case UserRole.reception:
        return 'استقبال';
    }
  }

  static UserRole fromString(String? value) {
    switch (value) {
      case 'admin':
        return UserRole.admin;
      case 'doctor':
        return UserRole.doctor;
      case 'reception':
      default:
        return UserRole.reception;
    }
  }
}
