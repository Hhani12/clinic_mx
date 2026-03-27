class StaffProfile {
  const StaffProfile({
    required this.id,
    required this.name,
    required this.role,
    this.pin,
    this.isActive = true,
  });

  final String id;
  final String name;
  final String role; // 'admin', 'doctor', 'reception'
  final String? pin;
  final bool isActive;

  StaffProfile copyWith({
    String? id,
    String? name,
    String? role,
    String? pin,
    bool? isActive,
  }) {
    return StaffProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      pin: pin ?? this.pin,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'pin': pin,
      'isActive': isActive,
    };
  }

  factory StaffProfile.fromMap(String id, Map<String, dynamic> map) {
    return StaffProfile(
      id: id,
      name: map['name'] as String? ?? '',
      role: map['role'] as String? ?? 'reception',
      pin: map['pin'] as String?,
      isActive: map['isActive'] as bool? ?? true,
    );
  }
}
