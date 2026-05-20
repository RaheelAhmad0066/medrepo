// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $TerritoriesTableTable extends TerritoriesTable
    with TableInfo<$TerritoriesTableTable, TerritoryCache> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TerritoriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
      'region', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, name, region];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'territories_table';
  @override
  VerificationContext validateIntegrity(Insertable<TerritoryCache> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('region')) {
      context.handle(_regionMeta,
          region.isAcceptableOrUnknown(data['region']!, _regionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TerritoryCache map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TerritoryCache(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      region: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}region']),
    );
  }

  @override
  $TerritoriesTableTable createAlias(String alias) {
    return $TerritoriesTableTable(attachedDatabase, alias);
  }
}

class TerritoryCache extends DataClass implements Insertable<TerritoryCache> {
  final String id;
  final String name;
  final String? region;
  const TerritoryCache({required this.id, required this.name, this.region});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || region != null) {
      map['region'] = Variable<String>(region);
    }
    return map;
  }

  TerritoriesTableCompanion toCompanion(bool nullToAbsent) {
    return TerritoriesTableCompanion(
      id: Value(id),
      name: Value(name),
      region:
          region == null && nullToAbsent ? const Value.absent() : Value(region),
    );
  }

  factory TerritoryCache.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TerritoryCache(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      region: serializer.fromJson<String?>(json['region']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'region': serializer.toJson<String?>(region),
    };
  }

  TerritoryCache copyWith(
          {String? id,
          String? name,
          Value<String?> region = const Value.absent()}) =>
      TerritoryCache(
        id: id ?? this.id,
        name: name ?? this.name,
        region: region.present ? region.value : this.region,
      );
  TerritoryCache copyWithCompanion(TerritoriesTableCompanion data) {
    return TerritoryCache(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      region: data.region.present ? data.region.value : this.region,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TerritoryCache(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('region: $region')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, region);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TerritoryCache &&
          other.id == this.id &&
          other.name == this.name &&
          other.region == this.region);
}

