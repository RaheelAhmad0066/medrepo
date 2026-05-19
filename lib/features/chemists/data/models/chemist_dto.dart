import 'package:drift/drift.dart';
import 'package:medrep_pro/core/database/app_database.dart';
import 'package:medrep_pro/features/chemists/domain/entities/chemist.dart';

class ChemistDto {
  final String id;
  final String tenantId;
  final String name;
  final String? contactPerson;
  final String? phone;
  final String address;
  final double? latitude;
  final double? longitude;
  final String priorityTag;
  final double outstandingBalance;
  final double creditLimit;
  final DateTime clientCreatedAt;
  final DateTime lastModifiedAt;
  final bool isDeleted;

  ChemistDto({
    required this.id,
    required this.tenantId,
    required this.name,
    this.contactPerson,
    this.phone,
    required this.address,
    this.latitude,
    this.longitude,
    required this.priorityTag,
    required this.outstandingBalance,
    required this.creditLimit,
    required this.clientCreatedAt,
    required this.lastModifiedAt,
    required this.isDeleted,
  });

  factory ChemistDto.fromJson(Map<String, dynamic> json) {
    return ChemistDto(
      id: json['id'] as String,
      tenantId: json['tenant_id'] as String? ?? '',
      name: json['name'] as String,
      contactPerson: json['contact_person'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String? ?? '',
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      priorityTag: json['priority_tag'] as String? ?? 'Medium',
      outstandingBalance: (json['outstanding_balance'] as num?)?.toDouble() ?? 0.0,
      creditLimit: (json['credit_limit'] as num?)?.toDouble() ?? 0.0,
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
      'contact_person': contactPerson,
      'phone': phone,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'priority_tag': priorityTag,
      'outstanding_balance': outstandingBalance,
      'credit_limit': creditLimit,
      'client_created_at': clientCreatedAt.toIso8601String(),
      'last_modified_at': lastModifiedAt.toIso8601String(),
      'is_deleted': isDeleted,
    };
  }

  Chemist toDomain() {
    return Chemist(
      id: id,
      tenantId: tenantId,
      name: name,
      contactPerson: contactPerson,
      phone: phone,
      address: address,
      latitude: latitude,
      longitude: longitude,
      priorityTag: priorityTag,
      outstandingBalance: outstandingBalance,
      creditLimit: creditLimit,
      clientCreatedAt: clientCreatedAt,
      lastModifiedAt: lastModifiedAt,
      isDeleted: isDeleted,
    );
  }

  factory ChemistDto.fromDomain(Chemist chemist) {
    return ChemistDto(
      id: chemist.id,
      tenantId: chemist.tenantId,
      name: chemist.name,
      contactPerson: chemist.contactPerson,
      phone: chemist.phone,
      address: chemist.address,
      latitude: chemist.latitude,
      longitude: chemist.longitude,
      priorityTag: chemist.priorityTag,
      outstandingBalance: chemist.outstandingBalance,
      creditLimit: chemist.creditLimit,
      clientCreatedAt: chemist.clientCreatedAt,
      lastModifiedAt: chemist.lastModifiedAt,
      isDeleted: chemist.isDeleted,
    );
  }

  factory ChemistDto.fromDb(ChemistsTableData dbData) {
    return ChemistDto(
      id: dbData.id,
      tenantId: dbData.tenantId,
      name: dbData.name,
      contactPerson: dbData.contactPerson,
      phone: dbData.phone,
      address: dbData.address,
      latitude: dbData.latitude,
      longitude: dbData.longitude,
      priorityTag: dbData.priorityTag,
      outstandingBalance: dbData.outstandingBalance,
      creditLimit: dbData.creditLimit,
      clientCreatedAt: dbData.clientCreatedAt,
      lastModifiedAt: dbData.lastModifiedAt,
      isDeleted: dbData.isDeleted,
    );
  }

  ChemistsTableCompanion toCompanion() {
    return ChemistsTableCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      name: Value(name),
      contactPerson: Value(contactPerson),
      phone: Value(phone),
      address: Value(address),
      latitude: Value(latitude),
      longitude: Value(longitude),
      priorityTag: Value(priorityTag),
      outstandingBalance: Value(outstandingBalance),
      creditLimit: Value(creditLimit),
      clientCreatedAt: Value(clientCreatedAt),
      lastModifiedAt: Value(lastModifiedAt),
      isDeleted: Value(isDeleted),
    );
  }
}
