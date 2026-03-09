import '../../../../core/enums/user_role.dart';

class AppUserProfile {
  const AppUserProfile({
    required this.uid,
    required this.clinicId,
    required this.email,
    required this.displayName,
    required this.role,
    required this.isActive,
    this.phoneNumber,
  });

  final String uid;
  final String clinicId;
  final String email;
  final String displayName;
  final UserRole role;
  final bool isActive;
  final String? phoneNumber;

  AppUserProfile copyWith({
    String? uid,
    String? clinicId,
    String? email,
    String? displayName,
    UserRole? role,
    bool? isActive,
    String? phoneNumber,
  }) {
    return AppUserProfile(
      uid: uid ?? this.uid,
      clinicId: clinicId ?? this.clinicId,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'clinicId': clinicId,
      'email': email,
      'displayName': displayName,
      'role': role.value,
      'isActive': isActive,
      'phoneNumber': phoneNumber,
    };
  }

  factory AppUserProfile.fromMap(Map<String, dynamic> map) {
    return AppUserProfile(
      uid: map['uid'] as String,
      clinicId: map['clinicId'] as String,
      email: map['email'] as String? ?? '',
      displayName: map['displayName'] as String? ?? '',
      role: UserRoleX.fromString(map['role'] as String?),
      isActive: map['isActive'] as bool? ?? true,
      phoneNumber: map['phoneNumber'] as String?,
    );
  }
}