class TerritoriesTableCompanion extends UpdateCompanion<TerritoryCache> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> region;
  final Value<int> rowid;
  const TerritoriesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.region = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TerritoriesTableCompanion.insert({
    required String id,
    required String name,
    this.region = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<TerritoryCache> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? region,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (region != null) 'region': region,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TerritoriesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? region,
      Value<int>? rowid}) {
    return TerritoriesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      region: region ?? this.region,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (region.present) {
      map['region'] = Variable<String>(region.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TerritoriesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('region: $region, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProfilesTableTable extends ProfilesTable
    with TableInfo<$ProfilesTableTable, ProfileCache> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfilesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _clerkUserIdMeta =
      const VerificationMeta('clerkUserId');
  @override
  late final GeneratedColumn<String> clerkUserId = GeneratedColumn<String>(
      'clerk_user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fullNameMeta =
      const VerificationMeta('fullName');
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
      'full_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _territoryIdMeta =
      const VerificationMeta('territoryId');
  @override
  late final GeneratedColumn<String> territoryId = GeneratedColumn<String>(
      'territory_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _managerIdMeta =
      const VerificationMeta('managerId');
  @override
  late final GeneratedColumn<String> managerId = GeneratedColumn<String>(
      'manager_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        clerkUserId,
        fullName,
        phone,
        role,
        territoryId,
        managerId,
        isActive
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profiles_table';
  @override
  VerificationContext validateIntegrity(Insertable<ProfileCache> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('clerk_user_id')) {
      context.handle(
          _clerkUserIdMeta,
          clerkUserId.isAcceptableOrUnknown(
              data['clerk_user_id']!, _clerkUserIdMeta));
    } else if (isInserting) {
      context.missing(_clerkUserIdMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(_fullNameMeta,
          fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    }
    if (data.containsKey('territory_id')) {
      context.handle(
          _territoryIdMeta,
          territoryId.isAcceptableOrUnknown(
              data['territory_id']!, _territoryIdMeta));
    }
    if (data.containsKey('manager_id')) {
      context.handle(_managerIdMeta,
          managerId.isAcceptableOrUnknown(data['manager_id']!, _managerIdMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProfileCache map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileCache(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      clerkUserId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}clerk_user_id'])!,
      fullName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}full_name']),
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role']),
      territoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}territory_id']),
      managerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}manager_id']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
    );
  }

  @override
  $ProfilesTableTable createAlias(String alias) {
    return $ProfilesTableTable(attachedDatabase, alias);
  }
}

class ProfileCache extends DataClass implements Insertable<ProfileCache> {
  final String id;
  final String clerkUserId;
  final String? fullName;
  final String? phone;
  final String? role;
  final String? territoryId;
  final String? managerId;
  final bool isActive;
  const ProfileCache(
      {required this.id,
      required this.clerkUserId,
      this.fullName,
      this.phone,
      this.role,
      this.territoryId,
      this.managerId,
      required this.isActive});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['clerk_user_id'] = Variable<String>(clerkUserId);
    if (!nullToAbsent || fullName != null) {
      map['full_name'] = Variable<String>(fullName);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || role != null) {
      map['role'] = Variable<String>(role);
    }
    if (!nullToAbsent || territoryId != null) {
      map['territory_id'] = Variable<String>(territoryId);
    }
    if (!nullToAbsent || managerId != null) {
      map['manager_id'] = Variable<String>(managerId);
    }
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  ProfilesTableCompanion toCompanion(bool nullToAbsent) {
    return ProfilesTableCompanion(
      id: Value(id),
      clerkUserId: Value(clerkUserId),
      fullName: fullName == null && nullToAbsent
          ? const Value.absent()
          : Value(fullName),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      role: role == null && nullToAbsent ? const Value.absent() : Value(role),
      territoryId: territoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(territoryId),
      managerId: managerId == null && nullToAbsent
          ? const Value.absent()
          : Value(managerId),
      isActive: Value(isActive),
    );
  }

  factory ProfileCache.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileCache(
      id: serializer.fromJson<String>(json['id']),
      clerkUserId: serializer.fromJson<String>(json['clerkUserId']),
      fullName: serializer.fromJson<String?>(json['fullName']),
      phone: serializer.fromJson<String?>(json['phone']),
      role: serializer.fromJson<String?>(json['role']),
      territoryId: serializer.fromJson<String?>(json['territoryId']),
      managerId: serializer.fromJson<String?>(json['managerId']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'clerkUserId': serializer.toJson<String>(clerkUserId),
      'fullName': serializer.toJson<String?>(fullName),
      'phone': serializer.toJson<String?>(phone),
      'role': serializer.toJson<String?>(role),
      'territoryId': serializer.toJson<String?>(territoryId),
      'managerId': serializer.toJson<String?>(managerId),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  ProfileCache copyWith(
          {String? id,
          String? clerkUserId,
          Value<String?> fullName = const Value.absent(),
          Value<String?> phone = const Value.absent(),
          Value<String?> role = const Value.absent(),
          Value<String?> territoryId = const Value.absent(),
          Value<String?> managerId = const Value.absent(),
          bool? isActive}) =>
      ProfileCache(
        id: id ?? this.id,
        clerkUserId: clerkUserId ?? this.clerkUserId,
        fullName: fullName.present ? fullName.value : this.fullName,
        phone: phone.present ? phone.value : this.phone,
        role: role.present ? role.value : this.role,
        territoryId: territoryId.present ? territoryId.value : this.territoryId,
        managerId: managerId.present ? managerId.value : this.managerId,
        isActive: isActive ?? this.isActive,
      );
  ProfileCache copyWithCompanion(ProfilesTableCompanion data) {
    return ProfileCache(
      id: data.id.present ? data.id.value : this.id,
      clerkUserId:
          data.clerkUserId.present ? data.clerkUserId.value : this.clerkUserId,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      phone: data.phone.present ? data.phone.value : this.phone,
      role: data.role.present ? data.role.value : this.role,
      territoryId:
          data.territoryId.present ? data.territoryId.value : this.territoryId,
      managerId: data.managerId.present ? data.managerId.value : this.managerId,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileCache(')
          ..write('id: $id, ')
          ..write('clerkUserId: $clerkUserId, ')
          ..write('fullName: $fullName, ')
          ..write('phone: $phone, ')
          ..write('role: $role, ')
          ..write('territoryId: $territoryId, ')
          ..write('managerId: $managerId, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, clerkUserId, fullName, phone, role, territoryId, managerId, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileCache &&
          other.id == this.id &&
          other.clerkUserId == this.clerkUserId &&
          other.fullName == this.fullName &&
          other.phone == this.phone &&
          other.role == this.role &&
          other.territoryId == this.territoryId &&
          other.managerId == this.managerId &&
          other.isActive == this.isActive);
}

class ProfilesTableCompanion extends UpdateCompanion<ProfileCache> {
  final Value<String> id;
  final Value<String> clerkUserId;
  final Value<String?> fullName;
  final Value<String?> phone;
  final Value<String?> role;
  final Value<String?> territoryId;
  final Value<String?> managerId;
  final Value<bool> isActive;
  final Value<int> rowid;
  const ProfilesTableCompanion({
    this.id = const Value.absent(),
    this.clerkUserId = const Value.absent(),
    this.fullName = const Value.absent(),
    this.phone = const Value.absent(),
    this.role = const Value.absent(),
    this.territoryId = const Value.absent(),
    this.managerId = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProfilesTableCompanion.insert({
    required String id,
    required String clerkUserId,
    this.fullName = const Value.absent(),
    this.phone = const Value.absent(),
    this.role = const Value.absent(),
    this.territoryId = const Value.absent(),
    this.managerId = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        clerkUserId = Value(clerkUserId);
  static Insertable<ProfileCache> custom({
    Expression<String>? id,
    Expression<String>? clerkUserId,
    Expression<String>? fullName,
    Expression<String>? phone,
    Expression<String>? role,
    Expression<String>? territoryId,
    Expression<String>? managerId,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clerkUserId != null) 'clerk_user_id': clerkUserId,
      if (fullName != null) 'full_name': fullName,
      if (phone != null) 'phone': phone,
      if (role != null) 'role': role,
      if (territoryId != null) 'territory_id': territoryId,
      if (managerId != null) 'manager_id': managerId,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProfilesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? clerkUserId,
      Value<String?>? fullName,
      Value<String?>? phone,
      Value<String?>? role,
      Value<String?>? territoryId,
      Value<String?>? managerId,
      Value<bool>? isActive,
      Value<int>? rowid}) {
    return ProfilesTableCompanion(
      id: id ?? this.id,
      clerkUserId: clerkUserId ?? this.clerkUserId,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      territoryId: territoryId ?? this.territoryId,
      managerId: managerId ?? this.managerId,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (clerkUserId.present) {
      map['clerk_user_id'] = Variable<String>(clerkUserId.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (territoryId.present) {
      map['territory_id'] = Variable<String>(territoryId.value);
    }
    if (managerId.present) {
      map['manager_id'] = Variable<String>(managerId.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfilesTableCompanion(')
          ..write('id: $id, ')
          ..write('clerkUserId: $clerkUserId, ')
          ..write('fullName: $fullName, ')
          ..write('phone: $phone, ')
          ..write('role: $role, ')
          ..write('territoryId: $territoryId, ')
          ..write('managerId: $managerId, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DoctorsTableTable extends DoctorsTable
    with TableInfo<$DoctorsTableTable, DoctorCache> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DoctorsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _specialtyMeta =
      const VerificationMeta('specialty');
  @override
  late final GeneratedColumn<String> specialty = GeneratedColumn<String>(
      'specialty', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _clinicNameMeta =
      const VerificationMeta('clinicName');
  @override
  late final GeneratedColumn<String> clinicName = GeneratedColumn<String>(
      'clinic_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _areaMeta = const VerificationMeta('area');
  @override
  late final GeneratedColumn<String> area = GeneratedColumn<String>(
      'area', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
      'city', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tierMeta = const VerificationMeta('tier');
  @override
  late final GeneratedColumn<String> tier = GeneratedColumn<String>(
      'tier', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _territoryIdMeta =
      const VerificationMeta('territoryId');
  @override
  late final GeneratedColumn<String> territoryId = GeneratedColumn<String>(
      'territory_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<double> lat = GeneratedColumn<double>(
      'lat', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _lngMeta = const VerificationMeta('lng');
  @override
  late final GeneratedColumn<double> lng = GeneratedColumn<double>(
      'lng', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        specialty,
        clinicName,
        area,
        city,
        phone,
        tier,
        territoryId,
        lat,
        lng
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'doctors_table';
  @override
  VerificationContext validateIntegrity(Insertable<DoctorCache> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('specialty')) {
      context.handle(_specialtyMeta,
          specialty.isAcceptableOrUnknown(data['specialty']!, _specialtyMeta));
    }
    if (data.containsKey('clinic_name')) {
      context.handle(
          _clinicNameMeta,
          clinicName.isAcceptableOrUnknown(
              data['clinic_name']!, _clinicNameMeta));
    }
    if (data.containsKey('area')) {
      context.handle(
          _areaMeta, area.isAcceptableOrUnknown(data['area']!, _areaMeta));
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city']!, _cityMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('tier')) {
      context.handle(
          _tierMeta, tier.isAcceptableOrUnknown(data['tier']!, _tierMeta));
    }
    if (data.containsKey('territory_id')) {
      context.handle(
          _territoryIdMeta,
          territoryId.isAcceptableOrUnknown(
              data['territory_id']!, _territoryIdMeta));
    }
    if (data.containsKey('lat')) {
      context.handle(
          _latMeta, lat.isAcceptableOrUnknown(data['lat']!, _latMeta));
    }
    if (data.containsKey('lng')) {
      context.handle(
          _lngMeta, lng.isAcceptableOrUnknown(data['lng']!, _lngMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DoctorCache map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DoctorCache(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      specialty: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}specialty']),
      clinicName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}clinic_name']),
      area: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}area']),
      city: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}city']),
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      tier: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tier']),
      territoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}territory_id']),
      lat: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}lat']),
      lng: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}lng']),
    );
  }

  @override
  $DoctorsTableTable createAlias(String alias) {
    return $DoctorsTableTable(attachedDatabase, alias);
  }
}

class DoctorCache extends DataClass implements Insertable<DoctorCache> {
  final String id;
  final String name;
  final String? specialty;
  final String? clinicName;
  final String? area;
  final String? city;
  final String? phone;
  final String? tier;
  final String? territoryId;
  final double? lat;
  final double? lng;
  const DoctorCache(
      {required this.id,
      required this.name,
      this.specialty,
      this.clinicName,
      this.area,
      this.city,
      this.phone,
      this.tier,
      this.territoryId,
      this.lat,
      this.lng});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || specialty != null) {
      map['specialty'] = Variable<String>(specialty);
    }
    if (!nullToAbsent || clinicName != null) {
      map['clinic_name'] = Variable<String>(clinicName);
    }
    if (!nullToAbsent || area != null) {
      map['area'] = Variable<String>(area);
    }
    if (!nullToAbsent || city != null) {
      map['city'] = Variable<String>(city);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || tier != null) {
      map['tier'] = Variable<String>(tier);
    }
    if (!nullToAbsent || territoryId != null) {
      map['territory_id'] = Variable<String>(territoryId);
    }
    if (!nullToAbsent || lat != null) {
      map['lat'] = Variable<double>(lat);
    }
    if (!nullToAbsent || lng != null) {
      map['lng'] = Variable<double>(lng);
    }
    return map;
  }

  DoctorsTableCompanion toCompanion(bool nullToAbsent) {
    return DoctorsTableCompanion(
      id: Value(id),
      name: Value(name),
      specialty: specialty == null && nullToAbsent
          ? const Value.absent()
          : Value(specialty),
      clinicName: clinicName == null && nullToAbsent
          ? const Value.absent()
          : Value(clinicName),
      area: area == null && nullToAbsent ? const Value.absent() : Value(area),
      city: city == null && nullToAbsent ? const Value.absent() : Value(city),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      tier: tier == null && nullToAbsent ? const Value.absent() : Value(tier),
      territoryId: territoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(territoryId),
      lat: lat == null && nullToAbsent ? const Value.absent() : Value(lat),
      lng: lng == null && nullToAbsent ? const Value.absent() : Value(lng),
    );
  }

  factory DoctorCache.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DoctorCache(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      specialty: serializer.fromJson<String?>(json['specialty']),
      clinicName: serializer.fromJson<String?>(json['clinicName']),
      area: serializer.fromJson<String?>(json['area']),
      city: serializer.fromJson<String?>(json['city']),
      phone: serializer.fromJson<String?>(json['phone']),
      tier: serializer.fromJson<String?>(json['tier']),
      territoryId: serializer.fromJson<String?>(json['territoryId']),
      lat: serializer.fromJson<double?>(json['lat']),
      lng: serializer.fromJson<double?>(json['lng']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'specialty': serializer.toJson<String?>(specialty),
      'clinicName': serializer.toJson<String?>(clinicName),
      'area': serializer.toJson<String?>(area),
      'city': serializer.toJson<String?>(city),
      'phone': serializer.toJson<String?>(phone),
      'tier': serializer.toJson<String?>(tier),
      'territoryId': serializer.toJson<String?>(territoryId),
      'lat': serializer.toJson<double?>(lat),
      'lng': serializer.toJson<double?>(lng),
    };
  }

  DoctorCache copyWith(
          {String? id,
          String? name,
          Value<String?> specialty = const Value.absent(),
          Value<String?> clinicName = const Value.absent(),
          Value<String?> area = const Value.absent(),
          Value<String?> city = const Value.absent(),
          Value<String?> phone = const Value.absent(),
          Value<String?> tier = const Value.absent(),
          Value<String?> territoryId = const Value.absent(),
          Value<double?> lat = const Value.absent(),
          Value<double?> lng = const Value.absent()}) =>
      DoctorCache(
        id: id ?? this.id,
        name: name ?? this.name,
        specialty: specialty.present ? specialty.value : this.specialty,
        clinicName: clinicName.present ? clinicName.value : this.clinicName,
        area: area.present ? area.value : this.area,
        city: city.present ? city.value : this.city,
        phone: phone.present ? phone.value : this.phone,
        tier: tier.present ? tier.value : this.tier,
        territoryId: territoryId.present ? territoryId.value : this.territoryId,
        lat: lat.present ? lat.value : this.lat,
        lng: lng.present ? lng.value : this.lng,
      );
  DoctorCache copyWithCompanion(DoctorsTableCompanion data) {
    return DoctorCache(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      specialty: data.specialty.present ? data.specialty.value : this.specialty,
      clinicName:
          data.clinicName.present ? data.clinicName.value : this.clinicName,
      area: data.area.present ? data.area.value : this.area,
      city: data.city.present ? data.city.value : this.city,
      phone: data.phone.present ? data.phone.value : this.phone,
      tier: data.tier.present ? data.tier.value : this.tier,
      territoryId:
          data.territoryId.present ? data.territoryId.value : this.territoryId,
      lat: data.lat.present ? data.lat.value : this.lat,
      lng: data.lng.present ? data.lng.value : this.lng,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DoctorCache(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('specialty: $specialty, ')
          ..write('clinicName: $clinicName, ')
          ..write('area: $area, ')
          ..write('city: $city, ')
          ..write('phone: $phone, ')
          ..write('tier: $tier, ')
          ..write('territoryId: $territoryId, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, specialty, clinicName, area, city,
      phone, tier, territoryId, lat, lng);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DoctorCache &&
          other.id == this.id &&
          other.name == this.name &&
          other.specialty == this.specialty &&
          other.clinicName == this.clinicName &&
          other.area == this.area &&
          other.city == this.city &&
          other.phone == this.phone &&
          other.tier == this.tier &&
          other.territoryId == this.territoryId &&
          other.lat == this.lat &&
          other.lng == this.lng);
}

class DoctorsTableCompanion extends UpdateCompanion<DoctorCache> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> specialty;
  final Value<String?> clinicName;
  final Value<String?> area;
  final Value<String?> city;
  final Value<String?> phone;
  final Value<String?> tier;
  final Value<String?> territoryId;
  final Value<double?> lat;
  final Value<double?> lng;
  final Value<int> rowid;
  const DoctorsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.specialty = const Value.absent(),
    this.clinicName = const Value.absent(),
    this.area = const Value.absent(),
    this.city = const Value.absent(),
    this.phone = const Value.absent(),
    this.tier = const Value.absent(),
    this.territoryId = const Value.absent(),
    this.lat = const Value.absent(),
    this.lng = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DoctorsTableCompanion.insert({
    required String id,
    required String name,
    this.specialty = const Value.absent(),
    this.clinicName = const Value.absent(),
    this.area = const Value.absent(),
    this.city = const Value.absent(),
    this.phone = const Value.absent(),
    this.tier = const Value.absent(),
    this.territoryId = const Value.absent(),
    this.lat = const Value.absent(),
    this.lng = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<DoctorCache> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? specialty,
    Expression<String>? clinicName,
    Expression<String>? area,
    Expression<String>? city,
    Expression<String>? phone,
    Expression<String>? tier,
    Expression<String>? territoryId,
    Expression<double>? lat,
    Expression<double>? lng,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (specialty != null) 'specialty': specialty,
      if (clinicName != null) 'clinic_name': clinicName,
      if (area != null) 'area': area,
      if (city != null) 'city': city,
      if (phone != null) 'phone': phone,
      if (tier != null) 'tier': tier,
      if (territoryId != null) 'territory_id': territoryId,
      if (lat != null) 'lat': lat,
      if (lng != null) 'lng': lng,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DoctorsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? specialty,
      Value<String?>? clinicName,
      Value<String?>? area,
      Value<String?>? city,
      Value<String?>? phone,
      Value<String?>? tier,
      Value<String?>? territoryId,
      Value<double?>? lat,
      Value<double?>? lng,
      Value<int>? rowid}) {
    return DoctorsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      specialty: specialty ?? this.specialty,
      clinicName: clinicName ?? this.clinicName,
      area: area ?? this.area,
      city: city ?? this.city,
      phone: phone ?? this.phone,
      tier: tier ?? this.tier,
      territoryId: territoryId ?? this.territoryId,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (specialty.present) {
      map['specialty'] = Variable<String>(specialty.value);
    }
    if (clinicName.present) {
      map['clinic_name'] = Variable<String>(clinicName.value);
    }
    if (area.present) {
      map['area'] = Variable<String>(area.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (tier.present) {
      map['tier'] = Variable<String>(tier.value);
    }
    if (territoryId.present) {
      map['territory_id'] = Variable<String>(territoryId.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lng.present) {
      map['lng'] = Variable<double>(lng.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DoctorsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('specialty: $specialty, ')
          ..write('clinicName: $clinicName, ')
          ..write('area: $area, ')
          ..write('city: $city, ')
          ..write('phone: $phone, ')
          ..write('tier: $tier, ')
          ..write('territoryId: $territoryId, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChemistsTableTable extends ChemistsTable
    with TableInfo<$ChemistsTableTable, ChemistCache> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChemistsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _shopNameMeta =
      const VerificationMeta('shopName');
  @override
  late final GeneratedColumn<String> shopName = GeneratedColumn<String>(
      'shop_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ownerNameMeta =
      const VerificationMeta('ownerName');
  @override
  late final GeneratedColumn<String> ownerName = GeneratedColumn<String>(
      'owner_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _areaMeta = const VerificationMeta('area');
  @override
  late final GeneratedColumn<String> area = GeneratedColumn<String>(
      'area', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
      'city', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _priorityMeta =
      const VerificationMeta('priority');
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
      'priority', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _territoryIdMeta =
      const VerificationMeta('territoryId');
  @override
  late final GeneratedColumn<String> territoryId = GeneratedColumn<String>(
      'territory_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<double> lat = GeneratedColumn<double>(
      'lat', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _lngMeta = const VerificationMeta('lng');
  @override
  late final GeneratedColumn<double> lng = GeneratedColumn<double>(
      'lng', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        shopName,
        ownerName,
        area,
        city,
        phone,
        priority,
        territoryId,
        lat,
        lng
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chemists_table';
  @override
  VerificationContext validateIntegrity(Insertable<ChemistCache> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_name')) {
      context.handle(_shopNameMeta,
          shopName.isAcceptableOrUnknown(data['shop_name']!, _shopNameMeta));
    } else if (isInserting) {
      context.missing(_shopNameMeta);
    }
    if (data.containsKey('owner_name')) {
      context.handle(_ownerNameMeta,
          ownerName.isAcceptableOrUnknown(data['owner_name']!, _ownerNameMeta));
    }
    if (data.containsKey('area')) {
      context.handle(
          _areaMeta, area.isAcceptableOrUnknown(data['area']!, _areaMeta));
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city']!, _cityMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    }
    if (data.containsKey('territory_id')) {
      context.handle(
          _territoryIdMeta,
          territoryId.isAcceptableOrUnknown(
              data['territory_id']!, _territoryIdMeta));
    }
    if (data.containsKey('lat')) {
      context.handle(
          _latMeta, lat.isAcceptableOrUnknown(data['lat']!, _latMeta));
    }
    if (data.containsKey('lng')) {
      context.handle(
          _lngMeta, lng.isAcceptableOrUnknown(data['lng']!, _lngMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChemistCache map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChemistCache(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      shopName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}shop_name'])!,
      ownerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}owner_name']),
      area: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}area']),
      city: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}city']),
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      priority: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}priority']),
      territoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}territory_id']),
      lat: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}lat']),
      lng: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}lng']),
    );
  }

  @override
  $ChemistsTableTable createAlias(String alias) {
    return $ChemistsTableTable(attachedDatabase, alias);
  }
}

class ChemistCache extends DataClass implements Insertable<ChemistCache> {
  final String id;
  final String shopName;
  final String? ownerName;
  final String? area;
  final String? city;
  final String? phone;
  final String? priority;
  final String? territoryId;
  final double? lat;
  final double? lng;
  const ChemistCache(
      {required this.id,
      required this.shopName,
      this.ownerName,
      this.area,
      this.city,
      this.phone,
      this.priority,
      this.territoryId,
      this.lat,
      this.lng});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_name'] = Variable<String>(shopName);
    if (!nullToAbsent || ownerName != null) {
      map['owner_name'] = Variable<String>(ownerName);
    }
    if (!nullToAbsent || area != null) {
      map['area'] = Variable<String>(area);
    }
    if (!nullToAbsent || city != null) {
      map['city'] = Variable<String>(city);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || priority != null) {
      map['priority'] = Variable<String>(priority);
    }
    if (!nullToAbsent || territoryId != null) {
      map['territory_id'] = Variable<String>(territoryId);
    }
    if (!nullToAbsent || lat != null) {
      map['lat'] = Variable<double>(lat);
    }
    if (!nullToAbsent || lng != null) {
      map['lng'] = Variable<double>(lng);
    }
    return map;
  }

  ChemistsTableCompanion toCompanion(bool nullToAbsent) {
    return ChemistsTableCompanion(
      id: Value(id),
      shopName: Value(shopName),
      ownerName: ownerName == null && nullToAbsent
          ? const Value.absent()
          : Value(ownerName),
      area: area == null && nullToAbsent ? const Value.absent() : Value(area),
      city: city == null && nullToAbsent ? const Value.absent() : Value(city),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      priority: priority == null && nullToAbsent
          ? const Value.absent()
          : Value(priority),
      territoryId: territoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(territoryId),
      lat: lat == null && nullToAbsent ? const Value.absent() : Value(lat),
      lng: lng == null && nullToAbsent ? const Value.absent() : Value(lng),
    );
  }

  factory ChemistCache.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChemistCache(
      id: serializer.fromJson<String>(json['id']),
      shopName: serializer.fromJson<String>(json['shopName']),
      ownerName: serializer.fromJson<String?>(json['ownerName']),
      area: serializer.fromJson<String?>(json['area']),
      city: serializer.fromJson<String?>(json['city']),
      phone: serializer.fromJson<String?>(json['phone']),
      priority: serializer.fromJson<String?>(json['priority']),
      territoryId: serializer.fromJson<String?>(json['territoryId']),
      lat: serializer.fromJson<double?>(json['lat']),
      lng: serializer.fromJson<double?>(json['lng']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopName': serializer.toJson<String>(shopName),
      'ownerName': serializer.toJson<String?>(ownerName),
      'area': serializer.toJson<String?>(area),
      'city': serializer.toJson<String?>(city),
      'phone': serializer.toJson<String?>(phone),
      'priority': serializer.toJson<String?>(priority),
      'territoryId': serializer.toJson<String?>(territoryId),
      'lat': serializer.toJson<double?>(lat),
      'lng': serializer.toJson<double?>(lng),
    };
  }

  ChemistCache copyWith(
          {String? id,
          String? shopName,
          Value<String?> ownerName = const Value.absent(),
          Value<String?> area = const Value.absent(),
          Value<String?> city = const Value.absent(),
          Value<String?> phone = const Value.absent(),
          Value<String?> priority = const Value.absent(),
          Value<String?> territoryId = const Value.absent(),
          Value<double?> lat = const Value.absent(),
          Value<double?> lng = const Value.absent()}) =>
      ChemistCache(
        id: id ?? this.id,
        shopName: shopName ?? this.shopName,
        ownerName: ownerName.present ? ownerName.value : this.ownerName,
        area: area.present ? area.value : this.area,
        city: city.present ? city.value : this.city,
        phone: phone.present ? phone.value : this.phone,
        priority: priority.present ? priority.value : this.priority,
        territoryId: territoryId.present ? territoryId.value : this.territoryId,
        lat: lat.present ? lat.value : this.lat,
        lng: lng.present ? lng.value : this.lng,
      );
  ChemistCache copyWithCompanion(ChemistsTableCompanion data) {
    return ChemistCache(
      id: data.id.present ? data.id.value : this.id,
      shopName: data.shopName.present ? data.shopName.value : this.shopName,
      ownerName: data.ownerName.present ? data.ownerName.value : this.ownerName,
      area: data.area.present ? data.area.value : this.area,
      city: data.city.present ? data.city.value : this.city,
      phone: data.phone.present ? data.phone.value : this.phone,
      priority: data.priority.present ? data.priority.value : this.priority,
      territoryId:
          data.territoryId.present ? data.territoryId.value : this.territoryId,
      lat: data.lat.present ? data.lat.value : this.lat,
      lng: data.lng.present ? data.lng.value : this.lng,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChemistCache(')
          ..write('id: $id, ')
          ..write('shopName: $shopName, ')
          ..write('ownerName: $ownerName, ')
          ..write('area: $area, ')
          ..write('city: $city, ')
          ..write('phone: $phone, ')
          ..write('priority: $priority, ')
          ..write('territoryId: $territoryId, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, shopName, ownerName, area, city, phone,
      priority, territoryId, lat, lng);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChemistCache &&
          other.id == this.id &&
          other.shopName == this.shopName &&
          other.ownerName == this.ownerName &&
          other.area == this.area &&
          other.city == this.city &&
          other.phone == this.phone &&
          other.priority == this.priority &&
          other.territoryId == this.territoryId &&
          other.lat == this.lat &&
          other.lng == this.lng);
}

class ChemistsTableCompanion extends UpdateCompanion<ChemistCache> {
  final Value<String> id;
  final Value<String> shopName;
  final Value<String?> ownerName;
  final Value<String?> area;
  final Value<String?> city;
  final Value<String?> phone;
  final Value<String?> priority;
  final Value<String?> territoryId;
  final Value<double?> lat;
  final Value<double?> lng;
  final Value<int> rowid;
  const ChemistsTableCompanion({
    this.id = const Value.absent(),
    this.shopName = const Value.absent(),
    this.ownerName = const Value.absent(),
    this.area = const Value.absent(),
    this.city = const Value.absent(),
    this.phone = const Value.absent(),
    this.priority = const Value.absent(),
    this.territoryId = const Value.absent(),
    this.lat = const Value.absent(),
    this.lng = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChemistsTableCompanion.insert({
    required String id,
    required String shopName,
    this.ownerName = const Value.absent(),
    this.area = const Value.absent(),
    this.city = const Value.absent(),
    this.phone = const Value.absent(),
    this.priority = const Value.absent(),
    this.territoryId = const Value.absent(),
    this.lat = const Value.absent(),
    this.lng = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        shopName = Value(shopName);
  static Insertable<ChemistCache> custom({
    Expression<String>? id,
    Expression<String>? shopName,
    Expression<String>? ownerName,
    Expression<String>? area,
    Expression<String>? city,
    Expression<String>? phone,
    Expression<String>? priority,
    Expression<String>? territoryId,
    Expression<double>? lat,
    Expression<double>? lng,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopName != null) 'shop_name': shopName,
      if (ownerName != null) 'owner_name': ownerName,
      if (area != null) 'area': area,
      if (city != null) 'city': city,
      if (phone != null) 'phone': phone,
      if (priority != null) 'priority': priority,
      if (territoryId != null) 'territory_id': territoryId,
      if (lat != null) 'lat': lat,
      if (lng != null) 'lng': lng,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChemistsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? shopName,
      Value<String?>? ownerName,
      Value<String?>? area,
      Value<String?>? city,
      Value<String?>? phone,
      Value<String?>? priority,
      Value<String?>? territoryId,
      Value<double?>? lat,
      Value<double?>? lng,
      Value<int>? rowid}) {
    return ChemistsTableCompanion(
      id: id ?? this.id,
      shopName: shopName ?? this.shopName,
      ownerName: ownerName ?? this.ownerName,
      area: area ?? this.area,
      city: city ?? this.city,
      phone: phone ?? this.phone,
      priority: priority ?? this.priority,
      territoryId: territoryId ?? this.territoryId,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopName.present) {
      map['shop_name'] = Variable<String>(shopName.value);
    }
    if (ownerName.present) {
      map['owner_name'] = Variable<String>(ownerName.value);
    }
    if (area.present) {
      map['area'] = Variable<String>(area.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (territoryId.present) {
      map['territory_id'] = Variable<String>(territoryId.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lng.present) {
      map['lng'] = Variable<double>(lng.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChemistsTableCompanion(')
          ..write('id: $id, ')
          ..write('shopName: $shopName, ')
          ..write('ownerName: $ownerName, ')
          ..write('area: $area, ')
          ..write('city: $city, ')
          ..write('phone: $phone, ')
          ..write('priority: $priority, ')
          ..write('territoryId: $territoryId, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductsTableTable extends ProductsTable
    with TableInfo<$ProductsTableTable, ProductCache> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
      'sku', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _formulationMeta =
      const VerificationMeta('formulation');
  @override
  late final GeneratedColumn<String> formulation = GeneratedColumn<String>(
      'formulation', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _netPriceMeta =
      const VerificationMeta('netPrice');
  @override
  late final GeneratedColumn<double> netPrice = GeneratedColumn<double>(
      'net_price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _isSampleEligibleMeta =
      const VerificationMeta('isSampleEligible');
  @override
  late final GeneratedColumn<bool> isSampleEligible = GeneratedColumn<bool>(
      'is_sample_eligible', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_sample_eligible" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        sku,
        formulation,
        category,
        netPrice,
        isSampleEligible,
        isActive
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products_table';
  @override
  VerificationContext validateIntegrity(Insertable<ProductCache> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sku')) {
      context.handle(
          _skuMeta, sku.isAcceptableOrUnknown(data['sku']!, _skuMeta));
    }
    if (data.containsKey('formulation')) {
      context.handle(
          _formulationMeta,
          formulation.isAcceptableOrUnknown(
              data['formulation']!, _formulationMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    if (data.containsKey('net_price')) {
      context.handle(_netPriceMeta,
          netPrice.isAcceptableOrUnknown(data['net_price']!, _netPriceMeta));
    } else if (isInserting) {
      context.missing(_netPriceMeta);
    }
    if (data.containsKey('is_sample_eligible')) {
      context.handle(
          _isSampleEligibleMeta,
          isSampleEligible.isAcceptableOrUnknown(
              data['is_sample_eligible']!, _isSampleEligibleMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductCache map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductCache(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      sku: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sku']),
      formulation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}formulation']),
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category']),
      netPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}net_price'])!,
      isSampleEligible: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}is_sample_eligible'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
    );
  }

  @override
  $ProductsTableTable createAlias(String alias) {
    return $ProductsTableTable(attachedDatabase, alias);
  }
}

class ProductCache extends DataClass implements Insertable<ProductCache> {
  final String id;
  final String name;
  final String? sku;
  final String? formulation;
  final String? category;
  final double netPrice;
  final bool isSampleEligible;
  final bool isActive;
  const ProductCache(
      {required this.id,
      required this.name,
      this.sku,
      this.formulation,
      this.category,
      required this.netPrice,
      required this.isSampleEligible,
      required this.isActive});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || sku != null) {
      map['sku'] = Variable<String>(sku);
    }
    if (!nullToAbsent || formulation != null) {
      map['formulation'] = Variable<String>(formulation);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    map['net_price'] = Variable<double>(netPrice);
    map['is_sample_eligible'] = Variable<bool>(isSampleEligible);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  ProductsTableCompanion toCompanion(bool nullToAbsent) {
    return ProductsTableCompanion(
      id: Value(id),
      name: Value(name),
      sku: sku == null && nullToAbsent ? const Value.absent() : Value(sku),
      formulation: formulation == null && nullToAbsent
          ? const Value.absent()
          : Value(formulation),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      netPrice: Value(netPrice),
      isSampleEligible: Value(isSampleEligible),
      isActive: Value(isActive),
    );
  }

  factory ProductCache.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductCache(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      sku: serializer.fromJson<String?>(json['sku']),
      formulation: serializer.fromJson<String?>(json['formulation']),
      category: serializer.fromJson<String?>(json['category']),
      netPrice: serializer.fromJson<double>(json['netPrice']),
      isSampleEligible: serializer.fromJson<bool>(json['isSampleEligible']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'sku': serializer.toJson<String?>(sku),
      'formulation': serializer.toJson<String?>(formulation),
      'category': serializer.toJson<String?>(category),
      'netPrice': serializer.toJson<double>(netPrice),
      'isSampleEligible': serializer.toJson<bool>(isSampleEligible),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  ProductCache copyWith(
          {String? id,
          String? name,
          Value<String?> sku = const Value.absent(),
          Value<String?> formulation = const Value.absent(),
          Value<String?> category = const Value.absent(),
          double? netPrice,
          bool? isSampleEligible,
          bool? isActive}) =>
      ProductCache(
        id: id ?? this.id,
        name: name ?? this.name,
        sku: sku.present ? sku.value : this.sku,
        formulation: formulation.present ? formulation.value : this.formulation,
        category: category.present ? category.value : this.category,
        netPrice: netPrice ?? this.netPrice,
        isSampleEligible: isSampleEligible ?? this.isSampleEligible,
        isActive: isActive ?? this.isActive,
      );
  ProductCache copyWithCompanion(ProductsTableCompanion data) {
    return ProductCache(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      sku: data.sku.present ? data.sku.value : this.sku,
      formulation:
          data.formulation.present ? data.formulation.value : this.formulation,
      category: data.category.present ? data.category.value : this.category,
      netPrice: data.netPrice.present ? data.netPrice.value : this.netPrice,
      isSampleEligible: data.isSampleEligible.present
          ? data.isSampleEligible.value
          : this.isSampleEligible,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductCache(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sku: $sku, ')
          ..write('formulation: $formulation, ')
          ..write('category: $category, ')
          ..write('netPrice: $netPrice, ')
          ..write('isSampleEligible: $isSampleEligible, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, sku, formulation, category,
      netPrice, isSampleEligible, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductCache &&
          other.id == this.id &&
          other.name == this.name &&
          other.sku == this.sku &&
          other.formulation == this.formulation &&
          other.category == this.category &&
          other.netPrice == this.netPrice &&
          other.isSampleEligible == this.isSampleEligible &&
          other.isActive == this.isActive);
}

class ProductsTableCompanion extends UpdateCompanion<ProductCache> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> sku;
  final Value<String?> formulation;
  final Value<String?> category;
  final Value<double> netPrice;
  final Value<bool> isSampleEligible;
  final Value<bool> isActive;
  final Value<int> rowid;
  const ProductsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.sku = const Value.absent(),
    this.formulation = const Value.absent(),
    this.category = const Value.absent(),
    this.netPrice = const Value.absent(),
    this.isSampleEligible = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductsTableCompanion.insert({
    required String id,
    required String name,
    this.sku = const Value.absent(),
    this.formulation = const Value.absent(),
    this.category = const Value.absent(),
    required double netPrice,
    this.isSampleEligible = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        netPrice = Value(netPrice);
  static Insertable<ProductCache> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? sku,
    Expression<String>? formulation,
    Expression<String>? category,
    Expression<double>? netPrice,
    Expression<bool>? isSampleEligible,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (sku != null) 'sku': sku,
      if (formulation != null) 'formulation': formulation,
      if (category != null) 'category': category,
      if (netPrice != null) 'net_price': netPrice,
      if (isSampleEligible != null) 'is_sample_eligible': isSampleEligible,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? sku,
      Value<String?>? formulation,
      Value<String?>? category,
      Value<double>? netPrice,
      Value<bool>? isSampleEligible,
      Value<bool>? isActive,
      Value<int>? rowid}) {
    return ProductsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      sku: sku ?? this.sku,
      formulation: formulation ?? this.formulation,
      category: category ?? this.category,
      netPrice: netPrice ?? this.netPrice,
      isSampleEligible: isSampleEligible ?? this.isSampleEligible,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (formulation.present) {
      map['formulation'] = Variable<String>(formulation.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (netPrice.present) {
      map['net_price'] = Variable<double>(netPrice.value);
    }
    if (isSampleEligible.present) {
      map['is_sample_eligible'] = Variable<bool>(isSampleEligible.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sku: $sku, ')
          ..write('formulation: $formulation, ')
          ..write('category: $category, ')
          ..write('netPrice: $netPrice, ')
          ..write('isSampleEligible: $isSampleEligible, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTableTable extends SyncQueueTable
    with TableInfo<$SyncQueueTableTable, SyncQueueEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _entityTypeMeta =
      const VerificationMeta('entityType');
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
      'entity_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _payloadJsonMeta =
      const VerificationMeta('payloadJson');
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
      'payload_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _operationMeta =
      const VerificationMeta('operation');
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
      'operation', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _errorMessageMeta =
      const VerificationMeta('errorMessage');
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
      'error_message', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _retryCountMeta =
      const VerificationMeta('retryCount');
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
      'retry_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        entityType,
        payloadJson,
        operation,
        status,
        createdAt,
        errorMessage,
        retryCount
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue_table';
  @override
  VerificationContext validateIntegrity(Insertable<SyncQueueEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entity_type')) {
      context.handle(
          _entityTypeMeta,
          entityType.isAcceptableOrUnknown(
              data['entity_type']!, _entityTypeMeta));
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
          _payloadJsonMeta,
          payloadJson.isAcceptableOrUnknown(
              data['payload_json']!, _payloadJsonMeta));
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(_operationMeta,
          operation.isAcceptableOrUnknown(data['operation']!, _operationMeta));
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('error_message')) {
      context.handle(
          _errorMessageMeta,
          errorMessage.isAcceptableOrUnknown(
              data['error_message']!, _errorMessageMeta));
    }
    if (data.containsKey('retry_count')) {
      context.handle(
          _retryCountMeta,
          retryCount.isAcceptableOrUnknown(
              data['retry_count']!, _retryCountMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      entityType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_type'])!,
      payloadJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payload_json'])!,
      operation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}operation'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      errorMessage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}error_message']),
      retryCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}retry_count'])!,
    );
  }

  @override
  $SyncQueueTableTable createAlias(String alias) {
    return $SyncQueueTableTable(attachedDatabase, alias);
  }
}

class SyncQueueEntry extends DataClass implements Insertable<SyncQueueEntry> {
  final int id;
  final String entityType;
  final String payloadJson;
  final String operation;
  final String status;
  final DateTime createdAt;
  final String? errorMessage;
  final int retryCount;
  const SyncQueueEntry(
      {required this.id,
      required this.entityType,
      required this.payloadJson,
      required this.operation,
      required this.status,
      required this.createdAt,
      this.errorMessage,
      required this.retryCount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entity_type'] = Variable<String>(entityType);
    map['payload_json'] = Variable<String>(payloadJson);
    map['operation'] = Variable<String>(operation);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    map['retry_count'] = Variable<int>(retryCount);
    return map;
  }

  SyncQueueTableCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueTableCompanion(
      id: Value(id),
      entityType: Value(entityType),
      payloadJson: Value(payloadJson),
      operation: Value(operation),
      status: Value(status),
      createdAt: Value(createdAt),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
      retryCount: Value(retryCount),
    );
  }

  factory SyncQueueEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueEntry(
      id: serializer.fromJson<int>(json['id']),
      entityType: serializer.fromJson<String>(json['entityType']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      operation: serializer.fromJson<String>(json['operation']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entityType': serializer.toJson<String>(entityType),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'operation': serializer.toJson<String>(operation),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'errorMessage': serializer.toJson<String?>(errorMessage),
      'retryCount': serializer.toJson<int>(retryCount),
    };
  }

  SyncQueueEntry copyWith(
          {int? id,
          String? entityType,
          String? payloadJson,
          String? operation,
          String? status,
          DateTime? createdAt,
          Value<String?> errorMessage = const Value.absent(),
          int? retryCount}) =>
      SyncQueueEntry(
        id: id ?? this.id,
        entityType: entityType ?? this.entityType,
        payloadJson: payloadJson ?? this.payloadJson,
        operation: operation ?? this.operation,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        errorMessage:
            errorMessage.present ? errorMessage.value : this.errorMessage,
        retryCount: retryCount ?? this.retryCount,
      );
  SyncQueueEntry copyWithCompanion(SyncQueueTableCompanion data) {
    return SyncQueueEntry(
      id: data.id.present ? data.id.value : this.id,
      entityType:
          data.entityType.present ? data.entityType.value : this.entityType,
      payloadJson:
          data.payloadJson.present ? data.payloadJson.value : this.payloadJson,
      operation: data.operation.present ? data.operation.value : this.operation,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
      retryCount:
          data.retryCount.present ? data.retryCount.value : this.retryCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueEntry(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('operation: $operation, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('retryCount: $retryCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, entityType, payloadJson, operation,
      status, createdAt, errorMessage, retryCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueEntry &&
          other.id == this.id &&
          other.entityType == this.entityType &&
          other.payloadJson == this.payloadJson &&
          other.operation == this.operation &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.errorMessage == this.errorMessage &&
          other.retryCount == this.retryCount);
}

class SyncQueueTableCompanion extends UpdateCompanion<SyncQueueEntry> {
  final Value<int> id;
  final Value<String> entityType;
  final Value<String> payloadJson;
  final Value<String> operation;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<String?> errorMessage;
  final Value<int> retryCount;
  const SyncQueueTableCompanion({
    this.id = const Value.absent(),
    this.entityType = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.operation = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.retryCount = const Value.absent(),
  });
  SyncQueueTableCompanion.insert({
    this.id = const Value.absent(),
    required String entityType,
    required String payloadJson,
    required String operation,
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.retryCount = const Value.absent(),
  })  : entityType = Value(entityType),
        payloadJson = Value(payloadJson),
        operation = Value(operation);
  static Insertable<SyncQueueEntry> custom({
    Expression<int>? id,
    Expression<String>? entityType,
    Expression<String>? payloadJson,
    Expression<String>? operation,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<String>? errorMessage,
    Expression<int>? retryCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityType != null) 'entity_type': entityType,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (operation != null) 'operation': operation,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (errorMessage != null) 'error_message': errorMessage,
      if (retryCount != null) 'retry_count': retryCount,
    });
  }

  SyncQueueTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? entityType,
      Value<String>? payloadJson,
      Value<String>? operation,
      Value<String>? status,
      Value<DateTime>? createdAt,
      Value<String?>? errorMessage,
      Value<int>? retryCount}) {
    return SyncQueueTableCompanion(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      payloadJson: payloadJson ?? this.payloadJson,
      operation: operation ?? this.operation,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      errorMessage: errorMessage ?? this.errorMessage,
      retryCount: retryCount ?? this.retryCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueTableCompanion(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('operation: $operation, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('retryCount: $retryCount')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TerritoriesTableTable territoriesTable =
      $TerritoriesTableTable(this);
  late final $ProfilesTableTable profilesTable = $ProfilesTableTable(this);
  late final $DoctorsTableTable doctorsTable = $DoctorsTableTable(this);
  late final $ChemistsTableTable chemistsTable = $ChemistsTableTable(this);
  late final $ProductsTableTable productsTable = $ProductsTableTable(this);
  late final $SyncQueueTableTable syncQueueTable = $SyncQueueTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        territoriesTable,
        profilesTable,
        doctorsTable,
        chemistsTable,
        productsTable,
        syncQueueTable
      ];
}

typedef $$TerritoriesTableTableCreateCompanionBuilder
    = TerritoriesTableCompanion Function({
  required String id,
  required String name,
  Value<String?> region,
  Value<int> rowid,
});
typedef $$TerritoriesTableTableUpdateCompanionBuilder
    = TerritoriesTableCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> region,
  Value<int> rowid,
});

class $$TerritoriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $TerritoriesTableTable> {
  $$TerritoriesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get region => $composableBuilder(
      column: $table.region, builder: (column) => ColumnFilters(column));
}

class $$TerritoriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TerritoriesTableTable> {
  $$TerritoriesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get region => $composableBuilder(
      column: $table.region, builder: (column) => ColumnOrderings(column));
}

class $$TerritoriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TerritoriesTableTable> {
  $$TerritoriesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);
}

class $$TerritoriesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TerritoriesTableTable,
    TerritoryCache,
    $$TerritoriesTableTableFilterComposer,
    $$TerritoriesTableTableOrderingComposer,
    $$TerritoriesTableTableAnnotationComposer,
    $$TerritoriesTableTableCreateCompanionBuilder,
    $$TerritoriesTableTableUpdateCompanionBuilder,
    (
      TerritoryCache,
      BaseReferences<_$AppDatabase, $TerritoriesTableTable, TerritoryCache>
    ),
    TerritoryCache,
    PrefetchHooks Function()> {
  $$TerritoriesTableTableTableManager(
      _$AppDatabase db, $TerritoriesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TerritoriesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TerritoriesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TerritoriesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> region = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TerritoriesTableCompanion(
            id: id,
            name: name,
            region: region,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> region = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TerritoriesTableCompanion.insert(
            id: id,
            name: name,
            region: region,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TerritoriesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TerritoriesTableTable,
    TerritoryCache,
    $$TerritoriesTableTableFilterComposer,
    $$TerritoriesTableTableOrderingComposer,
    $$TerritoriesTableTableAnnotationComposer,
    $$TerritoriesTableTableCreateCompanionBuilder,
    $$TerritoriesTableTableUpdateCompanionBuilder,
    (
      TerritoryCache,
      BaseReferences<_$AppDatabase, $TerritoriesTableTable, TerritoryCache>
    ),
    TerritoryCache,
    PrefetchHooks Function()>;
typedef $$ProfilesTableTableCreateCompanionBuilder = ProfilesTableCompanion
    Function({
  required String id,
  required String clerkUserId,
  Value<String?> fullName,
  Value<String?> phone,
  Value<String?> role,
  Value<String?> territoryId,
  Value<String?> managerId,
  Value<bool> isActive,
  Value<int> rowid,
});
typedef $$ProfilesTableTableUpdateCompanionBuilder = ProfilesTableCompanion
    Function({
  Value<String> id,
  Value<String> clerkUserId,
  Value<String?> fullName,
  Value<String?> phone,
  Value<String?> role,
  Value<String?> territoryId,
  Value<String?> managerId,
  Value<bool> isActive,
  Value<int> rowid,
});

class $$ProfilesTableTableFilterComposer
    extends Composer<_$AppDatabase, $ProfilesTableTable> {
  $$ProfilesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get clerkUserId => $composableBuilder(
      column: $table.clerkUserId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fullName => $composableBuilder(
      column: $table.fullName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get territoryId => $composableBuilder(
      column: $table.territoryId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get managerId => $composableBuilder(
      column: $table.managerId, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));
}

class $$ProfilesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfilesTableTable> {
  $$ProfilesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get clerkUserId => $composableBuilder(
      column: $table.clerkUserId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fullName => $composableBuilder(
      column: $table.fullName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get territoryId => $composableBuilder(
      column: $table.territoryId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get managerId => $composableBuilder(
      column: $table.managerId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));
}

class $$ProfilesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfilesTableTable> {
  $$ProfilesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get clerkUserId => $composableBuilder(
      column: $table.clerkUserId, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get territoryId => $composableBuilder(
      column: $table.territoryId, builder: (column) => column);

  GeneratedColumn<String> get managerId =>
      $composableBuilder(column: $table.managerId, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);
}

class $$ProfilesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProfilesTableTable,
    ProfileCache,
    $$ProfilesTableTableFilterComposer,
    $$ProfilesTableTableOrderingComposer,
    $$ProfilesTableTableAnnotationComposer,
    $$ProfilesTableTableCreateCompanionBuilder,
    $$ProfilesTableTableUpdateCompanionBuilder,
    (
      ProfileCache,
      BaseReferences<_$AppDatabase, $ProfilesTableTable, ProfileCache>
    ),
    ProfileCache,
    PrefetchHooks Function()> {
  $$ProfilesTableTableTableManager(_$AppDatabase db, $ProfilesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfilesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfilesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfilesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> clerkUserId = const Value.absent(),
            Value<String?> fullName = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> role = const Value.absent(),
            Value<String?> territoryId = const Value.absent(),
            Value<String?> managerId = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProfilesTableCompanion(
            id: id,
            clerkUserId: clerkUserId,
            fullName: fullName,
            phone: phone,
            role: role,
            territoryId: territoryId,
            managerId: managerId,
            isActive: isActive,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String clerkUserId,
            Value<String?> fullName = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> role = const Value.absent(),
            Value<String?> territoryId = const Value.absent(),
            Value<String?> managerId = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProfilesTableCompanion.insert(
            id: id,
            clerkUserId: clerkUserId,
            fullName: fullName,
            phone: phone,
            role: role,
            territoryId: territoryId,
            managerId: managerId,
            isActive: isActive,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ProfilesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProfilesTableTable,
    ProfileCache,
    $$ProfilesTableTableFilterComposer,
    $$ProfilesTableTableOrderingComposer,
    $$ProfilesTableTableAnnotationComposer,
    $$ProfilesTableTableCreateCompanionBuilder,
    $$ProfilesTableTableUpdateCompanionBuilder,
    (
      ProfileCache,
      BaseReferences<_$AppDatabase, $ProfilesTableTable, ProfileCache>
    ),
    ProfileCache,
    PrefetchHooks Function()>;
typedef $$DoctorsTableTableCreateCompanionBuilder = DoctorsTableCompanion
    Function({
  required String id,
  required String name,
  Value<String?> specialty,
  Value<String?> clinicName,
  Value<String?> area,
  Value<String?> city,
  Value<String?> phone,
  Value<String?> tier,
  Value<String?> territoryId,
  Value<double?> lat,
  Value<double?> lng,
  Value<int> rowid,
});
typedef $$DoctorsTableTableUpdateCompanionBuilder = DoctorsTableCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<String?> specialty,
  Value<String?> clinicName,
  Value<String?> area,
  Value<String?> city,
  Value<String?> phone,
  Value<String?> tier,
  Value<String?> territoryId,
  Value<double?> lat,
  Value<double?> lng,
  Value<int> rowid,
});

class $$DoctorsTableTableFilterComposer
    extends Composer<_$AppDatabase, $DoctorsTableTable> {
  $$DoctorsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get specialty => $composableBuilder(
      column: $table.specialty, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get clinicName => $composableBuilder(
      column: $table.clinicName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get area => $composableBuilder(
      column: $table.area, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get city => $composableBuilder(
      column: $table.city, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tier => $composableBuilder(
      column: $table.tier, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get territoryId => $composableBuilder(
      column: $table.territoryId, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get lat => $composableBuilder(
      column: $table.lat, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get lng => $composableBuilder(
      column: $table.lng, builder: (column) => ColumnFilters(column));
}

class $$DoctorsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $DoctorsTableTable> {
  $$DoctorsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get specialty => $composableBuilder(
      column: $table.specialty, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get clinicName => $composableBuilder(
      column: $table.clinicName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get area => $composableBuilder(
      column: $table.area, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get city => $composableBuilder(
      column: $table.city, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tier => $composableBuilder(
      column: $table.tier, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get territoryId => $composableBuilder(
      column: $table.territoryId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get lat => $composableBuilder(
      column: $table.lat, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get lng => $composableBuilder(
      column: $table.lng, builder: (column) => ColumnOrderings(column));
}

class $$DoctorsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $DoctorsTableTable> {
  $$DoctorsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get specialty =>
      $composableBuilder(column: $table.specialty, builder: (column) => column);

  GeneratedColumn<String> get clinicName => $composableBuilder(
      column: $table.clinicName, builder: (column) => column);

  GeneratedColumn<String> get area =>
      $composableBuilder(column: $table.area, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get tier =>
      $composableBuilder(column: $table.tier, builder: (column) => column);

  GeneratedColumn<String> get territoryId => $composableBuilder(
      column: $table.territoryId, builder: (column) => column);

  GeneratedColumn<double> get lat =>
      $composableBuilder(column: $table.lat, builder: (column) => column);

  GeneratedColumn<double> get lng =>
      $composableBuilder(column: $table.lng, builder: (column) => column);
}

class $$DoctorsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DoctorsTableTable,
    DoctorCache,
    $$DoctorsTableTableFilterComposer,
    $$DoctorsTableTableOrderingComposer,
    $$DoctorsTableTableAnnotationComposer,
    $$DoctorsTableTableCreateCompanionBuilder,
    $$DoctorsTableTableUpdateCompanionBuilder,
    (
      DoctorCache,
      BaseReferences<_$AppDatabase, $DoctorsTableTable, DoctorCache>
    ),
    DoctorCache,
    PrefetchHooks Function()> {
  $$DoctorsTableTableTableManager(_$AppDatabase db, $DoctorsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DoctorsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DoctorsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DoctorsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> specialty = const Value.absent(),
            Value<String?> clinicName = const Value.absent(),
            Value<String?> area = const Value.absent(),
            Value<String?> city = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> tier = const Value.absent(),
            Value<String?> territoryId = const Value.absent(),
            Value<double?> lat = const Value.absent(),
            Value<double?> lng = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DoctorsTableCompanion(
            id: id,
            name: name,
            specialty: specialty,
            clinicName: clinicName,
            area: area,
            city: city,
            phone: phone,
            tier: tier,
            territoryId: territoryId,
            lat: lat,
            lng: lng,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> specialty = const Value.absent(),
            Value<String?> clinicName = const Value.absent(),
            Value<String?> area = const Value.absent(),
            Value<String?> city = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> tier = const Value.absent(),
            Value<String?> territoryId = const Value.absent(),
            Value<double?> lat = const Value.absent(),
            Value<double?> lng = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DoctorsTableCompanion.insert(
            id: id,
            name: name,
            specialty: specialty,
            clinicName: clinicName,
            area: area,
            city: city,
            phone: phone,
            tier: tier,
            territoryId: territoryId,
            lat: lat,
            lng: lng,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DoctorsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DoctorsTableTable,
    DoctorCache,
    $$DoctorsTableTableFilterComposer,
    $$DoctorsTableTableOrderingComposer,
    $$DoctorsTableTableAnnotationComposer,
    $$DoctorsTableTableCreateCompanionBuilder,
    $$DoctorsTableTableUpdateCompanionBuilder,
    (
      DoctorCache,
      BaseReferences<_$AppDatabase, $DoctorsTableTable, DoctorCache>
    ),
    DoctorCache,
    PrefetchHooks Function()>;
typedef $$ChemistsTableTableCreateCompanionBuilder = ChemistsTableCompanion
    Function({
  required String id,
  required String shopName,
  Value<String?> ownerName,
  Value<String?> area,
  Value<String?> city,
  Value<String?> phone,
  Value<String?> priority,
  Value<String?> territoryId,
  Value<double?> lat,
  Value<double?> lng,
  Value<int> rowid,
});
typedef $$ChemistsTableTableUpdateCompanionBuilder = ChemistsTableCompanion
    Function({
  Value<String> id,
  Value<String> shopName,
  Value<String?> ownerName,
  Value<String?> area,
  Value<String?> city,
  Value<String?> phone,
  Value<String?> priority,
  Value<String?> territoryId,
  Value<double?> lat,
  Value<double?> lng,
  Value<int> rowid,
});

class $$ChemistsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ChemistsTableTable> {
  $$ChemistsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get shopName => $composableBuilder(
      column: $table.shopName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ownerName => $composableBuilder(
      column: $table.ownerName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get area => $composableBuilder(
      column: $table.area, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get city => $composableBuilder(
      column: $table.city, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get territoryId => $composableBuilder(
      column: $table.territoryId, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get lat => $composableBuilder(
      column: $table.lat, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get lng => $composableBuilder(
      column: $table.lng, builder: (column) => ColumnFilters(column));
}

class $$ChemistsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ChemistsTableTable> {
  $$ChemistsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get shopName => $composableBuilder(
      column: $table.shopName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ownerName => $composableBuilder(
      column: $table.ownerName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get area => $composableBuilder(
      column: $table.area, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get city => $composableBuilder(
      column: $table.city, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get territoryId => $composableBuilder(
      column: $table.territoryId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get lat => $composableBuilder(
      column: $table.lat, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get lng => $composableBuilder(
      column: $table.lng, builder: (column) => ColumnOrderings(column));
}

class $$ChemistsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChemistsTableTable> {
  $$ChemistsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get shopName =>
      $composableBuilder(column: $table.shopName, builder: (column) => column);

  GeneratedColumn<String> get ownerName =>
      $composableBuilder(column: $table.ownerName, builder: (column) => column);

  GeneratedColumn<String> get area =>
      $composableBuilder(column: $table.area, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get territoryId => $composableBuilder(
      column: $table.territoryId, builder: (column) => column);

  GeneratedColumn<double> get lat =>
      $composableBuilder(column: $table.lat, builder: (column) => column);

  GeneratedColumn<double> get lng =>
      $composableBuilder(column: $table.lng, builder: (column) => column);
}

class $$ChemistsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChemistsTableTable,
    ChemistCache,
    $$ChemistsTableTableFilterComposer,
    $$ChemistsTableTableOrderingComposer,
    $$ChemistsTableTableAnnotationComposer,
    $$ChemistsTableTableCreateCompanionBuilder,
    $$ChemistsTableTableUpdateCompanionBuilder,
    (
      ChemistCache,
      BaseReferences<_$AppDatabase, $ChemistsTableTable, ChemistCache>
    ),
    ChemistCache,
    PrefetchHooks Function()> {
  $$ChemistsTableTableTableManager(_$AppDatabase db, $ChemistsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChemistsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChemistsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChemistsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> shopName = const Value.absent(),
            Value<String?> ownerName = const Value.absent(),
            Value<String?> area = const Value.absent(),
            Value<String?> city = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> priority = const Value.absent(),
            Value<String?> territoryId = const Value.absent(),
            Value<double?> lat = const Value.absent(),
            Value<double?> lng = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChemistsTableCompanion(
            id: id,
            shopName: shopName,
            ownerName: ownerName,
            area: area,
            city: city,
            phone: phone,
            priority: priority,
            territoryId: territoryId,
            lat: lat,
            lng: lng,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String shopName,
            Value<String?> ownerName = const Value.absent(),
            Value<String?> area = const Value.absent(),
            Value<String?> city = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> priority = const Value.absent(),
            Value<String?> territoryId = const Value.absent(),
            Value<double?> lat = const Value.absent(),
            Value<double?> lng = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChemistsTableCompanion.insert(
            id: id,
            shopName: shopName,
            ownerName: ownerName,
            area: area,
            city: city,
            phone: phone,
            priority: priority,
            territoryId: territoryId,
            lat: lat,
            lng: lng,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ChemistsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ChemistsTableTable,
    ChemistCache,
    $$ChemistsTableTableFilterComposer,
    $$ChemistsTableTableOrderingComposer,
    $$ChemistsTableTableAnnotationComposer,
    $$ChemistsTableTableCreateCompanionBuilder,
    $$ChemistsTableTableUpdateCompanionBuilder,
    (
      ChemistCache,
      BaseReferences<_$AppDatabase, $ChemistsTableTable, ChemistCache>
    ),
    ChemistCache,
    PrefetchHooks Function()>;
typedef $$ProductsTableTableCreateCompanionBuilder = ProductsTableCompanion
    Function({
  required String id,
  required String name,
  Value<String?> sku,
  Value<String?> formulation,
  Value<String?> category,
  required double netPrice,
  Value<bool> isSampleEligible,
  Value<bool> isActive,
  Value<int> rowid,
});
typedef $$ProductsTableTableUpdateCompanionBuilder = ProductsTableCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<String?> sku,
  Value<String?> formulation,
  Value<String?> category,
  Value<double> netPrice,
  Value<bool> isSampleEligible,
  Value<bool> isActive,
  Value<int> rowid,
});

class $$ProductsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTableTable> {
  $$ProductsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sku => $composableBuilder(
      column: $table.sku, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get formulation => $composableBuilder(
      column: $table.formulation, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get netPrice => $composableBuilder(
      column: $table.netPrice, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSampleEligible => $composableBuilder(
      column: $table.isSampleEligible,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));
}

class $$ProductsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTableTable> {
  $$ProductsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sku => $composableBuilder(
      column: $table.sku, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get formulation => $composableBuilder(
      column: $table.formulation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get netPrice => $composableBuilder(
      column: $table.netPrice, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSampleEligible => $composableBuilder(
      column: $table.isSampleEligible,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));
}

class $$ProductsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTableTable> {
  $$ProductsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get sku =>
      $composableBuilder(column: $table.sku, builder: (column) => column);

  GeneratedColumn<String> get formulation => $composableBuilder(
      column: $table.formulation, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get netPrice =>
      $composableBuilder(column: $table.netPrice, builder: (column) => column);

  GeneratedColumn<bool> get isSampleEligible => $composableBuilder(
      column: $table.isSampleEligible, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);
}

class $$ProductsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProductsTableTable,
    ProductCache,
    $$ProductsTableTableFilterComposer,
    $$ProductsTableTableOrderingComposer,
    $$ProductsTableTableAnnotationComposer,
    $$ProductsTableTableCreateCompanionBuilder,
    $$ProductsTableTableUpdateCompanionBuilder,
    (
      ProductCache,
      BaseReferences<_$AppDatabase, $ProductsTableTable, ProductCache>
    ),
    ProductCache,
    PrefetchHooks Function()> {
  $$ProductsTableTableTableManager(_$AppDatabase db, $ProductsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> sku = const Value.absent(),
            Value<String?> formulation = const Value.absent(),
            Value<String?> category = const Value.absent(),
            Value<double> netPrice = const Value.absent(),
            Value<bool> isSampleEligible = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductsTableCompanion(
            id: id,
            name: name,
            sku: sku,
            formulation: formulation,
            category: category,
            netPrice: netPrice,
            isSampleEligible: isSampleEligible,
            isActive: isActive,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> sku = const Value.absent(),
            Value<String?> formulation = const Value.absent(),
            Value<String?> category = const Value.absent(),
            required double netPrice,
            Value<bool> isSampleEligible = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductsTableCompanion.insert(
            id: id,
            name: name,
            sku: sku,
            formulation: formulation,
            category: category,
            netPrice: netPrice,
            isSampleEligible: isSampleEligible,
            isActive: isActive,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ProductsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProductsTableTable,
    ProductCache,
    $$ProductsTableTableFilterComposer,
    $$ProductsTableTableOrderingComposer,
    $$ProductsTableTableAnnotationComposer,
    $$ProductsTableTableCreateCompanionBuilder,
    $$ProductsTableTableUpdateCompanionBuilder,
    (
      ProductCache,
      BaseReferences<_$AppDatabase, $ProductsTableTable, ProductCache>
    ),
    ProductCache,
    PrefetchHooks Function()>;
typedef $$SyncQueueTableTableCreateCompanionBuilder = SyncQueueTableCompanion
    Function({
  Value<int> id,
  required String entityType,
  required String payloadJson,
  required String operation,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<String?> errorMessage,
  Value<int> retryCount,
});
typedef $$SyncQueueTableTableUpdateCompanionBuilder = SyncQueueTableCompanion
    Function({
  Value<int> id,
  Value<String> entityType,
  Value<String> payloadJson,
  Value<String> operation,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<String?> errorMessage,
  Value<int> retryCount,
});

class $$SyncQueueTableTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueTableTable> {
  $$SyncQueueTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payloadJson => $composableBuilder(
      column: $table.payloadJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => ColumnFilters(column));
}

class $$SyncQueueTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueTableTable> {
  $$SyncQueueTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payloadJson => $composableBuilder(
      column: $table.payloadJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => ColumnOrderings(column));
}

class $$SyncQueueTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueTableTable> {
  $$SyncQueueTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
      column: $table.payloadJson, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => column);
}

class $$SyncQueueTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncQueueTableTable,
    SyncQueueEntry,
    $$SyncQueueTableTableFilterComposer,
    $$SyncQueueTableTableOrderingComposer,
    $$SyncQueueTableTableAnnotationComposer,
    $$SyncQueueTableTableCreateCompanionBuilder,
    $$SyncQueueTableTableUpdateCompanionBuilder,
    (
      SyncQueueEntry,
      BaseReferences<_$AppDatabase, $SyncQueueTableTable, SyncQueueEntry>
    ),
    SyncQueueEntry,
    PrefetchHooks Function()> {
  $$SyncQueueTableTableTableManager(
      _$AppDatabase db, $SyncQueueTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> entityType = const Value.absent(),
            Value<String> payloadJson = const Value.absent(),
            Value<String> operation = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<String?> errorMessage = const Value.absent(),
            Value<int> retryCount = const Value.absent(),
          }) =>
              SyncQueueTableCompanion(
            id: id,
            entityType: entityType,
            payloadJson: payloadJson,
            operation: operation,
            status: status,
            createdAt: createdAt,
            errorMessage: errorMessage,
            retryCount: retryCount,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String entityType,
            required String payloadJson,
            required String operation,
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<String?> errorMessage = const Value.absent(),
            Value<int> retryCount = const Value.absent(),
          }) =>
              SyncQueueTableCompanion.insert(
            id: id,
            entityType: entityType,
            payloadJson: payloadJson,
            operation: operation,
            status: status,
            createdAt: createdAt,
            errorMessage: errorMessage,
            retryCount: retryCount,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncQueueTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SyncQueueTableTable,
    SyncQueueEntry,
    $$SyncQueueTableTableFilterComposer,
    $$SyncQueueTableTableOrderingComposer,
    $$SyncQueueTableTableAnnotationComposer,
    $$SyncQueueTableTableCreateCompanionBuilder,
    $$SyncQueueTableTableUpdateCompanionBuilder,
    (
      SyncQueueEntry,
      BaseReferences<_$AppDatabase, $SyncQueueTableTable, SyncQueueEntry>
    ),
    SyncQueueEntry,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TerritoriesTableTableTableManager get territoriesTable =>
      $$TerritoriesTableTableTableManager(_db, _db.territoriesTable);
  $$ProfilesTableTableTableManager get profilesTable =>
      $$ProfilesTableTableTableManager(_db, _db.profilesTable);
  $$DoctorsTableTableTableManager get doctorsTable =>
      $$DoctorsTableTableTableManager(_db, _db.doctorsTable);
  $$ChemistsTableTableTableManager get chemistsTable =>
      $$ChemistsTableTableTableManager(_db, _db.chemistsTable);
  $$ProductsTableTableTableManager get productsTable =>
      $$ProductsTableTableTableManager(_db, _db.productsTable);
  $$SyncQueueTableTableTableManager get syncQueueTable =>
      $$SyncQueueTableTableTableManager(_db, _db.syncQueueTable);
}
