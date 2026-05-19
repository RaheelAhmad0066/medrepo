import 'package:drift/drift.dart';
import 'package:medrep_pro/core/database/app_database.dart';
import 'package:medrep_pro/features/doctors/domain/entities/doctor.dart';

class DoctorDto {
  final String id;
  final String tenantId;
  final String name;
  final String specialty;
  final String? email;
  final String? phone;
  final String clinicAddress;
  final double? latitude;
  final double? longitude;
  final String tier;
  final DateTime clientCreatedAt;
  final DateTime lastModifiedAt;
  final bool isDeleted;

  DoctorDto({
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

  factory DoctorDto.fromJson(Map<String, dynamic> json) {
    return DoctorDto(
      id: json['id'] as String,
      tenantId: json['tenant_id'] as String? ?? '',
      name: json['name'] as String,
      specialty: json['specialty'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      clinicAddress: json['clinic_address'] as String? ?? '',
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      tier: json['tier'] as String? ?? 'C',
      clientCreatedAt: DateTime.parse(json['client_created_at'] as String),
      lastModifiedAt: DateTime.parse(json['last_modified_at'] as String? ?? DateTime.now().toIso8601String()),
      isDeleted: json['is_deleted'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tenant_id': tenantId,
      'name': name,
      'specialty': specialty,
      'email': email,
      'phone': phone,
      'clinic_address': clinicAddress,
      'latitude': latitude,
      'longitude': longitude,
      'tier': tier,
      'client_created_at': clientCreatedAt.toIso8601String(),
      'last_modified_at': lastModifiedAt.toIso8601String(),
      'is_deleted': isDeleted,
    };
  }

  Doctor toDomain() {
    return Doctor(
      id: id,
      tenantId: tenantId,
      name: name,
      specialty: specialty,
      email: email,
      phone: phone,
      clinicAddress: clinicAddress,
      latitude: latitude,
      longitude: longitude,
      tier: tier,
      clientCreatedAt: clientCreatedAt,
      lastModifiedAt: lastModifiedAt,
      isDeleted: isDeleted,
    );
  }

  factory DoctorDto.fromDomain(Doctor doctor) {
    return DoctorDto(
      id: doctor.id,
      tenantId: doctor.tenantId,
      name: doctor.name,
      specialty: doctor.specialty,
      email: doctor.email,
      phone: doctor.phone,
      clinicAddress: doctor.clinicAddress,
      latitude: doctor.latitude,
      longitude: doctor.longitude,
      tier: doctor.tier,
      clientCreatedAt: doctor.clientCreatedAt,
      lastModifiedAt: doctor.lastModifiedAt,
      isDeleted: doctor.isDeleted,
    );
  }

  factory DoctorDto.fromDb(DoctorsTableData dbData) {
    return DoctorDto(
      id: dbData.id,
      tenantId: dbData.tenantId,
      name: dbData.name,
      specialty: dbData.specialty,
      email: dbData.email,
      phone: dbData.phone,
      clinicAddress: dbData.clinicAddress,
      latitude: dbData.latitude,
      longitude: dbData.longitude,
      tier: dbData.tier,
      clientCreatedAt: dbData.clientCreatedAt,
      lastModifiedAt: dbData.lastModifiedAt,
      isDeleted: dbData.isDeleted,
    );
  }

  DoctorsTableCompanion toCompanion() {
    return DoctorsTableCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      name: Value(name),
      specialty: Value(specialty),
      email: Value(email),
      phone: Value(phone),
      clinicAddress: Value(clinicAddress),
      latitude: Value(latitude),
      longitude: Value(longitude),
      tier: Value(tier),
      clientCreatedAt: Value(clientCreatedAt),
      lastModifiedAt: Value(lastModifiedAt),
      isDeleted: Value(isDeleted),
    );
  }
}
