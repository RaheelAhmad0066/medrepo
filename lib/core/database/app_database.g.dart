// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SyncQueueTableTable extends SyncQueueTable
    with TableInfo<$SyncQueueTableTable, SyncQueueItem> {
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
  static const VerificationMeta _endpointMeta =
      const VerificationMeta('endpoint');
  @override
  late final GeneratedColumn<String> endpoint = GeneratedColumn<String>(
      'endpoint', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
      'method', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _payloadMeta =
      const VerificationMeta('payload');
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
      'payload', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _headersMeta =
      const VerificationMeta('headers');
  @override
  late final GeneratedColumn<String> headers = GeneratedColumn<String>(
      'headers', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _retryCountMeta =
      const VerificationMeta('retryCount');
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
      'retry_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _errorMessageMeta =
      const VerificationMeta('errorMessage');
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
      'error_message', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        endpoint,
        method,
        payload,
        headers,
        status,
        retryCount,
        errorMessage,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue_table';
  @override
  VerificationContext validateIntegrity(Insertable<SyncQueueItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('endpoint')) {
      context.handle(_endpointMeta,
          endpoint.isAcceptableOrUnknown(data['endpoint']!, _endpointMeta));
    } else if (isInserting) {
      context.missing(_endpointMeta);
    }
    if (data.containsKey('method')) {
      context.handle(_methodMeta,
          method.isAcceptableOrUnknown(data['method']!, _methodMeta));
    } else if (isInserting) {
      context.missing(_methodMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(_payloadMeta,
          payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta));
    }
    if (data.containsKey('headers')) {
      context.handle(_headersMeta,
          headers.isAcceptableOrUnknown(data['headers']!, _headersMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('retry_count')) {
      context.handle(
          _retryCountMeta,
          retryCount.isAcceptableOrUnknown(
              data['retry_count']!, _retryCountMeta));
    }
    if (data.containsKey('error_message')) {
      context.handle(
          _errorMessageMeta,
          errorMessage.isAcceptableOrUnknown(
              data['error_message']!, _errorMessageMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      endpoint: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}endpoint'])!,
      method: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}method'])!,
      payload: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payload']),
      headers: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}headers']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      retryCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}retry_count'])!,
      errorMessage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}error_message']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $SyncQueueTableTable createAlias(String alias) {
    return $SyncQueueTableTable(attachedDatabase, alias);
  }
}

