import 'package:medrep_pro/features/auth/domain/entities/user.dart';

class UserDto {
  final String id;
  final String email;
  final String name;
  final String role;
  final String tenantId;
  final List<int> territoryIds;

  UserDto({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.tenantId,
    required this.territoryIds,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    final publicMetadata = json['public_metadata'] as Map<String, dynamic>? ?? {};
    final emailAddresses = json['email_addresses'] as List<dynamic>?;
    final primaryEmailAddressId = json['primary_email_address_id'] as String?;

    String email = json['email'] as String? ?? '';
    if (email.isEmpty && emailAddresses != null && primaryEmailAddressId != null) {
      for (final address in emailAddresses) {
        if (address['id'] == primaryEmailAddressId) {
          email = address['email_address'] as String? ?? '';
          break;
        }
      }
    }

    final firstName = json['first_name'] as String? ?? '';
    final lastName = json['last_name'] as String? ?? '';
    final fullName = [firstName, lastName].where((s) => s.isNotEmpty).join(' ');

    return UserDto(
      id: json['id'] as String? ?? '',
      email: email,
      name: fullName.isNotEmpty ? fullName : (json['name'] as String? ?? ''),
      role: publicMetadata['role'] as String? ?? 'medical_rep',
      tenantId: publicMetadata['tenant_id'] as String? ?? '',
      territoryIds: List<int>.from(publicMetadata['territory_ids'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'public_metadata': {
        'role': role,
        'tenant_id': tenantId,
        'territory_ids': territoryIds,
      },
    };
  }

  User toDomain() {
    return User(
      id: id,
      email: email,
      name: name,
      role: role,
      tenantId: tenantId,
      territoryIds: territoryIds,
    );
  }
}
