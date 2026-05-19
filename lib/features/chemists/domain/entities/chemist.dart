import 'package:equatable/equatable.dart';

class Chemist extends Equatable {
  final String id;
  final String tenantId;
  final String name;
  final String? contactPerson;
  final String? phone;
  final String address;
  final double? latitude;
  final double? longitude;
  final String priorityTag; // 'High', 'Medium', 'Low'
  final double outstandingBalance;
  final double creditLimit;
  final DateTime clientCreatedAt;
  final DateTime lastModifiedAt;
  final bool isDeleted;

  const Chemist({
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

  Chemist copyWith({
    String? id,
    String? tenantId,
    String? name,
    String? contactPerson,
    String? phone,
    String? address,
    double? latitude,
    double? longitude,
    String? priorityTag,
    double? outstandingBalance,
    double? creditLimit,
    DateTime? clientCreatedAt,
    DateTime? lastModifiedAt,
    bool? isDeleted,
  }) {
    return Chemist(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      name: name ?? this.name,
      contactPerson: contactPerson ?? this.contactPerson,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      priorityTag: priorityTag ?? this.priorityTag,
      outstandingBalance: outstandingBalance ?? this.outstandingBalance,
      creditLimit: creditLimit ?? this.creditLimit,
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
        contactPerson,
        phone,
        address,
        latitude,
        longitude,
        priorityTag,
        outstandingBalance,
        creditLimit,
        clientCreatedAt,
        lastModifiedAt,
        isDeleted,
      ];
}
