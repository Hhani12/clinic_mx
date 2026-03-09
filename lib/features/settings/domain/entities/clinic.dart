import 'package:cloud_firestore/cloud_firestore.dart';

class Clinic {
  const Clinic({
    required this.id,
    required this.name,
    this.phone,
    this.city,
    this.district,
    this.address,
    required this.updatedAt,
  });

  final String id;
  final String name;
  final String? phone;
  final String? city;
  final String? district;
  final String? address;
  final DateTime updatedAt;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'city': city,
      'district': district,
      'address': address,
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  factory Clinic.fromMap({
    required String id,
    required Map<String, dynamic> map,
  }) {
    return Clinic(
      id: id,
      name: map['name'] as String? ?? '',
      phone: map['phone'] as String?,
      city: map['city'] as String?,
      district: map['district'] as String?,
      address: map['address'] as String?,
      updatedAt: _asDateTime(map['updatedAt']) ?? DateTime.now(),
    );
  }

  static DateTime? _asDateTime(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    return null;
  }
}
