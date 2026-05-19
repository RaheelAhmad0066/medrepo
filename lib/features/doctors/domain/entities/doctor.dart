import 'package:equatable/equatable.dart';

class Doctor extends Equatable {
  final String id;
  final String tenantId;
  final String name;
  final String specialty;
  final String? email;
  final String? phone;
  final String clinicAddress;
  final double? latitude;
  final double? longitude;
  final String tier; // 'A', 'B', 'C'
  final DateTime clientCreatedAt;
  final DateTime lastModifiedAt;
  final bool isDeleted;

  const Doctor({
    required this.id,
    required this.tenantId,
    required this.name,
    required this.specialty,
    this.email,
    this.phone,
    required this.clinicAddress,
    this.latitude,
    this.longitude,
    required this.tier,
    required this.clientCreatedAt,
    required this.lastModifiedAt,
    required this.isDeleted,
  });

  Doctor copyWith({
    String? id,
    String? tenantId,
    String? name,
    String? specialty,
    String? email,
    String? phone,
    String? clinicAddress,
    double? latitude,
    double? longitude,
    String? tier,
    DateTime? clientCreatedAt,
    DateTime? lastModifiedAt,
    bool? isDeleted,
  }) {
    return Doctor(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      name: name ?? this.name,
      specialty: specialty ?? this.specialty,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      clinicAddress: clinicAddress ?? this.clinicAddress,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      tier: tier ?? this.tier,
      clientCreatedAt: clientCreatedAt ?? this.clientCreatedAt,
      lastModifiedAt: lastModifiedAt ?? this.lastModifiedAt,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  List<Object?> get props => [
        id,
        tenantId,
        name,
        specialty,
        email,
        phone,
        clinicAddress,
        latitude,
        longitude,
        tier,
        clientCreatedAt,
        lastModifiedAt,
        isDeleted,
      ];
}