class SyncQueueItem extends DataClass implements Insertable<SyncQueueItem> {
  final int id;
  final String endpoint;
  final String method;
  final String? payload;
  final String? headers;
  final String status;
  final int retryCount;
  final String? errorMessage;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SyncQueueItem(
      {required this.id,
      required this.endpoint,
      required this.method,
      this.payload,
      this.headers,
      required this.status,
      required this.retryCount,
      this.errorMessage,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['endpoint'] = Variable<String>(endpoint);
    map['method'] = Variable<String>(method);
    if (!nullToAbsent || payload != null) {
      map['payload'] = Variable<String>(payload);
    }
    if (!nullToAbsent || headers != null) {
      map['headers'] = Variable<String>(headers);
    }
    map['status'] = Variable<String>(status);
    map['retry_count'] = Variable<int>(retryCount);
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SyncQueueTableCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueTableCompanion(
      id: Value(id),
      endpoint: Value(endpoint),
      method: Value(method),
      payload: payload == null && nullToAbsent
          ? const Value.absent()
          : Value(payload),
      headers: headers == null && nullToAbsent
          ? const Value.absent()
          : Value(headers),
      status: Value(status),
      retryCount: Value(retryCount),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SyncQueueItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueItem(
      id: serializer.fromJson<int>(json['id']),
      endpoint: serializer.fromJson<String>(json['endpoint']),
      method: serializer.fromJson<String>(json['method']),
      payload: serializer.fromJson<String?>(json['payload']),
      headers: serializer.fromJson<String?>(json['headers']),
      status: serializer.fromJson<String>(json['status']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'endpoint': serializer.toJson<String>(endpoint),
      'method': serializer.toJson<String>(method),
      'payload': serializer.toJson<String?>(payload),
      'headers': serializer.toJson<String?>(headers),
      'status': serializer.toJson<String>(status),
      'retryCount': serializer.toJson<int>(retryCount),
      'errorMessage': serializer.toJson<String?>(errorMessage),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SyncQueueItem copyWith(
          {int? id,
          String? endpoint,
          String? method,
          Value<String?> payload = const Value.absent(),
          Value<String?> headers = const Value.absent(),
          String? status,
          int? retryCount,
          Value<String?> errorMessage = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      SyncQueueItem(
        id: id ?? this.id,
        endpoint: endpoint ?? this.endpoint,
        method: method ?? this.method,
        payload: payload.present ? payload.value : this.payload,
        headers: headers.present ? headers.value : this.headers,
        status: status ?? this.status,
        retryCount: retryCount ?? this.retryCount,
        errorMessage:
            errorMessage.present ? errorMessage.value : this.errorMessage,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  SyncQueueItem copyWithCompanion(SyncQueueTableCompanion data) {
    return SyncQueueItem(
      id: data.id.present ? data.id.value : this.id,
      endpoint: data.endpoint.present ? data.endpoint.value : this.endpoint,
      method: data.method.present ? data.method.value : this.method,
      payload: data.payload.present ? data.payload.value : this.payload,
      headers: data.headers.present ? data.headers.value : this.headers,
      status: data.status.present ? data.status.value : this.status,
      retryCount:
          data.retryCount.present ? data.retryCount.value : this.retryCount,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueItem(')
          ..write('id: $id, ')
          ..write('endpoint: $endpoint, ')
          ..write('method: $method, ')
          ..write('payload: $payload, ')
          ..write('headers: $headers, ')
          ..write('status: $status, ')
          ..write('retryCount: $retryCount, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, endpoint, method, payload, headers,
      status, retryCount, errorMessage, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueItem &&
          other.id == this.id &&
          other.endpoint == this.endpoint &&
          other.method == this.method &&
          other.payload == this.payload &&
          other.headers == this.headers &&
          other.status == this.status &&
          other.retryCount == this.retryCount &&
          other.errorMessage == this.errorMessage &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SyncQueueTableCompanion extends UpdateCompanion<SyncQueueItem> {
  final Value<int> id;
  final Value<String> endpoint;
  final Value<String> method;
  final Value<String?> payload;
  final Value<String?> headers;
  final Value<String> status;
  final Value<int> retryCount;
  final Value<String?> errorMessage;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const SyncQueueTableCompanion({
    this.id = const Value.absent(),
    this.endpoint = const Value.absent(),
    this.method = const Value.absent(),
    this.payload = const Value.absent(),
    this.headers = const Value.absent(),
    this.status = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SyncQueueTableCompanion.insert({
    this.id = const Value.absent(),
    required String endpoint,
    required String method,
    this.payload = const Value.absent(),
    this.headers = const Value.absent(),
    required String status,
    this.retryCount = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : endpoint = Value(endpoint),
        method = Value(method),
        status = Value(status);
  static Insertable<SyncQueueItem> custom({
    Expression<int>? id,
    Expression<String>? endpoint,
    Expression<String>? method,
    Expression<String>? payload,
    Expression<String>? headers,
    Expression<String>? status,
    Expression<int>? retryCount,
    Expression<String>? errorMessage,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (endpoint != null) 'endpoint': endpoint,
      if (method != null) 'method': method,
      if (payload != null) 'payload': payload,
      if (headers != null) 'headers': headers,
      if (status != null) 'status': status,
      if (retryCount != null) 'retry_count': retryCount,
      if (errorMessage != null) 'error_message': errorMessage,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SyncQueueTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? endpoint,
      Value<String>? method,
      Value<String?>? payload,
      Value<String?>? headers,
      Value<String>? status,
      Value<int>? retryCount,
      Value<String?>? errorMessage,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return SyncQueueTableCompanion(
      id: id ?? this.id,
      endpoint: endpoint ?? this.endpoint,
      method: method ?? this.method,
      payload: payload ?? this.payload,
      headers: headers ?? this.headers,
      status: status ?? this.status,
      retryCount: retryCount ?? this.retryCount,
      errorMessage: errorMessage ?? this.errorMessage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (endpoint.present) {
      map['endpoint'] = Variable<String>(endpoint.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (headers.present) {
      map['headers'] = Variable<String>(headers.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueTableCompanion(')
          ..write('id: $id, ')
          ..write('endpoint: $endpoint, ')
          ..write('method: $method, ')
          ..write('payload: $payload, ')
          ..write('headers: $headers, ')
          ..write('status: $status, ')
          ..write('retryCount: $retryCount, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CachedApiTableTable extends CachedApiTable
    with TableInfo<$CachedApiTableTable, CachedApiResponse> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedApiTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _endpointKeyMeta =
      const VerificationMeta('endpointKey');
  @override
  late final GeneratedColumn<String> endpointKey = GeneratedColumn<String>(
      'endpoint_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _responseJsonMeta =
      const VerificationMeta('responseJson');
  @override
  late final GeneratedColumn<String> responseJson = GeneratedColumn<String>(
      'response_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _expiresAtMeta =
      const VerificationMeta('expiresAt');
  @override
  late final GeneratedColumn<DateTime> expiresAt = GeneratedColumn<DateTime>(
      'expires_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _cachedAtMeta =
      const VerificationMeta('cachedAt');
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
      'cached_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [endpointKey, responseJson, expiresAt, cachedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_api_table';
  @override
  VerificationContext validateIntegrity(Insertable<CachedApiResponse> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('endpoint_key')) {
      context.handle(
          _endpointKeyMeta,
          endpointKey.isAcceptableOrUnknown(
              data['endpoint_key']!, _endpointKeyMeta));
    } else if (isInserting) {
      context.missing(_endpointKeyMeta);
    }
    if (data.containsKey('response_json')) {
      context.handle(
          _responseJsonMeta,
          responseJson.isAcceptableOrUnknown(
              data['response_json']!, _responseJsonMeta));
    } else if (isInserting) {
      context.missing(_responseJsonMeta);
    }
    if (data.containsKey('expires_at')) {
      context.handle(_expiresAtMeta,
          expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta));
    } else if (isInserting) {
      context.missing(_expiresAtMeta);
    }
    if (data.containsKey('cached_at')) {
      context.handle(_cachedAtMeta,
          cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {endpointKey};
  @override
  CachedApiResponse map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedApiResponse(
      endpointKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}endpoint_key'])!,
      responseJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}response_json'])!,
      expiresAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}expires_at'])!,
      cachedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}cached_at'])!,
    );
  }

  @override
  $CachedApiTableTable createAlias(String alias) {
    return $CachedApiTableTable(attachedDatabase, alias);
  }
}

class CachedApiResponse extends DataClass
    implements Insertable<CachedApiResponse> {
  final String endpointKey;
  final String responseJson;
  final DateTime expiresAt;
  final DateTime cachedAt;
  const CachedApiResponse(
      {required this.endpointKey,
      required this.responseJson,
      required this.expiresAt,
      required this.cachedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['endpoint_key'] = Variable<String>(endpointKey);
    map['response_json'] = Variable<String>(responseJson);
    map['expires_at'] = Variable<DateTime>(expiresAt);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  CachedApiTableCompanion toCompanion(bool nullToAbsent) {
    return CachedApiTableCompanion(
      endpointKey: Value(endpointKey),
      responseJson: Value(responseJson),
      expiresAt: Value(expiresAt),
      cachedAt: Value(cachedAt),
    );
  }

  factory CachedApiResponse.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedApiResponse(
      endpointKey: serializer.fromJson<String>(json['endpointKey']),
      responseJson: serializer.fromJson<String>(json['responseJson']),
      expiresAt: serializer.fromJson<DateTime>(json['expiresAt']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'endpointKey': serializer.toJson<String>(endpointKey),
      'responseJson': serializer.toJson<String>(responseJson),
      'expiresAt': serializer.toJson<DateTime>(expiresAt),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  CachedApiResponse copyWith(
          {String? endpointKey,
          String? responseJson,
          DateTime? expiresAt,
          DateTime? cachedAt}) =>
      CachedApiResponse(
        endpointKey: endpointKey ?? this.endpointKey,
        responseJson: responseJson ?? this.responseJson,
        expiresAt: expiresAt ?? this.expiresAt,
        cachedAt: cachedAt ?? this.cachedAt,
      );
  CachedApiResponse copyWithCompanion(CachedApiTableCompanion data) {
    return CachedApiResponse(
      endpointKey:
          data.endpointKey.present ? data.endpointKey.value : this.endpointKey,
      responseJson: data.responseJson.present
          ? data.responseJson.value
          : this.responseJson,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedApiResponse(')
          ..write('endpointKey: $endpointKey, ')
          ..write('responseJson: $responseJson, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(endpointKey, responseJson, expiresAt, cachedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedApiResponse &&
          other.endpointKey == this.endpointKey &&
          other.responseJson == this.responseJson &&
          other.expiresAt == this.expiresAt &&
          other.cachedAt == this.cachedAt);
}

class CachedApiTableCompanion extends UpdateCompanion<CachedApiResponse> {
  final Value<String> endpointKey;
  final Value<String> responseJson;
  final Value<DateTime> expiresAt;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const CachedApiTableCompanion({
    this.endpointKey = const Value.absent(),
    this.responseJson = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedApiTableCompanion.insert({
    required String endpointKey,
    required String responseJson,
    required DateTime expiresAt,
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : endpointKey = Value(endpointKey),
        responseJson = Value(responseJson),
        expiresAt = Value(expiresAt);
  static Insertable<CachedApiResponse> custom({
    Expression<String>? endpointKey,
    Expression<String>? responseJson,
    Expression<DateTime>? expiresAt,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (endpointKey != null) 'endpoint_key': endpointKey,
      if (responseJson != null) 'response_json': responseJson,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedApiTableCompanion copyWith(
      {Value<String>? endpointKey,
      Value<String>? responseJson,
      Value<DateTime>? expiresAt,
      Value<DateTime>? cachedAt,
      Value<int>? rowid}) {
    return CachedApiTableCompanion(
      endpointKey: endpointKey ?? this.endpointKey,
      responseJson: responseJson ?? this.responseJson,
      expiresAt: expiresAt ?? this.expiresAt,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (endpointKey.present) {
      map['endpoint_key'] = Variable<String>(endpointKey.value);
    }
    if (responseJson.present) {
      map['response_json'] = Variable<String>(responseJson.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedApiTableCompanion(')
          ..write('endpointKey: $endpointKey, ')
          ..write('responseJson: $responseJson, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DoctorsTableTable extends DoctorsTable
    with TableInfo<$DoctorsTableTable, DoctorsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DoctorsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tenantIdMeta =
      const VerificationMeta('tenantId');
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
      'tenant_id', aliasedName, false,
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
      'specialty', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _clinicAddressMeta =
      const VerificationMeta('clinicAddress');
  @override
  late final GeneratedColumn<String> clinicAddress = GeneratedColumn<String>(
      'clinic_address', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _latitudeMeta =
      const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
      'latitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _longitudeMeta =
      const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
      'longitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _tierMeta = const VerificationMeta('tier');
  @override
  late final GeneratedColumn<String> tier = GeneratedColumn<String>(
      'tier', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _clientCreatedAtMeta =
      const VerificationMeta('clientCreatedAt');
  @override
  late final GeneratedColumn<DateTime> clientCreatedAt =
      GeneratedColumn<DateTime>('client_created_at', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _lastModifiedAtMeta =
      const VerificationMeta('lastModifiedAt');
  @override
  late final GeneratedColumn<DateTime> lastModifiedAt =
      GeneratedColumn<DateTime>('last_modified_at', aliasedName, false,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          defaultValue: currentDateAndTime);
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
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
        isDeleted
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'doctors_table';
  @override
  VerificationContext validateIntegrity(Insertable<DoctorsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(_tenantIdMeta,
          tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta));
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
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
    } else if (isInserting) {
      context.missing(_specialtyMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('clinic_address')) {
      context.handle(
          _clinicAddressMeta,
          clinicAddress.isAcceptableOrUnknown(
              data['clinic_address']!, _clinicAddressMeta));
    } else if (isInserting) {
      context.missing(_clinicAddressMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    }
    if (data.containsKey('tier')) {
      context.handle(
          _tierMeta, tier.isAcceptableOrUnknown(data['tier']!, _tierMeta));
    } else if (isInserting) {
      context.missing(_tierMeta);
    }
    if (data.containsKey('client_created_at')) {
      context.handle(
          _clientCreatedAtMeta,
          clientCreatedAt.isAcceptableOrUnknown(
              data['client_created_at']!, _clientCreatedAtMeta));
    } else if (isInserting) {
      context.missing(_clientCreatedAtMeta);
    }
    if (data.containsKey('last_modified_at')) {
      context.handle(
          _lastModifiedAtMeta,
          lastModifiedAt.isAcceptableOrUnknown(
              data['last_modified_at']!, _lastModifiedAtMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DoctorsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DoctorsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      specialty: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}specialty'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      clinicAddress: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}clinic_address'])!,
      latitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}latitude']),
      longitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}longitude']),
      tier: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tier'])!,
      clientCreatedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}client_created_at'])!,
      lastModifiedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_modified_at'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
    );
  }

  @override
  $DoctorsTableTable createAlias(String alias) {
    return $DoctorsTableTable(attachedDatabase, alias);
  }
}

class DoctorsTableData extends DataClass
    implements Insertable<DoctorsTableData> {
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
  const DoctorsTableData(
      {required this.id,
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
      required this.isDeleted});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['name'] = Variable<String>(name);
    map['specialty'] = Variable<String>(specialty);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    map['clinic_address'] = Variable<String>(clinicAddress);
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    map['tier'] = Variable<String>(tier);
    map['client_created_at'] = Variable<DateTime>(clientCreatedAt);
    map['last_modified_at'] = Variable<DateTime>(lastModifiedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  DoctorsTableCompanion toCompanion(bool nullToAbsent) {
    return DoctorsTableCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      name: Value(name),
      specialty: Value(specialty),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      clinicAddress: Value(clinicAddress),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      tier: Value(tier),
      clientCreatedAt: Value(clientCreatedAt),
      lastModifiedAt: Value(lastModifiedAt),
      isDeleted: Value(isDeleted),
    );
  }

  factory DoctorsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DoctorsTableData(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      name: serializer.fromJson<String>(json['name']),
      specialty: serializer.fromJson<String>(json['specialty']),
      email: serializer.fromJson<String?>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      clinicAddress: serializer.fromJson<String>(json['clinicAddress']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      tier: serializer.fromJson<String>(json['tier']),
      clientCreatedAt: serializer.fromJson<DateTime>(json['clientCreatedAt']),
      lastModifiedAt: serializer.fromJson<DateTime>(json['lastModifiedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'name': serializer.toJson<String>(name),
      'specialty': serializer.toJson<String>(specialty),
      'email': serializer.toJson<String?>(email),
      'phone': serializer.toJson<String?>(phone),
      'clinicAddress': serializer.toJson<String>(clinicAddress),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'tier': serializer.toJson<String>(tier),
      'clientCreatedAt': serializer.toJson<DateTime>(clientCreatedAt),
      'lastModifiedAt': serializer.toJson<DateTime>(lastModifiedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  DoctorsTableData copyWith(
          {String? id,
          String? tenantId,
          String? name,
          String? specialty,
          Value<String?> email = const Value.absent(),
          Value<String?> phone = const Value.absent(),
          String? clinicAddress,
          Value<double?> latitude = const Value.absent(),
          Value<double?> longitude = const Value.absent(),
          String? tier,
          DateTime? clientCreatedAt,
          DateTime? lastModifiedAt,
          bool? isDeleted}) =>
      DoctorsTableData(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        name: name ?? this.name,
        specialty: specialty ?? this.specialty,
        email: email.present ? email.value : this.email,
        phone: phone.present ? phone.value : this.phone,
        clinicAddress: clinicAddress ?? this.clinicAddress,
        latitude: latitude.present ? latitude.value : this.latitude,
        longitude: longitude.present ? longitude.value : this.longitude,
        tier: tier ?? this.tier,
        clientCreatedAt: clientCreatedAt ?? this.clientCreatedAt,
        lastModifiedAt: lastModifiedAt ?? this.lastModifiedAt,
        isDeleted: isDeleted ?? this.isDeleted,
      );
  DoctorsTableData copyWithCompanion(DoctorsTableCompanion data) {
    return DoctorsTableData(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      name: data.name.present ? data.name.value : this.name,
      specialty: data.specialty.present ? data.specialty.value : this.specialty,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      clinicAddress: data.clinicAddress.present
          ? data.clinicAddress.value
          : this.clinicAddress,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      tier: data.tier.present ? data.tier.value : this.tier,
      clientCreatedAt: data.clientCreatedAt.present
          ? data.clientCreatedAt.value
          : this.clientCreatedAt,
      lastModifiedAt: data.lastModifiedAt.present
          ? data.lastModifiedAt.value
          : this.lastModifiedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DoctorsTableData(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('name: $name, ')
          ..write('specialty: $specialty, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('clinicAddress: $clinicAddress, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('tier: $tier, ')
          ..write('clientCreatedAt: $clientCreatedAt, ')
          ..write('lastModifiedAt: $lastModifiedAt, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
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
      isDeleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DoctorsTableData &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.name == this.name &&
          other.specialty == this.specialty &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.clinicAddress == this.clinicAddress &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.tier == this.tier &&
          other.clientCreatedAt == this.clientCreatedAt &&
          other.lastModifiedAt == this.lastModifiedAt &&
          other.isDeleted == this.isDeleted);
}

class DoctorsTableCompanion extends UpdateCompanion<DoctorsTableData> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> name;
  final Value<String> specialty;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<String> clinicAddress;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<String> tier;
  final Value<DateTime> clientCreatedAt;
  final Value<DateTime> lastModifiedAt;
  final Value<bool> isDeleted;
  final Value<int> rowid;
  const DoctorsTableCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.name = const Value.absent(),
    this.specialty = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.clinicAddress = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.tier = const Value.absent(),
    this.clientCreatedAt = const Value.absent(),
    this.lastModifiedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DoctorsTableCompanion.insert({
    required String id,
    required String tenantId,
    required String name,
    required String specialty,
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    required String clinicAddress,
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    required String tier,
    required DateTime clientCreatedAt,
    this.lastModifiedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tenantId = Value(tenantId),
        name = Value(name),
        specialty = Value(specialty),
        clinicAddress = Value(clinicAddress),
        tier = Value(tier),
        clientCreatedAt = Value(clientCreatedAt);
  static Insertable<DoctorsTableData> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? name,
    Expression<String>? specialty,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? clinicAddress,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? tier,
    Expression<DateTime>? clientCreatedAt,
    Expression<DateTime>? lastModifiedAt,
    Expression<bool>? isDeleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (name != null) 'name': name,
      if (specialty != null) 'specialty': specialty,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (clinicAddress != null) 'clinic_address': clinicAddress,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (tier != null) 'tier': tier,
      if (clientCreatedAt != null) 'client_created_at': clientCreatedAt,
      if (lastModifiedAt != null) 'last_modified_at': lastModifiedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DoctorsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String>? name,
      Value<String>? specialty,
      Value<String?>? email,
      Value<String?>? phone,
      Value<String>? clinicAddress,
      Value<double?>? latitude,
      Value<double?>? longitude,
      Value<String>? tier,
      Value<DateTime>? clientCreatedAt,
      Value<DateTime>? lastModifiedAt,
      Value<bool>? isDeleted,
      Value<int>? rowid}) {
    return DoctorsTableCompanion(
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
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (specialty.present) {
      map['specialty'] = Variable<String>(specialty.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (clinicAddress.present) {
      map['clinic_address'] = Variable<String>(clinicAddress.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (tier.present) {
      map['tier'] = Variable<String>(tier.value);
    }
    if (clientCreatedAt.present) {
      map['client_created_at'] = Variable<DateTime>(clientCreatedAt.value);
    }
    if (lastModifiedAt.present) {
      map['last_modified_at'] = Variable<DateTime>(lastModifiedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
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
          ..write('tenantId: $tenantId, ')
          ..write('name: $name, ')
          ..write('specialty: $specialty, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('clinicAddress: $clinicAddress, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('tier: $tier, ')
          ..write('clientCreatedAt: $clientCreatedAt, ')
          ..write('lastModifiedAt: $lastModifiedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChemistsTableTable extends ChemistsTable
    with TableInfo<$ChemistsTableTable, ChemistsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChemistsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tenantIdMeta =
      const VerificationMeta('tenantId');
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
      'tenant_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contactPersonMeta =
      const VerificationMeta('contactPerson');
  @override
  late final GeneratedColumn<String> contactPerson = GeneratedColumn<String>(
      'contact_person', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _latitudeMeta =
      const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
      'latitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _longitudeMeta =
      const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
      'longitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _priorityTagMeta =
      const VerificationMeta('priorityTag');
  @override
  late final GeneratedColumn<String> priorityTag = GeneratedColumn<String>(
      'priority_tag', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _outstandingBalanceMeta =
      const VerificationMeta('outstandingBalance');
  @override
  late final GeneratedColumn<double> outstandingBalance =
      GeneratedColumn<double>('outstanding_balance', aliasedName, false,
          type: DriftSqlType.double,
          requiredDuringInsert: false,
          defaultValue: const Constant(0.0));
  static const VerificationMeta _creditLimitMeta =
      const VerificationMeta('creditLimit');
  @override
  late final GeneratedColumn<double> creditLimit = GeneratedColumn<double>(
      'credit_limit', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _clientCreatedAtMeta =
      const VerificationMeta('clientCreatedAt');
  @override
  late final GeneratedColumn<DateTime> clientCreatedAt =
      GeneratedColumn<DateTime>('client_created_at', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _lastModifiedAtMeta =
      const VerificationMeta('lastModifiedAt');
  @override
  late final GeneratedColumn<DateTime> lastModifiedAt =
      GeneratedColumn<DateTime>('last_modified_at', aliasedName, false,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          defaultValue: currentDateAndTime);
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
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
        isDeleted
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chemists_table';
  @override
  VerificationContext validateIntegrity(Insertable<ChemistsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(_tenantIdMeta,
          tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta));
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('contact_person')) {
      context.handle(
          _contactPersonMeta,
          contactPerson.isAcceptableOrUnknown(
              data['contact_person']!, _contactPersonMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    }
    if (data.containsKey('priority_tag')) {
      context.handle(
          _priorityTagMeta,
          priorityTag.isAcceptableOrUnknown(
              data['priority_tag']!, _priorityTagMeta));
    } else if (isInserting) {
      context.missing(_priorityTagMeta);
    }
    if (data.containsKey('outstanding_balance')) {
      context.handle(
          _outstandingBalanceMeta,
          outstandingBalance.isAcceptableOrUnknown(
              data['outstanding_balance']!, _outstandingBalanceMeta));
    }
    if (data.containsKey('credit_limit')) {
      context.handle(
          _creditLimitMeta,
          creditLimit.isAcceptableOrUnknown(
              data['credit_limit']!, _creditLimitMeta));
    }
    if (data.containsKey('client_created_at')) {
      context.handle(
          _clientCreatedAtMeta,
          clientCreatedAt.isAcceptableOrUnknown(
              data['client_created_at']!, _clientCreatedAtMeta));
    } else if (isInserting) {
      context.missing(_clientCreatedAtMeta);
    }
    if (data.containsKey('last_modified_at')) {
      context.handle(
          _lastModifiedAtMeta,
          lastModifiedAt.isAcceptableOrUnknown(
              data['last_modified_at']!, _lastModifiedAtMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChemistsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChemistsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      contactPerson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}contact_person']),
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address'])!,
      latitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}latitude']),
      longitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}longitude']),
      priorityTag: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}priority_tag'])!,
      outstandingBalance: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}outstanding_balance'])!,
      creditLimit: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}credit_limit'])!,
      clientCreatedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}client_created_at'])!,
      lastModifiedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_modified_at'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
    );
  }

  @override
  $ChemistsTableTable createAlias(String alias) {
    return $ChemistsTableTable(attachedDatabase, alias);
  }
}

class ChemistsTableData extends DataClass
    implements Insertable<ChemistsTableData> {
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
  const ChemistsTableData(
      {required this.id,
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
      required this.isDeleted});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || contactPerson != null) {
      map['contact_person'] = Variable<String>(contactPerson);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    map['address'] = Variable<String>(address);
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    map['priority_tag'] = Variable<String>(priorityTag);
    map['outstanding_balance'] = Variable<double>(outstandingBalance);
    map['credit_limit'] = Variable<double>(creditLimit);
    map['client_created_at'] = Variable<DateTime>(clientCreatedAt);
    map['last_modified_at'] = Variable<DateTime>(lastModifiedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  ChemistsTableCompanion toCompanion(bool nullToAbsent) {
    return ChemistsTableCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      name: Value(name),
      contactPerson: contactPerson == null && nullToAbsent
          ? const Value.absent()
          : Value(contactPerson),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      address: Value(address),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      priorityTag: Value(priorityTag),
      outstandingBalance: Value(outstandingBalance),
      creditLimit: Value(creditLimit),
      clientCreatedAt: Value(clientCreatedAt),
      lastModifiedAt: Value(lastModifiedAt),
      isDeleted: Value(isDeleted),
    );
  }

  factory ChemistsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChemistsTableData(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      name: serializer.fromJson<String>(json['name']),
      contactPerson: serializer.fromJson<String?>(json['contactPerson']),
      phone: serializer.fromJson<String?>(json['phone']),
      address: serializer.fromJson<String>(json['address']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      priorityTag: serializer.fromJson<String>(json['priorityTag']),
      outstandingBalance:
          serializer.fromJson<double>(json['outstandingBalance']),
      creditLimit: serializer.fromJson<double>(json['creditLimit']),
      clientCreatedAt: serializer.fromJson<DateTime>(json['clientCreatedAt']),
      lastModifiedAt: serializer.fromJson<DateTime>(json['lastModifiedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'name': serializer.toJson<String>(name),
      'contactPerson': serializer.toJson<String?>(contactPerson),
      'phone': serializer.toJson<String?>(phone),
      'address': serializer.toJson<String>(address),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'priorityTag': serializer.toJson<String>(priorityTag),
      'outstandingBalance': serializer.toJson<double>(outstandingBalance),
      'creditLimit': serializer.toJson<double>(creditLimit),
      'clientCreatedAt': serializer.toJson<DateTime>(clientCreatedAt),
      'lastModifiedAt': serializer.toJson<DateTime>(lastModifiedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  ChemistsTableData copyWith(
          {String? id,
          String? tenantId,
          String? name,
          Value<String?> contactPerson = const Value.absent(),
          Value<String?> phone = const Value.absent(),
          String? address,
          Value<double?> latitude = const Value.absent(),
          Value<double?> longitude = const Value.absent(),
          String? priorityTag,
          double? outstandingBalance,
          double? creditLimit,
          DateTime? clientCreatedAt,
          DateTime? lastModifiedAt,
          bool? isDeleted}) =>
      ChemistsTableData(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        name: name ?? this.name,
        contactPerson:
            contactPerson.present ? contactPerson.value : this.contactPerson,
        phone: phone.present ? phone.value : this.phone,
        address: address ?? this.address,
        latitude: latitude.present ? latitude.value : this.latitude,
        longitude: longitude.present ? longitude.value : this.longitude,
        priorityTag: priorityTag ?? this.priorityTag,
        outstandingBalance: outstandingBalance ?? this.outstandingBalance,
        creditLimit: creditLimit ?? this.creditLimit,
        clientCreatedAt: clientCreatedAt ?? this.clientCreatedAt,
        lastModifiedAt: lastModifiedAt ?? this.lastModifiedAt,
        isDeleted: isDeleted ?? this.isDeleted,
      );
  ChemistsTableData copyWithCompanion(ChemistsTableCompanion data) {
    return ChemistsTableData(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      name: data.name.present ? data.name.value : this.name,
      contactPerson: data.contactPerson.present
          ? data.contactPerson.value
          : this.contactPerson,
      phone: data.phone.present ? data.phone.value : this.phone,
      address: data.address.present ? data.address.value : this.address,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      priorityTag:
          data.priorityTag.present ? data.priorityTag.value : this.priorityTag,
      outstandingBalance: data.outstandingBalance.present
          ? data.outstandingBalance.value
          : this.outstandingBalance,
      creditLimit:
          data.creditLimit.present ? data.creditLimit.value : this.creditLimit,
      clientCreatedAt: data.clientCreatedAt.present
          ? data.clientCreatedAt.value
          : this.clientCreatedAt,
      lastModifiedAt: data.lastModifiedAt.present
          ? data.lastModifiedAt.value
          : this.lastModifiedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChemistsTableData(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('name: $name, ')
          ..write('contactPerson: $contactPerson, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('priorityTag: $priorityTag, ')
          ..write('outstandingBalance: $outstandingBalance, ')
          ..write('creditLimit: $creditLimit, ')
          ..write('clientCreatedAt: $clientCreatedAt, ')
          ..write('lastModifiedAt: $lastModifiedAt, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
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
      isDeleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChemistsTableData &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.name == this.name &&
          other.contactPerson == this.contactPerson &&
          other.phone == this.phone &&
          other.address == this.address &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.priorityTag == this.priorityTag &&
          other.outstandingBalance == this.outstandingBalance &&
          other.creditLimit == this.creditLimit &&
          other.clientCreatedAt == this.clientCreatedAt &&
          other.lastModifiedAt == this.lastModifiedAt &&
          other.isDeleted == this.isDeleted);
}

class ChemistsTableCompanion extends UpdateCompanion<ChemistsTableData> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> name;
  final Value<String?> contactPerson;
  final Value<String?> phone;
  final Value<String> address;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<String> priorityTag;
  final Value<double> outstandingBalance;
  final Value<double> creditLimit;
  final Value<DateTime> clientCreatedAt;
  final Value<DateTime> lastModifiedAt;
  final Value<bool> isDeleted;
  final Value<int> rowid;
  const ChemistsTableCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.name = const Value.absent(),
    this.contactPerson = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.priorityTag = const Value.absent(),
    this.outstandingBalance = const Value.absent(),
    this.creditLimit = const Value.absent(),
    this.clientCreatedAt = const Value.absent(),
    this.lastModifiedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChemistsTableCompanion.insert({
    required String id,
    required String tenantId,
    required String name,
    this.contactPerson = const Value.absent(),
    this.phone = const Value.absent(),
    required String address,
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    required String priorityTag,
    this.outstandingBalance = const Value.absent(),
    this.creditLimit = const Value.absent(),
    required DateTime clientCreatedAt,
    this.lastModifiedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tenantId = Value(tenantId),
        name = Value(name),
        address = Value(address),
        priorityTag = Value(priorityTag),
        clientCreatedAt = Value(clientCreatedAt);
  static Insertable<ChemistsTableData> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? name,
    Expression<String>? contactPerson,
    Expression<String>? phone,
    Expression<String>? address,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? priorityTag,
    Expression<double>? outstandingBalance,
    Expression<double>? creditLimit,
    Expression<DateTime>? clientCreatedAt,
    Expression<DateTime>? lastModifiedAt,
    Expression<bool>? isDeleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (name != null) 'name': name,
      if (contactPerson != null) 'contact_person': contactPerson,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (priorityTag != null) 'priority_tag': priorityTag,
      if (outstandingBalance != null) 'outstanding_balance': outstandingBalance,
      if (creditLimit != null) 'credit_limit': creditLimit,
      if (clientCreatedAt != null) 'client_created_at': clientCreatedAt,
      if (lastModifiedAt != null) 'last_modified_at': lastModifiedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChemistsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String>? name,
      Value<String?>? contactPerson,
      Value<String?>? phone,
      Value<String>? address,
      Value<double?>? latitude,
      Value<double?>? longitude,
      Value<String>? priorityTag,
      Value<double>? outstandingBalance,
      Value<double>? creditLimit,
      Value<DateTime>? clientCreatedAt,
      Value<DateTime>? lastModifiedAt,
      Value<bool>? isDeleted,
      Value<int>? rowid}) {
    return ChemistsTableCompanion(
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
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (contactPerson.present) {
      map['contact_person'] = Variable<String>(contactPerson.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (priorityTag.present) {
      map['priority_tag'] = Variable<String>(priorityTag.value);
    }
    if (outstandingBalance.present) {
      map['outstanding_balance'] = Variable<double>(outstandingBalance.value);
    }
    if (creditLimit.present) {
      map['credit_limit'] = Variable<double>(creditLimit.value);
    }
    if (clientCreatedAt.present) {
      map['client_created_at'] = Variable<DateTime>(clientCreatedAt.value);
    }
    if (lastModifiedAt.present) {
      map['last_modified_at'] = Variable<DateTime>(lastModifiedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
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
          ..write('tenantId: $tenantId, ')
          ..write('name: $name, ')
          ..write('contactPerson: $contactPerson, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('priorityTag: $priorityTag, ')
          ..write('outstandingBalance: $outstandingBalance, ')
          ..write('creditLimit: $creditLimit, ')
          ..write('clientCreatedAt: $clientCreatedAt, ')
          ..write('lastModifiedAt: $lastModifiedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductsTableTable extends ProductsTable
    with TableInfo<$ProductsTableTable, ProductsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tenantIdMeta =
      const VerificationMeta('tenantId');
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
      'tenant_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
      'sku', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
      'price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _imageUrlMeta =
      const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
      'image_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _pdfVisualAidUrlMeta =
      const VerificationMeta('pdfVisualAidUrl');
  @override
  late final GeneratedColumn<String> pdfVisualAidUrl = GeneratedColumn<String>(
      'pdf_visual_aid_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isDiscontinuedMeta =
      const VerificationMeta('isDiscontinued');
  @override
  late final GeneratedColumn<bool> isDiscontinued = GeneratedColumn<bool>(
      'is_discontinued', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_discontinued" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isSampleEligibleMeta =
      const VerificationMeta('isSampleEligible');
  @override
  late final GeneratedColumn<bool> isSampleEligible = GeneratedColumn<bool>(
      'is_sample_eligible', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_sample_eligible" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _clientCreatedAtMeta =
      const VerificationMeta('clientCreatedAt');
  @override
  late final GeneratedColumn<DateTime> clientCreatedAt =
      GeneratedColumn<DateTime>('client_created_at', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _lastModifiedAtMeta =
      const VerificationMeta('lastModifiedAt');
  @override
  late final GeneratedColumn<DateTime> lastModifiedAt =
      GeneratedColumn<DateTime>('last_modified_at', aliasedName, false,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          defaultValue: currentDateAndTime);
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tenantId,
        name,
        category,
        sku,
        price,
        imageUrl,
        pdfVisualAidUrl,
        isDiscontinued,
        isSampleEligible,
        clientCreatedAt,
        lastModifiedAt,
        isDeleted
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products_table';
  @override
  VerificationContext validateIntegrity(Insertable<ProductsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(_tenantIdMeta,
          tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta));
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('sku')) {
      context.handle(
          _skuMeta, sku.isAcceptableOrUnknown(data['sku']!, _skuMeta));
    } else if (isInserting) {
      context.missing(_skuMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
    }
    if (data.containsKey('pdf_visual_aid_url')) {
      context.handle(
          _pdfVisualAidUrlMeta,
          pdfVisualAidUrl.isAcceptableOrUnknown(
              data['pdf_visual_aid_url']!, _pdfVisualAidUrlMeta));
    }
    if (data.containsKey('is_discontinued')) {
      context.handle(
          _isDiscontinuedMeta,
          isDiscontinued.isAcceptableOrUnknown(
              data['is_discontinued']!, _isDiscontinuedMeta));
    }
    if (data.containsKey('is_sample_eligible')) {
      context.handle(
          _isSampleEligibleMeta,
          isSampleEligible.isAcceptableOrUnknown(
              data['is_sample_eligible']!, _isSampleEligibleMeta));
    }
    if (data.containsKey('client_created_at')) {
      context.handle(
          _clientCreatedAtMeta,
          clientCreatedAt.isAcceptableOrUnknown(
              data['client_created_at']!, _clientCreatedAtMeta));
    } else if (isInserting) {
      context.missing(_clientCreatedAtMeta);
    }
    if (data.containsKey('last_modified_at')) {
      context.handle(
          _lastModifiedAtMeta,
          lastModifiedAt.isAcceptableOrUnknown(
              data['last_modified_at']!, _lastModifiedAtMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      sku: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sku'])!,
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}price'])!,
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url']),
      pdfVisualAidUrl: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}pdf_visual_aid_url']),
      isDiscontinued: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_discontinued'])!,
      isSampleEligible: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}is_sample_eligible'])!,
      clientCreatedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}client_created_at'])!,
      lastModifiedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_modified_at'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
    );
  }

  @override
  $ProductsTableTable createAlias(String alias) {
    return $ProductsTableTable(attachedDatabase, alias);
  }
}

class ProductsTableData extends DataClass
    implements Insertable<ProductsTableData> {
  final String id;
  final String tenantId;
  final String name;
  final String category;
  final String sku;
  final double price;
  final String? imageUrl;
  final String? pdfVisualAidUrl;
  final bool isDiscontinued;
  final bool isSampleEligible;
  final DateTime clientCreatedAt;
  final DateTime lastModifiedAt;
  final bool isDeleted;
  const ProductsTableData(
      {required this.id,
      required this.tenantId,
      required this.name,
      required this.category,
      required this.sku,
      required this.price,
      this.imageUrl,
      this.pdfVisualAidUrl,
      required this.isDiscontinued,
      required this.isSampleEligible,
      required this.clientCreatedAt,
      required this.lastModifiedAt,
      required this.isDeleted});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['sku'] = Variable<String>(sku);
    map['price'] = Variable<double>(price);
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    if (!nullToAbsent || pdfVisualAidUrl != null) {
      map['pdf_visual_aid_url'] = Variable<String>(pdfVisualAidUrl);
    }
    map['is_discontinued'] = Variable<bool>(isDiscontinued);
    map['is_sample_eligible'] = Variable<bool>(isSampleEligible);
    map['client_created_at'] = Variable<DateTime>(clientCreatedAt);
    map['last_modified_at'] = Variable<DateTime>(lastModifiedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  ProductsTableCompanion toCompanion(bool nullToAbsent) {
    return ProductsTableCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      name: Value(name),
      category: Value(category),
      sku: Value(sku),
      price: Value(price),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      pdfVisualAidUrl: pdfVisualAidUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(pdfVisualAidUrl),
      isDiscontinued: Value(isDiscontinued),
      isSampleEligible: Value(isSampleEligible),
      clientCreatedAt: Value(clientCreatedAt),
      lastModifiedAt: Value(lastModifiedAt),
      isDeleted: Value(isDeleted),
    );
  }

  factory ProductsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductsTableData(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      sku: serializer.fromJson<String>(json['sku']),
      price: serializer.fromJson<double>(json['price']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      pdfVisualAidUrl: serializer.fromJson<String?>(json['pdfVisualAidUrl']),
      isDiscontinued: serializer.fromJson<bool>(json['isDiscontinued']),
      isSampleEligible: serializer.fromJson<bool>(json['isSampleEligible']),
      clientCreatedAt: serializer.fromJson<DateTime>(json['clientCreatedAt']),
      lastModifiedAt: serializer.fromJson<DateTime>(json['lastModifiedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'sku': serializer.toJson<String>(sku),
      'price': serializer.toJson<double>(price),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'pdfVisualAidUrl': serializer.toJson<String?>(pdfVisualAidUrl),
      'isDiscontinued': serializer.toJson<bool>(isDiscontinued),
      'isSampleEligible': serializer.toJson<bool>(isSampleEligible),
      'clientCreatedAt': serializer.toJson<DateTime>(clientCreatedAt),
      'lastModifiedAt': serializer.toJson<DateTime>(lastModifiedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  ProductsTableData copyWith(
          {String? id,
          String? tenantId,
          String? name,
          String? category,
          String? sku,
          double? price,
          Value<String?> imageUrl = const Value.absent(),
          Value<String?> pdfVisualAidUrl = const Value.absent(),
          bool? isDiscontinued,
          bool? isSampleEligible,
          DateTime? clientCreatedAt,
          DateTime? lastModifiedAt,
          bool? isDeleted}) =>
      ProductsTableData(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        name: name ?? this.name,
        category: category ?? this.category,
        sku: sku ?? this.sku,
        price: price ?? this.price,
        imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
        pdfVisualAidUrl: pdfVisualAidUrl.present
            ? pdfVisualAidUrl.value
            : this.pdfVisualAidUrl,
        isDiscontinued: isDiscontinued ?? this.isDiscontinued,
        isSampleEligible: isSampleEligible ?? this.isSampleEligible,
        clientCreatedAt: clientCreatedAt ?? this.clientCreatedAt,
        lastModifiedAt: lastModifiedAt ?? this.lastModifiedAt,
        isDeleted: isDeleted ?? this.isDeleted,
      );
  ProductsTableData copyWithCompanion(ProductsTableCompanion data) {
    return ProductsTableData(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      sku: data.sku.present ? data.sku.value : this.sku,
      price: data.price.present ? data.price.value : this.price,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      pdfVisualAidUrl: data.pdfVisualAidUrl.present
          ? data.pdfVisualAidUrl.value
          : this.pdfVisualAidUrl,
      isDiscontinued: data.isDiscontinued.present
          ? data.isDiscontinued.value
          : this.isDiscontinued,
      isSampleEligible: data.isSampleEligible.present
          ? data.isSampleEligible.value
          : this.isSampleEligible,
      clientCreatedAt: data.clientCreatedAt.present
          ? data.clientCreatedAt.value
          : this.clientCreatedAt,
      lastModifiedAt: data.lastModifiedAt.present
          ? data.lastModifiedAt.value
          : this.lastModifiedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductsTableData(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('sku: $sku, ')
          ..write('price: $price, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('pdfVisualAidUrl: $pdfVisualAidUrl, ')
          ..write('isDiscontinued: $isDiscontinued, ')
          ..write('isSampleEligible: $isSampleEligible, ')
          ..write('clientCreatedAt: $clientCreatedAt, ')
          ..write('lastModifiedAt: $lastModifiedAt, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      tenantId,
      name,
      category,
      sku,
      price,
      imageUrl,
      pdfVisualAidUrl,
      isDiscontinued,
      isSampleEligible,
      clientCreatedAt,
      lastModifiedAt,
      isDeleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductsTableData &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.name == this.name &&
          other.category == this.category &&
          other.sku == this.sku &&
          other.price == this.price &&
          other.imageUrl == this.imageUrl &&
          other.pdfVisualAidUrl == this.pdfVisualAidUrl &&
          other.isDiscontinued == this.isDiscontinued &&
          other.isSampleEligible == this.isSampleEligible &&
          other.clientCreatedAt == this.clientCreatedAt &&
          other.lastModifiedAt == this.lastModifiedAt &&
          other.isDeleted == this.isDeleted);
}

class ProductsTableCompanion extends UpdateCompanion<ProductsTableData> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> name;
  final Value<String> category;
  final Value<String> sku;
  final Value<double> price;
  final Value<String?> imageUrl;
  final Value<String?> pdfVisualAidUrl;
  final Value<bool> isDiscontinued;
  final Value<bool> isSampleEligible;
  final Value<DateTime> clientCreatedAt;
  final Value<DateTime> lastModifiedAt;
  final Value<bool> isDeleted;
  final Value<int> rowid;
  const ProductsTableCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.sku = const Value.absent(),
    this.price = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.pdfVisualAidUrl = const Value.absent(),
    this.isDiscontinued = const Value.absent(),
    this.isSampleEligible = const Value.absent(),
    this.clientCreatedAt = const Value.absent(),
    this.lastModifiedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductsTableCompanion.insert({
    required String id,
    required String tenantId,
    required String name,
    required String category,
    required String sku,
    required double price,
    this.imageUrl = const Value.absent(),
    this.pdfVisualAidUrl = const Value.absent(),
    this.isDiscontinued = const Value.absent(),
    this.isSampleEligible = const Value.absent(),
    required DateTime clientCreatedAt,
    this.lastModifiedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tenantId = Value(tenantId),
        name = Value(name),
        category = Value(category),
        sku = Value(sku),
        price = Value(price),
        clientCreatedAt = Value(clientCreatedAt);
  static Insertable<ProductsTableData> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? sku,
    Expression<double>? price,
    Expression<String>? imageUrl,
    Expression<String>? pdfVisualAidUrl,
    Expression<bool>? isDiscontinued,
    Expression<bool>? isSampleEligible,
    Expression<DateTime>? clientCreatedAt,
    Expression<DateTime>? lastModifiedAt,
    Expression<bool>? isDeleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (sku != null) 'sku': sku,
      if (price != null) 'price': price,
      if (imageUrl != null) 'image_url': imageUrl,
      if (pdfVisualAidUrl != null) 'pdf_visual_aid_url': pdfVisualAidUrl,
      if (isDiscontinued != null) 'is_discontinued': isDiscontinued,
      if (isSampleEligible != null) 'is_sample_eligible': isSampleEligible,
      if (clientCreatedAt != null) 'client_created_at': clientCreatedAt,
      if (lastModifiedAt != null) 'last_modified_at': lastModifiedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String>? name,
      Value<String>? category,
      Value<String>? sku,
      Value<double>? price,
      Value<String?>? imageUrl,
      Value<String?>? pdfVisualAidUrl,
      Value<bool>? isDiscontinued,
      Value<bool>? isSampleEligible,
      Value<DateTime>? clientCreatedAt,
      Value<DateTime>? lastModifiedAt,
      Value<bool>? isDeleted,
      Value<int>? rowid}) {
    return ProductsTableCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      name: name ?? this.name,
      category: category ?? this.category,
      sku: sku ?? this.sku,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      pdfVisualAidUrl: pdfVisualAidUrl ?? this.pdfVisualAidUrl,
      isDiscontinued: isDiscontinued ?? this.isDiscontinued,
      isSampleEligible: isSampleEligible ?? this.isSampleEligible,
      clientCreatedAt: clientCreatedAt ?? this.clientCreatedAt,
      lastModifiedAt: lastModifiedAt ?? this.lastModifiedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (pdfVisualAidUrl.present) {
      map['pdf_visual_aid_url'] = Variable<String>(pdfVisualAidUrl.value);
    }
    if (isDiscontinued.present) {
      map['is_discontinued'] = Variable<bool>(isDiscontinued.value);
    }
    if (isSampleEligible.present) {
      map['is_sample_eligible'] = Variable<bool>(isSampleEligible.value);
    }
    if (clientCreatedAt.present) {
      map['client_created_at'] = Variable<DateTime>(clientCreatedAt.value);
    }
    if (lastModifiedAt.present) {
      map['last_modified_at'] = Variable<DateTime>(lastModifiedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
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
          ..write('tenantId: $tenantId, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('sku: $sku, ')
          ..write('price: $price, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('pdfVisualAidUrl: $pdfVisualAidUrl, ')
          ..write('isDiscontinued: $isDiscontinued, ')
          ..write('isSampleEligible: $isSampleEligible, ')
          ..write('clientCreatedAt: $clientCreatedAt, ')
          ..write('lastModifiedAt: $lastModifiedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PriceHistoryTableTable extends PriceHistoryTable
    with TableInfo<$PriceHistoryTableTable, PriceHistoryTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PriceHistoryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
      'product_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
      'price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _effectiveFromMeta =
      const VerificationMeta('effectiveFrom');
  @override
  late final GeneratedColumn<DateTime> effectiveFrom =
      GeneratedColumn<DateTime>('effective_from', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, productId, price, effectiveFrom];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'price_history_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<PriceHistoryTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('effective_from')) {
      context.handle(
          _effectiveFromMeta,
          effectiveFrom.isAcceptableOrUnknown(
              data['effective_from']!, _effectiveFromMeta));
    } else if (isInserting) {
      context.missing(_effectiveFromMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PriceHistoryTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PriceHistoryTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_id'])!,
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}price'])!,
      effectiveFrom: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}effective_from'])!,
    );
  }

  @override
  $PriceHistoryTableTable createAlias(String alias) {
    return $PriceHistoryTableTable(attachedDatabase, alias);
  }
}

class PriceHistoryTableData extends DataClass
    implements Insertable<PriceHistoryTableData> {
  final String id;
  final String productId;
  final double price;
  final DateTime effectiveFrom;
  const PriceHistoryTableData(
      {required this.id,
      required this.productId,
      required this.price,
      required this.effectiveFrom});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['product_id'] = Variable<String>(productId);
    map['price'] = Variable<double>(price);
    map['effective_from'] = Variable<DateTime>(effectiveFrom);
    return map;
  }

  PriceHistoryTableCompanion toCompanion(bool nullToAbsent) {
    return PriceHistoryTableCompanion(
      id: Value(id),
      productId: Value(productId),
      price: Value(price),
      effectiveFrom: Value(effectiveFrom),
    );
  }

  factory PriceHistoryTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PriceHistoryTableData(
      id: serializer.fromJson<String>(json['id']),
      productId: serializer.fromJson<String>(json['productId']),
      price: serializer.fromJson<double>(json['price']),
      effectiveFrom: serializer.fromJson<DateTime>(json['effectiveFrom']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'productId': serializer.toJson<String>(productId),
      'price': serializer.toJson<double>(price),
      'effectiveFrom': serializer.toJson<DateTime>(effectiveFrom),
    };
  }

  PriceHistoryTableData copyWith(
          {String? id,
          String? productId,
          double? price,
          DateTime? effectiveFrom}) =>
      PriceHistoryTableData(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        price: price ?? this.price,
        effectiveFrom: effectiveFrom ?? this.effectiveFrom,
      );
  PriceHistoryTableData copyWithCompanion(PriceHistoryTableCompanion data) {
    return PriceHistoryTableData(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      price: data.price.present ? data.price.value : this.price,
      effectiveFrom: data.effectiveFrom.present
          ? data.effectiveFrom.value
          : this.effectiveFrom,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PriceHistoryTableData(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('price: $price, ')
          ..write('effectiveFrom: $effectiveFrom')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, productId, price, effectiveFrom);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PriceHistoryTableData &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.price == this.price &&
          other.effectiveFrom == this.effectiveFrom);
}

class PriceHistoryTableCompanion
    extends UpdateCompanion<PriceHistoryTableData> {
  final Value<String> id;
  final Value<String> productId;
  final Value<double> price;
  final Value<DateTime> effectiveFrom;
  final Value<int> rowid;
  const PriceHistoryTableCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.price = const Value.absent(),
    this.effectiveFrom = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PriceHistoryTableCompanion.insert({
    required String id,
    required String productId,
    required double price,
    required DateTime effectiveFrom,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        productId = Value(productId),
        price = Value(price),
        effectiveFrom = Value(effectiveFrom);
  static Insertable<PriceHistoryTableData> custom({
    Expression<String>? id,
    Expression<String>? productId,
    Expression<double>? price,
    Expression<DateTime>? effectiveFrom,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (price != null) 'price': price,
      if (effectiveFrom != null) 'effective_from': effectiveFrom,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PriceHistoryTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? productId,
      Value<double>? price,
      Value<DateTime>? effectiveFrom,
      Value<int>? rowid}) {
    return PriceHistoryTableCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      price: price ?? this.price,
      effectiveFrom: effectiveFrom ?? this.effectiveFrom,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (effectiveFrom.present) {
      map['effective_from'] = Variable<DateTime>(effectiveFrom.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PriceHistoryTableCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('price: $price, ')
          ..write('effectiveFrom: $effectiveFrom, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TourPlansTableTable extends TourPlansTable
    with TableInfo<$TourPlansTableTable, TourPlansTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TourPlansTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tenantIdMeta =
      const VerificationMeta('tenantId');
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
      'tenant_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _repIdMeta = const VerificationMeta('repId');
  @override
  late final GeneratedColumn<String> repId = GeneratedColumn<String>(
      'rep_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _plannedDateMeta =
      const VerificationMeta('plannedDate');
  @override
  late final GeneratedColumn<DateTime> plannedDate = GeneratedColumn<DateTime>(
      'planned_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _routeOptimizationOrderMeta =
      const VerificationMeta('routeOptimizationOrder');
  @override
  late final GeneratedColumn<String> routeOptimizationOrder =
      GeneratedColumn<String>('route_optimization_order', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _managerCommentMeta =
      const VerificationMeta('managerComment');
  @override
  late final GeneratedColumn<String> managerComment = GeneratedColumn<String>(
      'manager_comment', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _clientCreatedAtMeta =
      const VerificationMeta('clientCreatedAt');
  @override
  late final GeneratedColumn<DateTime> clientCreatedAt =
      GeneratedColumn<DateTime>('client_created_at', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _lastModifiedAtMeta =
      const VerificationMeta('lastModifiedAt');
  @override
  late final GeneratedColumn<DateTime> lastModifiedAt =
      GeneratedColumn<DateTime>('last_modified_at', aliasedName, false,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          defaultValue: currentDateAndTime);
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tenantId,
        repId,
        plannedDate,
        routeOptimizationOrder,
        status,
        managerComment,
        clientCreatedAt,
        lastModifiedAt,
        isDeleted
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tour_plans_table';
  @override
  VerificationContext validateIntegrity(Insertable<TourPlansTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(_tenantIdMeta,
          tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta));
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('rep_id')) {
      context.handle(
          _repIdMeta, repId.isAcceptableOrUnknown(data['rep_id']!, _repIdMeta));
    } else if (isInserting) {
      context.missing(_repIdMeta);
    }
    if (data.containsKey('planned_date')) {
      context.handle(
          _plannedDateMeta,
          plannedDate.isAcceptableOrUnknown(
              data['planned_date']!, _plannedDateMeta));
    } else if (isInserting) {
      context.missing(_plannedDateMeta);
    }
    if (data.containsKey('route_optimization_order')) {
      context.handle(
          _routeOptimizationOrderMeta,
          routeOptimizationOrder.isAcceptableOrUnknown(
              data['route_optimization_order']!, _routeOptimizationOrderMeta));
    } else if (isInserting) {
      context.missing(_routeOptimizationOrderMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('manager_comment')) {
      context.handle(
          _managerCommentMeta,
          managerComment.isAcceptableOrUnknown(
              data['manager_comment']!, _managerCommentMeta));
    }
    if (data.containsKey('client_created_at')) {
      context.handle(
          _clientCreatedAtMeta,
          clientCreatedAt.isAcceptableOrUnknown(
              data['client_created_at']!, _clientCreatedAtMeta));
    } else if (isInserting) {
      context.missing(_clientCreatedAtMeta);
    }
    if (data.containsKey('last_modified_at')) {
      context.handle(
          _lastModifiedAtMeta,
          lastModifiedAt.isAcceptableOrUnknown(
              data['last_modified_at']!, _lastModifiedAtMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TourPlansTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TourPlansTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      repId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}rep_id'])!,
      plannedDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}planned_date'])!,
      routeOptimizationOrder: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}route_optimization_order'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      managerComment: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}manager_comment']),
      clientCreatedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}client_created_at'])!,
      lastModifiedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_modified_at'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
    );
  }

  @override
  $TourPlansTableTable createAlias(String alias) {
    return $TourPlansTableTable(attachedDatabase, alias);
  }
}

class TourPlansTableData extends DataClass
    implements Insertable<TourPlansTableData> {
  final String id;
  final String tenantId;
  final String repId;
  final DateTime plannedDate;
  final String routeOptimizationOrder;
  final String status;
  final String? managerComment;
  final DateTime clientCreatedAt;
  final DateTime lastModifiedAt;
  final bool isDeleted;
  const TourPlansTableData(
      {required this.id,
      required this.tenantId,
      required this.repId,
      required this.plannedDate,
      required this.routeOptimizationOrder,
      required this.status,
      this.managerComment,
      required this.clientCreatedAt,
      required this.lastModifiedAt,
      required this.isDeleted});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['rep_id'] = Variable<String>(repId);
    map['planned_date'] = Variable<DateTime>(plannedDate);
    map['route_optimization_order'] = Variable<String>(routeOptimizationOrder);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || managerComment != null) {
      map['manager_comment'] = Variable<String>(managerComment);
    }
    map['client_created_at'] = Variable<DateTime>(clientCreatedAt);
    map['last_modified_at'] = Variable<DateTime>(lastModifiedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  TourPlansTableCompanion toCompanion(bool nullToAbsent) {
    return TourPlansTableCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      repId: Value(repId),
      plannedDate: Value(plannedDate),
      routeOptimizationOrder: Value(routeOptimizationOrder),
      status: Value(status),
      managerComment: managerComment == null && nullToAbsent
          ? const Value.absent()
          : Value(managerComment),
      clientCreatedAt: Value(clientCreatedAt),
      lastModifiedAt: Value(lastModifiedAt),
      isDeleted: Value(isDeleted),
    );
  }

  factory TourPlansTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TourPlansTableData(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      repId: serializer.fromJson<String>(json['repId']),
      plannedDate: serializer.fromJson<DateTime>(json['plannedDate']),
      routeOptimizationOrder:
          serializer.fromJson<String>(json['routeOptimizationOrder']),
      status: serializer.fromJson<String>(json['status']),
      managerComment: serializer.fromJson<String?>(json['managerComment']),
      clientCreatedAt: serializer.fromJson<DateTime>(json['clientCreatedAt']),
      lastModifiedAt: serializer.fromJson<DateTime>(json['lastModifiedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'repId': serializer.toJson<String>(repId),
      'plannedDate': serializer.toJson<DateTime>(plannedDate),
      'routeOptimizationOrder':
          serializer.toJson<String>(routeOptimizationOrder),
      'status': serializer.toJson<String>(status),
      'managerComment': serializer.toJson<String?>(managerComment),
      'clientCreatedAt': serializer.toJson<DateTime>(clientCreatedAt),
      'lastModifiedAt': serializer.toJson<DateTime>(lastModifiedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  TourPlansTableData copyWith(
          {String? id,
          String? tenantId,
          String? repId,
          DateTime? plannedDate,
          String? routeOptimizationOrder,
          String? status,
          Value<String?> managerComment = const Value.absent(),
          DateTime? clientCreatedAt,
          DateTime? lastModifiedAt,
          bool? isDeleted}) =>
      TourPlansTableData(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        repId: repId ?? this.repId,
        plannedDate: plannedDate ?? this.plannedDate,
        routeOptimizationOrder:
            routeOptimizationOrder ?? this.routeOptimizationOrder,
        status: status ?? this.status,
        managerComment:
            managerComment.present ? managerComment.value : this.managerComment,
        clientCreatedAt: clientCreatedAt ?? this.clientCreatedAt,
        lastModifiedAt: lastModifiedAt ?? this.lastModifiedAt,
        isDeleted: isDeleted ?? this.isDeleted,
      );
  TourPlansTableData copyWithCompanion(TourPlansTableCompanion data) {
    return TourPlansTableData(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      repId: data.repId.present ? data.repId.value : this.repId,
      plannedDate:
          data.plannedDate.present ? data.plannedDate.value : this.plannedDate,
      routeOptimizationOrder: data.routeOptimizationOrder.present
          ? data.routeOptimizationOrder.value
          : this.routeOptimizationOrder,
      status: data.status.present ? data.status.value : this.status,
      managerComment: data.managerComment.present
          ? data.managerComment.value
          : this.managerComment,
      clientCreatedAt: data.clientCreatedAt.present
          ? data.clientCreatedAt.value
          : this.clientCreatedAt,
      lastModifiedAt: data.lastModifiedAt.present
          ? data.lastModifiedAt.value
          : this.lastModifiedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TourPlansTableData(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('repId: $repId, ')
          ..write('plannedDate: $plannedDate, ')
          ..write('routeOptimizationOrder: $routeOptimizationOrder, ')
          ..write('status: $status, ')
          ..write('managerComment: $managerComment, ')
          ..write('clientCreatedAt: $clientCreatedAt, ')
          ..write('lastModifiedAt: $lastModifiedAt, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      tenantId,
      repId,
      plannedDate,
      routeOptimizationOrder,
      status,
      managerComment,
      clientCreatedAt,
      lastModifiedAt,
      isDeleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TourPlansTableData &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.repId == this.repId &&
          other.plannedDate == this.plannedDate &&
          other.routeOptimizationOrder == this.routeOptimizationOrder &&
          other.status == this.status &&
          other.managerComment == this.managerComment &&
          other.clientCreatedAt == this.clientCreatedAt &&
          other.lastModifiedAt == this.lastModifiedAt &&
          other.isDeleted == this.isDeleted);
}

class TourPlansTableCompanion extends UpdateCompanion<TourPlansTableData> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> repId;
  final Value<DateTime> plannedDate;
  final Value<String> routeOptimizationOrder;
  final Value<String> status;
  final Value<String?> managerComment;
  final Value<DateTime> clientCreatedAt;
  final Value<DateTime> lastModifiedAt;
  final Value<bool> isDeleted;
  final Value<int> rowid;
  const TourPlansTableCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.repId = const Value.absent(),
    this.plannedDate = const Value.absent(),
    this.routeOptimizationOrder = const Value.absent(),
    this.status = const Value.absent(),
    this.managerComment = const Value.absent(),
    this.clientCreatedAt = const Value.absent(),
    this.lastModifiedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TourPlansTableCompanion.insert({
    required String id,
    required String tenantId,
    required String repId,
    required DateTime plannedDate,
    required String routeOptimizationOrder,
    required String status,
    this.managerComment = const Value.absent(),
    required DateTime clientCreatedAt,
    this.lastModifiedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tenantId = Value(tenantId),
        repId = Value(repId),
        plannedDate = Value(plannedDate),
        routeOptimizationOrder = Value(routeOptimizationOrder),
        status = Value(status),
        clientCreatedAt = Value(clientCreatedAt);
  static Insertable<TourPlansTableData> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? repId,
    Expression<DateTime>? plannedDate,
    Expression<String>? routeOptimizationOrder,
    Expression<String>? status,
    Expression<String>? managerComment,
    Expression<DateTime>? clientCreatedAt,
    Expression<DateTime>? lastModifiedAt,
    Expression<bool>? isDeleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (repId != null) 'rep_id': repId,
      if (plannedDate != null) 'planned_date': plannedDate,
      if (routeOptimizationOrder != null)
        'route_optimization_order': routeOptimizationOrder,
      if (status != null) 'status': status,
      if (managerComment != null) 'manager_comment': managerComment,
      if (clientCreatedAt != null) 'client_created_at': clientCreatedAt,
      if (lastModifiedAt != null) 'last_modified_at': lastModifiedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TourPlansTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String>? repId,
      Value<DateTime>? plannedDate,
      Value<String>? routeOptimizationOrder,
      Value<String>? status,
      Value<String?>? managerComment,
      Value<DateTime>? clientCreatedAt,
      Value<DateTime>? lastModifiedAt,
      Value<bool>? isDeleted,
      Value<int>? rowid}) {
    return TourPlansTableCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      repId: repId ?? this.repId,
      plannedDate: plannedDate ?? this.plannedDate,
      routeOptimizationOrder:
          routeOptimizationOrder ?? this.routeOptimizationOrder,
      status: status ?? this.status,
      managerComment: managerComment ?? this.managerComment,
      clientCreatedAt: clientCreatedAt ?? this.clientCreatedAt,
      lastModifiedAt: lastModifiedAt ?? this.lastModifiedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (repId.present) {
      map['rep_id'] = Variable<String>(repId.value);
    }
    if (plannedDate.present) {
      map['planned_date'] = Variable<DateTime>(plannedDate.value);
    }
    if (routeOptimizationOrder.present) {
      map['route_optimization_order'] =
          Variable<String>(routeOptimizationOrder.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (managerComment.present) {
      map['manager_comment'] = Variable<String>(managerComment.value);
    }
    if (clientCreatedAt.present) {
      map['client_created_at'] = Variable<DateTime>(clientCreatedAt.value);
    }
    if (lastModifiedAt.present) {
      map['last_modified_at'] = Variable<DateTime>(lastModifiedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TourPlansTableCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('repId: $repId, ')
          ..write('plannedDate: $plannedDate, ')
          ..write('routeOptimizationOrder: $routeOptimizationOrder, ')
          ..write('status: $status, ')
          ..write('managerComment: $managerComment, ')
          ..write('clientCreatedAt: $clientCreatedAt, ')
          ..write('lastModifiedAt: $lastModifiedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TourPlanStopsTableTable extends TourPlanStopsTable
    with TableInfo<$TourPlanStopsTableTable, TourPlanStopsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TourPlanStopsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tourPlanIdMeta =
      const VerificationMeta('tourPlanId');
  @override
  late final GeneratedColumn<String> tourPlanId = GeneratedColumn<String>(
      'tour_plan_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _targetTypeMeta =
      const VerificationMeta('targetType');
  @override
  late final GeneratedColumn<String> targetType = GeneratedColumn<String>(
      'target_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _targetIdMeta =
      const VerificationMeta('targetId');
  @override
  late final GeneratedColumn<String> targetId = GeneratedColumn<String>(
      'target_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sequenceOrderMeta =
      const VerificationMeta('sequenceOrder');
  @override
  late final GeneratedColumn<int> sequenceOrder = GeneratedColumn<int>(
      'sequence_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _checkedInMeta =
      const VerificationMeta('checkedIn');
  @override
  late final GeneratedColumn<bool> checkedIn = GeneratedColumn<bool>(
      'checked_in', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("checked_in" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _checkInTimeMeta =
      const VerificationMeta('checkInTime');
  @override
  late final GeneratedColumn<DateTime> checkInTime = GeneratedColumn<DateTime>(
      'check_in_time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _checkInLatitudeMeta =
      const VerificationMeta('checkInLatitude');
  @override
  late final GeneratedColumn<double> checkInLatitude = GeneratedColumn<double>(
      'check_in_latitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _checkInLongitudeMeta =
      const VerificationMeta('checkInLongitude');
  @override
  late final GeneratedColumn<double> checkInLongitude = GeneratedColumn<double>(
      'check_in_longitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _deviationReasonMeta =
      const VerificationMeta('deviationReason');
  @override
  late final GeneratedColumn<String> deviationReason = GeneratedColumn<String>(
      'deviation_reason', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tourPlanId,
        targetType,
        targetId,
        sequenceOrder,
        checkedIn,
        checkInTime,
        checkInLatitude,
        checkInLongitude,
        deviationReason
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tour_plan_stops_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<TourPlanStopsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tour_plan_id')) {
      context.handle(
          _tourPlanIdMeta,
          tourPlanId.isAcceptableOrUnknown(
              data['tour_plan_id']!, _tourPlanIdMeta));
    } else if (isInserting) {
      context.missing(_tourPlanIdMeta);
    }
    if (data.containsKey('target_type')) {
      context.handle(
          _targetTypeMeta,
          targetType.isAcceptableOrUnknown(
              data['target_type']!, _targetTypeMeta));
    } else if (isInserting) {
      context.missing(_targetTypeMeta);
    }
    if (data.containsKey('target_id')) {
      context.handle(_targetIdMeta,
          targetId.isAcceptableOrUnknown(data['target_id']!, _targetIdMeta));
    } else if (isInserting) {
      context.missing(_targetIdMeta);
    }
    if (data.containsKey('sequence_order')) {
      context.handle(
          _sequenceOrderMeta,
          sequenceOrder.isAcceptableOrUnknown(
              data['sequence_order']!, _sequenceOrderMeta));
    } else if (isInserting) {
      context.missing(_sequenceOrderMeta);
    }
    if (data.containsKey('checked_in')) {
      context.handle(_checkedInMeta,
          checkedIn.isAcceptableOrUnknown(data['checked_in']!, _checkedInMeta));
    }
    if (data.containsKey('check_in_time')) {
      context.handle(
          _checkInTimeMeta,
          checkInTime.isAcceptableOrUnknown(
              data['check_in_time']!, _checkInTimeMeta));
    }
    if (data.containsKey('check_in_latitude')) {
      context.handle(
          _checkInLatitudeMeta,
          checkInLatitude.isAcceptableOrUnknown(
              data['check_in_latitude']!, _checkInLatitudeMeta));
    }
    if (data.containsKey('check_in_longitude')) {
      context.handle(
          _checkInLongitudeMeta,
          checkInLongitude.isAcceptableOrUnknown(
              data['check_in_longitude']!, _checkInLongitudeMeta));
    }
    if (data.containsKey('deviation_reason')) {
      context.handle(
          _deviationReasonMeta,
          deviationReason.isAcceptableOrUnknown(
              data['deviation_reason']!, _deviationReasonMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TourPlanStopsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TourPlanStopsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tourPlanId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tour_plan_id'])!,
      targetType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}target_type'])!,
      targetId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}target_id'])!,
      sequenceOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sequence_order'])!,
      checkedIn: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}checked_in'])!,
      checkInTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}check_in_time']),
      checkInLatitude: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}check_in_latitude']),
      checkInLongitude: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}check_in_longitude']),
      deviationReason: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}deviation_reason']),
    );
  }

  @override
  $TourPlanStopsTableTable createAlias(String alias) {
    return $TourPlanStopsTableTable(attachedDatabase, alias);
  }
}

class TourPlanStopsTableData extends DataClass
    implements Insertable<TourPlanStopsTableData> {
  final String id;
  final String tourPlanId;
  final String targetType;
  final String targetId;
  final int sequenceOrder;
  final bool checkedIn;
  final DateTime? checkInTime;
  final double? checkInLatitude;
  final double? checkInLongitude;
  final String? deviationReason;
  const TourPlanStopsTableData(
      {required this.id,
      required this.tourPlanId,
      required this.targetType,
      required this.targetId,
      required this.sequenceOrder,
      required this.checkedIn,
      this.checkInTime,
      this.checkInLatitude,
      this.checkInLongitude,
      this.deviationReason});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tour_plan_id'] = Variable<String>(tourPlanId);
    map['target_type'] = Variable<String>(targetType);
    map['target_id'] = Variable<String>(targetId);
    map['sequence_order'] = Variable<int>(sequenceOrder);
    map['checked_in'] = Variable<bool>(checkedIn);
    if (!nullToAbsent || checkInTime != null) {
      map['check_in_time'] = Variable<DateTime>(checkInTime);
    }
    if (!nullToAbsent || checkInLatitude != null) {
      map['check_in_latitude'] = Variable<double>(checkInLatitude);
    }
    if (!nullToAbsent || checkInLongitude != null) {
      map['check_in_longitude'] = Variable<double>(checkInLongitude);
    }
    if (!nullToAbsent || deviationReason != null) {
      map['deviation_reason'] = Variable<String>(deviationReason);
    }
    return map;
  }

  TourPlanStopsTableCompanion toCompanion(bool nullToAbsent) {
    return TourPlanStopsTableCompanion(
      id: Value(id),
      tourPlanId: Value(tourPlanId),
      targetType: Value(targetType),
      targetId: Value(targetId),
      sequenceOrder: Value(sequenceOrder),
      checkedIn: Value(checkedIn),
      checkInTime: checkInTime == null && nullToAbsent
          ? const Value.absent()
          : Value(checkInTime),
      checkInLatitude: checkInLatitude == null && nullToAbsent
          ? const Value.absent()
          : Value(checkInLatitude),
      checkInLongitude: checkInLongitude == null && nullToAbsent
          ? const Value.absent()
          : Value(checkInLongitude),
      deviationReason: deviationReason == null && nullToAbsent
          ? const Value.absent()
          : Value(deviationReason),
    );
  }

  factory TourPlanStopsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TourPlanStopsTableData(
      id: serializer.fromJson<String>(json['id']),
      tourPlanId: serializer.fromJson<String>(json['tourPlanId']),
      targetType: serializer.fromJson<String>(json['targetType']),
      targetId: serializer.fromJson<String>(json['targetId']),
      sequenceOrder: serializer.fromJson<int>(json['sequenceOrder']),
      checkedIn: serializer.fromJson<bool>(json['checkedIn']),
      checkInTime: serializer.fromJson<DateTime?>(json['checkInTime']),
      checkInLatitude: serializer.fromJson<double?>(json['checkInLatitude']),
      checkInLongitude: serializer.fromJson<double?>(json['checkInLongitude']),
      deviationReason: serializer.fromJson<String?>(json['deviationReason']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tourPlanId': serializer.toJson<String>(tourPlanId),
      'targetType': serializer.toJson<String>(targetType),
      'targetId': serializer.toJson<String>(targetId),
      'sequenceOrder': serializer.toJson<int>(sequenceOrder),
      'checkedIn': serializer.toJson<bool>(checkedIn),
      'checkInTime': serializer.toJson<DateTime?>(checkInTime),
      'checkInLatitude': serializer.toJson<double?>(checkInLatitude),
      'checkInLongitude': serializer.toJson<double?>(checkInLongitude),
      'deviationReason': serializer.toJson<String?>(deviationReason),
    };
  }

  TourPlanStopsTableData copyWith(
          {String? id,
          String? tourPlanId,
          String? targetType,
          String? targetId,
          int? sequenceOrder,
          bool? checkedIn,
          Value<DateTime?> checkInTime = const Value.absent(),
          Value<double?> checkInLatitude = const Value.absent(),
          Value<double?> checkInLongitude = const Value.absent(),
          Value<String?> deviationReason = const Value.absent()}) =>
      TourPlanStopsTableData(
        id: id ?? this.id,
        tourPlanId: tourPlanId ?? this.tourPlanId,
        targetType: targetType ?? this.targetType,
        targetId: targetId ?? this.targetId,
        sequenceOrder: sequenceOrder ?? this.sequenceOrder,
        checkedIn: checkedIn ?? this.checkedIn,
        checkInTime: checkInTime.present ? checkInTime.value : this.checkInTime,
        checkInLatitude: checkInLatitude.present
            ? checkInLatitude.value
            : this.checkInLatitude,
        checkInLongitude: checkInLongitude.present
            ? checkInLongitude.value
            : this.checkInLongitude,
        deviationReason: deviationReason.present
            ? deviationReason.value
            : this.deviationReason,
      );
  TourPlanStopsTableData copyWithCompanion(TourPlanStopsTableCompanion data) {
    return TourPlanStopsTableData(
      id: data.id.present ? data.id.value : this.id,
      tourPlanId:
          data.tourPlanId.present ? data.tourPlanId.value : this.tourPlanId,
      targetType:
          data.targetType.present ? data.targetType.value : this.targetType,
      targetId: data.targetId.present ? data.targetId.value : this.targetId,
      sequenceOrder: data.sequenceOrder.present
          ? data.sequenceOrder.value
          : this.sequenceOrder,
      checkedIn: data.checkedIn.present ? data.checkedIn.value : this.checkedIn,
      checkInTime:
          data.checkInTime.present ? data.checkInTime.value : this.checkInTime,
      checkInLatitude: data.checkInLatitude.present
          ? data.checkInLatitude.value
          : this.checkInLatitude,
      checkInLongitude: data.checkInLongitude.present
          ? data.checkInLongitude.value
          : this.checkInLongitude,
      deviationReason: data.deviationReason.present
          ? data.deviationReason.value
          : this.deviationReason,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TourPlanStopsTableData(')
          ..write('id: $id, ')
          ..write('tourPlanId: $tourPlanId, ')
          ..write('targetType: $targetType, ')
          ..write('targetId: $targetId, ')
          ..write('sequenceOrder: $sequenceOrder, ')
          ..write('checkedIn: $checkedIn, ')
          ..write('checkInTime: $checkInTime, ')
          ..write('checkInLatitude: $checkInLatitude, ')
          ..write('checkInLongitude: $checkInLongitude, ')
          ..write('deviationReason: $deviationReason')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      tourPlanId,
      targetType,
      targetId,
      sequenceOrder,
      checkedIn,
      checkInTime,
      checkInLatitude,
      checkInLongitude,
      deviationReason);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TourPlanStopsTableData &&
          other.id == this.id &&
          other.tourPlanId == this.tourPlanId &&
          other.targetType == this.targetType &&
          other.targetId == this.targetId &&
          other.sequenceOrder == this.sequenceOrder &&
          other.checkedIn == this.checkedIn &&
          other.checkInTime == this.checkInTime &&
          other.checkInLatitude == this.checkInLatitude &&
          other.checkInLongitude == this.checkInLongitude &&
          other.deviationReason == this.deviationReason);
}

class TourPlanStopsTableCompanion
    extends UpdateCompanion<TourPlanStopsTableData> {
  final Value<String> id;
  final Value<String> tourPlanId;
  final Value<String> targetType;
  final Value<String> targetId;
  final Value<int> sequenceOrder;
  final Value<bool> checkedIn;
  final Value<DateTime?> checkInTime;
  final Value<double?> checkInLatitude;
  final Value<double?> checkInLongitude;
  final Value<String?> deviationReason;
  final Value<int> rowid;
  const TourPlanStopsTableCompanion({
    this.id = const Value.absent(),
    this.tourPlanId = const Value.absent(),
    this.targetType = const Value.absent(),
    this.targetId = const Value.absent(),
    this.sequenceOrder = const Value.absent(),
    this.checkedIn = const Value.absent(),
    this.checkInTime = const Value.absent(),
    this.checkInLatitude = const Value.absent(),
    this.checkInLongitude = const Value.absent(),
    this.deviationReason = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TourPlanStopsTableCompanion.insert({
    required String id,
    required String tourPlanId,
    required String targetType,
    required String targetId,
    required int sequenceOrder,
    this.checkedIn = const Value.absent(),
    this.checkInTime = const Value.absent(),
    this.checkInLatitude = const Value.absent(),
    this.checkInLongitude = const Value.absent(),
    this.deviationReason = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tourPlanId = Value(tourPlanId),
        targetType = Value(targetType),
        targetId = Value(targetId),
        sequenceOrder = Value(sequenceOrder);
  static Insertable<TourPlanStopsTableData> custom({
    Expression<String>? id,
    Expression<String>? tourPlanId,
    Expression<String>? targetType,
    Expression<String>? targetId,
    Expression<int>? sequenceOrder,
    Expression<bool>? checkedIn,
    Expression<DateTime>? checkInTime,
    Expression<double>? checkInLatitude,
    Expression<double>? checkInLongitude,
    Expression<String>? deviationReason,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tourPlanId != null) 'tour_plan_id': tourPlanId,
      if (targetType != null) 'target_type': targetType,
      if (targetId != null) 'target_id': targetId,
      if (sequenceOrder != null) 'sequence_order': sequenceOrder,
      if (checkedIn != null) 'checked_in': checkedIn,
      if (checkInTime != null) 'check_in_time': checkInTime,
      if (checkInLatitude != null) 'check_in_latitude': checkInLatitude,
      if (checkInLongitude != null) 'check_in_longitude': checkInLongitude,
      if (deviationReason != null) 'deviation_reason': deviationReason,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TourPlanStopsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? tourPlanId,
      Value<String>? targetType,
      Value<String>? targetId,
      Value<int>? sequenceOrder,
      Value<bool>? checkedIn,
      Value<DateTime?>? checkInTime,
      Value<double?>? checkInLatitude,
      Value<double?>? checkInLongitude,
      Value<String?>? deviationReason,
      Value<int>? rowid}) {
    return TourPlanStopsTableCompanion(
      id: id ?? this.id,
      tourPlanId: tourPlanId ?? this.tourPlanId,
      targetType: targetType ?? this.targetType,
      targetId: targetId ?? this.targetId,
      sequenceOrder: sequenceOrder ?? this.sequenceOrder,
      checkedIn: checkedIn ?? this.checkedIn,
      checkInTime: checkInTime ?? this.checkInTime,
      checkInLatitude: checkInLatitude ?? this.checkInLatitude,
      checkInLongitude: checkInLongitude ?? this.checkInLongitude,
      deviationReason: deviationReason ?? this.deviationReason,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tourPlanId.present) {
      map['tour_plan_id'] = Variable<String>(tourPlanId.value);
    }
    if (targetType.present) {
      map['target_type'] = Variable<String>(targetType.value);
    }
    if (targetId.present) {
      map['target_id'] = Variable<String>(targetId.value);
    }
    if (sequenceOrder.present) {
      map['sequence_order'] = Variable<int>(sequenceOrder.value);
    }
    if (checkedIn.present) {
      map['checked_in'] = Variable<bool>(checkedIn.value);
    }
    if (checkInTime.present) {
      map['check_in_time'] = Variable<DateTime>(checkInTime.value);
    }
    if (checkInLatitude.present) {
      map['check_in_latitude'] = Variable<double>(checkInLatitude.value);
    }
    if (checkInLongitude.present) {
      map['check_in_longitude'] = Variable<double>(checkInLongitude.value);
    }
    if (deviationReason.present) {
      map['deviation_reason'] = Variable<String>(deviationReason.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TourPlanStopsTableCompanion(')
          ..write('id: $id, ')
          ..write('tourPlanId: $tourPlanId, ')
          ..write('targetType: $targetType, ')
          ..write('targetId: $targetId, ')
          ..write('sequenceOrder: $sequenceOrder, ')
          ..write('checkedIn: $checkedIn, ')
          ..write('checkInTime: $checkInTime, ')
          ..write('checkInLatitude: $checkInLatitude, ')
          ..write('checkInLongitude: $checkInLongitude, ')
          ..write('deviationReason: $deviationReason, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DcrsTableTable extends DcrsTable
    with TableInfo<$DcrsTableTable, DcrsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DcrsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _repIdMeta = const VerificationMeta('repId');
  @override
  late final GeneratedColumn<String> repId = GeneratedColumn<String>(
      'rep_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _managerCommentMeta =
      const VerificationMeta('managerComment');
  @override
  late final GeneratedColumn<String> managerComment = GeneratedColumn<String>(
      'manager_comment', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _voiceMemoUrlMeta =
      const VerificationMeta('voiceMemoUrl');
  @override
  late final GeneratedColumn<String> voiceMemoUrl = GeneratedColumn<String>(
      'voice_memo_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _submittedAtMeta =
      const VerificationMeta('submittedAt');
  @override
  late final GeneratedColumn<DateTime> submittedAt = GeneratedColumn<DateTime>(
      'submitted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        repId,
        date,
        status,
        managerComment,
        voiceMemoUrl,
        submittedAt,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dcrs_table';
  @override
  VerificationContext validateIntegrity(Insertable<DcrsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('rep_id')) {
      context.handle(
          _repIdMeta, repId.isAcceptableOrUnknown(data['rep_id']!, _repIdMeta));
    } else if (isInserting) {
      context.missing(_repIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('manager_comment')) {
      context.handle(
          _managerCommentMeta,
          managerComment.isAcceptableOrUnknown(
              data['manager_comment']!, _managerCommentMeta));
    }
    if (data.containsKey('voice_memo_url')) {
      context.handle(
          _voiceMemoUrlMeta,
          voiceMemoUrl.isAcceptableOrUnknown(
              data['voice_memo_url']!, _voiceMemoUrlMeta));
    }
    if (data.containsKey('submitted_at')) {
      context.handle(
          _submittedAtMeta,
          submittedAt.isAcceptableOrUnknown(
              data['submitted_at']!, _submittedAtMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DcrsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DcrsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      repId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}rep_id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      managerComment: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}manager_comment']),
      voiceMemoUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}voice_memo_url']),
      submittedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}submitted_at']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $DcrsTableTable createAlias(String alias) {
    return $DcrsTableTable(attachedDatabase, alias);
  }
}

class DcrsTableData extends DataClass implements Insertable<DcrsTableData> {
  final String id;
  final String repId;
  final DateTime date;
  final String status;
  final String? managerComment;
  final String? voiceMemoUrl;
  final DateTime? submittedAt;
  final DateTime createdAt;
  const DcrsTableData(
      {required this.id,
      required this.repId,
      required this.date,
      required this.status,
      this.managerComment,
      this.voiceMemoUrl,
      this.submittedAt,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['rep_id'] = Variable<String>(repId);
    map['date'] = Variable<DateTime>(date);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || managerComment != null) {
      map['manager_comment'] = Variable<String>(managerComment);
    }
    if (!nullToAbsent || voiceMemoUrl != null) {
      map['voice_memo_url'] = Variable<String>(voiceMemoUrl);
    }
    if (!nullToAbsent || submittedAt != null) {
      map['submitted_at'] = Variable<DateTime>(submittedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DcrsTableCompanion toCompanion(bool nullToAbsent) {
    return DcrsTableCompanion(
      id: Value(id),
      repId: Value(repId),
      date: Value(date),
      status: Value(status),
      managerComment: managerComment == null && nullToAbsent
          ? const Value.absent()
          : Value(managerComment),
      voiceMemoUrl: voiceMemoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(voiceMemoUrl),
      submittedAt: submittedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(submittedAt),
      createdAt: Value(createdAt),
    );
  }

  factory DcrsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DcrsTableData(
      id: serializer.fromJson<String>(json['id']),
      repId: serializer.fromJson<String>(json['repId']),
      date: serializer.fromJson<DateTime>(json['date']),
      status: serializer.fromJson<String>(json['status']),
      managerComment: serializer.fromJson<String?>(json['managerComment']),
      voiceMemoUrl: serializer.fromJson<String?>(json['voiceMemoUrl']),
      submittedAt: serializer.fromJson<DateTime?>(json['submittedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'repId': serializer.toJson<String>(repId),
      'date': serializer.toJson<DateTime>(date),
      'status': serializer.toJson<String>(status),
      'managerComment': serializer.toJson<String?>(managerComment),
      'voiceMemoUrl': serializer.toJson<String?>(voiceMemoUrl),
      'submittedAt': serializer.toJson<DateTime?>(submittedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DcrsTableData copyWith(
          {String? id,
          String? repId,
          DateTime? date,
          String? status,
          Value<String?> managerComment = const Value.absent(),
          Value<String?> voiceMemoUrl = const Value.absent(),
          Value<DateTime?> submittedAt = const Value.absent(),
          DateTime? createdAt}) =>
      DcrsTableData(
        id: id ?? this.id,
        repId: repId ?? this.repId,
        date: date ?? this.date,
        status: status ?? this.status,
        managerComment:
            managerComment.present ? managerComment.value : this.managerComment,
        voiceMemoUrl:
            voiceMemoUrl.present ? voiceMemoUrl.value : this.voiceMemoUrl,
        submittedAt: submittedAt.present ? submittedAt.value : this.submittedAt,
        createdAt: createdAt ?? this.createdAt,
      );
  DcrsTableData copyWithCompanion(DcrsTableCompanion data) {
    return DcrsTableData(
      id: data.id.present ? data.id.value : this.id,
      repId: data.repId.present ? data.repId.value : this.repId,
      date: data.date.present ? data.date.value : this.date,
      status: data.status.present ? data.status.value : this.status,
      managerComment: data.managerComment.present
          ? data.managerComment.value
          : this.managerComment,
      voiceMemoUrl: data.voiceMemoUrl.present
          ? data.voiceMemoUrl.value
          : this.voiceMemoUrl,
      submittedAt:
          data.submittedAt.present ? data.submittedAt.value : this.submittedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DcrsTableData(')
          ..write('id: $id, ')
          ..write('repId: $repId, ')
          ..write('date: $date, ')
          ..write('status: $status, ')
          ..write('managerComment: $managerComment, ')
          ..write('voiceMemoUrl: $voiceMemoUrl, ')
          ..write('submittedAt: $submittedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, repId, date, status, managerComment,
      voiceMemoUrl, submittedAt, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DcrsTableData &&
          other.id == this.id &&
          other.repId == this.repId &&
          other.date == this.date &&
          other.status == this.status &&
          other.managerComment == this.managerComment &&
          other.voiceMemoUrl == this.voiceMemoUrl &&
          other.submittedAt == this.submittedAt &&
          other.createdAt == this.createdAt);
}

class DcrsTableCompanion extends UpdateCompanion<DcrsTableData> {
  final Value<String> id;
  final Value<String> repId;
  final Value<DateTime> date;
  final Value<String> status;
  final Value<String?> managerComment;
  final Value<String?> voiceMemoUrl;
  final Value<DateTime?> submittedAt;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const DcrsTableCompanion({
    this.id = const Value.absent(),
    this.repId = const Value.absent(),
    this.date = const Value.absent(),
    this.status = const Value.absent(),
    this.managerComment = const Value.absent(),
    this.voiceMemoUrl = const Value.absent(),
    this.submittedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DcrsTableCompanion.insert({
    required String id,
    required String repId,
    required DateTime date,
    required String status,
    this.managerComment = const Value.absent(),
    this.voiceMemoUrl = const Value.absent(),
    this.submittedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        repId = Value(repId),
        date = Value(date),
        status = Value(status);
  static Insertable<DcrsTableData> custom({
    Expression<String>? id,
    Expression<String>? repId,
    Expression<DateTime>? date,
    Expression<String>? status,
    Expression<String>? managerComment,
    Expression<String>? voiceMemoUrl,
    Expression<DateTime>? submittedAt,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (repId != null) 'rep_id': repId,
      if (date != null) 'date': date,
      if (status != null) 'status': status,
      if (managerComment != null) 'manager_comment': managerComment,
      if (voiceMemoUrl != null) 'voice_memo_url': voiceMemoUrl,
      if (submittedAt != null) 'submitted_at': submittedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DcrsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? repId,
      Value<DateTime>? date,
      Value<String>? status,
      Value<String?>? managerComment,
      Value<String?>? voiceMemoUrl,
      Value<DateTime?>? submittedAt,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return DcrsTableCompanion(
      id: id ?? this.id,
      repId: repId ?? this.repId,
      date: date ?? this.date,
      status: status ?? this.status,
      managerComment: managerComment ?? this.managerComment,
      voiceMemoUrl: voiceMemoUrl ?? this.voiceMemoUrl,
      submittedAt: submittedAt ?? this.submittedAt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (repId.present) {
      map['rep_id'] = Variable<String>(repId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (managerComment.present) {
      map['manager_comment'] = Variable<String>(managerComment.value);
    }
    if (voiceMemoUrl.present) {
      map['voice_memo_url'] = Variable<String>(voiceMemoUrl.value);
    }
    if (submittedAt.present) {
      map['submitted_at'] = Variable<DateTime>(submittedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DcrsTableCompanion(')
          ..write('id: $id, ')
          ..write('repId: $repId, ')
          ..write('date: $date, ')
          ..write('status: $status, ')
          ..write('managerComment: $managerComment, ')
          ..write('voiceMemoUrl: $voiceMemoUrl, ')
          ..write('submittedAt: $submittedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DcrDoctorVisitsTableTable extends DcrDoctorVisitsTable
    with TableInfo<$DcrDoctorVisitsTableTable, DcrDoctorVisitsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DcrDoctorVisitsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dcrIdMeta = const VerificationMeta('dcrId');
  @override
  late final GeneratedColumn<String> dcrId = GeneratedColumn<String>(
      'dcr_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _doctorIdMeta =
      const VerificationMeta('doctorId');
  @override
  late final GeneratedColumn<String> doctorId = GeneratedColumn<String>(
      'doctor_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sessionMeta =
      const VerificationMeta('session');
  @override
  late final GeneratedColumn<String> session = GeneratedColumn<String>(
      'session', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _visitTimeMeta =
      const VerificationMeta('visitTime');
  @override
  late final GeneratedColumn<DateTime> visitTime = GeneratedColumn<DateTime>(
      'visit_time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _callOutcomeMeta =
      const VerificationMeta('callOutcome');
  @override
  late final GeneratedColumn<String> callOutcome = GeneratedColumn<String>(
      'call_outcome', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _gpsLatMeta = const VerificationMeta('gpsLat');
  @override
  late final GeneratedColumn<double> gpsLat = GeneratedColumn<double>(
      'gps_lat', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _gpsLngMeta = const VerificationMeta('gpsLng');
  @override
  late final GeneratedColumn<double> gpsLng = GeneratedColumn<double>(
      'gps_lng', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _photoUrlMeta =
      const VerificationMeta('photoUrl');
  @override
  late final GeneratedColumn<String> photoUrl = GeneratedColumn<String>(
      'photo_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isPlannedMeta =
      const VerificationMeta('isPlanned');
  @override
  late final GeneratedColumn<bool> isPlanned = GeneratedColumn<bool>(
      'is_planned', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_planned" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        dcrId,
        doctorId,
        session,
        visitTime,
        callOutcome,
        notes,
        gpsLat,
        gpsLng,
        photoUrl,
        isPlanned,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dcr_doctor_visits_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<DcrDoctorVisitsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('dcr_id')) {
      context.handle(
          _dcrIdMeta, dcrId.isAcceptableOrUnknown(data['dcr_id']!, _dcrIdMeta));
    } else if (isInserting) {
      context.missing(_dcrIdMeta);
    }
    if (data.containsKey('doctor_id')) {
      context.handle(_doctorIdMeta,
          doctorId.isAcceptableOrUnknown(data['doctor_id']!, _doctorIdMeta));
    } else if (isInserting) {
      context.missing(_doctorIdMeta);
    }
    if (data.containsKey('session')) {
      context.handle(_sessionMeta,
          session.isAcceptableOrUnknown(data['session']!, _sessionMeta));
    } else if (isInserting) {
      context.missing(_sessionMeta);
    }
    if (data.containsKey('visit_time')) {
      context.handle(_visitTimeMeta,
          visitTime.isAcceptableOrUnknown(data['visit_time']!, _visitTimeMeta));
    }
    if (data.containsKey('call_outcome')) {
      context.handle(
          _callOutcomeMeta,
          callOutcome.isAcceptableOrUnknown(
              data['call_outcome']!, _callOutcomeMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('gps_lat')) {
      context.handle(_gpsLatMeta,
          gpsLat.isAcceptableOrUnknown(data['gps_lat']!, _gpsLatMeta));
    }
    if (data.containsKey('gps_lng')) {
      context.handle(_gpsLngMeta,
          gpsLng.isAcceptableOrUnknown(data['gps_lng']!, _gpsLngMeta));
    }
    if (data.containsKey('photo_url')) {
      context.handle(_photoUrlMeta,
          photoUrl.isAcceptableOrUnknown(data['photo_url']!, _photoUrlMeta));
    }
    if (data.containsKey('is_planned')) {
      context.handle(_isPlannedMeta,
          isPlanned.isAcceptableOrUnknown(data['is_planned']!, _isPlannedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DcrDoctorVisitsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DcrDoctorVisitsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      dcrId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dcr_id'])!,
      doctorId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}doctor_id'])!,
      session: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}session'])!,
      visitTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}visit_time']),
      callOutcome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}call_outcome']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      gpsLat: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}gps_lat']),
      gpsLng: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}gps_lng']),
      photoUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}photo_url']),
      isPlanned: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_planned'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $DcrDoctorVisitsTableTable createAlias(String alias) {
    return $DcrDoctorVisitsTableTable(attachedDatabase, alias);
  }
}

class DcrDoctorVisitsTableData extends DataClass
    implements Insertable<DcrDoctorVisitsTableData> {
  final String id;
  final String dcrId;
  final String doctorId;
  final String session;
  final DateTime? visitTime;
  final String? callOutcome;
  final String? notes;
  final double? gpsLat;
  final double? gpsLng;
  final String? photoUrl;
  final bool isPlanned;
  final DateTime createdAt;
  const DcrDoctorVisitsTableData(
      {required this.id,
      required this.dcrId,
      required this.doctorId,
      required this.session,
      this.visitTime,
      this.callOutcome,
      this.notes,
      this.gpsLat,
      this.gpsLng,
      this.photoUrl,
      required this.isPlanned,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['dcr_id'] = Variable<String>(dcrId);
    map['doctor_id'] = Variable<String>(doctorId);
    map['session'] = Variable<String>(session);
    if (!nullToAbsent || visitTime != null) {
      map['visit_time'] = Variable<DateTime>(visitTime);
    }
    if (!nullToAbsent || callOutcome != null) {
      map['call_outcome'] = Variable<String>(callOutcome);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || gpsLat != null) {
      map['gps_lat'] = Variable<double>(gpsLat);
    }
    if (!nullToAbsent || gpsLng != null) {
      map['gps_lng'] = Variable<double>(gpsLng);
    }
    if (!nullToAbsent || photoUrl != null) {
      map['photo_url'] = Variable<String>(photoUrl);
    }
    map['is_planned'] = Variable<bool>(isPlanned);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DcrDoctorVisitsTableCompanion toCompanion(bool nullToAbsent) {
    return DcrDoctorVisitsTableCompanion(
      id: Value(id),
      dcrId: Value(dcrId),
      doctorId: Value(doctorId),
      session: Value(session),
      visitTime: visitTime == null && nullToAbsent
          ? const Value.absent()
          : Value(visitTime),
      callOutcome: callOutcome == null && nullToAbsent
          ? const Value.absent()
          : Value(callOutcome),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      gpsLat:
          gpsLat == null && nullToAbsent ? const Value.absent() : Value(gpsLat),
      gpsLng:
          gpsLng == null && nullToAbsent ? const Value.absent() : Value(gpsLng),
      photoUrl: photoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(photoUrl),
      isPlanned: Value(isPlanned),
      createdAt: Value(createdAt),
    );
  }

  factory DcrDoctorVisitsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DcrDoctorVisitsTableData(
      id: serializer.fromJson<String>(json['id']),
      dcrId: serializer.fromJson<String>(json['dcrId']),
      doctorId: serializer.fromJson<String>(json['doctorId']),
      session: serializer.fromJson<String>(json['session']),
      visitTime: serializer.fromJson<DateTime?>(json['visitTime']),
      callOutcome: serializer.fromJson<String?>(json['callOutcome']),
      notes: serializer.fromJson<String?>(json['notes']),
      gpsLat: serializer.fromJson<double?>(json['gpsLat']),
      gpsLng: serializer.fromJson<double?>(json['gpsLng']),
      photoUrl: serializer.fromJson<String?>(json['photoUrl']),
      isPlanned: serializer.fromJson<bool>(json['isPlanned']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'dcrId': serializer.toJson<String>(dcrId),
      'doctorId': serializer.toJson<String>(doctorId),
      'session': serializer.toJson<String>(session),
      'visitTime': serializer.toJson<DateTime?>(visitTime),
      'callOutcome': serializer.toJson<String?>(callOutcome),
      'notes': serializer.toJson<String?>(notes),
      'gpsLat': serializer.toJson<double?>(gpsLat),
      'gpsLng': serializer.toJson<double?>(gpsLng),
      'photoUrl': serializer.toJson<String?>(photoUrl),
      'isPlanned': serializer.toJson<bool>(isPlanned),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DcrDoctorVisitsTableData copyWith(
          {String? id,
          String? dcrId,
          String? doctorId,
          String? session,
          Value<DateTime?> visitTime = const Value.absent(),
          Value<String?> callOutcome = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          Value<double?> gpsLat = const Value.absent(),
          Value<double?> gpsLng = const Value.absent(),
          Value<String?> photoUrl = const Value.absent(),
          bool? isPlanned,
          DateTime? createdAt}) =>
      DcrDoctorVisitsTableData(
        id: id ?? this.id,
        dcrId: dcrId ?? this.dcrId,
        doctorId: doctorId ?? this.doctorId,
        session: session ?? this.session,
        visitTime: visitTime.present ? visitTime.value : this.visitTime,
        callOutcome: callOutcome.present ? callOutcome.value : this.callOutcome,
        notes: notes.present ? notes.value : this.notes,
        gpsLat: gpsLat.present ? gpsLat.value : this.gpsLat,
        gpsLng: gpsLng.present ? gpsLng.value : this.gpsLng,
        photoUrl: photoUrl.present ? photoUrl.value : this.photoUrl,
        isPlanned: isPlanned ?? this.isPlanned,
        createdAt: createdAt ?? this.createdAt,
      );
  DcrDoctorVisitsTableData copyWithCompanion(
      DcrDoctorVisitsTableCompanion data) {
    return DcrDoctorVisitsTableData(
      id: data.id.present ? data.id.value : this.id,
      dcrId: data.dcrId.present ? data.dcrId.value : this.dcrId,
      doctorId: data.doctorId.present ? data.doctorId.value : this.doctorId,
      session: data.session.present ? data.session.value : this.session,
      visitTime: data.visitTime.present ? data.visitTime.value : this.visitTime,
      callOutcome:
          data.callOutcome.present ? data.callOutcome.value : this.callOutcome,
      notes: data.notes.present ? data.notes.value : this.notes,
      gpsLat: data.gpsLat.present ? data.gpsLat.value : this.gpsLat,
      gpsLng: data.gpsLng.present ? data.gpsLng.value : this.gpsLng,
      photoUrl: data.photoUrl.present ? data.photoUrl.value : this.photoUrl,
      isPlanned: data.isPlanned.present ? data.isPlanned.value : this.isPlanned,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DcrDoctorVisitsTableData(')
          ..write('id: $id, ')
          ..write('dcrId: $dcrId, ')
          ..write('doctorId: $doctorId, ')
          ..write('session: $session, ')
          ..write('visitTime: $visitTime, ')
          ..write('callOutcome: $callOutcome, ')
          ..write('notes: $notes, ')
          ..write('gpsLat: $gpsLat, ')
          ..write('gpsLng: $gpsLng, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('isPlanned: $isPlanned, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, dcrId, doctorId, session, visitTime,
      callOutcome, notes, gpsLat, gpsLng, photoUrl, isPlanned, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DcrDoctorVisitsTableData &&
          other.id == this.id &&
          other.dcrId == this.dcrId &&
          other.doctorId == this.doctorId &&
          other.session == this.session &&
          other.visitTime == this.visitTime &&
          other.callOutcome == this.callOutcome &&
          other.notes == this.notes &&
          other.gpsLat == this.gpsLat &&
          other.gpsLng == this.gpsLng &&
          other.photoUrl == this.photoUrl &&
          other.isPlanned == this.isPlanned &&
          other.createdAt == this.createdAt);
}

class DcrDoctorVisitsTableCompanion
    extends UpdateCompanion<DcrDoctorVisitsTableData> {
  final Value<String> id;
  final Value<String> dcrId;
  final Value<String> doctorId;
  final Value<String> session;
  final Value<DateTime?> visitTime;
  final Value<String?> callOutcome;
  final Value<String?> notes;
  final Value<double?> gpsLat;
  final Value<double?> gpsLng;
  final Value<String?> photoUrl;
  final Value<bool> isPlanned;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const DcrDoctorVisitsTableCompanion({
    this.id = const Value.absent(),
    this.dcrId = const Value.absent(),
    this.doctorId = const Value.absent(),
    this.session = const Value.absent(),
    this.visitTime = const Value.absent(),
    this.callOutcome = const Value.absent(),
    this.notes = const Value.absent(),
    this.gpsLat = const Value.absent(),
    this.gpsLng = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.isPlanned = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DcrDoctorVisitsTableCompanion.insert({
    required String id,
    required String dcrId,
    required String doctorId,
    required String session,
    this.visitTime = const Value.absent(),
    this.callOutcome = const Value.absent(),
    this.notes = const Value.absent(),
    this.gpsLat = const Value.absent(),
    this.gpsLng = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.isPlanned = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        dcrId = Value(dcrId),
        doctorId = Value(doctorId),
        session = Value(session);
  static Insertable<DcrDoctorVisitsTableData> custom({
    Expression<String>? id,
    Expression<String>? dcrId,
    Expression<String>? doctorId,
    Expression<String>? session,
    Expression<DateTime>? visitTime,
    Expression<String>? callOutcome,
    Expression<String>? notes,
    Expression<double>? gpsLat,
    Expression<double>? gpsLng,
    Expression<String>? photoUrl,
    Expression<bool>? isPlanned,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dcrId != null) 'dcr_id': dcrId,
      if (doctorId != null) 'doctor_id': doctorId,
      if (session != null) 'session': session,
      if (visitTime != null) 'visit_time': visitTime,
      if (callOutcome != null) 'call_outcome': callOutcome,
      if (notes != null) 'notes': notes,
      if (gpsLat != null) 'gps_lat': gpsLat,
      if (gpsLng != null) 'gps_lng': gpsLng,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (isPlanned != null) 'is_planned': isPlanned,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DcrDoctorVisitsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? dcrId,
      Value<String>? doctorId,
      Value<String>? session,
      Value<DateTime?>? visitTime,
      Value<String?>? callOutcome,
      Value<String?>? notes,
      Value<double?>? gpsLat,
      Value<double?>? gpsLng,
      Value<String?>? photoUrl,
      Value<bool>? isPlanned,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return DcrDoctorVisitsTableCompanion(
      id: id ?? this.id,
      dcrId: dcrId ?? this.dcrId,
      doctorId: doctorId ?? this.doctorId,
      session: session ?? this.session,
      visitTime: visitTime ?? this.visitTime,
      callOutcome: callOutcome ?? this.callOutcome,
      notes: notes ?? this.notes,
      gpsLat: gpsLat ?? this.gpsLat,
      gpsLng: gpsLng ?? this.gpsLng,
      photoUrl: photoUrl ?? this.photoUrl,
      isPlanned: isPlanned ?? this.isPlanned,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (dcrId.present) {
      map['dcr_id'] = Variable<String>(dcrId.value);
    }
    if (doctorId.present) {
      map['doctor_id'] = Variable<String>(doctorId.value);
    }
    if (session.present) {
      map['session'] = Variable<String>(session.value);
    }
    if (visitTime.present) {
      map['visit_time'] = Variable<DateTime>(visitTime.value);
    }
    if (callOutcome.present) {
      map['call_outcome'] = Variable<String>(callOutcome.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (gpsLat.present) {
      map['gps_lat'] = Variable<double>(gpsLat.value);
    }
    if (gpsLng.present) {
      map['gps_lng'] = Variable<double>(gpsLng.value);
    }
    if (photoUrl.present) {
      map['photo_url'] = Variable<String>(photoUrl.value);
    }
    if (isPlanned.present) {
      map['is_planned'] = Variable<bool>(isPlanned.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DcrDoctorVisitsTableCompanion(')
          ..write('id: $id, ')
          ..write('dcrId: $dcrId, ')
          ..write('doctorId: $doctorId, ')
          ..write('session: $session, ')
          ..write('visitTime: $visitTime, ')
          ..write('callOutcome: $callOutcome, ')
          ..write('notes: $notes, ')
          ..write('gpsLat: $gpsLat, ')
          ..write('gpsLng: $gpsLng, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('isPlanned: $isPlanned, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DcrChemistVisitsTableTable extends DcrChemistVisitsTable
    with TableInfo<$DcrChemistVisitsTableTable, DcrChemistVisitsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DcrChemistVisitsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dcrIdMeta = const VerificationMeta('dcrId');
  @override
  late final GeneratedColumn<String> dcrId = GeneratedColumn<String>(
      'dcr_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _chemistIdMeta =
      const VerificationMeta('chemistId');
  @override
  late final GeneratedColumn<String> chemistId = GeneratedColumn<String>(
      'chemist_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sessionMeta =
      const VerificationMeta('session');
  @override
  late final GeneratedColumn<String> session = GeneratedColumn<String>(
      'session', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _visitTimeMeta =
      const VerificationMeta('visitTime');
  @override
  late final GeneratedColumn<DateTime> visitTime = GeneratedColumn<DateTime>(
      'visit_time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _gpsLatMeta = const VerificationMeta('gpsLat');
  @override
  late final GeneratedColumn<double> gpsLat = GeneratedColumn<double>(
      'gps_lat', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _gpsLngMeta = const VerificationMeta('gpsLng');
  @override
  late final GeneratedColumn<double> gpsLng = GeneratedColumn<double>(
      'gps_lng', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _photoUrlMeta =
      const VerificationMeta('photoUrl');
  @override
  late final GeneratedColumn<String> photoUrl = GeneratedColumn<String>(
      'photo_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isPlannedMeta =
      const VerificationMeta('isPlanned');
  @override
  late final GeneratedColumn<bool> isPlanned = GeneratedColumn<bool>(
      'is_planned', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_planned" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        dcrId,
        chemistId,
        session,
        visitTime,
        notes,
        gpsLat,
        gpsLng,
        photoUrl,
        isPlanned,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dcr_chemist_visits_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<DcrChemistVisitsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('dcr_id')) {
      context.handle(
          _dcrIdMeta, dcrId.isAcceptableOrUnknown(data['dcr_id']!, _dcrIdMeta));
    } else if (isInserting) {
      context.missing(_dcrIdMeta);
    }
    if (data.containsKey('chemist_id')) {
      context.handle(_chemistIdMeta,
          chemistId.isAcceptableOrUnknown(data['chemist_id']!, _chemistIdMeta));
    } else if (isInserting) {
      context.missing(_chemistIdMeta);
    }
    if (data.containsKey('session')) {
      context.handle(_sessionMeta,
          session.isAcceptableOrUnknown(data['session']!, _sessionMeta));
    } else if (isInserting) {
      context.missing(_sessionMeta);
    }
    if (data.containsKey('visit_time')) {
      context.handle(_visitTimeMeta,
          visitTime.isAcceptableOrUnknown(data['visit_time']!, _visitTimeMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('gps_lat')) {
      context.handle(_gpsLatMeta,
          gpsLat.isAcceptableOrUnknown(data['gps_lat']!, _gpsLatMeta));
    }
    if (data.containsKey('gps_lng')) {
      context.handle(_gpsLngMeta,
          gpsLng.isAcceptableOrUnknown(data['gps_lng']!, _gpsLngMeta));
    }
    if (data.containsKey('photo_url')) {
      context.handle(_photoUrlMeta,
          photoUrl.isAcceptableOrUnknown(data['photo_url']!, _photoUrlMeta));
    }
    if (data.containsKey('is_planned')) {
      context.handle(_isPlannedMeta,
          isPlanned.isAcceptableOrUnknown(data['is_planned']!, _isPlannedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DcrChemistVisitsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DcrChemistVisitsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      dcrId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dcr_id'])!,
      chemistId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}chemist_id'])!,
      session: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}session'])!,
      visitTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}visit_time']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      gpsLat: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}gps_lat']),
      gpsLng: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}gps_lng']),
      photoUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}photo_url']),
      isPlanned: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_planned'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $DcrChemistVisitsTableTable createAlias(String alias) {
    return $DcrChemistVisitsTableTable(attachedDatabase, alias);
  }
}

class DcrChemistVisitsTableData extends DataClass
    implements Insertable<DcrChemistVisitsTableData> {
  final String id;
  final String dcrId;
  final String chemistId;
  final String session;
  final DateTime? visitTime;
  final String? notes;
  final double? gpsLat;
  final double? gpsLng;
  final String? photoUrl;
  final bool isPlanned;
  final DateTime createdAt;
  const DcrChemistVisitsTableData(
      {required this.id,
      required this.dcrId,
      required this.chemistId,
      required this.session,
      this.visitTime,
      this.notes,
      this.gpsLat,
      this.gpsLng,
      this.photoUrl,
      required this.isPlanned,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['dcr_id'] = Variable<String>(dcrId);
    map['chemist_id'] = Variable<String>(chemistId);
    map['session'] = Variable<String>(session);
    if (!nullToAbsent || visitTime != null) {
      map['visit_time'] = Variable<DateTime>(visitTime);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || gpsLat != null) {
      map['gps_lat'] = Variable<double>(gpsLat);
    }
    if (!nullToAbsent || gpsLng != null) {
      map['gps_lng'] = Variable<double>(gpsLng);
    }
    if (!nullToAbsent || photoUrl != null) {
      map['photo_url'] = Variable<String>(photoUrl);
    }
    map['is_planned'] = Variable<bool>(isPlanned);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DcrChemistVisitsTableCompanion toCompanion(bool nullToAbsent) {
    return DcrChemistVisitsTableCompanion(
      id: Value(id),
      dcrId: Value(dcrId),
      chemistId: Value(chemistId),
      session: Value(session),
      visitTime: visitTime == null && nullToAbsent
          ? const Value.absent()
          : Value(visitTime),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      gpsLat:
          gpsLat == null && nullToAbsent ? const Value.absent() : Value(gpsLat),
      gpsLng:
          gpsLng == null && nullToAbsent ? const Value.absent() : Value(gpsLng),
      photoUrl: photoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(photoUrl),
      isPlanned: Value(isPlanned),
      createdAt: Value(createdAt),
    );
  }

  factory DcrChemistVisitsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DcrChemistVisitsTableData(
      id: serializer.fromJson<String>(json['id']),
      dcrId: serializer.fromJson<String>(json['dcrId']),
      chemistId: serializer.fromJson<String>(json['chemistId']),
      session: serializer.fromJson<String>(json['session']),
      visitTime: serializer.fromJson<DateTime?>(json['visitTime']),
      notes: serializer.fromJson<String?>(json['notes']),
      gpsLat: serializer.fromJson<double?>(json['gpsLat']),
      gpsLng: serializer.fromJson<double?>(json['gpsLng']),
      photoUrl: serializer.fromJson<String?>(json['photoUrl']),
      isPlanned: serializer.fromJson<bool>(json['isPlanned']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'dcrId': serializer.toJson<String>(dcrId),
      'chemistId': serializer.toJson<String>(chemistId),
      'session': serializer.toJson<String>(session),
      'visitTime': serializer.toJson<DateTime?>(visitTime),
      'notes': serializer.toJson<String?>(notes),
      'gpsLat': serializer.toJson<double?>(gpsLat),
      'gpsLng': serializer.toJson<double?>(gpsLng),
      'photoUrl': serializer.toJson<String?>(photoUrl),
      'isPlanned': serializer.toJson<bool>(isPlanned),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DcrChemistVisitsTableData copyWith(
          {String? id,
          String? dcrId,
          String? chemistId,
          String? session,
          Value<DateTime?> visitTime = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          Value<double?> gpsLat = const Value.absent(),
          Value<double?> gpsLng = const Value.absent(),
          Value<String?> photoUrl = const Value.absent(),
          bool? isPlanned,
          DateTime? createdAt}) =>
      DcrChemistVisitsTableData(
        id: id ?? this.id,
        dcrId: dcrId ?? this.dcrId,
        chemistId: chemistId ?? this.chemistId,
        session: session ?? this.session,
        visitTime: visitTime.present ? visitTime.value : this.visitTime,
        notes: notes.present ? notes.value : this.notes,
        gpsLat: gpsLat.present ? gpsLat.value : this.gpsLat,
        gpsLng: gpsLng.present ? gpsLng.value : this.gpsLng,
        photoUrl: photoUrl.present ? photoUrl.value : this.photoUrl,
        isPlanned: isPlanned ?? this.isPlanned,
        createdAt: createdAt ?? this.createdAt,
      );
  DcrChemistVisitsTableData copyWithCompanion(
      DcrChemistVisitsTableCompanion data) {
    return DcrChemistVisitsTableData(
      id: data.id.present ? data.id.value : this.id,
      dcrId: data.dcrId.present ? data.dcrId.value : this.dcrId,
      chemistId: data.chemistId.present ? data.chemistId.value : this.chemistId,
      session: data.session.present ? data.session.value : this.session,
      visitTime: data.visitTime.present ? data.visitTime.value : this.visitTime,
      notes: data.notes.present ? data.notes.value : this.notes,
      gpsLat: data.gpsLat.present ? data.gpsLat.value : this.gpsLat,
      gpsLng: data.gpsLng.present ? data.gpsLng.value : this.gpsLng,
      photoUrl: data.photoUrl.present ? data.photoUrl.value : this.photoUrl,
      isPlanned: data.isPlanned.present ? data.isPlanned.value : this.isPlanned,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DcrChemistVisitsTableData(')
          ..write('id: $id, ')
          ..write('dcrId: $dcrId, ')
          ..write('chemistId: $chemistId, ')
          ..write('session: $session, ')
          ..write('visitTime: $visitTime, ')
          ..write('notes: $notes, ')
          ..write('gpsLat: $gpsLat, ')
          ..write('gpsLng: $gpsLng, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('isPlanned: $isPlanned, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, dcrId, chemistId, session, visitTime,
      notes, gpsLat, gpsLng, photoUrl, isPlanned, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DcrChemistVisitsTableData &&
          other.id == this.id &&
          other.dcrId == this.dcrId &&
          other.chemistId == this.chemistId &&
          other.session == this.session &&
          other.visitTime == this.visitTime &&
          other.notes == this.notes &&
          other.gpsLat == this.gpsLat &&
          other.gpsLng == this.gpsLng &&
          other.photoUrl == this.photoUrl &&
          other.isPlanned == this.isPlanned &&
          other.createdAt == this.createdAt);
}

class DcrChemistVisitsTableCompanion
    extends UpdateCompanion<DcrChemistVisitsTableData> {
  final Value<String> id;
  final Value<String> dcrId;
  final Value<String> chemistId;
  final Value<String> session;
  final Value<DateTime?> visitTime;
  final Value<String?> notes;
  final Value<double?> gpsLat;
  final Value<double?> gpsLng;
  final Value<String?> photoUrl;
  final Value<bool> isPlanned;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const DcrChemistVisitsTableCompanion({
    this.id = const Value.absent(),
    this.dcrId = const Value.absent(),
    this.chemistId = const Value.absent(),
    this.session = const Value.absent(),
    this.visitTime = const Value.absent(),
    this.notes = const Value.absent(),
    this.gpsLat = const Value.absent(),
    this.gpsLng = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.isPlanned = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DcrChemistVisitsTableCompanion.insert({
    required String id,
    required String dcrId,
    required String chemistId,
    required String session,
    this.visitTime = const Value.absent(),
    this.notes = const Value.absent(),
    this.gpsLat = const Value.absent(),
    this.gpsLng = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.isPlanned = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        dcrId = Value(dcrId),
        chemistId = Value(chemistId),
        session = Value(session);
  static Insertable<DcrChemistVisitsTableData> custom({
    Expression<String>? id,
    Expression<String>? dcrId,
    Expression<String>? chemistId,
    Expression<String>? session,
    Expression<DateTime>? visitTime,
    Expression<String>? notes,
    Expression<double>? gpsLat,
    Expression<double>? gpsLng,
    Expression<String>? photoUrl,
    Expression<bool>? isPlanned,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dcrId != null) 'dcr_id': dcrId,
      if (chemistId != null) 'chemist_id': chemistId,
      if (session != null) 'session': session,
      if (visitTime != null) 'visit_time': visitTime,
      if (notes != null) 'notes': notes,
      if (gpsLat != null) 'gps_lat': gpsLat,
      if (gpsLng != null) 'gps_lng': gpsLng,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (isPlanned != null) 'is_planned': isPlanned,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DcrChemistVisitsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? dcrId,
      Value<String>? chemistId,
      Value<String>? session,
      Value<DateTime?>? visitTime,
      Value<String?>? notes,
      Value<double?>? gpsLat,
      Value<double?>? gpsLng,
      Value<String?>? photoUrl,
      Value<bool>? isPlanned,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return DcrChemistVisitsTableCompanion(
      id: id ?? this.id,
      dcrId: dcrId ?? this.dcrId,
      chemistId: chemistId ?? this.chemistId,
      session: session ?? this.session,
      visitTime: visitTime ?? this.visitTime,
      notes: notes ?? this.notes,
      gpsLat: gpsLat ?? this.gpsLat,
      gpsLng: gpsLng ?? this.gpsLng,
      photoUrl: photoUrl ?? this.photoUrl,
      isPlanned: isPlanned ?? this.isPlanned,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (dcrId.present) {
      map['dcr_id'] = Variable<String>(dcrId.value);
    }
    if (chemistId.present) {
      map['chemist_id'] = Variable<String>(chemistId.value);
    }
    if (session.present) {
      map['session'] = Variable<String>(session.value);
    }
    if (visitTime.present) {
      map['visit_time'] = Variable<DateTime>(visitTime.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (gpsLat.present) {
      map['gps_lat'] = Variable<double>(gpsLat.value);
    }
    if (gpsLng.present) {
      map['gps_lng'] = Variable<double>(gpsLng.value);
    }
    if (photoUrl.present) {
      map['photo_url'] = Variable<String>(photoUrl.value);
    }
    if (isPlanned.present) {
      map['is_planned'] = Variable<bool>(isPlanned.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DcrChemistVisitsTableCompanion(')
          ..write('id: $id, ')
          ..write('dcrId: $dcrId, ')
          ..write('chemistId: $chemistId, ')
          ..write('session: $session, ')
          ..write('visitTime: $visitTime, ')
          ..write('notes: $notes, ')
          ..write('gpsLat: $gpsLat, ')
          ..write('gpsLng: $gpsLng, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('isPlanned: $isPlanned, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DcrVisitProductsTableTable extends DcrVisitProductsTable
    with TableInfo<$DcrVisitProductsTableTable, DcrVisitProductsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DcrVisitProductsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _visitIdMeta =
      const VerificationMeta('visitId');
  @override
  late final GeneratedColumn<String> visitId = GeneratedColumn<String>(
      'visit_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
      'product_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, visitId, productId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dcr_visit_products_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<DcrVisitProductsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('visit_id')) {
      context.handle(_visitIdMeta,
          visitId.isAcceptableOrUnknown(data['visit_id']!, _visitIdMeta));
    } else if (isInserting) {
      context.missing(_visitIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DcrVisitProductsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DcrVisitProductsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      visitId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}visit_id'])!,
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_id'])!,
    );
  }

  @override
  $DcrVisitProductsTableTable createAlias(String alias) {
    return $DcrVisitProductsTableTable(attachedDatabase, alias);
  }
}

class DcrVisitProductsTableData extends DataClass
    implements Insertable<DcrVisitProductsTableData> {
  final String id;
  final String visitId;
  final String productId;
  const DcrVisitProductsTableData(
      {required this.id, required this.visitId, required this.productId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['visit_id'] = Variable<String>(visitId);
    map['product_id'] = Variable<String>(productId);
    return map;
  }

  DcrVisitProductsTableCompanion toCompanion(bool nullToAbsent) {
    return DcrVisitProductsTableCompanion(
      id: Value(id),
      visitId: Value(visitId),
      productId: Value(productId),
    );
  }

  factory DcrVisitProductsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DcrVisitProductsTableData(
      id: serializer.fromJson<String>(json['id']),
      visitId: serializer.fromJson<String>(json['visitId']),
      productId: serializer.fromJson<String>(json['productId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'visitId': serializer.toJson<String>(visitId),
      'productId': serializer.toJson<String>(productId),
    };
  }

  DcrVisitProductsTableData copyWith(
          {String? id, String? visitId, String? productId}) =>
      DcrVisitProductsTableData(
        id: id ?? this.id,
        visitId: visitId ?? this.visitId,
        productId: productId ?? this.productId,
      );
  DcrVisitProductsTableData copyWithCompanion(
      DcrVisitProductsTableCompanion data) {
    return DcrVisitProductsTableData(
      id: data.id.present ? data.id.value : this.id,
      visitId: data.visitId.present ? data.visitId.value : this.visitId,
      productId: data.productId.present ? data.productId.value : this.productId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DcrVisitProductsTableData(')
          ..write('id: $id, ')
          ..write('visitId: $visitId, ')
          ..write('productId: $productId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, visitId, productId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DcrVisitProductsTableData &&
          other.id == this.id &&
          other.visitId == this.visitId &&
          other.productId == this.productId);
}

class DcrVisitProductsTableCompanion
    extends UpdateCompanion<DcrVisitProductsTableData> {
  final Value<String> id;
  final Value<String> visitId;
  final Value<String> productId;
  final Value<int> rowid;
  const DcrVisitProductsTableCompanion({
    this.id = const Value.absent(),
    this.visitId = const Value.absent(),
    this.productId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DcrVisitProductsTableCompanion.insert({
    required String id,
    required String visitId,
    required String productId,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        visitId = Value(visitId),
        productId = Value(productId);
  static Insertable<DcrVisitProductsTableData> custom({
    Expression<String>? id,
    Expression<String>? visitId,
    Expression<String>? productId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (visitId != null) 'visit_id': visitId,
      if (productId != null) 'product_id': productId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DcrVisitProductsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? visitId,
      Value<String>? productId,
      Value<int>? rowid}) {
    return DcrVisitProductsTableCompanion(
      id: id ?? this.id,
      visitId: visitId ?? this.visitId,
      productId: productId ?? this.productId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (visitId.present) {
      map['visit_id'] = Variable<String>(visitId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DcrVisitProductsTableCompanion(')
          ..write('id: $id, ')
          ..write('visitId: $visitId, ')
          ..write('productId: $productId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SyncQueueTableTable syncQueueTable = $SyncQueueTableTable(this);
  late final $CachedApiTableTable cachedApiTable = $CachedApiTableTable(this);
  late final $DoctorsTableTable doctorsTable = $DoctorsTableTable(this);
  late final $ChemistsTableTable chemistsTable = $ChemistsTableTable(this);
  late final $ProductsTableTable productsTable = $ProductsTableTable(this);
  late final $PriceHistoryTableTable priceHistoryTable =
      $PriceHistoryTableTable(this);
  late final $TourPlansTableTable tourPlansTable = $TourPlansTableTable(this);
  late final $TourPlanStopsTableTable tourPlanStopsTable =
      $TourPlanStopsTableTable(this);
  late final $DcrsTableTable dcrsTable = $DcrsTableTable(this);
  late final $DcrDoctorVisitsTableTable dcrDoctorVisitsTable =
      $DcrDoctorVisitsTableTable(this);
  late final $DcrChemistVisitsTableTable dcrChemistVisitsTable =
      $DcrChemistVisitsTableTable(this);
  late final $DcrVisitProductsTableTable dcrVisitProductsTable =
      $DcrVisitProductsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        syncQueueTable,
        cachedApiTable,
        doctorsTable,
        chemistsTable,
        productsTable,
        priceHistoryTable,
        tourPlansTable,
        tourPlanStopsTable,
        dcrsTable,
        dcrDoctorVisitsTable,
        dcrChemistVisitsTable,
        dcrVisitProductsTable
      ];
}

typedef $$SyncQueueTableTableCreateCompanionBuilder = SyncQueueTableCompanion
    Function({
  Value<int> id,
  required String endpoint,
  required String method,
  Value<String?> payload,
  Value<String?> headers,
  required String status,
  Value<int> retryCount,
  Value<String?> errorMessage,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$SyncQueueTableTableUpdateCompanionBuilder = SyncQueueTableCompanion
    Function({
  Value<int> id,
  Value<String> endpoint,
  Value<String> method,
  Value<String?> payload,
  Value<String?> headers,
  Value<String> status,
  Value<int> retryCount,
  Value<String?> errorMessage,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
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

  ColumnFilters<String> get endpoint => $composableBuilder(
      column: $table.endpoint, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get method => $composableBuilder(
      column: $table.method, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get headers => $composableBuilder(
      column: $table.headers, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<String> get endpoint => $composableBuilder(
      column: $table.endpoint, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get method => $composableBuilder(
      column: $table.method, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get headers => $composableBuilder(
      column: $table.headers, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<String> get endpoint =>
      $composableBuilder(column: $table.endpoint, builder: (column) => column);

  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<String> get headers =>
      $composableBuilder(column: $table.headers, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => column);

  GeneratedColumn<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SyncQueueTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncQueueTableTable,
    SyncQueueItem,
    $$SyncQueueTableTableFilterComposer,
    $$SyncQueueTableTableOrderingComposer,
    $$SyncQueueTableTableAnnotationComposer,
    $$SyncQueueTableTableCreateCompanionBuilder,
    $$SyncQueueTableTableUpdateCompanionBuilder,
    (
      SyncQueueItem,
      BaseReferences<_$AppDatabase, $SyncQueueTableTable, SyncQueueItem>
    ),
    SyncQueueItem,
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
            Value<String> endpoint = const Value.absent(),
            Value<String> method = const Value.absent(),
            Value<String?> payload = const Value.absent(),
            Value<String?> headers = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> retryCount = const Value.absent(),
            Value<String?> errorMessage = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              SyncQueueTableCompanion(
            id: id,
            endpoint: endpoint,
            method: method,
            payload: payload,
            headers: headers,
            status: status,
            retryCount: retryCount,
            errorMessage: errorMessage,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String endpoint,
            required String method,
            Value<String?> payload = const Value.absent(),
            Value<String?> headers = const Value.absent(),
            required String status,
            Value<int> retryCount = const Value.absent(),
            Value<String?> errorMessage = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              SyncQueueTableCompanion.insert(
            id: id,
            endpoint: endpoint,
            method: method,
            payload: payload,
            headers: headers,
            status: status,
            retryCount: retryCount,
            errorMessage: errorMessage,
            createdAt: createdAt,
            updatedAt: updatedAt,
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
    SyncQueueItem,
    $$SyncQueueTableTableFilterComposer,
    $$SyncQueueTableTableOrderingComposer,
    $$SyncQueueTableTableAnnotationComposer,
    $$SyncQueueTableTableCreateCompanionBuilder,
    $$SyncQueueTableTableUpdateCompanionBuilder,
    (
      SyncQueueItem,
      BaseReferences<_$AppDatabase, $SyncQueueTableTable, SyncQueueItem>
    ),
    SyncQueueItem,
    PrefetchHooks Function()>;
typedef $$CachedApiTableTableCreateCompanionBuilder = CachedApiTableCompanion
    Function({
  required String endpointKey,
  required String responseJson,
  required DateTime expiresAt,
  Value<DateTime> cachedAt,
  Value<int> rowid,
});
typedef $$CachedApiTableTableUpdateCompanionBuilder = CachedApiTableCompanion
    Function({
  Value<String> endpointKey,
  Value<String> responseJson,
  Value<DateTime> expiresAt,
  Value<DateTime> cachedAt,
  Value<int> rowid,
});

class $$CachedApiTableTableFilterComposer
    extends Composer<_$AppDatabase, $CachedApiTableTable> {
  $$CachedApiTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get endpointKey => $composableBuilder(
      column: $table.endpointKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get responseJson => $composableBuilder(
      column: $table.responseJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get expiresAt => $composableBuilder(
      column: $table.expiresAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnFilters(column));
}

class $$CachedApiTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedApiTableTable> {
  $$CachedApiTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get endpointKey => $composableBuilder(
      column: $table.endpointKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get responseJson => $composableBuilder(
      column: $table.responseJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get expiresAt => $composableBuilder(
      column: $table.expiresAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnOrderings(column));
}

class $$CachedApiTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedApiTableTable> {
  $$CachedApiTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get endpointKey => $composableBuilder(
      column: $table.endpointKey, builder: (column) => column);

  GeneratedColumn<String> get responseJson => $composableBuilder(
      column: $table.responseJson, builder: (column) => column);

  GeneratedColumn<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$CachedApiTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CachedApiTableTable,
    CachedApiResponse,
    $$CachedApiTableTableFilterComposer,
    $$CachedApiTableTableOrderingComposer,
    $$CachedApiTableTableAnnotationComposer,
    $$CachedApiTableTableCreateCompanionBuilder,
    $$CachedApiTableTableUpdateCompanionBuilder,
    (
      CachedApiResponse,
      BaseReferences<_$AppDatabase, $CachedApiTableTable, CachedApiResponse>
    ),
    CachedApiResponse,
    PrefetchHooks Function()> {
  $$CachedApiTableTableTableManager(
      _$AppDatabase db, $CachedApiTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedApiTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedApiTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedApiTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> endpointKey = const Value.absent(),
            Value<String> responseJson = const Value.absent(),
            Value<DateTime> expiresAt = const Value.absent(),
            Value<DateTime> cachedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedApiTableCompanion(
            endpointKey: endpointKey,
            responseJson: responseJson,
            expiresAt: expiresAt,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String endpointKey,
            required String responseJson,
            required DateTime expiresAt,
            Value<DateTime> cachedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedApiTableCompanion.insert(
            endpointKey: endpointKey,
            responseJson: responseJson,
            expiresAt: expiresAt,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CachedApiTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CachedApiTableTable,
    CachedApiResponse,
    $$CachedApiTableTableFilterComposer,
    $$CachedApiTableTableOrderingComposer,
    $$CachedApiTableTableAnnotationComposer,
    $$CachedApiTableTableCreateCompanionBuilder,
    $$CachedApiTableTableUpdateCompanionBuilder,
    (
      CachedApiResponse,
      BaseReferences<_$AppDatabase, $CachedApiTableTable, CachedApiResponse>
    ),
    CachedApiResponse,
    PrefetchHooks Function()>;
typedef $$DoctorsTableTableCreateCompanionBuilder = DoctorsTableCompanion
    Function({
  required String id,
  required String tenantId,
  required String name,
  required String specialty,
  Value<String?> email,
  Value<String?> phone,
  required String clinicAddress,
  Value<double?> latitude,
  Value<double?> longitude,
  required String tier,
  required DateTime clientCreatedAt,
  Value<DateTime> lastModifiedAt,
  Value<bool> isDeleted,
  Value<int> rowid,
});
typedef $$DoctorsTableTableUpdateCompanionBuilder = DoctorsTableCompanion
    Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String> name,
  Value<String> specialty,
  Value<String?> email,
  Value<String?> phone,
  Value<String> clinicAddress,
  Value<double?> latitude,
  Value<double?> longitude,
  Value<String> tier,
  Value<DateTime> clientCreatedAt,
  Value<DateTime> lastModifiedAt,
  Value<bool> isDeleted,
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

  ColumnFilters<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get specialty => $composableBuilder(
      column: $table.specialty, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get clinicAddress => $composableBuilder(
      column: $table.clinicAddress, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tier => $composableBuilder(
      column: $table.tier, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get clientCreatedAt => $composableBuilder(
      column: $table.clientCreatedAt,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastModifiedAt => $composableBuilder(
      column: $table.lastModifiedAt,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get specialty => $composableBuilder(
      column: $table.specialty, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get clinicAddress => $composableBuilder(
      column: $table.clinicAddress,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tier => $composableBuilder(
      column: $table.tier, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get clientCreatedAt => $composableBuilder(
      column: $table.clientCreatedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastModifiedAt => $composableBuilder(
      column: $table.lastModifiedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get specialty =>
      $composableBuilder(column: $table.specialty, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get clinicAddress => $composableBuilder(
      column: $table.clinicAddress, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get tier =>
      $composableBuilder(column: $table.tier, builder: (column) => column);

  GeneratedColumn<DateTime> get clientCreatedAt => $composableBuilder(
      column: $table.clientCreatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastModifiedAt => $composableBuilder(
      column: $table.lastModifiedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);
}

class $$DoctorsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DoctorsTableTable,
    DoctorsTableData,
    $$DoctorsTableTableFilterComposer,
    $$DoctorsTableTableOrderingComposer,
    $$DoctorsTableTableAnnotationComposer,
    $$DoctorsTableTableCreateCompanionBuilder,
    $$DoctorsTableTableUpdateCompanionBuilder,
    (
      DoctorsTableData,
      BaseReferences<_$AppDatabase, $DoctorsTableTable, DoctorsTableData>
    ),
    DoctorsTableData,
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
            Value<String> tenantId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> specialty = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String> clinicAddress = const Value.absent(),
            Value<double?> latitude = const Value.absent(),
            Value<double?> longitude = const Value.absent(),
            Value<String> tier = const Value.absent(),
            Value<DateTime> clientCreatedAt = const Value.absent(),
            Value<DateTime> lastModifiedAt = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DoctorsTableCompanion(
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
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
            required String name,
            required String specialty,
            Value<String?> email = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            required String clinicAddress,
            Value<double?> latitude = const Value.absent(),
            Value<double?> longitude = const Value.absent(),
            required String tier,
            required DateTime clientCreatedAt,
            Value<DateTime> lastModifiedAt = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DoctorsTableCompanion.insert(
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
    DoctorsTableData,
    $$DoctorsTableTableFilterComposer,
    $$DoctorsTableTableOrderingComposer,
    $$DoctorsTableTableAnnotationComposer,
    $$DoctorsTableTableCreateCompanionBuilder,
    $$DoctorsTableTableUpdateCompanionBuilder,
    (
      DoctorsTableData,
      BaseReferences<_$AppDatabase, $DoctorsTableTable, DoctorsTableData>
    ),
    DoctorsTableData,
    PrefetchHooks Function()>;
typedef $$ChemistsTableTableCreateCompanionBuilder = ChemistsTableCompanion
    Function({
  required String id,
  required String tenantId,
  required String name,
  Value<String?> contactPerson,
  Value<String?> phone,
  required String address,
  Value<double?> latitude,
  Value<double?> longitude,
  required String priorityTag,
  Value<double> outstandingBalance,
  Value<double> creditLimit,
  required DateTime clientCreatedAt,
  Value<DateTime> lastModifiedAt,
  Value<bool> isDeleted,
  Value<int> rowid,
});
typedef $$ChemistsTableTableUpdateCompanionBuilder = ChemistsTableCompanion
    Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String> name,
  Value<String?> contactPerson,
  Value<String?> phone,
  Value<String> address,
  Value<double?> latitude,
  Value<double?> longitude,
  Value<String> priorityTag,
  Value<double> outstandingBalance,
  Value<double> creditLimit,
  Value<DateTime> clientCreatedAt,
  Value<DateTime> lastModifiedAt,
  Value<bool> isDeleted,
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

  ColumnFilters<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contactPerson => $composableBuilder(
      column: $table.contactPerson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get priorityTag => $composableBuilder(
      column: $table.priorityTag, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get outstandingBalance => $composableBuilder(
      column: $table.outstandingBalance,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get creditLimit => $composableBuilder(
      column: $table.creditLimit, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get clientCreatedAt => $composableBuilder(
      column: $table.clientCreatedAt,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastModifiedAt => $composableBuilder(
      column: $table.lastModifiedAt,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contactPerson => $composableBuilder(
      column: $table.contactPerson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get priorityTag => $composableBuilder(
      column: $table.priorityTag, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get outstandingBalance => $composableBuilder(
      column: $table.outstandingBalance,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get creditLimit => $composableBuilder(
      column: $table.creditLimit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get clientCreatedAt => $composableBuilder(
      column: $table.clientCreatedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastModifiedAt => $composableBuilder(
      column: $table.lastModifiedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get contactPerson => $composableBuilder(
      column: $table.contactPerson, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get priorityTag => $composableBuilder(
      column: $table.priorityTag, builder: (column) => column);

  GeneratedColumn<double> get outstandingBalance => $composableBuilder(
      column: $table.outstandingBalance, builder: (column) => column);

  GeneratedColumn<double> get creditLimit => $composableBuilder(
      column: $table.creditLimit, builder: (column) => column);

  GeneratedColumn<DateTime> get clientCreatedAt => $composableBuilder(
      column: $table.clientCreatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastModifiedAt => $composableBuilder(
      column: $table.lastModifiedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);
}

class $$ChemistsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChemistsTableTable,
    ChemistsTableData,
    $$ChemistsTableTableFilterComposer,
    $$ChemistsTableTableOrderingComposer,
    $$ChemistsTableTableAnnotationComposer,
    $$ChemistsTableTableCreateCompanionBuilder,
    $$ChemistsTableTableUpdateCompanionBuilder,
    (
      ChemistsTableData,
      BaseReferences<_$AppDatabase, $ChemistsTableTable, ChemistsTableData>
    ),
    ChemistsTableData,
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
            Value<String> tenantId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> contactPerson = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String> address = const Value.absent(),
            Value<double?> latitude = const Value.absent(),
            Value<double?> longitude = const Value.absent(),
            Value<String> priorityTag = const Value.absent(),
            Value<double> outstandingBalance = const Value.absent(),
            Value<double> creditLimit = const Value.absent(),
            Value<DateTime> clientCreatedAt = const Value.absent(),
            Value<DateTime> lastModifiedAt = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChemistsTableCompanion(
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
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
            required String name,
            Value<String?> contactPerson = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            required String address,
            Value<double?> latitude = const Value.absent(),
            Value<double?> longitude = const Value.absent(),
            required String priorityTag,
            Value<double> outstandingBalance = const Value.absent(),
            Value<double> creditLimit = const Value.absent(),
            required DateTime clientCreatedAt,
            Value<DateTime> lastModifiedAt = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChemistsTableCompanion.insert(
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
    ChemistsTableData,
    $$ChemistsTableTableFilterComposer,
    $$ChemistsTableTableOrderingComposer,
    $$ChemistsTableTableAnnotationComposer,
    $$ChemistsTableTableCreateCompanionBuilder,
    $$ChemistsTableTableUpdateCompanionBuilder,
    (
      ChemistsTableData,
      BaseReferences<_$AppDatabase, $ChemistsTableTable, ChemistsTableData>
    ),
    ChemistsTableData,
    PrefetchHooks Function()>;
typedef $$ProductsTableTableCreateCompanionBuilder = ProductsTableCompanion
    Function({
  required String id,
  required String tenantId,
  required String name,
  required String category,
  required String sku,
  required double price,
  Value<String?> imageUrl,
  Value<String?> pdfVisualAidUrl,
  Value<bool> isDiscontinued,
  Value<bool> isSampleEligible,
  required DateTime clientCreatedAt,
  Value<DateTime> lastModifiedAt,
  Value<bool> isDeleted,
  Value<int> rowid,
});
typedef $$ProductsTableTableUpdateCompanionBuilder = ProductsTableCompanion
    Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String> name,
  Value<String> category,
  Value<String> sku,
  Value<double> price,
  Value<String?> imageUrl,
  Value<String?> pdfVisualAidUrl,
  Value<bool> isDiscontinued,
  Value<bool> isSampleEligible,
  Value<DateTime> clientCreatedAt,
  Value<DateTime> lastModifiedAt,
  Value<bool> isDeleted,
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

  ColumnFilters<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sku => $composableBuilder(
      column: $table.sku, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get pdfVisualAidUrl => $composableBuilder(
      column: $table.pdfVisualAidUrl,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDiscontinued => $composableBuilder(
      column: $table.isDiscontinued,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSampleEligible => $composableBuilder(
      column: $table.isSampleEligible,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get clientCreatedAt => $composableBuilder(
      column: $table.clientCreatedAt,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastModifiedAt => $composableBuilder(
      column: $table.lastModifiedAt,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sku => $composableBuilder(
      column: $table.sku, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get pdfVisualAidUrl => $composableBuilder(
      column: $table.pdfVisualAidUrl,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDiscontinued => $composableBuilder(
      column: $table.isDiscontinued,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSampleEligible => $composableBuilder(
      column: $table.isSampleEligible,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get clientCreatedAt => $composableBuilder(
      column: $table.clientCreatedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastModifiedAt => $composableBuilder(
      column: $table.lastModifiedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get sku =>
      $composableBuilder(column: $table.sku, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get pdfVisualAidUrl => $composableBuilder(
      column: $table.pdfVisualAidUrl, builder: (column) => column);

  GeneratedColumn<bool> get isDiscontinued => $composableBuilder(
      column: $table.isDiscontinued, builder: (column) => column);

  GeneratedColumn<bool> get isSampleEligible => $composableBuilder(
      column: $table.isSampleEligible, builder: (column) => column);

  GeneratedColumn<DateTime> get clientCreatedAt => $composableBuilder(
      column: $table.clientCreatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastModifiedAt => $composableBuilder(
      column: $table.lastModifiedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);
}

class $$ProductsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProductsTableTable,
    ProductsTableData,
    $$ProductsTableTableFilterComposer,
    $$ProductsTableTableOrderingComposer,
    $$ProductsTableTableAnnotationComposer,
    $$ProductsTableTableCreateCompanionBuilder,
    $$ProductsTableTableUpdateCompanionBuilder,
    (
      ProductsTableData,
      BaseReferences<_$AppDatabase, $ProductsTableTable, ProductsTableData>
    ),
    ProductsTableData,
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
            Value<String> tenantId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> sku = const Value.absent(),
            Value<double> price = const Value.absent(),
            Value<String?> imageUrl = const Value.absent(),
            Value<String?> pdfVisualAidUrl = const Value.absent(),
            Value<bool> isDiscontinued = const Value.absent(),
            Value<bool> isSampleEligible = const Value.absent(),
            Value<DateTime> clientCreatedAt = const Value.absent(),
            Value<DateTime> lastModifiedAt = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductsTableCompanion(
            id: id,
            tenantId: tenantId,
            name: name,
            category: category,
            sku: sku,
            price: price,
            imageUrl: imageUrl,
            pdfVisualAidUrl: pdfVisualAidUrl,
            isDiscontinued: isDiscontinued,
            isSampleEligible: isSampleEligible,
            clientCreatedAt: clientCreatedAt,
            lastModifiedAt: lastModifiedAt,
            isDeleted: isDeleted,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
            required String name,
            required String category,
            required String sku,
            required double price,
            Value<String?> imageUrl = const Value.absent(),
            Value<String?> pdfVisualAidUrl = const Value.absent(),
            Value<bool> isDiscontinued = const Value.absent(),
            Value<bool> isSampleEligible = const Value.absent(),
            required DateTime clientCreatedAt,
            Value<DateTime> lastModifiedAt = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductsTableCompanion.insert(
            id: id,
            tenantId: tenantId,
            name: name,
            category: category,
            sku: sku,
            price: price,
            imageUrl: imageUrl,
            pdfVisualAidUrl: pdfVisualAidUrl,
            isDiscontinued: isDiscontinued,
            isSampleEligible: isSampleEligible,
            clientCreatedAt: clientCreatedAt,
            lastModifiedAt: lastModifiedAt,
            isDeleted: isDeleted,
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
    ProductsTableData,
    $$ProductsTableTableFilterComposer,
    $$ProductsTableTableOrderingComposer,
    $$ProductsTableTableAnnotationComposer,
    $$ProductsTableTableCreateCompanionBuilder,
    $$ProductsTableTableUpdateCompanionBuilder,
    (
      ProductsTableData,
      BaseReferences<_$AppDatabase, $ProductsTableTable, ProductsTableData>
    ),
    ProductsTableData,
    PrefetchHooks Function()>;
typedef $$PriceHistoryTableTableCreateCompanionBuilder
    = PriceHistoryTableCompanion Function({
  required String id,
  required String productId,
  required double price,
  required DateTime effectiveFrom,
  Value<int> rowid,
});
typedef $$PriceHistoryTableTableUpdateCompanionBuilder
    = PriceHistoryTableCompanion Function({
  Value<String> id,
  Value<String> productId,
  Value<double> price,
  Value<DateTime> effectiveFrom,
  Value<int> rowid,
});

class $$PriceHistoryTableTableFilterComposer
    extends Composer<_$AppDatabase, $PriceHistoryTableTable> {
  $$PriceHistoryTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get productId => $composableBuilder(
      column: $table.productId, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get effectiveFrom => $composableBuilder(
      column: $table.effectiveFrom, builder: (column) => ColumnFilters(column));
}

class $$PriceHistoryTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PriceHistoryTableTable> {
  $$PriceHistoryTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get productId => $composableBuilder(
      column: $table.productId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get effectiveFrom => $composableBuilder(
      column: $table.effectiveFrom,
      builder: (column) => ColumnOrderings(column));
}

class $$PriceHistoryTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PriceHistoryTableTable> {
  $$PriceHistoryTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<DateTime> get effectiveFrom => $composableBuilder(
      column: $table.effectiveFrom, builder: (column) => column);
}

class $$PriceHistoryTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PriceHistoryTableTable,
    PriceHistoryTableData,
    $$PriceHistoryTableTableFilterComposer,
    $$PriceHistoryTableTableOrderingComposer,
    $$PriceHistoryTableTableAnnotationComposer,
    $$PriceHistoryTableTableCreateCompanionBuilder,
    $$PriceHistoryTableTableUpdateCompanionBuilder,
    (
      PriceHistoryTableData,
      BaseReferences<_$AppDatabase, $PriceHistoryTableTable,
          PriceHistoryTableData>
    ),
    PriceHistoryTableData,
    PrefetchHooks Function()> {
  $$PriceHistoryTableTableTableManager(
      _$AppDatabase db, $PriceHistoryTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PriceHistoryTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PriceHistoryTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PriceHistoryTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> productId = const Value.absent(),
            Value<double> price = const Value.absent(),
            Value<DateTime> effectiveFrom = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PriceHistoryTableCompanion(
            id: id,
            productId: productId,
            price: price,
            effectiveFrom: effectiveFrom,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String productId,
            required double price,
            required DateTime effectiveFrom,
            Value<int> rowid = const Value.absent(),
          }) =>
              PriceHistoryTableCompanion.insert(
            id: id,
            productId: productId,
            price: price,
            effectiveFrom: effectiveFrom,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PriceHistoryTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PriceHistoryTableTable,
    PriceHistoryTableData,
    $$PriceHistoryTableTableFilterComposer,
    $$PriceHistoryTableTableOrderingComposer,
    $$PriceHistoryTableTableAnnotationComposer,
    $$PriceHistoryTableTableCreateCompanionBuilder,
    $$PriceHistoryTableTableUpdateCompanionBuilder,
    (
      PriceHistoryTableData,
      BaseReferences<_$AppDatabase, $PriceHistoryTableTable,
          PriceHistoryTableData>
    ),
    PriceHistoryTableData,
    PrefetchHooks Function()>;
typedef $$TourPlansTableTableCreateCompanionBuilder = TourPlansTableCompanion
    Function({
  required String id,
  required String tenantId,
  required String repId,
  required DateTime plannedDate,
  required String routeOptimizationOrder,
  required String status,
  Value<String?> managerComment,
  required DateTime clientCreatedAt,
  Value<DateTime> lastModifiedAt,
  Value<bool> isDeleted,
  Value<int> rowid,
});
typedef $$TourPlansTableTableUpdateCompanionBuilder = TourPlansTableCompanion
    Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String> repId,
  Value<DateTime> plannedDate,
  Value<String> routeOptimizationOrder,
  Value<String> status,
  Value<String?> managerComment,
  Value<DateTime> clientCreatedAt,
  Value<DateTime> lastModifiedAt,
  Value<bool> isDeleted,
  Value<int> rowid,
});

class $$TourPlansTableTableFilterComposer
    extends Composer<_$AppDatabase, $TourPlansTableTable> {
  $$TourPlansTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get repId => $composableBuilder(
      column: $table.repId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get plannedDate => $composableBuilder(
      column: $table.plannedDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get routeOptimizationOrder => $composableBuilder(
      column: $table.routeOptimizationOrder,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get managerComment => $composableBuilder(
      column: $table.managerComment,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get clientCreatedAt => $composableBuilder(
      column: $table.clientCreatedAt,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastModifiedAt => $composableBuilder(
      column: $table.lastModifiedAt,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));
}

class $$TourPlansTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TourPlansTableTable> {
  $$TourPlansTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get repId => $composableBuilder(
      column: $table.repId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get plannedDate => $composableBuilder(
      column: $table.plannedDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get routeOptimizationOrder => $composableBuilder(
      column: $table.routeOptimizationOrder,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get managerComment => $composableBuilder(
      column: $table.managerComment,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get clientCreatedAt => $composableBuilder(
      column: $table.clientCreatedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastModifiedAt => $composableBuilder(
      column: $table.lastModifiedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));
}

class $$TourPlansTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TourPlansTableTable> {
  $$TourPlansTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get repId =>
      $composableBuilder(column: $table.repId, builder: (column) => column);

  GeneratedColumn<DateTime> get plannedDate => $composableBuilder(
      column: $table.plannedDate, builder: (column) => column);

  GeneratedColumn<String> get routeOptimizationOrder => $composableBuilder(
      column: $table.routeOptimizationOrder, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get managerComment => $composableBuilder(
      column: $table.managerComment, builder: (column) => column);

  GeneratedColumn<DateTime> get clientCreatedAt => $composableBuilder(
      column: $table.clientCreatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastModifiedAt => $composableBuilder(
      column: $table.lastModifiedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);
}

class $$TourPlansTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TourPlansTableTable,
    TourPlansTableData,
    $$TourPlansTableTableFilterComposer,
    $$TourPlansTableTableOrderingComposer,
    $$TourPlansTableTableAnnotationComposer,
    $$TourPlansTableTableCreateCompanionBuilder,
    $$TourPlansTableTableUpdateCompanionBuilder,
    (
      TourPlansTableData,
      BaseReferences<_$AppDatabase, $TourPlansTableTable, TourPlansTableData>
    ),
    TourPlansTableData,
    PrefetchHooks Function()> {
  $$TourPlansTableTableTableManager(
      _$AppDatabase db, $TourPlansTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TourPlansTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TourPlansTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TourPlansTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tenantId = const Value.absent(),
            Value<String> repId = const Value.absent(),
            Value<DateTime> plannedDate = const Value.absent(),
            Value<String> routeOptimizationOrder = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> managerComment = const Value.absent(),
            Value<DateTime> clientCreatedAt = const Value.absent(),
            Value<DateTime> lastModifiedAt = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TourPlansTableCompanion(
            id: id,
            tenantId: tenantId,
            repId: repId,
            plannedDate: plannedDate,
            routeOptimizationOrder: routeOptimizationOrder,
            status: status,
            managerComment: managerComment,
            clientCreatedAt: clientCreatedAt,
            lastModifiedAt: lastModifiedAt,
            isDeleted: isDeleted,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
            required String repId,
            required DateTime plannedDate,
            required String routeOptimizationOrder,
            required String status,
            Value<String?> managerComment = const Value.absent(),
            required DateTime clientCreatedAt,
            Value<DateTime> lastModifiedAt = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TourPlansTableCompanion.insert(
            id: id,
            tenantId: tenantId,
            repId: repId,
            plannedDate: plannedDate,
            routeOptimizationOrder: routeOptimizationOrder,
            status: status,
            managerComment: managerComment,
            clientCreatedAt: clientCreatedAt,
            lastModifiedAt: lastModifiedAt,
            isDeleted: isDeleted,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TourPlansTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TourPlansTableTable,
    TourPlansTableData,
    $$TourPlansTableTableFilterComposer,
    $$TourPlansTableTableOrderingComposer,
    $$TourPlansTableTableAnnotationComposer,
    $$TourPlansTableTableCreateCompanionBuilder,
    $$TourPlansTableTableUpdateCompanionBuilder,
    (
      TourPlansTableData,
      BaseReferences<_$AppDatabase, $TourPlansTableTable, TourPlansTableData>
    ),
    TourPlansTableData,
    PrefetchHooks Function()>;
typedef $$TourPlanStopsTableTableCreateCompanionBuilder
    = TourPlanStopsTableCompanion Function({
  required String id,
  required String tourPlanId,
  required String targetType,
  required String targetId,
  required int sequenceOrder,
  Value<bool> checkedIn,
  Value<DateTime?> checkInTime,
  Value<double?> checkInLatitude,
  Value<double?> checkInLongitude,
  Value<String?> deviationReason,
  Value<int> rowid,
});
typedef $$TourPlanStopsTableTableUpdateCompanionBuilder
    = TourPlanStopsTableCompanion Function({
  Value<String> id,
  Value<String> tourPlanId,
  Value<String> targetType,
  Value<String> targetId,
  Value<int> sequenceOrder,
  Value<bool> checkedIn,
  Value<DateTime?> checkInTime,
  Value<double?> checkInLatitude,
  Value<double?> checkInLongitude,
  Value<String?> deviationReason,
  Value<int> rowid,
});

class $$TourPlanStopsTableTableFilterComposer
    extends Composer<_$AppDatabase, $TourPlanStopsTableTable> {
  $$TourPlanStopsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tourPlanId => $composableBuilder(
      column: $table.tourPlanId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get targetType => $composableBuilder(
      column: $table.targetType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get targetId => $composableBuilder(
      column: $table.targetId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sequenceOrder => $composableBuilder(
      column: $table.sequenceOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get checkedIn => $composableBuilder(
      column: $table.checkedIn, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get checkInTime => $composableBuilder(
      column: $table.checkInTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get checkInLatitude => $composableBuilder(
      column: $table.checkInLatitude,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get checkInLongitude => $composableBuilder(
      column: $table.checkInLongitude,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deviationReason => $composableBuilder(
      column: $table.deviationReason,
      builder: (column) => ColumnFilters(column));
}

class $$TourPlanStopsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TourPlanStopsTableTable> {
  $$TourPlanStopsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tourPlanId => $composableBuilder(
      column: $table.tourPlanId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get targetType => $composableBuilder(
      column: $table.targetType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get targetId => $composableBuilder(
      column: $table.targetId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sequenceOrder => $composableBuilder(
      column: $table.sequenceOrder,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get checkedIn => $composableBuilder(
      column: $table.checkedIn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get checkInTime => $composableBuilder(
      column: $table.checkInTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get checkInLatitude => $composableBuilder(
      column: $table.checkInLatitude,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get checkInLongitude => $composableBuilder(
      column: $table.checkInLongitude,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deviationReason => $composableBuilder(
      column: $table.deviationReason,
      builder: (column) => ColumnOrderings(column));
}

class $$TourPlanStopsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TourPlanStopsTableTable> {
  $$TourPlanStopsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tourPlanId => $composableBuilder(
      column: $table.tourPlanId, builder: (column) => column);

  GeneratedColumn<String> get targetType => $composableBuilder(
      column: $table.targetType, builder: (column) => column);

  GeneratedColumn<String> get targetId =>
      $composableBuilder(column: $table.targetId, builder: (column) => column);

  GeneratedColumn<int> get sequenceOrder => $composableBuilder(
      column: $table.sequenceOrder, builder: (column) => column);

  GeneratedColumn<bool> get checkedIn =>
      $composableBuilder(column: $table.checkedIn, builder: (column) => column);

  GeneratedColumn<DateTime> get checkInTime => $composableBuilder(
      column: $table.checkInTime, builder: (column) => column);

  GeneratedColumn<double> get checkInLatitude => $composableBuilder(
      column: $table.checkInLatitude, builder: (column) => column);

  GeneratedColumn<double> get checkInLongitude => $composableBuilder(
      column: $table.checkInLongitude, builder: (column) => column);

  GeneratedColumn<String> get deviationReason => $composableBuilder(
      column: $table.deviationReason, builder: (column) => column);
}

class $$TourPlanStopsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TourPlanStopsTableTable,
    TourPlanStopsTableData,
    $$TourPlanStopsTableTableFilterComposer,
    $$TourPlanStopsTableTableOrderingComposer,
    $$TourPlanStopsTableTableAnnotationComposer,
    $$TourPlanStopsTableTableCreateCompanionBuilder,
    $$TourPlanStopsTableTableUpdateCompanionBuilder,
    (
      TourPlanStopsTableData,
      BaseReferences<_$AppDatabase, $TourPlanStopsTableTable,
          TourPlanStopsTableData>
    ),
    TourPlanStopsTableData,
    PrefetchHooks Function()> {
  $$TourPlanStopsTableTableTableManager(
      _$AppDatabase db, $TourPlanStopsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TourPlanStopsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TourPlanStopsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TourPlanStopsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tourPlanId = const Value.absent(),
            Value<String> targetType = const Value.absent(),
            Value<String> targetId = const Value.absent(),
            Value<int> sequenceOrder = const Value.absent(),
            Value<bool> checkedIn = const Value.absent(),
            Value<DateTime?> checkInTime = const Value.absent(),
            Value<double?> checkInLatitude = const Value.absent(),
            Value<double?> checkInLongitude = const Value.absent(),
            Value<String?> deviationReason = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TourPlanStopsTableCompanion(
            id: id,
            tourPlanId: tourPlanId,
            targetType: targetType,
            targetId: targetId,
            sequenceOrder: sequenceOrder,
            checkedIn: checkedIn,
            checkInTime: checkInTime,
            checkInLatitude: checkInLatitude,
            checkInLongitude: checkInLongitude,
            deviationReason: deviationReason,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tourPlanId,
            required String targetType,
            required String targetId,
            required int sequenceOrder,
            Value<bool> checkedIn = const Value.absent(),
            Value<DateTime?> checkInTime = const Value.absent(),
            Value<double?> checkInLatitude = const Value.absent(),
            Value<double?> checkInLongitude = const Value.absent(),
            Value<String?> deviationReason = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TourPlanStopsTableCompanion.insert(
            id: id,
            tourPlanId: tourPlanId,
            targetType: targetType,
            targetId: targetId,
            sequenceOrder: sequenceOrder,
            checkedIn: checkedIn,
            checkInTime: checkInTime,
            checkInLatitude: checkInLatitude,
            checkInLongitude: checkInLongitude,
            deviationReason: deviationReason,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TourPlanStopsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TourPlanStopsTableTable,
    TourPlanStopsTableData,
    $$TourPlanStopsTableTableFilterComposer,
    $$TourPlanStopsTableTableOrderingComposer,
    $$TourPlanStopsTableTableAnnotationComposer,
    $$TourPlanStopsTableTableCreateCompanionBuilder,
    $$TourPlanStopsTableTableUpdateCompanionBuilder,
    (
      TourPlanStopsTableData,
      BaseReferences<_$AppDatabase, $TourPlanStopsTableTable,
          TourPlanStopsTableData>
    ),
    TourPlanStopsTableData,
    PrefetchHooks Function()>;
typedef $$DcrsTableTableCreateCompanionBuilder = DcrsTableCompanion Function({
  required String id,
  required String repId,
  required DateTime date,
  required String status,
  Value<String?> managerComment,
  Value<String?> voiceMemoUrl,
  Value<DateTime?> submittedAt,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$DcrsTableTableUpdateCompanionBuilder = DcrsTableCompanion Function({
  Value<String> id,
  Value<String> repId,
  Value<DateTime> date,
  Value<String> status,
  Value<String?> managerComment,
  Value<String?> voiceMemoUrl,
  Value<DateTime?> submittedAt,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$DcrsTableTableFilterComposer
    extends Composer<_$AppDatabase, $DcrsTableTable> {
  $$DcrsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get repId => $composableBuilder(
      column: $table.repId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get managerComment => $composableBuilder(
      column: $table.managerComment,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get voiceMemoUrl => $composableBuilder(
      column: $table.voiceMemoUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get submittedAt => $composableBuilder(
      column: $table.submittedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$DcrsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $DcrsTableTable> {
  $$DcrsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get repId => $composableBuilder(
      column: $table.repId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get managerComment => $composableBuilder(
      column: $table.managerComment,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get voiceMemoUrl => $composableBuilder(
      column: $table.voiceMemoUrl,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get submittedAt => $composableBuilder(
      column: $table.submittedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$DcrsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $DcrsTableTable> {
  $$DcrsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get repId =>
      $composableBuilder(column: $table.repId, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get managerComment => $composableBuilder(
      column: $table.managerComment, builder: (column) => column);

  GeneratedColumn<String> get voiceMemoUrl => $composableBuilder(
      column: $table.voiceMemoUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get submittedAt => $composableBuilder(
      column: $table.submittedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$DcrsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DcrsTableTable,
    DcrsTableData,
    $$DcrsTableTableFilterComposer,
    $$DcrsTableTableOrderingComposer,
    $$DcrsTableTableAnnotationComposer,
    $$DcrsTableTableCreateCompanionBuilder,
    $$DcrsTableTableUpdateCompanionBuilder,
    (
      DcrsTableData,
      BaseReferences<_$AppDatabase, $DcrsTableTable, DcrsTableData>
    ),
    DcrsTableData,
    PrefetchHooks Function()> {
  $$DcrsTableTableTableManager(_$AppDatabase db, $DcrsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DcrsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DcrsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DcrsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> repId = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> managerComment = const Value.absent(),
            Value<String?> voiceMemoUrl = const Value.absent(),
            Value<DateTime?> submittedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DcrsTableCompanion(
            id: id,
            repId: repId,
            date: date,
            status: status,
            managerComment: managerComment,
            voiceMemoUrl: voiceMemoUrl,
            submittedAt: submittedAt,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String repId,
            required DateTime date,
            required String status,
            Value<String?> managerComment = const Value.absent(),
            Value<String?> voiceMemoUrl = const Value.absent(),
            Value<DateTime?> submittedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DcrsTableCompanion.insert(
            id: id,
            repId: repId,
            date: date,
            status: status,
            managerComment: managerComment,
            voiceMemoUrl: voiceMemoUrl,
            submittedAt: submittedAt,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DcrsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DcrsTableTable,
    DcrsTableData,
    $$DcrsTableTableFilterComposer,
    $$DcrsTableTableOrderingComposer,
    $$DcrsTableTableAnnotationComposer,
    $$DcrsTableTableCreateCompanionBuilder,
    $$DcrsTableTableUpdateCompanionBuilder,
    (
      DcrsTableData,
      BaseReferences<_$AppDatabase, $DcrsTableTable, DcrsTableData>
    ),
    DcrsTableData,
    PrefetchHooks Function()>;
typedef $$DcrDoctorVisitsTableTableCreateCompanionBuilder
    = DcrDoctorVisitsTableCompanion Function({
  required String id,
  required String dcrId,
  required String doctorId,
  required String session,
  Value<DateTime?> visitTime,
  Value<String?> callOutcome,
  Value<String?> notes,
  Value<double?> gpsLat,
  Value<double?> gpsLng,
  Value<String?> photoUrl,
  Value<bool> isPlanned,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$DcrDoctorVisitsTableTableUpdateCompanionBuilder
    = DcrDoctorVisitsTableCompanion Function({
  Value<String> id,
  Value<String> dcrId,
  Value<String> doctorId,
  Value<String> session,
  Value<DateTime?> visitTime,
  Value<String?> callOutcome,
  Value<String?> notes,
  Value<double?> gpsLat,
  Value<double?> gpsLng,
  Value<String?> photoUrl,
  Value<bool> isPlanned,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$DcrDoctorVisitsTableTableFilterComposer
    extends Composer<_$AppDatabase, $DcrDoctorVisitsTableTable> {
  $$DcrDoctorVisitsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dcrId => $composableBuilder(
      column: $table.dcrId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get doctorId => $composableBuilder(
      column: $table.doctorId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get session => $composableBuilder(
      column: $table.session, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get visitTime => $composableBuilder(
      column: $table.visitTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get callOutcome => $composableBuilder(
      column: $table.callOutcome, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get gpsLat => $composableBuilder(
      column: $table.gpsLat, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get gpsLng => $composableBuilder(
      column: $table.gpsLng, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get photoUrl => $composableBuilder(
      column: $table.photoUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isPlanned => $composableBuilder(
      column: $table.isPlanned, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$DcrDoctorVisitsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $DcrDoctorVisitsTableTable> {
  $$DcrDoctorVisitsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dcrId => $composableBuilder(
      column: $table.dcrId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get doctorId => $composableBuilder(
      column: $table.doctorId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get session => $composableBuilder(
      column: $table.session, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get visitTime => $composableBuilder(
      column: $table.visitTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get callOutcome => $composableBuilder(
      column: $table.callOutcome, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get gpsLat => $composableBuilder(
      column: $table.gpsLat, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get gpsLng => $composableBuilder(
      column: $table.gpsLng, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get photoUrl => $composableBuilder(
      column: $table.photoUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isPlanned => $composableBuilder(
      column: $table.isPlanned, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$DcrDoctorVisitsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $DcrDoctorVisitsTableTable> {
  $$DcrDoctorVisitsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get dcrId =>
      $composableBuilder(column: $table.dcrId, builder: (column) => column);

  GeneratedColumn<String> get doctorId =>
      $composableBuilder(column: $table.doctorId, builder: (column) => column);

  GeneratedColumn<String> get session =>
      $composableBuilder(column: $table.session, builder: (column) => column);

  GeneratedColumn<DateTime> get visitTime =>
      $composableBuilder(column: $table.visitTime, builder: (column) => column);

  GeneratedColumn<String> get callOutcome => $composableBuilder(
      column: $table.callOutcome, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<double> get gpsLat =>
      $composableBuilder(column: $table.gpsLat, builder: (column) => column);

  GeneratedColumn<double> get gpsLng =>
      $composableBuilder(column: $table.gpsLng, builder: (column) => column);

  GeneratedColumn<String> get photoUrl =>
      $composableBuilder(column: $table.photoUrl, builder: (column) => column);

  GeneratedColumn<bool> get isPlanned =>
      $composableBuilder(column: $table.isPlanned, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$DcrDoctorVisitsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DcrDoctorVisitsTableTable,
    DcrDoctorVisitsTableData,
    $$DcrDoctorVisitsTableTableFilterComposer,
    $$DcrDoctorVisitsTableTableOrderingComposer,
    $$DcrDoctorVisitsTableTableAnnotationComposer,
    $$DcrDoctorVisitsTableTableCreateCompanionBuilder,
    $$DcrDoctorVisitsTableTableUpdateCompanionBuilder,
    (
      DcrDoctorVisitsTableData,
      BaseReferences<_$AppDatabase, $DcrDoctorVisitsTableTable,
          DcrDoctorVisitsTableData>
    ),
    DcrDoctorVisitsTableData,
    PrefetchHooks Function()> {
  $$DcrDoctorVisitsTableTableTableManager(
      _$AppDatabase db, $DcrDoctorVisitsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DcrDoctorVisitsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DcrDoctorVisitsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DcrDoctorVisitsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> dcrId = const Value.absent(),
            Value<String> doctorId = const Value.absent(),
            Value<String> session = const Value.absent(),
            Value<DateTime?> visitTime = const Value.absent(),
            Value<String?> callOutcome = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<double?> gpsLat = const Value.absent(),
            Value<double?> gpsLng = const Value.absent(),
            Value<String?> photoUrl = const Value.absent(),
            Value<bool> isPlanned = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DcrDoctorVisitsTableCompanion(
            id: id,
            dcrId: dcrId,
            doctorId: doctorId,
            session: session,
            visitTime: visitTime,
            callOutcome: callOutcome,
            notes: notes,
            gpsLat: gpsLat,
            gpsLng: gpsLng,
            photoUrl: photoUrl,
            isPlanned: isPlanned,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String dcrId,
            required String doctorId,
            required String session,
            Value<DateTime?> visitTime = const Value.absent(),
            Value<String?> callOutcome = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<double?> gpsLat = const Value.absent(),
            Value<double?> gpsLng = const Value.absent(),
            Value<String?> photoUrl = const Value.absent(),
            Value<bool> isPlanned = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DcrDoctorVisitsTableCompanion.insert(
            id: id,
            dcrId: dcrId,
            doctorId: doctorId,
            session: session,
            visitTime: visitTime,
            callOutcome: callOutcome,
            notes: notes,
            gpsLat: gpsLat,
            gpsLng: gpsLng,
            photoUrl: photoUrl,
            isPlanned: isPlanned,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DcrDoctorVisitsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $DcrDoctorVisitsTableTable,
        DcrDoctorVisitsTableData,
        $$DcrDoctorVisitsTableTableFilterComposer,
        $$DcrDoctorVisitsTableTableOrderingComposer,
        $$DcrDoctorVisitsTableTableAnnotationComposer,
        $$DcrDoctorVisitsTableTableCreateCompanionBuilder,
        $$DcrDoctorVisitsTableTableUpdateCompanionBuilder,
        (
          DcrDoctorVisitsTableData,
          BaseReferences<_$AppDatabase, $DcrDoctorVisitsTableTable,
              DcrDoctorVisitsTableData>
        ),
        DcrDoctorVisitsTableData,
        PrefetchHooks Function()>;
typedef $$DcrChemistVisitsTableTableCreateCompanionBuilder
    = DcrChemistVisitsTableCompanion Function({
  required String id,
  required String dcrId,
  required String chemistId,
  required String session,
  Value<DateTime?> visitTime,
  Value<String?> notes,
  Value<double?> gpsLat,
  Value<double?> gpsLng,
  Value<String?> photoUrl,
  Value<bool> isPlanned,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$DcrChemistVisitsTableTableUpdateCompanionBuilder
    = DcrChemistVisitsTableCompanion Function({
  Value<String> id,
  Value<String> dcrId,
  Value<String> chemistId,
  Value<String> session,
  Value<DateTime?> visitTime,
  Value<String?> notes,
  Value<double?> gpsLat,
  Value<double?> gpsLng,
  Value<String?> photoUrl,
  Value<bool> isPlanned,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$DcrChemistVisitsTableTableFilterComposer
    extends Composer<_$AppDatabase, $DcrChemistVisitsTableTable> {
  $$DcrChemistVisitsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dcrId => $composableBuilder(
      column: $table.dcrId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get chemistId => $composableBuilder(
      column: $table.chemistId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get session => $composableBuilder(
      column: $table.session, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get visitTime => $composableBuilder(
      column: $table.visitTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get gpsLat => $composableBuilder(
      column: $table.gpsLat, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get gpsLng => $composableBuilder(
      column: $table.gpsLng, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get photoUrl => $composableBuilder(
      column: $table.photoUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isPlanned => $composableBuilder(
      column: $table.isPlanned, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$DcrChemistVisitsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $DcrChemistVisitsTableTable> {
  $$DcrChemistVisitsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dcrId => $composableBuilder(
      column: $table.dcrId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get chemistId => $composableBuilder(
      column: $table.chemistId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get session => $composableBuilder(
      column: $table.session, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get visitTime => $composableBuilder(
      column: $table.visitTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get gpsLat => $composableBuilder(
      column: $table.gpsLat, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get gpsLng => $composableBuilder(
      column: $table.gpsLng, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get photoUrl => $composableBuilder(
      column: $table.photoUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isPlanned => $composableBuilder(
      column: $table.isPlanned, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$DcrChemistVisitsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $DcrChemistVisitsTableTable> {
  $$DcrChemistVisitsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get dcrId =>
      $composableBuilder(column: $table.dcrId, builder: (column) => column);

  GeneratedColumn<String> get chemistId =>
      $composableBuilder(column: $table.chemistId, builder: (column) => column);

  GeneratedColumn<String> get session =>
      $composableBuilder(column: $table.session, builder: (column) => column);

  GeneratedColumn<DateTime> get visitTime =>
      $composableBuilder(column: $table.visitTime, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<double> get gpsLat =>
      $composableBuilder(column: $table.gpsLat, builder: (column) => column);

  GeneratedColumn<double> get gpsLng =>
      $composableBuilder(column: $table.gpsLng, builder: (column) => column);

  GeneratedColumn<String> get photoUrl =>
      $composableBuilder(column: $table.photoUrl, builder: (column) => column);

  GeneratedColumn<bool> get isPlanned =>
      $composableBuilder(column: $table.isPlanned, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$DcrChemistVisitsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DcrChemistVisitsTableTable,
    DcrChemistVisitsTableData,
    $$DcrChemistVisitsTableTableFilterComposer,
    $$DcrChemistVisitsTableTableOrderingComposer,
    $$DcrChemistVisitsTableTableAnnotationComposer,
    $$DcrChemistVisitsTableTableCreateCompanionBuilder,
    $$DcrChemistVisitsTableTableUpdateCompanionBuilder,
    (
      DcrChemistVisitsTableData,
      BaseReferences<_$AppDatabase, $DcrChemistVisitsTableTable,
          DcrChemistVisitsTableData>
    ),
    DcrChemistVisitsTableData,
    PrefetchHooks Function()> {
  $$DcrChemistVisitsTableTableTableManager(
      _$AppDatabase db, $DcrChemistVisitsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DcrChemistVisitsTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$DcrChemistVisitsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DcrChemistVisitsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> dcrId = const Value.absent(),
            Value<String> chemistId = const Value.absent(),
            Value<String> session = const Value.absent(),
            Value<DateTime?> visitTime = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<double?> gpsLat = const Value.absent(),
            Value<double?> gpsLng = const Value.absent(),
            Value<String?> photoUrl = const Value.absent(),
            Value<bool> isPlanned = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DcrChemistVisitsTableCompanion(
            id: id,
            dcrId: dcrId,
            chemistId: chemistId,
            session: session,
            visitTime: visitTime,
            notes: notes,
            gpsLat: gpsLat,
            gpsLng: gpsLng,
            photoUrl: photoUrl,
            isPlanned: isPlanned,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String dcrId,
            required String chemistId,
            required String session,
            Value<DateTime?> visitTime = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<double?> gpsLat = const Value.absent(),
            Value<double?> gpsLng = const Value.absent(),
            Value<String?> photoUrl = const Value.absent(),
            Value<bool> isPlanned = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DcrChemistVisitsTableCompanion.insert(
            id: id,
            dcrId: dcrId,
            chemistId: chemistId,
            session: session,
            visitTime: visitTime,
            notes: notes,
            gpsLat: gpsLat,
            gpsLng: gpsLng,
            photoUrl: photoUrl,
            isPlanned: isPlanned,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DcrChemistVisitsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $DcrChemistVisitsTableTable,
        DcrChemistVisitsTableData,
        $$DcrChemistVisitsTableTableFilterComposer,
        $$DcrChemistVisitsTableTableOrderingComposer,
        $$DcrChemistVisitsTableTableAnnotationComposer,
        $$DcrChemistVisitsTableTableCreateCompanionBuilder,
        $$DcrChemistVisitsTableTableUpdateCompanionBuilder,
        (
          DcrChemistVisitsTableData,
          BaseReferences<_$AppDatabase, $DcrChemistVisitsTableTable,
              DcrChemistVisitsTableData>
        ),
        DcrChemistVisitsTableData,
        PrefetchHooks Function()>;
typedef $$DcrVisitProductsTableTableCreateCompanionBuilder
    = DcrVisitProductsTableCompanion Function({
  required String id,
  required String visitId,
  required String productId,
  Value<int> rowid,
});
typedef $$DcrVisitProductsTableTableUpdateCompanionBuilder
    = DcrVisitProductsTableCompanion Function({
  Value<String> id,
  Value<String> visitId,
  Value<String> productId,
  Value<int> rowid,
});

class $$DcrVisitProductsTableTableFilterComposer
    extends Composer<_$AppDatabase, $DcrVisitProductsTableTable> {
  $$DcrVisitProductsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get visitId => $composableBuilder(
      column: $table.visitId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get productId => $composableBuilder(
      column: $table.productId, builder: (column) => ColumnFilters(column));
}

class $$DcrVisitProductsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $DcrVisitProductsTableTable> {
  $$DcrVisitProductsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get visitId => $composableBuilder(
      column: $table.visitId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get productId => $composableBuilder(
      column: $table.productId, builder: (column) => ColumnOrderings(column));
}

class $$DcrVisitProductsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $DcrVisitProductsTableTable> {
  $$DcrVisitProductsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get visitId =>
      $composableBuilder(column: $table.visitId, builder: (column) => column);

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);
}

class $$DcrVisitProductsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DcrVisitProductsTableTable,
    DcrVisitProductsTableData,
    $$DcrVisitProductsTableTableFilterComposer,
    $$DcrVisitProductsTableTableOrderingComposer,
    $$DcrVisitProductsTableTableAnnotationComposer,
    $$DcrVisitProductsTableTableCreateCompanionBuilder,
    $$DcrVisitProductsTableTableUpdateCompanionBuilder,
    (
      DcrVisitProductsTableData,
      BaseReferences<_$AppDatabase, $DcrVisitProductsTableTable,
          DcrVisitProductsTableData>
    ),
    DcrVisitProductsTableData,
    PrefetchHooks Function()> {
  $$DcrVisitProductsTableTableTableManager(
      _$AppDatabase db, $DcrVisitProductsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DcrVisitProductsTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$DcrVisitProductsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DcrVisitProductsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> visitId = const Value.absent(),
            Value<String> productId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DcrVisitProductsTableCompanion(
            id: id,
            visitId: visitId,
            productId: productId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String visitId,
            required String productId,
            Value<int> rowid = const Value.absent(),
          }) =>
              DcrVisitProductsTableCompanion.insert(
            id: id,
            visitId: visitId,
            productId: productId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DcrVisitProductsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $DcrVisitProductsTableTable,
        DcrVisitProductsTableData,
        $$DcrVisitProductsTableTableFilterComposer,
        $$DcrVisitProductsTableTableOrderingComposer,
        $$DcrVisitProductsTableTableAnnotationComposer,
        $$DcrVisitProductsTableTableCreateCompanionBuilder,
        $$DcrVisitProductsTableTableUpdateCompanionBuilder,
        (
          DcrVisitProductsTableData,
          BaseReferences<_$AppDatabase, $DcrVisitProductsTableTable,
              DcrVisitProductsTableData>
        ),
        DcrVisitProductsTableData,
        PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SyncQueueTableTableTableManager get syncQueueTable =>
      $$SyncQueueTableTableTableManager(_db, _db.syncQueueTable);
  $$CachedApiTableTableTableManager get cachedApiTable =>
      $$CachedApiTableTableTableManager(_db, _db.cachedApiTable);
  $$DoctorsTableTableTableManager get doctorsTable =>
      $$DoctorsTableTableTableManager(_db, _db.doctorsTable);
  $$ChemistsTableTableTableManager get chemistsTable =>
      $$ChemistsTableTableTableManager(_db, _db.chemistsTable);
  $$ProductsTableTableTableManager get productsTable =>
      $$ProductsTableTableTableManager(_db, _db.productsTable);
  $$PriceHistoryTableTableTableManager get priceHistoryTable =>
      $$PriceHistoryTableTableTableManager(_db, _db.priceHistoryTable);
  $$TourPlansTableTableTableManager get tourPlansTable =>
      $$TourPlansTableTableTableManager(_db, _db.tourPlansTable);
  $$TourPlanStopsTableTableTableManager get tourPlanStopsTable =>
      $$TourPlanStopsTableTableTableManager(_db, _db.tourPlanStopsTable);
  $$DcrsTableTableTableManager get dcrsTable =>
      $$DcrsTableTableTableManager(_db, _db.dcrsTable);
  $$DcrDoctorVisitsTableTableTableManager get dcrDoctorVisitsTable =>
      $$DcrDoctorVisitsTableTableTableManager(_db, _db.dcrDoctorVisitsTable);
  $$DcrChemistVisitsTableTableTableManager get dcrChemistVisitsTable =>
      $$DcrChemistVisitsTableTableTableManager(_db, _db.dcrChemistVisitsTable);
  $$DcrVisitProductsTableTableTableManager get dcrVisitProductsTable =>
      $$DcrVisitProductsTableTableTableManager(_db, _db.dcrVisitProductsTable);
}
