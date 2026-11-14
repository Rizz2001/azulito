// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SyncQueueTable extends SyncQueue
    with TableInfo<$SyncQueueTable, SyncQueueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _targetTableMeta =
      const VerificationMeta('targetTable');
  @override
  late final GeneratedColumn<String> targetTable = GeneratedColumn<String>(
      'target_table', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _entityIdMeta =
      const VerificationMeta('entityId');
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
      'entity_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _operationMeta =
      const VerificationMeta('operation');
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
      'operation', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _payloadMeta =
      const VerificationMeta('payload');
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
      'payload', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _attemptsMeta =
      const VerificationMeta('attempts');
  @override
  late final GeneratedColumn<int> attempts = GeneratedColumn<int>(
      'attempts', aliasedName, false,
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
  @override
  List<GeneratedColumn> get $columns => [
        id,
        targetTable,
        entityId,
        operation,
        payload,
        status,
        attempts,
        errorMessage,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue';
  @override
  VerificationContext validateIntegrity(Insertable<SyncQueueData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('target_table')) {
      context.handle(
          _targetTableMeta,
          targetTable.isAcceptableOrUnknown(
              data['target_table']!, _targetTableMeta));
    } else if (isInserting) {
      context.missing(_targetTableMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(_entityIdMeta,
          entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta));
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(_operationMeta,
          operation.isAcceptableOrUnknown(data['operation']!, _operationMeta));
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(_payloadMeta,
          payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta));
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('attempts')) {
      context.handle(_attemptsMeta,
          attempts.isAcceptableOrUnknown(data['attempts']!, _attemptsMeta));
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      targetTable: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}target_table'])!,
      entityId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_id'])!,
      operation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}operation'])!,
      payload: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payload'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      attempts: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}attempts'])!,
      errorMessage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}error_message']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SyncQueueTable createAlias(String alias) {
    return $SyncQueueTable(attachedDatabase, alias);
  }
}

class SyncQueueData extends DataClass implements Insertable<SyncQueueData> {
  final String id;
  final String targetTable;
  final String entityId;
  final String operation;
  final String payload;
  final String status;
  final int attempts;
  final String? errorMessage;
  final DateTime createdAt;
  const SyncQueueData(
      {required this.id,
      required this.targetTable,
      required this.entityId,
      required this.operation,
      required this.payload,
      required this.status,
      required this.attempts,
      this.errorMessage,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['target_table'] = Variable<String>(targetTable);
    map['entity_id'] = Variable<String>(entityId);
    map['operation'] = Variable<String>(operation);
    map['payload'] = Variable<String>(payload);
    map['status'] = Variable<String>(status);
    map['attempts'] = Variable<int>(attempts);
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SyncQueueCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueCompanion(
      id: Value(id),
      targetTable: Value(targetTable),
      entityId: Value(entityId),
      operation: Value(operation),
      payload: Value(payload),
      status: Value(status),
      attempts: Value(attempts),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
      createdAt: Value(createdAt),
    );
  }

  factory SyncQueueData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueData(
      id: serializer.fromJson<String>(json['id']),
      targetTable: serializer.fromJson<String>(json['targetTable']),
      entityId: serializer.fromJson<String>(json['entityId']),
      operation: serializer.fromJson<String>(json['operation']),
      payload: serializer.fromJson<String>(json['payload']),
      status: serializer.fromJson<String>(json['status']),
      attempts: serializer.fromJson<int>(json['attempts']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'targetTable': serializer.toJson<String>(targetTable),
      'entityId': serializer.toJson<String>(entityId),
      'operation': serializer.toJson<String>(operation),
      'payload': serializer.toJson<String>(payload),
      'status': serializer.toJson<String>(status),
      'attempts': serializer.toJson<int>(attempts),
      'errorMessage': serializer.toJson<String?>(errorMessage),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SyncQueueData copyWith(
          {String? id,
          String? targetTable,
          String? entityId,
          String? operation,
          String? payload,
          String? status,
          int? attempts,
          Value<String?> errorMessage = const Value.absent(),
          DateTime? createdAt}) =>
      SyncQueueData(
        id: id ?? this.id,
        targetTable: targetTable ?? this.targetTable,
        entityId: entityId ?? this.entityId,
        operation: operation ?? this.operation,
        payload: payload ?? this.payload,
        status: status ?? this.status,
        attempts: attempts ?? this.attempts,
        errorMessage:
            errorMessage.present ? errorMessage.value : this.errorMessage,
        createdAt: createdAt ?? this.createdAt,
      );
  SyncQueueData copyWithCompanion(SyncQueueCompanion data) {
    return SyncQueueData(
      id: data.id.present ? data.id.value : this.id,
      targetTable:
          data.targetTable.present ? data.targetTable.value : this.targetTable,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      operation: data.operation.present ? data.operation.value : this.operation,
      payload: data.payload.present ? data.payload.value : this.payload,
      status: data.status.present ? data.status.value : this.status,
      attempts: data.attempts.present ? data.attempts.value : this.attempts,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueData(')
          ..write('id: $id, ')
          ..write('targetTable: $targetTable, ')
          ..write('entityId: $entityId, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('status: $status, ')
          ..write('attempts: $attempts, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, targetTable, entityId, operation, payload,
      status, attempts, errorMessage, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueData &&
          other.id == this.id &&
          other.targetTable == this.targetTable &&
          other.entityId == this.entityId &&
          other.operation == this.operation &&
          other.payload == this.payload &&
          other.status == this.status &&
          other.attempts == this.attempts &&
          other.errorMessage == this.errorMessage &&
          other.createdAt == this.createdAt);
}

class SyncQueueCompanion extends UpdateCompanion<SyncQueueData> {
  final Value<String> id;
  final Value<String> targetTable;
  final Value<String> entityId;
  final Value<String> operation;
  final Value<String> payload;
  final Value<String> status;
  final Value<int> attempts;
  final Value<String?> errorMessage;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SyncQueueCompanion({
    this.id = const Value.absent(),
    this.targetTable = const Value.absent(),
    this.entityId = const Value.absent(),
    this.operation = const Value.absent(),
    this.payload = const Value.absent(),
    this.status = const Value.absent(),
    this.attempts = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncQueueCompanion.insert({
    required String id,
    required String targetTable,
    required String entityId,
    required String operation,
    required String payload,
    this.status = const Value.absent(),
    this.attempts = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        targetTable = Value(targetTable),
        entityId = Value(entityId),
        operation = Value(operation),
        payload = Value(payload);
  static Insertable<SyncQueueData> custom({
    Expression<String>? id,
    Expression<String>? targetTable,
    Expression<String>? entityId,
    Expression<String>? operation,
    Expression<String>? payload,
    Expression<String>? status,
    Expression<int>? attempts,
    Expression<String>? errorMessage,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (targetTable != null) 'target_table': targetTable,
      if (entityId != null) 'entity_id': entityId,
      if (operation != null) 'operation': operation,
      if (payload != null) 'payload': payload,
      if (status != null) 'status': status,
      if (attempts != null) 'attempts': attempts,
      if (errorMessage != null) 'error_message': errorMessage,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncQueueCompanion copyWith(
      {Value<String>? id,
      Value<String>? targetTable,
      Value<String>? entityId,
      Value<String>? operation,
      Value<String>? payload,
      Value<String>? status,
      Value<int>? attempts,
      Value<String?>? errorMessage,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return SyncQueueCompanion(
      id: id ?? this.id,
      targetTable: targetTable ?? this.targetTable,
      entityId: entityId ?? this.entityId,
      operation: operation ?? this.operation,
      payload: payload ?? this.payload,
      status: status ?? this.status,
      attempts: attempts ?? this.attempts,
      errorMessage: errorMessage ?? this.errorMessage,
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
    if (targetTable.present) {
      map['target_table'] = Variable<String>(targetTable.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (attempts.present) {
      map['attempts'] = Variable<int>(attempts.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
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
    return (StringBuffer('SyncQueueCompanion(')
          ..write('id: $id, ')
          ..write('targetTable: $targetTable, ')
          ..write('entityId: $entityId, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('status: $status, ')
          ..write('attempts: $attempts, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StoresTable extends Stores with TableInfo<$StoresTable, Store> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StoresTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _rifMeta = const VerificationMeta('rif');
  @override
  late final GeneratedColumn<String> rif = GeneratedColumn<String>(
      'rif', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _primaryColorMeta =
      const VerificationMeta('primaryColor');
  @override
  late final GeneratedColumn<String> primaryColor = GeneratedColumn<String>(
      'primary_color', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('#1E40AF'));
  static const VerificationMeta _secondaryColorMeta =
      const VerificationMeta('secondaryColor');
  @override
  late final GeneratedColumn<String> secondaryColor = GeneratedColumn<String>(
      'secondary_color', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('#0EA5E9'));
  static const VerificationMeta _defaultIgtfEnabledMeta =
      const VerificationMeta('defaultIgtfEnabled');
  @override
  late final GeneratedColumn<bool> defaultIgtfEnabled = GeneratedColumn<bool>(
      'default_igtf_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("default_igtf_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
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
        name,
        rif,
        phone,
        address,
        primaryColor,
        secondaryColor,
        defaultIgtfEnabled,
        isDeleted,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stores';
  @override
  VerificationContext validateIntegrity(Insertable<Store> instance,
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
    if (data.containsKey('rif')) {
      context.handle(
          _rifMeta, rif.isAcceptableOrUnknown(data['rif']!, _rifMeta));
    } else if (isInserting) {
      context.missing(_rifMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('primary_color')) {
      context.handle(
          _primaryColorMeta,
          primaryColor.isAcceptableOrUnknown(
              data['primary_color']!, _primaryColorMeta));
    }
    if (data.containsKey('secondary_color')) {
      context.handle(
          _secondaryColorMeta,
          secondaryColor.isAcceptableOrUnknown(
              data['secondary_color']!, _secondaryColorMeta));
    }
    if (data.containsKey('default_igtf_enabled')) {
      context.handle(
          _defaultIgtfEnabledMeta,
          defaultIgtfEnabled.isAcceptableOrUnknown(
              data['default_igtf_enabled']!, _defaultIgtfEnabledMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
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
  Store map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Store(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      rif: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}rif'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address']),
      primaryColor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}primary_color'])!,
      secondaryColor: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}secondary_color'])!,
      defaultIgtfEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}default_igtf_enabled'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $StoresTable createAlias(String alias) {
    return $StoresTable(attachedDatabase, alias);
  }
}

class Store extends DataClass implements Insertable<Store> {
  final String id;
  final String name;
  final String rif;
  final String? phone;
  final String? address;
  final String primaryColor;
  final String secondaryColor;
  final bool defaultIgtfEnabled;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Store(
      {required this.id,
      required this.name,
      required this.rif,
      this.phone,
      this.address,
      required this.primaryColor,
      required this.secondaryColor,
      required this.defaultIgtfEnabled,
      required this.isDeleted,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['rif'] = Variable<String>(rif);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    map['primary_color'] = Variable<String>(primaryColor);
    map['secondary_color'] = Variable<String>(secondaryColor);
    map['default_igtf_enabled'] = Variable<bool>(defaultIgtfEnabled);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  StoresCompanion toCompanion(bool nullToAbsent) {
    return StoresCompanion(
      id: Value(id),
      name: Value(name),
      rif: Value(rif),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      primaryColor: Value(primaryColor),
      secondaryColor: Value(secondaryColor),
      defaultIgtfEnabled: Value(defaultIgtfEnabled),
      isDeleted: Value(isDeleted),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Store.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Store(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      rif: serializer.fromJson<String>(json['rif']),
      phone: serializer.fromJson<String?>(json['phone']),
      address: serializer.fromJson<String?>(json['address']),
      primaryColor: serializer.fromJson<String>(json['primaryColor']),
      secondaryColor: serializer.fromJson<String>(json['secondaryColor']),
      defaultIgtfEnabled: serializer.fromJson<bool>(json['defaultIgtfEnabled']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'rif': serializer.toJson<String>(rif),
      'phone': serializer.toJson<String?>(phone),
      'address': serializer.toJson<String?>(address),
      'primaryColor': serializer.toJson<String>(primaryColor),
      'secondaryColor': serializer.toJson<String>(secondaryColor),
      'defaultIgtfEnabled': serializer.toJson<bool>(defaultIgtfEnabled),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Store copyWith(
          {String? id,
          String? name,
          String? rif,
          Value<String?> phone = const Value.absent(),
          Value<String?> address = const Value.absent(),
          String? primaryColor,
          String? secondaryColor,
          bool? defaultIgtfEnabled,
          bool? isDeleted,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Store(
        id: id ?? this.id,
        name: name ?? this.name,
        rif: rif ?? this.rif,
        phone: phone.present ? phone.value : this.phone,
        address: address.present ? address.value : this.address,
        primaryColor: primaryColor ?? this.primaryColor,
        secondaryColor: secondaryColor ?? this.secondaryColor,
        defaultIgtfEnabled: defaultIgtfEnabled ?? this.defaultIgtfEnabled,
        isDeleted: isDeleted ?? this.isDeleted,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Store copyWithCompanion(StoresCompanion data) {
    return Store(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      rif: data.rif.present ? data.rif.value : this.rif,
      phone: data.phone.present ? data.phone.value : this.phone,
      address: data.address.present ? data.address.value : this.address,
      primaryColor: data.primaryColor.present
          ? data.primaryColor.value
          : this.primaryColor,
      secondaryColor: data.secondaryColor.present
          ? data.secondaryColor.value
          : this.secondaryColor,
      defaultIgtfEnabled: data.defaultIgtfEnabled.present
          ? data.defaultIgtfEnabled.value
          : this.defaultIgtfEnabled,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Store(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('rif: $rif, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('primaryColor: $primaryColor, ')
          ..write('secondaryColor: $secondaryColor, ')
          ..write('defaultIgtfEnabled: $defaultIgtfEnabled, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, rif, phone, address, primaryColor,
      secondaryColor, defaultIgtfEnabled, isDeleted, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Store &&
          other.id == this.id &&
          other.name == this.name &&
          other.rif == this.rif &&
          other.phone == this.phone &&
          other.address == this.address &&
          other.primaryColor == this.primaryColor &&
          other.secondaryColor == this.secondaryColor &&
          other.defaultIgtfEnabled == this.defaultIgtfEnabled &&
          other.isDeleted == this.isDeleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class StoresCompanion extends UpdateCompanion<Store> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> rif;
  final Value<String?> phone;
  final Value<String?> address;
  final Value<String> primaryColor;
  final Value<String> secondaryColor;
  final Value<bool> defaultIgtfEnabled;
  final Value<bool> isDeleted;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const StoresCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.rif = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.primaryColor = const Value.absent(),
    this.secondaryColor = const Value.absent(),
    this.defaultIgtfEnabled = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StoresCompanion.insert({
    required String id,
    required String name,
    required String rif,
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.primaryColor = const Value.absent(),
    this.secondaryColor = const Value.absent(),
    this.defaultIgtfEnabled = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        rif = Value(rif);
  static Insertable<Store> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? rif,
    Expression<String>? phone,
    Expression<String>? address,
    Expression<String>? primaryColor,
    Expression<String>? secondaryColor,
    Expression<bool>? defaultIgtfEnabled,
    Expression<bool>? isDeleted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (rif != null) 'rif': rif,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (primaryColor != null) 'primary_color': primaryColor,
      if (secondaryColor != null) 'secondary_color': secondaryColor,
      if (defaultIgtfEnabled != null)
        'default_igtf_enabled': defaultIgtfEnabled,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StoresCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? rif,
      Value<String?>? phone,
      Value<String?>? address,
      Value<String>? primaryColor,
      Value<String>? secondaryColor,
      Value<bool>? defaultIgtfEnabled,
      Value<bool>? isDeleted,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return StoresCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      rif: rif ?? this.rif,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      defaultIgtfEnabled: defaultIgtfEnabled ?? this.defaultIgtfEnabled,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
    if (rif.present) {
      map['rif'] = Variable<String>(rif.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (primaryColor.present) {
      map['primary_color'] = Variable<String>(primaryColor.value);
    }
    if (secondaryColor.present) {
      map['secondary_color'] = Variable<String>(secondaryColor.value);
    }
    if (defaultIgtfEnabled.present) {
      map['default_igtf_enabled'] = Variable<bool>(defaultIgtfEnabled.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StoresCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('rif: $rif, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('primaryColor: $primaryColor, ')
          ..write('secondaryColor: $secondaryColor, ')
          ..write('defaultIgtfEnabled: $defaultIgtfEnabled, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExchangeRatesTable extends ExchangeRates
    with TableInfo<$ExchangeRatesTable, ExchangeRate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExchangeRatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _storeIdMeta =
      const VerificationMeta('storeId');
  @override
  late final GeneratedColumn<String> storeId = GeneratedColumn<String>(
      'store_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _rateMeta = const VerificationMeta('rate');
  @override
  late final GeneratedColumn<double> rate = GeneratedColumn<double>(
      'rate', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
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
  List<GeneratedColumn> get $columns =>
      [id, storeId, source, rate, isActive, isDeleted, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exchange_rates';
  @override
  VerificationContext validateIntegrity(Insertable<ExchangeRate> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('store_id')) {
      context.handle(_storeIdMeta,
          storeId.isAcceptableOrUnknown(data['store_id']!, _storeIdMeta));
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('rate')) {
      context.handle(
          _rateMeta, rate.isAcceptableOrUnknown(data['rate']!, _rateMeta));
    } else if (isInserting) {
      context.missing(_rateMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
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
  ExchangeRate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExchangeRate(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      storeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}store_id']),
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
      rate: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}rate'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ExchangeRatesTable createAlias(String alias) {
    return $ExchangeRatesTable(attachedDatabase, alias);
  }
}

class ExchangeRate extends DataClass implements Insertable<ExchangeRate> {
  final String id;
  final String? storeId;
  final String source;
  final double rate;
  final bool isActive;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ExchangeRate(
      {required this.id,
      this.storeId,
      required this.source,
      required this.rate,
      required this.isActive,
      required this.isDeleted,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || storeId != null) {
      map['store_id'] = Variable<String>(storeId);
    }
    map['source'] = Variable<String>(source);
    map['rate'] = Variable<double>(rate);
    map['is_active'] = Variable<bool>(isActive);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ExchangeRatesCompanion toCompanion(bool nullToAbsent) {
    return ExchangeRatesCompanion(
      id: Value(id),
      storeId: storeId == null && nullToAbsent
          ? const Value.absent()
          : Value(storeId),
      source: Value(source),
      rate: Value(rate),
      isActive: Value(isActive),
      isDeleted: Value(isDeleted),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ExchangeRate.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExchangeRate(
      id: serializer.fromJson<String>(json['id']),
      storeId: serializer.fromJson<String?>(json['storeId']),
      source: serializer.fromJson<String>(json['source']),
      rate: serializer.fromJson<double>(json['rate']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'storeId': serializer.toJson<String?>(storeId),
      'source': serializer.toJson<String>(source),
      'rate': serializer.toJson<double>(rate),
      'isActive': serializer.toJson<bool>(isActive),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ExchangeRate copyWith(
          {String? id,
          Value<String?> storeId = const Value.absent(),
          String? source,
          double? rate,
          bool? isActive,
          bool? isDeleted,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      ExchangeRate(
        id: id ?? this.id,
        storeId: storeId.present ? storeId.value : this.storeId,
        source: source ?? this.source,
        rate: rate ?? this.rate,
        isActive: isActive ?? this.isActive,
        isDeleted: isDeleted ?? this.isDeleted,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  ExchangeRate copyWithCompanion(ExchangeRatesCompanion data) {
    return ExchangeRate(
      id: data.id.present ? data.id.value : this.id,
      storeId: data.storeId.present ? data.storeId.value : this.storeId,
      source: data.source.present ? data.source.value : this.source,
      rate: data.rate.present ? data.rate.value : this.rate,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExchangeRate(')
          ..write('id: $id, ')
          ..write('storeId: $storeId, ')
          ..write('source: $source, ')
          ..write('rate: $rate, ')
          ..write('isActive: $isActive, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, storeId, source, rate, isActive, isDeleted, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExchangeRate &&
          other.id == this.id &&
          other.storeId == this.storeId &&
          other.source == this.source &&
          other.rate == this.rate &&
          other.isActive == this.isActive &&
          other.isDeleted == this.isDeleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ExchangeRatesCompanion extends UpdateCompanion<ExchangeRate> {
  final Value<String> id;
  final Value<String?> storeId;
  final Value<String> source;
  final Value<double> rate;
  final Value<bool> isActive;
  final Value<bool> isDeleted;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ExchangeRatesCompanion({
    this.id = const Value.absent(),
    this.storeId = const Value.absent(),
    this.source = const Value.absent(),
    this.rate = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExchangeRatesCompanion.insert({
    required String id,
    this.storeId = const Value.absent(),
    required String source,
    required double rate,
    this.isActive = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        source = Value(source),
        rate = Value(rate);
  static Insertable<ExchangeRate> custom({
    Expression<String>? id,
    Expression<String>? storeId,
    Expression<String>? source,
    Expression<double>? rate,
    Expression<bool>? isActive,
    Expression<bool>? isDeleted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (storeId != null) 'store_id': storeId,
      if (source != null) 'source': source,
      if (rate != null) 'rate': rate,
      if (isActive != null) 'is_active': isActive,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExchangeRatesCompanion copyWith(
      {Value<String>? id,
      Value<String?>? storeId,
      Value<String>? source,
      Value<double>? rate,
      Value<bool>? isActive,
      Value<bool>? isDeleted,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return ExchangeRatesCompanion(
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
      source: source ?? this.source,
      rate: rate ?? this.rate,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (storeId.present) {
      map['store_id'] = Variable<String>(storeId.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (rate.present) {
      map['rate'] = Variable<double>(rate.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExchangeRatesCompanion(')
          ..write('id: $id, ')
          ..write('storeId: $storeId, ')
          ..write('source: $source, ')
          ..write('rate: $rate, ')
          ..write('isActive: $isActive, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProfilesTable extends Profiles with TableInfo<$ProfilesTable, Profile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _storeIdMeta =
      const VerificationMeta('storeId');
  @override
  late final GeneratedColumn<String> storeId = GeneratedColumn<String>(
      'store_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fullNameMeta =
      const VerificationMeta('fullName');
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
      'full_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('cashier'));
  static const VerificationMeta _quickPinMeta =
      const VerificationMeta('quickPin');
  @override
  late final GeneratedColumn<String> quickPin = GeneratedColumn<String>(
      'quick_pin', aliasedName, true,
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
        storeId,
        fullName,
        email,
        role,
        quickPin,
        isActive,
        isDeleted,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profiles';
  @override
  VerificationContext validateIntegrity(Insertable<Profile> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('store_id')) {
      context.handle(_storeIdMeta,
          storeId.isAcceptableOrUnknown(data['store_id']!, _storeIdMeta));
    }
    if (data.containsKey('full_name')) {
      context.handle(_fullNameMeta,
          fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta));
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    }
    if (data.containsKey('quick_pin')) {
      context.handle(_quickPinMeta,
          quickPin.isAcceptableOrUnknown(data['quick_pin']!, _quickPinMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
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
  Profile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Profile(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      storeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}store_id']),
      fullName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}full_name'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      quickPin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}quick_pin']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ProfilesTable createAlias(String alias) {
    return $ProfilesTable(attachedDatabase, alias);
  }
}

class Profile extends DataClass implements Insertable<Profile> {
  final String id;
  final String? storeId;
  final String fullName;
  final String? email;
  final String role;
  final String? quickPin;
  final bool isActive;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Profile(
      {required this.id,
      this.storeId,
      required this.fullName,
      this.email,
      required this.role,
      this.quickPin,
      required this.isActive,
      required this.isDeleted,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || storeId != null) {
      map['store_id'] = Variable<String>(storeId);
    }
    map['full_name'] = Variable<String>(fullName);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    map['role'] = Variable<String>(role);
    if (!nullToAbsent || quickPin != null) {
      map['quick_pin'] = Variable<String>(quickPin);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProfilesCompanion toCompanion(bool nullToAbsent) {
    return ProfilesCompanion(
      id: Value(id),
      storeId: storeId == null && nullToAbsent
          ? const Value.absent()
          : Value(storeId),
      fullName: Value(fullName),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      role: Value(role),
      quickPin: quickPin == null && nullToAbsent
          ? const Value.absent()
          : Value(quickPin),
      isActive: Value(isActive),
      isDeleted: Value(isDeleted),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Profile.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Profile(
      id: serializer.fromJson<String>(json['id']),
      storeId: serializer.fromJson<String?>(json['storeId']),
      fullName: serializer.fromJson<String>(json['fullName']),
      email: serializer.fromJson<String?>(json['email']),
      role: serializer.fromJson<String>(json['role']),
      quickPin: serializer.fromJson<String?>(json['quickPin']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'storeId': serializer.toJson<String?>(storeId),
      'fullName': serializer.toJson<String>(fullName),
      'email': serializer.toJson<String?>(email),
      'role': serializer.toJson<String>(role),
      'quickPin': serializer.toJson<String?>(quickPin),
      'isActive': serializer.toJson<bool>(isActive),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Profile copyWith(
          {String? id,
          Value<String?> storeId = const Value.absent(),
          String? fullName,
          Value<String?> email = const Value.absent(),
          String? role,
          Value<String?> quickPin = const Value.absent(),
          bool? isActive,
          bool? isDeleted,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Profile(
        id: id ?? this.id,
        storeId: storeId.present ? storeId.value : this.storeId,
        fullName: fullName ?? this.fullName,
        email: email.present ? email.value : this.email,
        role: role ?? this.role,
        quickPin: quickPin.present ? quickPin.value : this.quickPin,
        isActive: isActive ?? this.isActive,
        isDeleted: isDeleted ?? this.isDeleted,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Profile copyWithCompanion(ProfilesCompanion data) {
    return Profile(
      id: data.id.present ? data.id.value : this.id,
      storeId: data.storeId.present ? data.storeId.value : this.storeId,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      email: data.email.present ? data.email.value : this.email,
      role: data.role.present ? data.role.value : this.role,
      quickPin: data.quickPin.present ? data.quickPin.value : this.quickPin,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Profile(')
          ..write('id: $id, ')
          ..write('storeId: $storeId, ')
          ..write('fullName: $fullName, ')
          ..write('email: $email, ')
          ..write('role: $role, ')
          ..write('quickPin: $quickPin, ')
          ..write('isActive: $isActive, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, storeId, fullName, email, role, quickPin,
      isActive, isDeleted, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Profile &&
          other.id == this.id &&
          other.storeId == this.storeId &&
          other.fullName == this.fullName &&
          other.email == this.email &&
          other.role == this.role &&
          other.quickPin == this.quickPin &&
          other.isActive == this.isActive &&
          other.isDeleted == this.isDeleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ProfilesCompanion extends UpdateCompanion<Profile> {
  final Value<String> id;
  final Value<String?> storeId;
  final Value<String> fullName;
  final Value<String?> email;
  final Value<String> role;
  final Value<String?> quickPin;
  final Value<bool> isActive;
  final Value<bool> isDeleted;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ProfilesCompanion({
    this.id = const Value.absent(),
    this.storeId = const Value.absent(),
    this.fullName = const Value.absent(),
    this.email = const Value.absent(),
    this.role = const Value.absent(),
    this.quickPin = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProfilesCompanion.insert({
    required String id,
    this.storeId = const Value.absent(),
    required String fullName,
    this.email = const Value.absent(),
    this.role = const Value.absent(),
    this.quickPin = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        fullName = Value(fullName);
  static Insertable<Profile> custom({
    Expression<String>? id,
    Expression<String>? storeId,
    Expression<String>? fullName,
    Expression<String>? email,
    Expression<String>? role,
    Expression<String>? quickPin,
    Expression<bool>? isActive,
    Expression<bool>? isDeleted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (storeId != null) 'store_id': storeId,
      if (fullName != null) 'full_name': fullName,
      if (email != null) 'email': email,
      if (role != null) 'role': role,
      if (quickPin != null) 'quick_pin': quickPin,
      if (isActive != null) 'is_active': isActive,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProfilesCompanion copyWith(
      {Value<String>? id,
      Value<String?>? storeId,
      Value<String>? fullName,
      Value<String?>? email,
      Value<String>? role,
      Value<String?>? quickPin,
      Value<bool>? isActive,
      Value<bool>? isDeleted,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return ProfilesCompanion(
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      role: role ?? this.role,
      quickPin: quickPin ?? this.quickPin,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (storeId.present) {
      map['store_id'] = Variable<String>(storeId.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (quickPin.present) {
      map['quick_pin'] = Variable<String>(quickPin.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfilesCompanion(')
          ..write('id: $id, ')
          ..write('storeId: $storeId, ')
          ..write('fullName: $fullName, ')
          ..write('email: $email, ')
          ..write('role: $role, ')
          ..write('quickPin: $quickPin, ')
          ..write('isActive: $isActive, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _storeIdMeta =
      const VerificationMeta('storeId');
  @override
  late final GeneratedColumn<String> storeId = GeneratedColumn<String>(
      'store_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconNameMeta =
      const VerificationMeta('iconName');
  @override
  late final GeneratedColumn<String> iconName = GeneratedColumn<String>(
      'icon_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('category'));
  static const VerificationMeta _colorHexMeta =
      const VerificationMeta('colorHex');
  @override
  late final GeneratedColumn<String> colorHex = GeneratedColumn<String>(
      'color_hex', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('#0EA5E9'));
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
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
        storeId,
        name,
        iconName,
        colorHex,
        sortOrder,
        isDeleted,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(Insertable<Category> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('store_id')) {
      context.handle(_storeIdMeta,
          storeId.isAcceptableOrUnknown(data['store_id']!, _storeIdMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon_name')) {
      context.handle(_iconNameMeta,
          iconName.isAcceptableOrUnknown(data['icon_name']!, _iconNameMeta));
    }
    if (data.containsKey('color_hex')) {
      context.handle(_colorHexMeta,
          colorHex.isAcceptableOrUnknown(data['color_hex']!, _colorHexMeta));
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
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
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      storeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}store_id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      iconName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon_name'])!,
      colorHex: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color_hex'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final String id;
  final String? storeId;
  final String name;
  final String iconName;
  final String colorHex;
  final int sortOrder;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Category(
      {required this.id,
      this.storeId,
      required this.name,
      required this.iconName,
      required this.colorHex,
      required this.sortOrder,
      required this.isDeleted,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || storeId != null) {
      map['store_id'] = Variable<String>(storeId);
    }
    map['name'] = Variable<String>(name);
    map['icon_name'] = Variable<String>(iconName);
    map['color_hex'] = Variable<String>(colorHex);
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      storeId: storeId == null && nullToAbsent
          ? const Value.absent()
          : Value(storeId),
      name: Value(name),
      iconName: Value(iconName),
      colorHex: Value(colorHex),
      sortOrder: Value(sortOrder),
      isDeleted: Value(isDeleted),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Category.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<String>(json['id']),
      storeId: serializer.fromJson<String?>(json['storeId']),
      name: serializer.fromJson<String>(json['name']),
      iconName: serializer.fromJson<String>(json['iconName']),
      colorHex: serializer.fromJson<String>(json['colorHex']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'storeId': serializer.toJson<String?>(storeId),
      'name': serializer.toJson<String>(name),
      'iconName': serializer.toJson<String>(iconName),
      'colorHex': serializer.toJson<String>(colorHex),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Category copyWith(
          {String? id,
          Value<String?> storeId = const Value.absent(),
          String? name,
          String? iconName,
          String? colorHex,
          int? sortOrder,
          bool? isDeleted,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Category(
        id: id ?? this.id,
        storeId: storeId.present ? storeId.value : this.storeId,
        name: name ?? this.name,
        iconName: iconName ?? this.iconName,
        colorHex: colorHex ?? this.colorHex,
        sortOrder: sortOrder ?? this.sortOrder,
        isDeleted: isDeleted ?? this.isDeleted,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      storeId: data.storeId.present ? data.storeId.value : this.storeId,
      name: data.name.present ? data.name.value : this.name,
      iconName: data.iconName.present ? data.iconName.value : this.iconName,
      colorHex: data.colorHex.present ? data.colorHex.value : this.colorHex,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('storeId: $storeId, ')
          ..write('name: $name, ')
          ..write('iconName: $iconName, ')
          ..write('colorHex: $colorHex, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, storeId, name, iconName, colorHex,
      sortOrder, isDeleted, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.storeId == this.storeId &&
          other.name == this.name &&
          other.iconName == this.iconName &&
          other.colorHex == this.colorHex &&
          other.sortOrder == this.sortOrder &&
          other.isDeleted == this.isDeleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<String> id;
  final Value<String?> storeId;
  final Value<String> name;
  final Value<String> iconName;
  final Value<String> colorHex;
  final Value<int> sortOrder;
  final Value<bool> isDeleted;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.storeId = const Value.absent(),
    this.name = const Value.absent(),
    this.iconName = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesCompanion.insert({
    required String id,
    this.storeId = const Value.absent(),
    required String name,
    this.iconName = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<Category> custom({
    Expression<String>? id,
    Expression<String>? storeId,
    Expression<String>? name,
    Expression<String>? iconName,
    Expression<String>? colorHex,
    Expression<int>? sortOrder,
    Expression<bool>? isDeleted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (storeId != null) 'store_id': storeId,
      if (name != null) 'name': name,
      if (iconName != null) 'icon_name': iconName,
      if (colorHex != null) 'color_hex': colorHex,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesCompanion copyWith(
      {Value<String>? id,
      Value<String?>? storeId,
      Value<String>? name,
      Value<String>? iconName,
      Value<String>? colorHex,
      Value<int>? sortOrder,
      Value<bool>? isDeleted,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return CategoriesCompanion(
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
      name: name ?? this.name,
      iconName: iconName ?? this.iconName,
      colorHex: colorHex ?? this.colorHex,
      sortOrder: sortOrder ?? this.sortOrder,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (storeId.present) {
      map['store_id'] = Variable<String>(storeId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (iconName.present) {
      map['icon_name'] = Variable<String>(iconName.value);
    }
    if (colorHex.present) {
      map['color_hex'] = Variable<String>(colorHex.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('storeId: $storeId, ')
          ..write('name: $name, ')
          ..write('iconName: $iconName, ')
          ..write('colorHex: $colorHex, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _storeIdMeta =
      const VerificationMeta('storeId');
  @override
  late final GeneratedColumn<String> storeId = GeneratedColumn<String>(
      'store_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
      'category_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
      'sku', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _barcodeMeta =
      const VerificationMeta('barcode');
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
      'barcode', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _imageUrlMeta =
      const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
      'image_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _productTypeMeta =
      const VerificationMeta('productType');
  @override
  late final GeneratedColumn<String> productType = GeneratedColumn<String>(
      'product_type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('unit'));
  static const VerificationMeta _costUsdMeta =
      const VerificationMeta('costUsd');
  @override
  late final GeneratedColumn<double> costUsd = GeneratedColumn<double>(
      'cost_usd', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _profitMarginPercentMeta =
      const VerificationMeta('profitMarginPercent');
  @override
  late final GeneratedColumn<double> profitMarginPercent =
      GeneratedColumn<double>('profit_margin_percent', aliasedName, false,
          type: DriftSqlType.double,
          requiredDuringInsert: false,
          defaultValue: const Constant(30.0));
  static const VerificationMeta _priceUsdMeta =
      const VerificationMeta('priceUsd');
  @override
  late final GeneratedColumn<double> priceUsd = GeneratedColumn<double>(
      'price_usd', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _stockQuantityMeta =
      const VerificationMeta('stockQuantity');
  @override
  late final GeneratedColumn<double> stockQuantity = GeneratedColumn<double>(
      'stock_quantity', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _minStockAlertMeta =
      const VerificationMeta('minStockAlert');
  @override
  late final GeneratedColumn<double> minStockAlert = GeneratedColumn<double>(
      'min_stock_alert', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(5.0));
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
        storeId,
        categoryId,
        sku,
        barcode,
        name,
        description,
        imageUrl,
        productType,
        costUsd,
        profitMarginPercent,
        priceUsd,
        stockQuantity,
        minStockAlert,
        isDeleted,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(Insertable<Product> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('store_id')) {
      context.handle(_storeIdMeta,
          storeId.isAcceptableOrUnknown(data['store_id']!, _storeIdMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    }
    if (data.containsKey('sku')) {
      context.handle(
          _skuMeta, sku.isAcceptableOrUnknown(data['sku']!, _skuMeta));
    }
    if (data.containsKey('barcode')) {
      context.handle(_barcodeMeta,
          barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
    }
    if (data.containsKey('product_type')) {
      context.handle(
          _productTypeMeta,
          productType.isAcceptableOrUnknown(
              data['product_type']!, _productTypeMeta));
    }
    if (data.containsKey('cost_usd')) {
      context.handle(_costUsdMeta,
          costUsd.isAcceptableOrUnknown(data['cost_usd']!, _costUsdMeta));
    }
    if (data.containsKey('profit_margin_percent')) {
      context.handle(
          _profitMarginPercentMeta,
          profitMarginPercent.isAcceptableOrUnknown(
              data['profit_margin_percent']!, _profitMarginPercentMeta));
    }
    if (data.containsKey('price_usd')) {
      context.handle(_priceUsdMeta,
          priceUsd.isAcceptableOrUnknown(data['price_usd']!, _priceUsdMeta));
    } else if (isInserting) {
      context.missing(_priceUsdMeta);
    }
    if (data.containsKey('stock_quantity')) {
      context.handle(
          _stockQuantityMeta,
          stockQuantity.isAcceptableOrUnknown(
              data['stock_quantity']!, _stockQuantityMeta));
    }
    if (data.containsKey('min_stock_alert')) {
      context.handle(
          _minStockAlertMeta,
          minStockAlert.isAcceptableOrUnknown(
              data['min_stock_alert']!, _minStockAlertMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
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
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      storeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}store_id']),
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_id']),
      sku: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sku']),
      barcode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}barcode']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url']),
      productType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_type'])!,
      costUsd: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}cost_usd'])!,
      profitMarginPercent: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}profit_margin_percent'])!,
      priceUsd: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}price_usd'])!,
      stockQuantity: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}stock_quantity'])!,
      minStockAlert: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}min_stock_alert'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class Product extends DataClass implements Insertable<Product> {
  final String id;
  final String? storeId;
  final String? categoryId;
  final String? sku;
  final String? barcode;
  final String name;
  final String? description;
  final String? imageUrl;
  final String productType;
  final double costUsd;
  final double profitMarginPercent;
  final double priceUsd;
  final double stockQuantity;
  final double minStockAlert;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Product(
      {required this.id,
      this.storeId,
      this.categoryId,
      this.sku,
      this.barcode,
      required this.name,
      this.description,
      this.imageUrl,
      required this.productType,
      required this.costUsd,
      required this.profitMarginPercent,
      required this.priceUsd,
      required this.stockQuantity,
      required this.minStockAlert,
      required this.isDeleted,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || storeId != null) {
      map['store_id'] = Variable<String>(storeId);
    }
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    if (!nullToAbsent || sku != null) {
      map['sku'] = Variable<String>(sku);
    }
    if (!nullToAbsent || barcode != null) {
      map['barcode'] = Variable<String>(barcode);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    map['product_type'] = Variable<String>(productType);
    map['cost_usd'] = Variable<double>(costUsd);
    map['profit_margin_percent'] = Variable<double>(profitMarginPercent);
    map['price_usd'] = Variable<double>(priceUsd);
    map['stock_quantity'] = Variable<double>(stockQuantity);
    map['min_stock_alert'] = Variable<double>(minStockAlert);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      storeId: storeId == null && nullToAbsent
          ? const Value.absent()
          : Value(storeId),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      sku: sku == null && nullToAbsent ? const Value.absent() : Value(sku),
      barcode: barcode == null && nullToAbsent
          ? const Value.absent()
          : Value(barcode),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      productType: Value(productType),
      costUsd: Value(costUsd),
      profitMarginPercent: Value(profitMarginPercent),
      priceUsd: Value(priceUsd),
      stockQuantity: Value(stockQuantity),
      minStockAlert: Value(minStockAlert),
      isDeleted: Value(isDeleted),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Product.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<String>(json['id']),
      storeId: serializer.fromJson<String?>(json['storeId']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      sku: serializer.fromJson<String?>(json['sku']),
      barcode: serializer.fromJson<String?>(json['barcode']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      productType: serializer.fromJson<String>(json['productType']),
      costUsd: serializer.fromJson<double>(json['costUsd']),
      profitMarginPercent:
          serializer.fromJson<double>(json['profitMarginPercent']),
      priceUsd: serializer.fromJson<double>(json['priceUsd']),
      stockQuantity: serializer.fromJson<double>(json['stockQuantity']),
      minStockAlert: serializer.fromJson<double>(json['minStockAlert']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'storeId': serializer.toJson<String?>(storeId),
      'categoryId': serializer.toJson<String?>(categoryId),
      'sku': serializer.toJson<String?>(sku),
      'barcode': serializer.toJson<String?>(barcode),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'productType': serializer.toJson<String>(productType),
      'costUsd': serializer.toJson<double>(costUsd),
      'profitMarginPercent': serializer.toJson<double>(profitMarginPercent),
      'priceUsd': serializer.toJson<double>(priceUsd),
      'stockQuantity': serializer.toJson<double>(stockQuantity),
      'minStockAlert': serializer.toJson<double>(minStockAlert),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Product copyWith(
          {String? id,
          Value<String?> storeId = const Value.absent(),
          Value<String?> categoryId = const Value.absent(),
          Value<String?> sku = const Value.absent(),
          Value<String?> barcode = const Value.absent(),
          String? name,
          Value<String?> description = const Value.absent(),
          Value<String?> imageUrl = const Value.absent(),
          String? productType,
          double? costUsd,
          double? profitMarginPercent,
          double? priceUsd,
          double? stockQuantity,
          double? minStockAlert,
          bool? isDeleted,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Product(
        id: id ?? this.id,
        storeId: storeId.present ? storeId.value : this.storeId,
        categoryId: categoryId.present ? categoryId.value : this.categoryId,
        sku: sku.present ? sku.value : this.sku,
        barcode: barcode.present ? barcode.value : this.barcode,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
        productType: productType ?? this.productType,
        costUsd: costUsd ?? this.costUsd,
        profitMarginPercent: profitMarginPercent ?? this.profitMarginPercent,
        priceUsd: priceUsd ?? this.priceUsd,
        stockQuantity: stockQuantity ?? this.stockQuantity,
        minStockAlert: minStockAlert ?? this.minStockAlert,
        isDeleted: isDeleted ?? this.isDeleted,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Product copyWithCompanion(ProductsCompanion data) {
    return Product(
      id: data.id.present ? data.id.value : this.id,
      storeId: data.storeId.present ? data.storeId.value : this.storeId,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      sku: data.sku.present ? data.sku.value : this.sku,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      productType:
          data.productType.present ? data.productType.value : this.productType,
      costUsd: data.costUsd.present ? data.costUsd.value : this.costUsd,
      profitMarginPercent: data.profitMarginPercent.present
          ? data.profitMarginPercent.value
          : this.profitMarginPercent,
      priceUsd: data.priceUsd.present ? data.priceUsd.value : this.priceUsd,
      stockQuantity: data.stockQuantity.present
          ? data.stockQuantity.value
          : this.stockQuantity,
      minStockAlert: data.minStockAlert.present
          ? data.minStockAlert.value
          : this.minStockAlert,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('storeId: $storeId, ')
          ..write('categoryId: $categoryId, ')
          ..write('sku: $sku, ')
          ..write('barcode: $barcode, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('productType: $productType, ')
          ..write('costUsd: $costUsd, ')
          ..write('profitMarginPercent: $profitMarginPercent, ')
          ..write('priceUsd: $priceUsd, ')
          ..write('stockQuantity: $stockQuantity, ')
          ..write('minStockAlert: $minStockAlert, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      storeId,
      categoryId,
      sku,
      barcode,
      name,
      description,
      imageUrl,
      productType,
      costUsd,
      profitMarginPercent,
      priceUsd,
      stockQuantity,
      minStockAlert,
      isDeleted,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.storeId == this.storeId &&
          other.categoryId == this.categoryId &&
          other.sku == this.sku &&
          other.barcode == this.barcode &&
          other.name == this.name &&
          other.description == this.description &&
          other.imageUrl == this.imageUrl &&
          other.productType == this.productType &&
          other.costUsd == this.costUsd &&
          other.profitMarginPercent == this.profitMarginPercent &&
          other.priceUsd == this.priceUsd &&
          other.stockQuantity == this.stockQuantity &&
          other.minStockAlert == this.minStockAlert &&
          other.isDeleted == this.isDeleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<String> id;
  final Value<String?> storeId;
  final Value<String?> categoryId;
  final Value<String?> sku;
  final Value<String?> barcode;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> imageUrl;
  final Value<String> productType;
  final Value<double> costUsd;
  final Value<double> profitMarginPercent;
  final Value<double> priceUsd;
  final Value<double> stockQuantity;
  final Value<double> minStockAlert;
  final Value<bool> isDeleted;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.storeId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.sku = const Value.absent(),
    this.barcode = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.productType = const Value.absent(),
    this.costUsd = const Value.absent(),
    this.profitMarginPercent = const Value.absent(),
    this.priceUsd = const Value.absent(),
    this.stockQuantity = const Value.absent(),
    this.minStockAlert = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductsCompanion.insert({
    required String id,
    this.storeId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.sku = const Value.absent(),
    this.barcode = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.productType = const Value.absent(),
    this.costUsd = const Value.absent(),
    this.profitMarginPercent = const Value.absent(),
    required double priceUsd,
    this.stockQuantity = const Value.absent(),
    this.minStockAlert = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        priceUsd = Value(priceUsd);
  static Insertable<Product> custom({
    Expression<String>? id,
    Expression<String>? storeId,
    Expression<String>? categoryId,
    Expression<String>? sku,
    Expression<String>? barcode,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? imageUrl,
    Expression<String>? productType,
    Expression<double>? costUsd,
    Expression<double>? profitMarginPercent,
    Expression<double>? priceUsd,
    Expression<double>? stockQuantity,
    Expression<double>? minStockAlert,
    Expression<bool>? isDeleted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (storeId != null) 'store_id': storeId,
      if (categoryId != null) 'category_id': categoryId,
      if (sku != null) 'sku': sku,
      if (barcode != null) 'barcode': barcode,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (imageUrl != null) 'image_url': imageUrl,
      if (productType != null) 'product_type': productType,
      if (costUsd != null) 'cost_usd': costUsd,
      if (profitMarginPercent != null)
        'profit_margin_percent': profitMarginPercent,
      if (priceUsd != null) 'price_usd': priceUsd,
      if (stockQuantity != null) 'stock_quantity': stockQuantity,
      if (minStockAlert != null) 'min_stock_alert': minStockAlert,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductsCompanion copyWith(
      {Value<String>? id,
      Value<String?>? storeId,
      Value<String?>? categoryId,
      Value<String?>? sku,
      Value<String?>? barcode,
      Value<String>? name,
      Value<String?>? description,
      Value<String?>? imageUrl,
      Value<String>? productType,
      Value<double>? costUsd,
      Value<double>? profitMarginPercent,
      Value<double>? priceUsd,
      Value<double>? stockQuantity,
      Value<double>? minStockAlert,
      Value<bool>? isDeleted,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return ProductsCompanion(
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
      categoryId: categoryId ?? this.categoryId,
      sku: sku ?? this.sku,
      barcode: barcode ?? this.barcode,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      productType: productType ?? this.productType,
      costUsd: costUsd ?? this.costUsd,
      profitMarginPercent: profitMarginPercent ?? this.profitMarginPercent,
      priceUsd: priceUsd ?? this.priceUsd,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      minStockAlert: minStockAlert ?? this.minStockAlert,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (storeId.present) {
      map['store_id'] = Variable<String>(storeId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (productType.present) {
      map['product_type'] = Variable<String>(productType.value);
    }
    if (costUsd.present) {
      map['cost_usd'] = Variable<double>(costUsd.value);
    }
    if (profitMarginPercent.present) {
      map['profit_margin_percent'] =
          Variable<double>(profitMarginPercent.value);
    }
    if (priceUsd.present) {
      map['price_usd'] = Variable<double>(priceUsd.value);
    }
    if (stockQuantity.present) {
      map['stock_quantity'] = Variable<double>(stockQuantity.value);
    }
    if (minStockAlert.present) {
      map['min_stock_alert'] = Variable<double>(minStockAlert.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('storeId: $storeId, ')
          ..write('categoryId: $categoryId, ')
          ..write('sku: $sku, ')
          ..write('barcode: $barcode, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('productType: $productType, ')
          ..write('costUsd: $costUsd, ')
          ..write('profitMarginPercent: $profitMarginPercent, ')
          ..write('priceUsd: $priceUsd, ')
          ..write('stockQuantity: $stockQuantity, ')
          ..write('minStockAlert: $minStockAlert, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductPresentationsTable extends ProductPresentations
    with TableInfo<$ProductPresentationsTable, ProductPresentation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductPresentationsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _barcodeMeta =
      const VerificationMeta('barcode');
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
      'barcode', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _quantityEquivalentMeta =
      const VerificationMeta('quantityEquivalent');
  @override
  late final GeneratedColumn<double> quantityEquivalent =
      GeneratedColumn<double>('quantity_equivalent', aliasedName, false,
          type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _priceUsdMeta =
      const VerificationMeta('priceUsd');
  @override
  late final GeneratedColumn<double> priceUsd = GeneratedColumn<double>(
      'price_usd', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
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
        productId,
        name,
        barcode,
        quantityEquivalent,
        priceUsd,
        isDeleted,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_presentations';
  @override
  VerificationContext validateIntegrity(
      Insertable<ProductPresentation> instance,
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
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('barcode')) {
      context.handle(_barcodeMeta,
          barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta));
    }
    if (data.containsKey('quantity_equivalent')) {
      context.handle(
          _quantityEquivalentMeta,
          quantityEquivalent.isAcceptableOrUnknown(
              data['quantity_equivalent']!, _quantityEquivalentMeta));
    } else if (isInserting) {
      context.missing(_quantityEquivalentMeta);
    }
    if (data.containsKey('price_usd')) {
      context.handle(_priceUsdMeta,
          priceUsd.isAcceptableOrUnknown(data['price_usd']!, _priceUsdMeta));
    } else if (isInserting) {
      context.missing(_priceUsdMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
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
  ProductPresentation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductPresentation(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      barcode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}barcode']),
      quantityEquivalent: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}quantity_equivalent'])!,
      priceUsd: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}price_usd'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ProductPresentationsTable createAlias(String alias) {
    return $ProductPresentationsTable(attachedDatabase, alias);
  }
}

class ProductPresentation extends DataClass
    implements Insertable<ProductPresentation> {
  final String id;
  final String productId;
  final String name;
  final String? barcode;
  final double quantityEquivalent;
  final double priceUsd;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ProductPresentation(
      {required this.id,
      required this.productId,
      required this.name,
      this.barcode,
      required this.quantityEquivalent,
      required this.priceUsd,
      required this.isDeleted,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['product_id'] = Variable<String>(productId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || barcode != null) {
      map['barcode'] = Variable<String>(barcode);
    }
    map['quantity_equivalent'] = Variable<double>(quantityEquivalent);
    map['price_usd'] = Variable<double>(priceUsd);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProductPresentationsCompanion toCompanion(bool nullToAbsent) {
    return ProductPresentationsCompanion(
      id: Value(id),
      productId: Value(productId),
      name: Value(name),
      barcode: barcode == null && nullToAbsent
          ? const Value.absent()
          : Value(barcode),
      quantityEquivalent: Value(quantityEquivalent),
      priceUsd: Value(priceUsd),
      isDeleted: Value(isDeleted),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ProductPresentation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductPresentation(
      id: serializer.fromJson<String>(json['id']),
      productId: serializer.fromJson<String>(json['productId']),
      name: serializer.fromJson<String>(json['name']),
      barcode: serializer.fromJson<String?>(json['barcode']),
      quantityEquivalent:
          serializer.fromJson<double>(json['quantityEquivalent']),
      priceUsd: serializer.fromJson<double>(json['priceUsd']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'productId': serializer.toJson<String>(productId),
      'name': serializer.toJson<String>(name),
      'barcode': serializer.toJson<String?>(barcode),
      'quantityEquivalent': serializer.toJson<double>(quantityEquivalent),
      'priceUsd': serializer.toJson<double>(priceUsd),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ProductPresentation copyWith(
          {String? id,
          String? productId,
          String? name,
          Value<String?> barcode = const Value.absent(),
          double? quantityEquivalent,
          double? priceUsd,
          bool? isDeleted,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      ProductPresentation(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        name: name ?? this.name,
        barcode: barcode.present ? barcode.value : this.barcode,
        quantityEquivalent: quantityEquivalent ?? this.quantityEquivalent,
        priceUsd: priceUsd ?? this.priceUsd,
        isDeleted: isDeleted ?? this.isDeleted,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  ProductPresentation copyWithCompanion(ProductPresentationsCompanion data) {
    return ProductPresentation(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      name: data.name.present ? data.name.value : this.name,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      quantityEquivalent: data.quantityEquivalent.present
          ? data.quantityEquivalent.value
          : this.quantityEquivalent,
      priceUsd: data.priceUsd.present ? data.priceUsd.value : this.priceUsd,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductPresentation(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('name: $name, ')
          ..write('barcode: $barcode, ')
          ..write('quantityEquivalent: $quantityEquivalent, ')
          ..write('priceUsd: $priceUsd, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, productId, name, barcode,
      quantityEquivalent, priceUsd, isDeleted, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductPresentation &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.name == this.name &&
          other.barcode == this.barcode &&
          other.quantityEquivalent == this.quantityEquivalent &&
          other.priceUsd == this.priceUsd &&
          other.isDeleted == this.isDeleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ProductPresentationsCompanion
    extends UpdateCompanion<ProductPresentation> {
  final Value<String> id;
  final Value<String> productId;
  final Value<String> name;
  final Value<String?> barcode;
  final Value<double> quantityEquivalent;
  final Value<double> priceUsd;
  final Value<bool> isDeleted;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ProductPresentationsCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.name = const Value.absent(),
    this.barcode = const Value.absent(),
    this.quantityEquivalent = const Value.absent(),
    this.priceUsd = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductPresentationsCompanion.insert({
    required String id,
    required String productId,
    required String name,
    this.barcode = const Value.absent(),
    required double quantityEquivalent,
    required double priceUsd,
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        productId = Value(productId),
        name = Value(name),
        quantityEquivalent = Value(quantityEquivalent),
        priceUsd = Value(priceUsd);
  static Insertable<ProductPresentation> custom({
    Expression<String>? id,
    Expression<String>? productId,
    Expression<String>? name,
    Expression<String>? barcode,
    Expression<double>? quantityEquivalent,
    Expression<double>? priceUsd,
    Expression<bool>? isDeleted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (name != null) 'name': name,
      if (barcode != null) 'barcode': barcode,
      if (quantityEquivalent != null) 'quantity_equivalent': quantityEquivalent,
      if (priceUsd != null) 'price_usd': priceUsd,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductPresentationsCompanion copyWith(
      {Value<String>? id,
      Value<String>? productId,
      Value<String>? name,
      Value<String?>? barcode,
      Value<double>? quantityEquivalent,
      Value<double>? priceUsd,
      Value<bool>? isDeleted,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return ProductPresentationsCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      barcode: barcode ?? this.barcode,
      quantityEquivalent: quantityEquivalent ?? this.quantityEquivalent,
      priceUsd: priceUsd ?? this.priceUsd,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (quantityEquivalent.present) {
      map['quantity_equivalent'] = Variable<double>(quantityEquivalent.value);
    }
    if (priceUsd.present) {
      map['price_usd'] = Variable<double>(priceUsd.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductPresentationsCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('name: $name, ')
          ..write('barcode: $barcode, ')
          ..write('quantityEquivalent: $quantityEquivalent, ')
          ..write('priceUsd: $priceUsd, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductVariantsTable extends ProductVariants
    with TableInfo<$ProductVariantsTable, ProductVariant> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductVariantsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _variantNameMeta =
      const VerificationMeta('variantName');
  @override
  late final GeneratedColumn<String> variantName = GeneratedColumn<String>(
      'variant_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
      'sku', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _barcodeMeta =
      const VerificationMeta('barcode');
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
      'barcode', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _additionalPriceUsdMeta =
      const VerificationMeta('additionalPriceUsd');
  @override
  late final GeneratedColumn<double> additionalPriceUsd =
      GeneratedColumn<double>('additional_price_usd', aliasedName, false,
          type: DriftSqlType.double,
          requiredDuringInsert: false,
          defaultValue: const Constant(0.0));
  static const VerificationMeta _stockQuantityMeta =
      const VerificationMeta('stockQuantity');
  @override
  late final GeneratedColumn<double> stockQuantity = GeneratedColumn<double>(
      'stock_quantity', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
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
        productId,
        variantName,
        sku,
        barcode,
        additionalPriceUsd,
        stockQuantity,
        isDeleted,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_variants';
  @override
  VerificationContext validateIntegrity(Insertable<ProductVariant> instance,
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
    if (data.containsKey('variant_name')) {
      context.handle(
          _variantNameMeta,
          variantName.isAcceptableOrUnknown(
              data['variant_name']!, _variantNameMeta));
    } else if (isInserting) {
      context.missing(_variantNameMeta);
    }
    if (data.containsKey('sku')) {
      context.handle(
          _skuMeta, sku.isAcceptableOrUnknown(data['sku']!, _skuMeta));
    }
    if (data.containsKey('barcode')) {
      context.handle(_barcodeMeta,
          barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta));
    }
    if (data.containsKey('additional_price_usd')) {
      context.handle(
          _additionalPriceUsdMeta,
          additionalPriceUsd.isAcceptableOrUnknown(
              data['additional_price_usd']!, _additionalPriceUsdMeta));
    }
    if (data.containsKey('stock_quantity')) {
      context.handle(
          _stockQuantityMeta,
          stockQuantity.isAcceptableOrUnknown(
              data['stock_quantity']!, _stockQuantityMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
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
  ProductVariant map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductVariant(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_id'])!,
      variantName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}variant_name'])!,
      sku: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sku']),
      barcode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}barcode']),
      additionalPriceUsd: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}additional_price_usd'])!,
      stockQuantity: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}stock_quantity'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ProductVariantsTable createAlias(String alias) {
    return $ProductVariantsTable(attachedDatabase, alias);
  }
}

class ProductVariant extends DataClass implements Insertable<ProductVariant> {
  final String id;
  final String productId;
  final String variantName;
  final String? sku;
  final String? barcode;
  final double additionalPriceUsd;
  final double stockQuantity;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ProductVariant(
      {required this.id,
      required this.productId,
      required this.variantName,
      this.sku,
      this.barcode,
      required this.additionalPriceUsd,
      required this.stockQuantity,
      required this.isDeleted,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['product_id'] = Variable<String>(productId);
    map['variant_name'] = Variable<String>(variantName);
    if (!nullToAbsent || sku != null) {
      map['sku'] = Variable<String>(sku);
    }
    if (!nullToAbsent || barcode != null) {
      map['barcode'] = Variable<String>(barcode);
    }
    map['additional_price_usd'] = Variable<double>(additionalPriceUsd);
    map['stock_quantity'] = Variable<double>(stockQuantity);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProductVariantsCompanion toCompanion(bool nullToAbsent) {
    return ProductVariantsCompanion(
      id: Value(id),
      productId: Value(productId),
      variantName: Value(variantName),
      sku: sku == null && nullToAbsent ? const Value.absent() : Value(sku),
      barcode: barcode == null && nullToAbsent
          ? const Value.absent()
          : Value(barcode),
      additionalPriceUsd: Value(additionalPriceUsd),
      stockQuantity: Value(stockQuantity),
      isDeleted: Value(isDeleted),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ProductVariant.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductVariant(
      id: serializer.fromJson<String>(json['id']),
      productId: serializer.fromJson<String>(json['productId']),
      variantName: serializer.fromJson<String>(json['variantName']),
      sku: serializer.fromJson<String?>(json['sku']),
      barcode: serializer.fromJson<String?>(json['barcode']),
      additionalPriceUsd:
          serializer.fromJson<double>(json['additionalPriceUsd']),
      stockQuantity: serializer.fromJson<double>(json['stockQuantity']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'productId': serializer.toJson<String>(productId),
      'variantName': serializer.toJson<String>(variantName),
      'sku': serializer.toJson<String?>(sku),
      'barcode': serializer.toJson<String?>(barcode),
      'additionalPriceUsd': serializer.toJson<double>(additionalPriceUsd),
      'stockQuantity': serializer.toJson<double>(stockQuantity),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ProductVariant copyWith(
          {String? id,
          String? productId,
          String? variantName,
          Value<String?> sku = const Value.absent(),
          Value<String?> barcode = const Value.absent(),
          double? additionalPriceUsd,
          double? stockQuantity,
          bool? isDeleted,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      ProductVariant(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        variantName: variantName ?? this.variantName,
        sku: sku.present ? sku.value : this.sku,
        barcode: barcode.present ? barcode.value : this.barcode,
        additionalPriceUsd: additionalPriceUsd ?? this.additionalPriceUsd,
        stockQuantity: stockQuantity ?? this.stockQuantity,
        isDeleted: isDeleted ?? this.isDeleted,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  ProductVariant copyWithCompanion(ProductVariantsCompanion data) {
    return ProductVariant(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      variantName:
          data.variantName.present ? data.variantName.value : this.variantName,
      sku: data.sku.present ? data.sku.value : this.sku,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      additionalPriceUsd: data.additionalPriceUsd.present
          ? data.additionalPriceUsd.value
          : this.additionalPriceUsd,
      stockQuantity: data.stockQuantity.present
          ? data.stockQuantity.value
          : this.stockQuantity,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductVariant(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('variantName: $variantName, ')
          ..write('sku: $sku, ')
          ..write('barcode: $barcode, ')
          ..write('additionalPriceUsd: $additionalPriceUsd, ')
          ..write('stockQuantity: $stockQuantity, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, productId, variantName, sku, barcode,
      additionalPriceUsd, stockQuantity, isDeleted, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductVariant &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.variantName == this.variantName &&
          other.sku == this.sku &&
          other.barcode == this.barcode &&
          other.additionalPriceUsd == this.additionalPriceUsd &&
          other.stockQuantity == this.stockQuantity &&
          other.isDeleted == this.isDeleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ProductVariantsCompanion extends UpdateCompanion<ProductVariant> {
  final Value<String> id;
  final Value<String> productId;
  final Value<String> variantName;
  final Value<String?> sku;
  final Value<String?> barcode;
  final Value<double> additionalPriceUsd;
  final Value<double> stockQuantity;
  final Value<bool> isDeleted;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ProductVariantsCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.variantName = const Value.absent(),
    this.sku = const Value.absent(),
    this.barcode = const Value.absent(),
    this.additionalPriceUsd = const Value.absent(),
    this.stockQuantity = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductVariantsCompanion.insert({
    required String id,
    required String productId,
    required String variantName,
    this.sku = const Value.absent(),
    this.barcode = const Value.absent(),
    this.additionalPriceUsd = const Value.absent(),
    this.stockQuantity = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        productId = Value(productId),
        variantName = Value(variantName);
  static Insertable<ProductVariant> custom({
    Expression<String>? id,
    Expression<String>? productId,
    Expression<String>? variantName,
    Expression<String>? sku,
    Expression<String>? barcode,
    Expression<double>? additionalPriceUsd,
    Expression<double>? stockQuantity,
    Expression<bool>? isDeleted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (variantName != null) 'variant_name': variantName,
      if (sku != null) 'sku': sku,
      if (barcode != null) 'barcode': barcode,
      if (additionalPriceUsd != null)
        'additional_price_usd': additionalPriceUsd,
      if (stockQuantity != null) 'stock_quantity': stockQuantity,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductVariantsCompanion copyWith(
      {Value<String>? id,
      Value<String>? productId,
      Value<String>? variantName,
      Value<String?>? sku,
      Value<String?>? barcode,
      Value<double>? additionalPriceUsd,
      Value<double>? stockQuantity,
      Value<bool>? isDeleted,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return ProductVariantsCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      variantName: variantName ?? this.variantName,
      sku: sku ?? this.sku,
      barcode: barcode ?? this.barcode,
      additionalPriceUsd: additionalPriceUsd ?? this.additionalPriceUsd,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
    if (variantName.present) {
      map['variant_name'] = Variable<String>(variantName.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (additionalPriceUsd.present) {
      map['additional_price_usd'] = Variable<double>(additionalPriceUsd.value);
    }
    if (stockQuantity.present) {
      map['stock_quantity'] = Variable<double>(stockQuantity.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductVariantsCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('variantName: $variantName, ')
          ..write('sku: $sku, ')
          ..write('barcode: $barcode, ')
          ..write('additionalPriceUsd: $additionalPriceUsd, ')
          ..write('stockQuantity: $stockQuantity, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ComboItemsTable extends ComboItems
    with TableInfo<$ComboItemsTable, ComboItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ComboItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _comboProductIdMeta =
      const VerificationMeta('comboProductId');
  @override
  late final GeneratedColumn<String> comboProductId = GeneratedColumn<String>(
      'combo_product_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _componentProductIdMeta =
      const VerificationMeta('componentProductId');
  @override
  late final GeneratedColumn<String> componentProductId =
      GeneratedColumn<String>('component_product_id', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _quantityRequiredMeta =
      const VerificationMeta('quantityRequired');
  @override
  late final GeneratedColumn<double> quantityRequired = GeneratedColumn<double>(
      'quantity_required', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(1.0));
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
        comboProductId,
        componentProductId,
        quantityRequired,
        isDeleted,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'combo_items';
  @override
  VerificationContext validateIntegrity(Insertable<ComboItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('combo_product_id')) {
      context.handle(
          _comboProductIdMeta,
          comboProductId.isAcceptableOrUnknown(
              data['combo_product_id']!, _comboProductIdMeta));
    } else if (isInserting) {
      context.missing(_comboProductIdMeta);
    }
    if (data.containsKey('component_product_id')) {
      context.handle(
          _componentProductIdMeta,
          componentProductId.isAcceptableOrUnknown(
              data['component_product_id']!, _componentProductIdMeta));
    } else if (isInserting) {
      context.missing(_componentProductIdMeta);
    }
    if (data.containsKey('quantity_required')) {
      context.handle(
          _quantityRequiredMeta,
          quantityRequired.isAcceptableOrUnknown(
              data['quantity_required']!, _quantityRequiredMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
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
  ComboItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ComboItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      comboProductId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}combo_product_id'])!,
      componentProductId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}component_product_id'])!,
      quantityRequired: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}quantity_required'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ComboItemsTable createAlias(String alias) {
    return $ComboItemsTable(attachedDatabase, alias);
  }
}

class ComboItem extends DataClass implements Insertable<ComboItem> {
  final String id;
  final String comboProductId;
  final String componentProductId;
  final double quantityRequired;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ComboItem(
      {required this.id,
      required this.comboProductId,
      required this.componentProductId,
      required this.quantityRequired,
      required this.isDeleted,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['combo_product_id'] = Variable<String>(comboProductId);
    map['component_product_id'] = Variable<String>(componentProductId);
    map['quantity_required'] = Variable<double>(quantityRequired);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ComboItemsCompanion toCompanion(bool nullToAbsent) {
    return ComboItemsCompanion(
      id: Value(id),
      comboProductId: Value(comboProductId),
      componentProductId: Value(componentProductId),
      quantityRequired: Value(quantityRequired),
      isDeleted: Value(isDeleted),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ComboItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ComboItem(
      id: serializer.fromJson<String>(json['id']),
      comboProductId: serializer.fromJson<String>(json['comboProductId']),
      componentProductId:
          serializer.fromJson<String>(json['componentProductId']),
      quantityRequired: serializer.fromJson<double>(json['quantityRequired']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'comboProductId': serializer.toJson<String>(comboProductId),
      'componentProductId': serializer.toJson<String>(componentProductId),
      'quantityRequired': serializer.toJson<double>(quantityRequired),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ComboItem copyWith(
          {String? id,
          String? comboProductId,
          String? componentProductId,
          double? quantityRequired,
          bool? isDeleted,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      ComboItem(
        id: id ?? this.id,
        comboProductId: comboProductId ?? this.comboProductId,
        componentProductId: componentProductId ?? this.componentProductId,
        quantityRequired: quantityRequired ?? this.quantityRequired,
        isDeleted: isDeleted ?? this.isDeleted,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  ComboItem copyWithCompanion(ComboItemsCompanion data) {
    return ComboItem(
      id: data.id.present ? data.id.value : this.id,
      comboProductId: data.comboProductId.present
          ? data.comboProductId.value
          : this.comboProductId,
      componentProductId: data.componentProductId.present
          ? data.componentProductId.value
          : this.componentProductId,
      quantityRequired: data.quantityRequired.present
          ? data.quantityRequired.value
          : this.quantityRequired,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ComboItem(')
          ..write('id: $id, ')
          ..write('comboProductId: $comboProductId, ')
          ..write('componentProductId: $componentProductId, ')
          ..write('quantityRequired: $quantityRequired, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, comboProductId, componentProductId,
      quantityRequired, isDeleted, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ComboItem &&
          other.id == this.id &&
          other.comboProductId == this.comboProductId &&
          other.componentProductId == this.componentProductId &&
          other.quantityRequired == this.quantityRequired &&
          other.isDeleted == this.isDeleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ComboItemsCompanion extends UpdateCompanion<ComboItem> {
  final Value<String> id;
  final Value<String> comboProductId;
  final Value<String> componentProductId;
  final Value<double> quantityRequired;
  final Value<bool> isDeleted;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ComboItemsCompanion({
    this.id = const Value.absent(),
    this.comboProductId = const Value.absent(),
    this.componentProductId = const Value.absent(),
    this.quantityRequired = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ComboItemsCompanion.insert({
    required String id,
    required String comboProductId,
    required String componentProductId,
    this.quantityRequired = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        comboProductId = Value(comboProductId),
        componentProductId = Value(componentProductId);
  static Insertable<ComboItem> custom({
    Expression<String>? id,
    Expression<String>? comboProductId,
    Expression<String>? componentProductId,
    Expression<double>? quantityRequired,
    Expression<bool>? isDeleted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (comboProductId != null) 'combo_product_id': comboProductId,
      if (componentProductId != null)
        'component_product_id': componentProductId,
      if (quantityRequired != null) 'quantity_required': quantityRequired,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ComboItemsCompanion copyWith(
      {Value<String>? id,
      Value<String>? comboProductId,
      Value<String>? componentProductId,
      Value<double>? quantityRequired,
      Value<bool>? isDeleted,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return ComboItemsCompanion(
      id: id ?? this.id,
      comboProductId: comboProductId ?? this.comboProductId,
      componentProductId: componentProductId ?? this.componentProductId,
      quantityRequired: quantityRequired ?? this.quantityRequired,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (comboProductId.present) {
      map['combo_product_id'] = Variable<String>(comboProductId.value);
    }
    if (componentProductId.present) {
      map['component_product_id'] = Variable<String>(componentProductId.value);
    }
    if (quantityRequired.present) {
      map['quantity_required'] = Variable<double>(quantityRequired.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ComboItemsCompanion(')
          ..write('id: $id, ')
          ..write('comboProductId: $comboProductId, ')
          ..write('componentProductId: $componentProductId, ')
          ..write('quantityRequired: $quantityRequired, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CustomersTable extends Customers
    with TableInfo<$CustomersTable, Customer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _storeIdMeta =
      const VerificationMeta('storeId');
  @override
  late final GeneratedColumn<String> storeId = GeneratedColumn<String>(
      'store_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fullNameMeta =
      const VerificationMeta('fullName');
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
      'full_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _idDocumentMeta =
      const VerificationMeta('idDocument');
  @override
  late final GeneratedColumn<String> idDocument = GeneratedColumn<String>(
      'id_document', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _creditLimitUsdMeta =
      const VerificationMeta('creditLimitUsd');
  @override
  late final GeneratedColumn<double> creditLimitUsd = GeneratedColumn<double>(
      'credit_limit_usd', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _currentDebtUsdMeta =
      const VerificationMeta('currentDebtUsd');
  @override
  late final GeneratedColumn<double> currentDebtUsd = GeneratedColumn<double>(
      'current_debt_usd', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
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
        storeId,
        fullName,
        idDocument,
        phone,
        email,
        address,
        creditLimitUsd,
        currentDebtUsd,
        isDeleted,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers';
  @override
  VerificationContext validateIntegrity(Insertable<Customer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('store_id')) {
      context.handle(_storeIdMeta,
          storeId.isAcceptableOrUnknown(data['store_id']!, _storeIdMeta));
    }
    if (data.containsKey('full_name')) {
      context.handle(_fullNameMeta,
          fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta));
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('id_document')) {
      context.handle(
          _idDocumentMeta,
          idDocument.isAcceptableOrUnknown(
              data['id_document']!, _idDocumentMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('credit_limit_usd')) {
      context.handle(
          _creditLimitUsdMeta,
          creditLimitUsd.isAcceptableOrUnknown(
              data['credit_limit_usd']!, _creditLimitUsdMeta));
    }
    if (data.containsKey('current_debt_usd')) {
      context.handle(
          _currentDebtUsdMeta,
          currentDebtUsd.isAcceptableOrUnknown(
              data['current_debt_usd']!, _currentDebtUsdMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
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
  Customer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Customer(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      storeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}store_id']),
      fullName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}full_name'])!,
      idDocument: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id_document']),
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address']),
      creditLimitUsd: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}credit_limit_usd'])!,
      currentDebtUsd: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}current_debt_usd'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(attachedDatabase, alias);
  }
}

class Customer extends DataClass implements Insertable<Customer> {
  final String id;
  final String? storeId;
  final String fullName;
  final String? idDocument;
  final String? phone;
  final String? email;
  final String? address;
  final double creditLimitUsd;
  final double currentDebtUsd;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Customer(
      {required this.id,
      this.storeId,
      required this.fullName,
      this.idDocument,
      this.phone,
      this.email,
      this.address,
      required this.creditLimitUsd,
      required this.currentDebtUsd,
      required this.isDeleted,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || storeId != null) {
      map['store_id'] = Variable<String>(storeId);
    }
    map['full_name'] = Variable<String>(fullName);
    if (!nullToAbsent || idDocument != null) {
      map['id_document'] = Variable<String>(idDocument);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    map['credit_limit_usd'] = Variable<double>(creditLimitUsd);
    map['current_debt_usd'] = Variable<double>(currentDebtUsd);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CustomersCompanion toCompanion(bool nullToAbsent) {
    return CustomersCompanion(
      id: Value(id),
      storeId: storeId == null && nullToAbsent
          ? const Value.absent()
          : Value(storeId),
      fullName: Value(fullName),
      idDocument: idDocument == null && nullToAbsent
          ? const Value.absent()
          : Value(idDocument),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      creditLimitUsd: Value(creditLimitUsd),
      currentDebtUsd: Value(currentDebtUsd),
      isDeleted: Value(isDeleted),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Customer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Customer(
      id: serializer.fromJson<String>(json['id']),
      storeId: serializer.fromJson<String?>(json['storeId']),
      fullName: serializer.fromJson<String>(json['fullName']),
      idDocument: serializer.fromJson<String?>(json['idDocument']),
      phone: serializer.fromJson<String?>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      address: serializer.fromJson<String?>(json['address']),
      creditLimitUsd: serializer.fromJson<double>(json['creditLimitUsd']),
      currentDebtUsd: serializer.fromJson<double>(json['currentDebtUsd']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'storeId': serializer.toJson<String?>(storeId),
      'fullName': serializer.toJson<String>(fullName),
      'idDocument': serializer.toJson<String?>(idDocument),
      'phone': serializer.toJson<String?>(phone),
      'email': serializer.toJson<String?>(email),
      'address': serializer.toJson<String?>(address),
      'creditLimitUsd': serializer.toJson<double>(creditLimitUsd),
      'currentDebtUsd': serializer.toJson<double>(currentDebtUsd),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Customer copyWith(
          {String? id,
          Value<String?> storeId = const Value.absent(),
          String? fullName,
          Value<String?> idDocument = const Value.absent(),
          Value<String?> phone = const Value.absent(),
          Value<String?> email = const Value.absent(),
          Value<String?> address = const Value.absent(),
          double? creditLimitUsd,
          double? currentDebtUsd,
          bool? isDeleted,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Customer(
        id: id ?? this.id,
        storeId: storeId.present ? storeId.value : this.storeId,
        fullName: fullName ?? this.fullName,
        idDocument: idDocument.present ? idDocument.value : this.idDocument,
        phone: phone.present ? phone.value : this.phone,
        email: email.present ? email.value : this.email,
        address: address.present ? address.value : this.address,
        creditLimitUsd: creditLimitUsd ?? this.creditLimitUsd,
        currentDebtUsd: currentDebtUsd ?? this.currentDebtUsd,
        isDeleted: isDeleted ?? this.isDeleted,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Customer copyWithCompanion(CustomersCompanion data) {
    return Customer(
      id: data.id.present ? data.id.value : this.id,
      storeId: data.storeId.present ? data.storeId.value : this.storeId,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      idDocument:
          data.idDocument.present ? data.idDocument.value : this.idDocument,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      address: data.address.present ? data.address.value : this.address,
      creditLimitUsd: data.creditLimitUsd.present
          ? data.creditLimitUsd.value
          : this.creditLimitUsd,
      currentDebtUsd: data.currentDebtUsd.present
          ? data.currentDebtUsd.value
          : this.currentDebtUsd,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Customer(')
          ..write('id: $id, ')
          ..write('storeId: $storeId, ')
          ..write('fullName: $fullName, ')
          ..write('idDocument: $idDocument, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('creditLimitUsd: $creditLimitUsd, ')
          ..write('currentDebtUsd: $currentDebtUsd, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      storeId,
      fullName,
      idDocument,
      phone,
      email,
      address,
      creditLimitUsd,
      currentDebtUsd,
      isDeleted,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Customer &&
          other.id == this.id &&
          other.storeId == this.storeId &&
          other.fullName == this.fullName &&
          other.idDocument == this.idDocument &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.address == this.address &&
          other.creditLimitUsd == this.creditLimitUsd &&
          other.currentDebtUsd == this.currentDebtUsd &&
          other.isDeleted == this.isDeleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CustomersCompanion extends UpdateCompanion<Customer> {
  final Value<String> id;
  final Value<String?> storeId;
  final Value<String> fullName;
  final Value<String?> idDocument;
  final Value<String?> phone;
  final Value<String?> email;
  final Value<String?> address;
  final Value<double> creditLimitUsd;
  final Value<double> currentDebtUsd;
  final Value<bool> isDeleted;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.storeId = const Value.absent(),
    this.fullName = const Value.absent(),
    this.idDocument = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.creditLimitUsd = const Value.absent(),
    this.currentDebtUsd = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CustomersCompanion.insert({
    required String id,
    this.storeId = const Value.absent(),
    required String fullName,
    this.idDocument = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.creditLimitUsd = const Value.absent(),
    this.currentDebtUsd = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        fullName = Value(fullName);
  static Insertable<Customer> custom({
    Expression<String>? id,
    Expression<String>? storeId,
    Expression<String>? fullName,
    Expression<String>? idDocument,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? address,
    Expression<double>? creditLimitUsd,
    Expression<double>? currentDebtUsd,
    Expression<bool>? isDeleted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (storeId != null) 'store_id': storeId,
      if (fullName != null) 'full_name': fullName,
      if (idDocument != null) 'id_document': idDocument,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (address != null) 'address': address,
      if (creditLimitUsd != null) 'credit_limit_usd': creditLimitUsd,
      if (currentDebtUsd != null) 'current_debt_usd': currentDebtUsd,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CustomersCompanion copyWith(
      {Value<String>? id,
      Value<String?>? storeId,
      Value<String>? fullName,
      Value<String?>? idDocument,
      Value<String?>? phone,
      Value<String?>? email,
      Value<String?>? address,
      Value<double>? creditLimitUsd,
      Value<double>? currentDebtUsd,
      Value<bool>? isDeleted,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return CustomersCompanion(
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
      fullName: fullName ?? this.fullName,
      idDocument: idDocument ?? this.idDocument,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      creditLimitUsd: creditLimitUsd ?? this.creditLimitUsd,
      currentDebtUsd: currentDebtUsd ?? this.currentDebtUsd,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (storeId.present) {
      map['store_id'] = Variable<String>(storeId.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (idDocument.present) {
      map['id_document'] = Variable<String>(idDocument.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (creditLimitUsd.present) {
      map['credit_limit_usd'] = Variable<double>(creditLimitUsd.value);
    }
    if (currentDebtUsd.present) {
      map['current_debt_usd'] = Variable<double>(currentDebtUsd.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersCompanion(')
          ..write('id: $id, ')
          ..write('storeId: $storeId, ')
          ..write('fullName: $fullName, ')
          ..write('idDocument: $idDocument, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('creditLimitUsd: $creditLimitUsd, ')
          ..write('currentDebtUsd: $currentDebtUsd, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CashSessionsTable extends CashSessions
    with TableInfo<$CashSessionsTable, CashSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CashSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _storeIdMeta =
      const VerificationMeta('storeId');
  @override
  late final GeneratedColumn<String> storeId = GeneratedColumn<String>(
      'store_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('open'));
  static const VerificationMeta _openedAtMeta =
      const VerificationMeta('openedAt');
  @override
  late final GeneratedColumn<DateTime> openedAt = GeneratedColumn<DateTime>(
      'opened_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _closedAtMeta =
      const VerificationMeta('closedAt');
  @override
  late final GeneratedColumn<DateTime> closedAt = GeneratedColumn<DateTime>(
      'closed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _openingCashUsdMeta =
      const VerificationMeta('openingCashUsd');
  @override
  late final GeneratedColumn<double> openingCashUsd = GeneratedColumn<double>(
      'opening_cash_usd', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _openingCashBsMeta =
      const VerificationMeta('openingCashBs');
  @override
  late final GeneratedColumn<double> openingCashBs = GeneratedColumn<double>(
      'opening_cash_bs', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _expectedCashUsdMeta =
      const VerificationMeta('expectedCashUsd');
  @override
  late final GeneratedColumn<double> expectedCashUsd = GeneratedColumn<double>(
      'expected_cash_usd', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _expectedCashBsMeta =
      const VerificationMeta('expectedCashBs');
  @override
  late final GeneratedColumn<double> expectedCashBs = GeneratedColumn<double>(
      'expected_cash_bs', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _declaredCashUsdMeta =
      const VerificationMeta('declaredCashUsd');
  @override
  late final GeneratedColumn<double> declaredCashUsd = GeneratedColumn<double>(
      'declared_cash_usd', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _declaredCashBsMeta =
      const VerificationMeta('declaredCashBs');
  @override
  late final GeneratedColumn<double> declaredCashBs = GeneratedColumn<double>(
      'declared_cash_bs', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _differenceUsdMeta =
      const VerificationMeta('differenceUsd');
  @override
  late final GeneratedColumn<double> differenceUsd = GeneratedColumn<double>(
      'difference_usd', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _differenceBsMeta =
      const VerificationMeta('differenceBs');
  @override
  late final GeneratedColumn<double> differenceBs = GeneratedColumn<double>(
      'difference_bs', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
        storeId,
        userId,
        status,
        openedAt,
        closedAt,
        openingCashUsd,
        openingCashBs,
        expectedCashUsd,
        expectedCashBs,
        declaredCashUsd,
        declaredCashBs,
        differenceUsd,
        differenceBs,
        notes,
        isDeleted,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cash_sessions';
  @override
  VerificationContext validateIntegrity(Insertable<CashSession> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('store_id')) {
      context.handle(_storeIdMeta,
          storeId.isAcceptableOrUnknown(data['store_id']!, _storeIdMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('opened_at')) {
      context.handle(_openedAtMeta,
          openedAt.isAcceptableOrUnknown(data['opened_at']!, _openedAtMeta));
    }
    if (data.containsKey('closed_at')) {
      context.handle(_closedAtMeta,
          closedAt.isAcceptableOrUnknown(data['closed_at']!, _closedAtMeta));
    }
    if (data.containsKey('opening_cash_usd')) {
      context.handle(
          _openingCashUsdMeta,
          openingCashUsd.isAcceptableOrUnknown(
              data['opening_cash_usd']!, _openingCashUsdMeta));
    }
    if (data.containsKey('opening_cash_bs')) {
      context.handle(
          _openingCashBsMeta,
          openingCashBs.isAcceptableOrUnknown(
              data['opening_cash_bs']!, _openingCashBsMeta));
    }
    if (data.containsKey('expected_cash_usd')) {
      context.handle(
          _expectedCashUsdMeta,
          expectedCashUsd.isAcceptableOrUnknown(
              data['expected_cash_usd']!, _expectedCashUsdMeta));
    }
    if (data.containsKey('expected_cash_bs')) {
      context.handle(
          _expectedCashBsMeta,
          expectedCashBs.isAcceptableOrUnknown(
              data['expected_cash_bs']!, _expectedCashBsMeta));
    }
    if (data.containsKey('declared_cash_usd')) {
      context.handle(
          _declaredCashUsdMeta,
          declaredCashUsd.isAcceptableOrUnknown(
              data['declared_cash_usd']!, _declaredCashUsdMeta));
    }
    if (data.containsKey('declared_cash_bs')) {
      context.handle(
          _declaredCashBsMeta,
          declaredCashBs.isAcceptableOrUnknown(
              data['declared_cash_bs']!, _declaredCashBsMeta));
    }
    if (data.containsKey('difference_usd')) {
      context.handle(
          _differenceUsdMeta,
          differenceUsd.isAcceptableOrUnknown(
              data['difference_usd']!, _differenceUsdMeta));
    }
    if (data.containsKey('difference_bs')) {
      context.handle(
          _differenceBsMeta,
          differenceBs.isAcceptableOrUnknown(
              data['difference_bs']!, _differenceBsMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
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
  CashSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CashSession(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      storeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}store_id']),
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      openedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}opened_at'])!,
      closedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}closed_at']),
      openingCashUsd: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}opening_cash_usd'])!,
      openingCashBs: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}opening_cash_bs'])!,
      expectedCashUsd: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}expected_cash_usd'])!,
      expectedCashBs: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}expected_cash_bs'])!,
      declaredCashUsd: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}declared_cash_usd']),
      declaredCashBs: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}declared_cash_bs']),
      differenceUsd: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}difference_usd']),
      differenceBs: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}difference_bs']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $CashSessionsTable createAlias(String alias) {
    return $CashSessionsTable(attachedDatabase, alias);
  }
}

class CashSession extends DataClass implements Insertable<CashSession> {
  final String id;
  final String? storeId;
  final String? userId;
  final String status;
  final DateTime openedAt;
  final DateTime? closedAt;
  final double openingCashUsd;
  final double openingCashBs;
  final double expectedCashUsd;
  final double expectedCashBs;
  final double? declaredCashUsd;
  final double? declaredCashBs;
  final double? differenceUsd;
  final double? differenceBs;
  final String? notes;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CashSession(
      {required this.id,
      this.storeId,
      this.userId,
      required this.status,
      required this.openedAt,
      this.closedAt,
      required this.openingCashUsd,
      required this.openingCashBs,
      required this.expectedCashUsd,
      required this.expectedCashBs,
      this.declaredCashUsd,
      this.declaredCashBs,
      this.differenceUsd,
      this.differenceBs,
      this.notes,
      required this.isDeleted,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || storeId != null) {
      map['store_id'] = Variable<String>(storeId);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    map['status'] = Variable<String>(status);
    map['opened_at'] = Variable<DateTime>(openedAt);
    if (!nullToAbsent || closedAt != null) {
      map['closed_at'] = Variable<DateTime>(closedAt);
    }
    map['opening_cash_usd'] = Variable<double>(openingCashUsd);
    map['opening_cash_bs'] = Variable<double>(openingCashBs);
    map['expected_cash_usd'] = Variable<double>(expectedCashUsd);
    map['expected_cash_bs'] = Variable<double>(expectedCashBs);
    if (!nullToAbsent || declaredCashUsd != null) {
      map['declared_cash_usd'] = Variable<double>(declaredCashUsd);
    }
    if (!nullToAbsent || declaredCashBs != null) {
      map['declared_cash_bs'] = Variable<double>(declaredCashBs);
    }
    if (!nullToAbsent || differenceUsd != null) {
      map['difference_usd'] = Variable<double>(differenceUsd);
    }
    if (!nullToAbsent || differenceBs != null) {
      map['difference_bs'] = Variable<double>(differenceBs);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CashSessionsCompanion toCompanion(bool nullToAbsent) {
    return CashSessionsCompanion(
      id: Value(id),
      storeId: storeId == null && nullToAbsent
          ? const Value.absent()
          : Value(storeId),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      status: Value(status),
      openedAt: Value(openedAt),
      closedAt: closedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(closedAt),
      openingCashUsd: Value(openingCashUsd),
      openingCashBs: Value(openingCashBs),
      expectedCashUsd: Value(expectedCashUsd),
      expectedCashBs: Value(expectedCashBs),
      declaredCashUsd: declaredCashUsd == null && nullToAbsent
          ? const Value.absent()
          : Value(declaredCashUsd),
      declaredCashBs: declaredCashBs == null && nullToAbsent
          ? const Value.absent()
          : Value(declaredCashBs),
      differenceUsd: differenceUsd == null && nullToAbsent
          ? const Value.absent()
          : Value(differenceUsd),
      differenceBs: differenceBs == null && nullToAbsent
          ? const Value.absent()
          : Value(differenceBs),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      isDeleted: Value(isDeleted),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CashSession.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CashSession(
      id: serializer.fromJson<String>(json['id']),
      storeId: serializer.fromJson<String?>(json['storeId']),
      userId: serializer.fromJson<String?>(json['userId']),
      status: serializer.fromJson<String>(json['status']),
      openedAt: serializer.fromJson<DateTime>(json['openedAt']),
      closedAt: serializer.fromJson<DateTime?>(json['closedAt']),
      openingCashUsd: serializer.fromJson<double>(json['openingCashUsd']),
      openingCashBs: serializer.fromJson<double>(json['openingCashBs']),
      expectedCashUsd: serializer.fromJson<double>(json['expectedCashUsd']),
      expectedCashBs: serializer.fromJson<double>(json['expectedCashBs']),
      declaredCashUsd: serializer.fromJson<double?>(json['declaredCashUsd']),
      declaredCashBs: serializer.fromJson<double?>(json['declaredCashBs']),
      differenceUsd: serializer.fromJson<double?>(json['differenceUsd']),
      differenceBs: serializer.fromJson<double?>(json['differenceBs']),
      notes: serializer.fromJson<String?>(json['notes']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'storeId': serializer.toJson<String?>(storeId),
      'userId': serializer.toJson<String?>(userId),
      'status': serializer.toJson<String>(status),
      'openedAt': serializer.toJson<DateTime>(openedAt),
      'closedAt': serializer.toJson<DateTime?>(closedAt),
      'openingCashUsd': serializer.toJson<double>(openingCashUsd),
      'openingCashBs': serializer.toJson<double>(openingCashBs),
      'expectedCashUsd': serializer.toJson<double>(expectedCashUsd),
      'expectedCashBs': serializer.toJson<double>(expectedCashBs),
      'declaredCashUsd': serializer.toJson<double?>(declaredCashUsd),
      'declaredCashBs': serializer.toJson<double?>(declaredCashBs),
      'differenceUsd': serializer.toJson<double?>(differenceUsd),
      'differenceBs': serializer.toJson<double?>(differenceBs),
      'notes': serializer.toJson<String?>(notes),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CashSession copyWith(
          {String? id,
          Value<String?> storeId = const Value.absent(),
          Value<String?> userId = const Value.absent(),
          String? status,
          DateTime? openedAt,
          Value<DateTime?> closedAt = const Value.absent(),
          double? openingCashUsd,
          double? openingCashBs,
          double? expectedCashUsd,
          double? expectedCashBs,
          Value<double?> declaredCashUsd = const Value.absent(),
          Value<double?> declaredCashBs = const Value.absent(),
          Value<double?> differenceUsd = const Value.absent(),
          Value<double?> differenceBs = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          bool? isDeleted,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      CashSession(
        id: id ?? this.id,
        storeId: storeId.present ? storeId.value : this.storeId,
        userId: userId.present ? userId.value : this.userId,
        status: status ?? this.status,
        openedAt: openedAt ?? this.openedAt,
        closedAt: closedAt.present ? closedAt.value : this.closedAt,
        openingCashUsd: openingCashUsd ?? this.openingCashUsd,
        openingCashBs: openingCashBs ?? this.openingCashBs,
        expectedCashUsd: expectedCashUsd ?? this.expectedCashUsd,
        expectedCashBs: expectedCashBs ?? this.expectedCashBs,
        declaredCashUsd: declaredCashUsd.present
            ? declaredCashUsd.value
            : this.declaredCashUsd,
        declaredCashBs:
            declaredCashBs.present ? declaredCashBs.value : this.declaredCashBs,
        differenceUsd:
            differenceUsd.present ? differenceUsd.value : this.differenceUsd,
        differenceBs:
            differenceBs.present ? differenceBs.value : this.differenceBs,
        notes: notes.present ? notes.value : this.notes,
        isDeleted: isDeleted ?? this.isDeleted,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  CashSession copyWithCompanion(CashSessionsCompanion data) {
    return CashSession(
      id: data.id.present ? data.id.value : this.id,
      storeId: data.storeId.present ? data.storeId.value : this.storeId,
      userId: data.userId.present ? data.userId.value : this.userId,
      status: data.status.present ? data.status.value : this.status,
      openedAt: data.openedAt.present ? data.openedAt.value : this.openedAt,
      closedAt: data.closedAt.present ? data.closedAt.value : this.closedAt,
      openingCashUsd: data.openingCashUsd.present
          ? data.openingCashUsd.value
          : this.openingCashUsd,
      openingCashBs: data.openingCashBs.present
          ? data.openingCashBs.value
          : this.openingCashBs,
      expectedCashUsd: data.expectedCashUsd.present
          ? data.expectedCashUsd.value
          : this.expectedCashUsd,
      expectedCashBs: data.expectedCashBs.present
          ? data.expectedCashBs.value
          : this.expectedCashBs,
      declaredCashUsd: data.declaredCashUsd.present
          ? data.declaredCashUsd.value
          : this.declaredCashUsd,
      declaredCashBs: data.declaredCashBs.present
          ? data.declaredCashBs.value
          : this.declaredCashBs,
      differenceUsd: data.differenceUsd.present
          ? data.differenceUsd.value
          : this.differenceUsd,
      differenceBs: data.differenceBs.present
          ? data.differenceBs.value
          : this.differenceBs,
      notes: data.notes.present ? data.notes.value : this.notes,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CashSession(')
          ..write('id: $id, ')
          ..write('storeId: $storeId, ')
          ..write('userId: $userId, ')
          ..write('status: $status, ')
          ..write('openedAt: $openedAt, ')
          ..write('closedAt: $closedAt, ')
          ..write('openingCashUsd: $openingCashUsd, ')
          ..write('openingCashBs: $openingCashBs, ')
          ..write('expectedCashUsd: $expectedCashUsd, ')
          ..write('expectedCashBs: $expectedCashBs, ')
          ..write('declaredCashUsd: $declaredCashUsd, ')
          ..write('declaredCashBs: $declaredCashBs, ')
          ..write('differenceUsd: $differenceUsd, ')
          ..write('differenceBs: $differenceBs, ')
          ..write('notes: $notes, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      storeId,
      userId,
      status,
      openedAt,
      closedAt,
      openingCashUsd,
      openingCashBs,
      expectedCashUsd,
      expectedCashBs,
      declaredCashUsd,
      declaredCashBs,
      differenceUsd,
      differenceBs,
      notes,
      isDeleted,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CashSession &&
          other.id == this.id &&
          other.storeId == this.storeId &&
          other.userId == this.userId &&
          other.status == this.status &&
          other.openedAt == this.openedAt &&
          other.closedAt == this.closedAt &&
          other.openingCashUsd == this.openingCashUsd &&
          other.openingCashBs == this.openingCashBs &&
          other.expectedCashUsd == this.expectedCashUsd &&
          other.expectedCashBs == this.expectedCashBs &&
          other.declaredCashUsd == this.declaredCashUsd &&
          other.declaredCashBs == this.declaredCashBs &&
          other.differenceUsd == this.differenceUsd &&
          other.differenceBs == this.differenceBs &&
          other.notes == this.notes &&
          other.isDeleted == this.isDeleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CashSessionsCompanion extends UpdateCompanion<CashSession> {
  final Value<String> id;
  final Value<String?> storeId;
  final Value<String?> userId;
  final Value<String> status;
  final Value<DateTime> openedAt;
  final Value<DateTime?> closedAt;
  final Value<double> openingCashUsd;
  final Value<double> openingCashBs;
  final Value<double> expectedCashUsd;
  final Value<double> expectedCashBs;
  final Value<double?> declaredCashUsd;
  final Value<double?> declaredCashBs;
  final Value<double?> differenceUsd;
  final Value<double?> differenceBs;
  final Value<String?> notes;
  final Value<bool> isDeleted;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CashSessionsCompanion({
    this.id = const Value.absent(),
    this.storeId = const Value.absent(),
    this.userId = const Value.absent(),
    this.status = const Value.absent(),
    this.openedAt = const Value.absent(),
    this.closedAt = const Value.absent(),
    this.openingCashUsd = const Value.absent(),
    this.openingCashBs = const Value.absent(),
    this.expectedCashUsd = const Value.absent(),
    this.expectedCashBs = const Value.absent(),
    this.declaredCashUsd = const Value.absent(),
    this.declaredCashBs = const Value.absent(),
    this.differenceUsd = const Value.absent(),
    this.differenceBs = const Value.absent(),
    this.notes = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CashSessionsCompanion.insert({
    required String id,
    this.storeId = const Value.absent(),
    this.userId = const Value.absent(),
    this.status = const Value.absent(),
    this.openedAt = const Value.absent(),
    this.closedAt = const Value.absent(),
    this.openingCashUsd = const Value.absent(),
    this.openingCashBs = const Value.absent(),
    this.expectedCashUsd = const Value.absent(),
    this.expectedCashBs = const Value.absent(),
    this.declaredCashUsd = const Value.absent(),
    this.declaredCashBs = const Value.absent(),
    this.differenceUsd = const Value.absent(),
    this.differenceBs = const Value.absent(),
    this.notes = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<CashSession> custom({
    Expression<String>? id,
    Expression<String>? storeId,
    Expression<String>? userId,
    Expression<String>? status,
    Expression<DateTime>? openedAt,
    Expression<DateTime>? closedAt,
    Expression<double>? openingCashUsd,
    Expression<double>? openingCashBs,
    Expression<double>? expectedCashUsd,
    Expression<double>? expectedCashBs,
    Expression<double>? declaredCashUsd,
    Expression<double>? declaredCashBs,
    Expression<double>? differenceUsd,
    Expression<double>? differenceBs,
    Expression<String>? notes,
    Expression<bool>? isDeleted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (storeId != null) 'store_id': storeId,
      if (userId != null) 'user_id': userId,
      if (status != null) 'status': status,
      if (openedAt != null) 'opened_at': openedAt,
      if (closedAt != null) 'closed_at': closedAt,
      if (openingCashUsd != null) 'opening_cash_usd': openingCashUsd,
      if (openingCashBs != null) 'opening_cash_bs': openingCashBs,
      if (expectedCashUsd != null) 'expected_cash_usd': expectedCashUsd,
      if (expectedCashBs != null) 'expected_cash_bs': expectedCashBs,
      if (declaredCashUsd != null) 'declared_cash_usd': declaredCashUsd,
      if (declaredCashBs != null) 'declared_cash_bs': declaredCashBs,
      if (differenceUsd != null) 'difference_usd': differenceUsd,
      if (differenceBs != null) 'difference_bs': differenceBs,
      if (notes != null) 'notes': notes,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CashSessionsCompanion copyWith(
      {Value<String>? id,
      Value<String?>? storeId,
      Value<String?>? userId,
      Value<String>? status,
      Value<DateTime>? openedAt,
      Value<DateTime?>? closedAt,
      Value<double>? openingCashUsd,
      Value<double>? openingCashBs,
      Value<double>? expectedCashUsd,
      Value<double>? expectedCashBs,
      Value<double?>? declaredCashUsd,
      Value<double?>? declaredCashBs,
      Value<double?>? differenceUsd,
      Value<double?>? differenceBs,
      Value<String?>? notes,
      Value<bool>? isDeleted,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return CashSessionsCompanion(
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      openedAt: openedAt ?? this.openedAt,
      closedAt: closedAt ?? this.closedAt,
      openingCashUsd: openingCashUsd ?? this.openingCashUsd,
      openingCashBs: openingCashBs ?? this.openingCashBs,
      expectedCashUsd: expectedCashUsd ?? this.expectedCashUsd,
      expectedCashBs: expectedCashBs ?? this.expectedCashBs,
      declaredCashUsd: declaredCashUsd ?? this.declaredCashUsd,
      declaredCashBs: declaredCashBs ?? this.declaredCashBs,
      differenceUsd: differenceUsd ?? this.differenceUsd,
      differenceBs: differenceBs ?? this.differenceBs,
      notes: notes ?? this.notes,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (storeId.present) {
      map['store_id'] = Variable<String>(storeId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (openedAt.present) {
      map['opened_at'] = Variable<DateTime>(openedAt.value);
    }
    if (closedAt.present) {
      map['closed_at'] = Variable<DateTime>(closedAt.value);
    }
    if (openingCashUsd.present) {
      map['opening_cash_usd'] = Variable<double>(openingCashUsd.value);
    }
    if (openingCashBs.present) {
      map['opening_cash_bs'] = Variable<double>(openingCashBs.value);
    }
    if (expectedCashUsd.present) {
      map['expected_cash_usd'] = Variable<double>(expectedCashUsd.value);
    }
    if (expectedCashBs.present) {
      map['expected_cash_bs'] = Variable<double>(expectedCashBs.value);
    }
    if (declaredCashUsd.present) {
      map['declared_cash_usd'] = Variable<double>(declaredCashUsd.value);
    }
    if (declaredCashBs.present) {
      map['declared_cash_bs'] = Variable<double>(declaredCashBs.value);
    }
    if (differenceUsd.present) {
      map['difference_usd'] = Variable<double>(differenceUsd.value);
    }
    if (differenceBs.present) {
      map['difference_bs'] = Variable<double>(differenceBs.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CashSessionsCompanion(')
          ..write('id: $id, ')
          ..write('storeId: $storeId, ')
          ..write('userId: $userId, ')
          ..write('status: $status, ')
          ..write('openedAt: $openedAt, ')
          ..write('closedAt: $closedAt, ')
          ..write('openingCashUsd: $openingCashUsd, ')
          ..write('openingCashBs: $openingCashBs, ')
          ..write('expectedCashUsd: $expectedCashUsd, ')
          ..write('expectedCashBs: $expectedCashBs, ')
          ..write('declaredCashUsd: $declaredCashUsd, ')
          ..write('declaredCashBs: $declaredCashBs, ')
          ..write('differenceUsd: $differenceUsd, ')
          ..write('differenceBs: $differenceBs, ')
          ..write('notes: $notes, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SalesTable extends Sales with TableInfo<$SalesTable, Sale> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _storeIdMeta =
      const VerificationMeta('storeId');
  @override
  late final GeneratedColumn<String> storeId = GeneratedColumn<String>(
      'store_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cashSessionIdMeta =
      const VerificationMeta('cashSessionId');
  @override
  late final GeneratedColumn<String> cashSessionId = GeneratedColumn<String>(
      'cash_session_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _customerIdMeta =
      const VerificationMeta('customerId');
  @override
  late final GeneratedColumn<String> customerId = GeneratedColumn<String>(
      'customer_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _invoiceNumberMeta =
      const VerificationMeta('invoiceNumber');
  @override
  late final GeneratedColumn<String> invoiceNumber = GeneratedColumn<String>(
      'invoice_number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _exchangeRateUsedMeta =
      const VerificationMeta('exchangeRateUsed');
  @override
  late final GeneratedColumn<double> exchangeRateUsed = GeneratedColumn<double>(
      'exchange_rate_used', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _subtotalUsdMeta =
      const VerificationMeta('subtotalUsd');
  @override
  late final GeneratedColumn<double> subtotalUsd = GeneratedColumn<double>(
      'subtotal_usd', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _discountUsdMeta =
      const VerificationMeta('discountUsd');
  @override
  late final GeneratedColumn<double> discountUsd = GeneratedColumn<double>(
      'discount_usd', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _igtfAppliedMeta =
      const VerificationMeta('igtfApplied');
  @override
  late final GeneratedColumn<bool> igtfApplied = GeneratedColumn<bool>(
      'igtf_applied', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("igtf_applied" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _igtfAmountUsdMeta =
      const VerificationMeta('igtfAmountUsd');
  @override
  late final GeneratedColumn<double> igtfAmountUsd = GeneratedColumn<double>(
      'igtf_amount_usd', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _totalUsdMeta =
      const VerificationMeta('totalUsd');
  @override
  late final GeneratedColumn<double> totalUsd = GeneratedColumn<double>(
      'total_usd', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _totalBsMeta =
      const VerificationMeta('totalBs');
  @override
  late final GeneratedColumn<double> totalBs = GeneratedColumn<double>(
      'total_bs', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _paymentStatusMeta =
      const VerificationMeta('paymentStatus');
  @override
  late final GeneratedColumn<String> paymentStatus = GeneratedColumn<String>(
      'payment_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('paid'));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
        storeId,
        cashSessionId,
        customerId,
        userId,
        invoiceNumber,
        exchangeRateUsed,
        subtotalUsd,
        discountUsd,
        igtfApplied,
        igtfAmountUsd,
        totalUsd,
        totalBs,
        paymentStatus,
        notes,
        isDeleted,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sales';
  @override
  VerificationContext validateIntegrity(Insertable<Sale> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('store_id')) {
      context.handle(_storeIdMeta,
          storeId.isAcceptableOrUnknown(data['store_id']!, _storeIdMeta));
    }
    if (data.containsKey('cash_session_id')) {
      context.handle(
          _cashSessionIdMeta,
          cashSessionId.isAcceptableOrUnknown(
              data['cash_session_id']!, _cashSessionIdMeta));
    }
    if (data.containsKey('customer_id')) {
      context.handle(
          _customerIdMeta,
          customerId.isAcceptableOrUnknown(
              data['customer_id']!, _customerIdMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('invoice_number')) {
      context.handle(
          _invoiceNumberMeta,
          invoiceNumber.isAcceptableOrUnknown(
              data['invoice_number']!, _invoiceNumberMeta));
    } else if (isInserting) {
      context.missing(_invoiceNumberMeta);
    }
    if (data.containsKey('exchange_rate_used')) {
      context.handle(
          _exchangeRateUsedMeta,
          exchangeRateUsed.isAcceptableOrUnknown(
              data['exchange_rate_used']!, _exchangeRateUsedMeta));
    } else if (isInserting) {
      context.missing(_exchangeRateUsedMeta);
    }
    if (data.containsKey('subtotal_usd')) {
      context.handle(
          _subtotalUsdMeta,
          subtotalUsd.isAcceptableOrUnknown(
              data['subtotal_usd']!, _subtotalUsdMeta));
    } else if (isInserting) {
      context.missing(_subtotalUsdMeta);
    }
    if (data.containsKey('discount_usd')) {
      context.handle(
          _discountUsdMeta,
          discountUsd.isAcceptableOrUnknown(
              data['discount_usd']!, _discountUsdMeta));
    }
    if (data.containsKey('igtf_applied')) {
      context.handle(
          _igtfAppliedMeta,
          igtfApplied.isAcceptableOrUnknown(
              data['igtf_applied']!, _igtfAppliedMeta));
    }
    if (data.containsKey('igtf_amount_usd')) {
      context.handle(
          _igtfAmountUsdMeta,
          igtfAmountUsd.isAcceptableOrUnknown(
              data['igtf_amount_usd']!, _igtfAmountUsdMeta));
    }
    if (data.containsKey('total_usd')) {
      context.handle(_totalUsdMeta,
          totalUsd.isAcceptableOrUnknown(data['total_usd']!, _totalUsdMeta));
    } else if (isInserting) {
      context.missing(_totalUsdMeta);
    }
    if (data.containsKey('total_bs')) {
      context.handle(_totalBsMeta,
          totalBs.isAcceptableOrUnknown(data['total_bs']!, _totalBsMeta));
    } else if (isInserting) {
      context.missing(_totalBsMeta);
    }
    if (data.containsKey('payment_status')) {
      context.handle(
          _paymentStatusMeta,
          paymentStatus.isAcceptableOrUnknown(
              data['payment_status']!, _paymentStatusMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
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
  Sale map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Sale(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      storeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}store_id']),
      cashSessionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cash_session_id']),
      customerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}customer_id']),
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id']),
      invoiceNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}invoice_number'])!,
      exchangeRateUsed: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}exchange_rate_used'])!,
      subtotalUsd: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}subtotal_usd'])!,
      discountUsd: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}discount_usd'])!,
      igtfApplied: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}igtf_applied'])!,
      igtfAmountUsd: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}igtf_amount_usd'])!,
      totalUsd: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_usd'])!,
      totalBs: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_bs'])!,
      paymentStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payment_status'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $SalesTable createAlias(String alias) {
    return $SalesTable(attachedDatabase, alias);
  }
}

class Sale extends DataClass implements Insertable<Sale> {
  final String id;
  final String? storeId;
  final String? cashSessionId;
  final String? customerId;
  final String? userId;
  final String invoiceNumber;
  final double exchangeRateUsed;
  final double subtotalUsd;
  final double discountUsd;
  final bool igtfApplied;
  final double igtfAmountUsd;
  final double totalUsd;
  final double totalBs;
  final String paymentStatus;
  final String? notes;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Sale(
      {required this.id,
      this.storeId,
      this.cashSessionId,
      this.customerId,
      this.userId,
      required this.invoiceNumber,
      required this.exchangeRateUsed,
      required this.subtotalUsd,
      required this.discountUsd,
      required this.igtfApplied,
      required this.igtfAmountUsd,
      required this.totalUsd,
      required this.totalBs,
      required this.paymentStatus,
      this.notes,
      required this.isDeleted,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || storeId != null) {
      map['store_id'] = Variable<String>(storeId);
    }
    if (!nullToAbsent || cashSessionId != null) {
      map['cash_session_id'] = Variable<String>(cashSessionId);
    }
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<String>(customerId);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    map['invoice_number'] = Variable<String>(invoiceNumber);
    map['exchange_rate_used'] = Variable<double>(exchangeRateUsed);
    map['subtotal_usd'] = Variable<double>(subtotalUsd);
    map['discount_usd'] = Variable<double>(discountUsd);
    map['igtf_applied'] = Variable<bool>(igtfApplied);
    map['igtf_amount_usd'] = Variable<double>(igtfAmountUsd);
    map['total_usd'] = Variable<double>(totalUsd);
    map['total_bs'] = Variable<double>(totalBs);
    map['payment_status'] = Variable<String>(paymentStatus);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SalesCompanion toCompanion(bool nullToAbsent) {
    return SalesCompanion(
      id: Value(id),
      storeId: storeId == null && nullToAbsent
          ? const Value.absent()
          : Value(storeId),
      cashSessionId: cashSessionId == null && nullToAbsent
          ? const Value.absent()
          : Value(cashSessionId),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      invoiceNumber: Value(invoiceNumber),
      exchangeRateUsed: Value(exchangeRateUsed),
      subtotalUsd: Value(subtotalUsd),
      discountUsd: Value(discountUsd),
      igtfApplied: Value(igtfApplied),
      igtfAmountUsd: Value(igtfAmountUsd),
      totalUsd: Value(totalUsd),
      totalBs: Value(totalBs),
      paymentStatus: Value(paymentStatus),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      isDeleted: Value(isDeleted),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Sale.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Sale(
      id: serializer.fromJson<String>(json['id']),
      storeId: serializer.fromJson<String?>(json['storeId']),
      cashSessionId: serializer.fromJson<String?>(json['cashSessionId']),
      customerId: serializer.fromJson<String?>(json['customerId']),
      userId: serializer.fromJson<String?>(json['userId']),
      invoiceNumber: serializer.fromJson<String>(json['invoiceNumber']),
      exchangeRateUsed: serializer.fromJson<double>(json['exchangeRateUsed']),
      subtotalUsd: serializer.fromJson<double>(json['subtotalUsd']),
      discountUsd: serializer.fromJson<double>(json['discountUsd']),
      igtfApplied: serializer.fromJson<bool>(json['igtfApplied']),
      igtfAmountUsd: serializer.fromJson<double>(json['igtfAmountUsd']),
      totalUsd: serializer.fromJson<double>(json['totalUsd']),
      totalBs: serializer.fromJson<double>(json['totalBs']),
      paymentStatus: serializer.fromJson<String>(json['paymentStatus']),
      notes: serializer.fromJson<String?>(json['notes']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'storeId': serializer.toJson<String?>(storeId),
      'cashSessionId': serializer.toJson<String?>(cashSessionId),
      'customerId': serializer.toJson<String?>(customerId),
      'userId': serializer.toJson<String?>(userId),
      'invoiceNumber': serializer.toJson<String>(invoiceNumber),
      'exchangeRateUsed': serializer.toJson<double>(exchangeRateUsed),
      'subtotalUsd': serializer.toJson<double>(subtotalUsd),
      'discountUsd': serializer.toJson<double>(discountUsd),
      'igtfApplied': serializer.toJson<bool>(igtfApplied),
      'igtfAmountUsd': serializer.toJson<double>(igtfAmountUsd),
      'totalUsd': serializer.toJson<double>(totalUsd),
      'totalBs': serializer.toJson<double>(totalBs),
      'paymentStatus': serializer.toJson<String>(paymentStatus),
      'notes': serializer.toJson<String?>(notes),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Sale copyWith(
          {String? id,
          Value<String?> storeId = const Value.absent(),
          Value<String?> cashSessionId = const Value.absent(),
          Value<String?> customerId = const Value.absent(),
          Value<String?> userId = const Value.absent(),
          String? invoiceNumber,
          double? exchangeRateUsed,
          double? subtotalUsd,
          double? discountUsd,
          bool? igtfApplied,
          double? igtfAmountUsd,
          double? totalUsd,
          double? totalBs,
          String? paymentStatus,
          Value<String?> notes = const Value.absent(),
          bool? isDeleted,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Sale(
        id: id ?? this.id,
        storeId: storeId.present ? storeId.value : this.storeId,
        cashSessionId:
            cashSessionId.present ? cashSessionId.value : this.cashSessionId,
        customerId: customerId.present ? customerId.value : this.customerId,
        userId: userId.present ? userId.value : this.userId,
        invoiceNumber: invoiceNumber ?? this.invoiceNumber,
        exchangeRateUsed: exchangeRateUsed ?? this.exchangeRateUsed,
        subtotalUsd: subtotalUsd ?? this.subtotalUsd,
        discountUsd: discountUsd ?? this.discountUsd,
        igtfApplied: igtfApplied ?? this.igtfApplied,
        igtfAmountUsd: igtfAmountUsd ?? this.igtfAmountUsd,
        totalUsd: totalUsd ?? this.totalUsd,
        totalBs: totalBs ?? this.totalBs,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        notes: notes.present ? notes.value : this.notes,
        isDeleted: isDeleted ?? this.isDeleted,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Sale copyWithCompanion(SalesCompanion data) {
    return Sale(
      id: data.id.present ? data.id.value : this.id,
      storeId: data.storeId.present ? data.storeId.value : this.storeId,
      cashSessionId: data.cashSessionId.present
          ? data.cashSessionId.value
          : this.cashSessionId,
      customerId:
          data.customerId.present ? data.customerId.value : this.customerId,
      userId: data.userId.present ? data.userId.value : this.userId,
      invoiceNumber: data.invoiceNumber.present
          ? data.invoiceNumber.value
          : this.invoiceNumber,
      exchangeRateUsed: data.exchangeRateUsed.present
          ? data.exchangeRateUsed.value
          : this.exchangeRateUsed,
      subtotalUsd:
          data.subtotalUsd.present ? data.subtotalUsd.value : this.subtotalUsd,
      discountUsd:
          data.discountUsd.present ? data.discountUsd.value : this.discountUsd,
      igtfApplied:
          data.igtfApplied.present ? data.igtfApplied.value : this.igtfApplied,
      igtfAmountUsd: data.igtfAmountUsd.present
          ? data.igtfAmountUsd.value
          : this.igtfAmountUsd,
      totalUsd: data.totalUsd.present ? data.totalUsd.value : this.totalUsd,
      totalBs: data.totalBs.present ? data.totalBs.value : this.totalBs,
      paymentStatus: data.paymentStatus.present
          ? data.paymentStatus.value
          : this.paymentStatus,
      notes: data.notes.present ? data.notes.value : this.notes,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Sale(')
          ..write('id: $id, ')
          ..write('storeId: $storeId, ')
          ..write('cashSessionId: $cashSessionId, ')
          ..write('customerId: $customerId, ')
          ..write('userId: $userId, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('exchangeRateUsed: $exchangeRateUsed, ')
          ..write('subtotalUsd: $subtotalUsd, ')
          ..write('discountUsd: $discountUsd, ')
          ..write('igtfApplied: $igtfApplied, ')
          ..write('igtfAmountUsd: $igtfAmountUsd, ')
          ..write('totalUsd: $totalUsd, ')
          ..write('totalBs: $totalBs, ')
          ..write('paymentStatus: $paymentStatus, ')
          ..write('notes: $notes, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      storeId,
      cashSessionId,
      customerId,
      userId,
      invoiceNumber,
      exchangeRateUsed,
      subtotalUsd,
      discountUsd,
      igtfApplied,
      igtfAmountUsd,
      totalUsd,
      totalBs,
      paymentStatus,
      notes,
      isDeleted,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Sale &&
          other.id == this.id &&
          other.storeId == this.storeId &&
          other.cashSessionId == this.cashSessionId &&
          other.customerId == this.customerId &&
          other.userId == this.userId &&
          other.invoiceNumber == this.invoiceNumber &&
          other.exchangeRateUsed == this.exchangeRateUsed &&
          other.subtotalUsd == this.subtotalUsd &&
          other.discountUsd == this.discountUsd &&
          other.igtfApplied == this.igtfApplied &&
          other.igtfAmountUsd == this.igtfAmountUsd &&
          other.totalUsd == this.totalUsd &&
          other.totalBs == this.totalBs &&
          other.paymentStatus == this.paymentStatus &&
          other.notes == this.notes &&
          other.isDeleted == this.isDeleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SalesCompanion extends UpdateCompanion<Sale> {
  final Value<String> id;
  final Value<String?> storeId;
  final Value<String?> cashSessionId;
  final Value<String?> customerId;
  final Value<String?> userId;
  final Value<String> invoiceNumber;
  final Value<double> exchangeRateUsed;
  final Value<double> subtotalUsd;
  final Value<double> discountUsd;
  final Value<bool> igtfApplied;
  final Value<double> igtfAmountUsd;
  final Value<double> totalUsd;
  final Value<double> totalBs;
  final Value<String> paymentStatus;
  final Value<String?> notes;
  final Value<bool> isDeleted;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SalesCompanion({
    this.id = const Value.absent(),
    this.storeId = const Value.absent(),
    this.cashSessionId = const Value.absent(),
    this.customerId = const Value.absent(),
    this.userId = const Value.absent(),
    this.invoiceNumber = const Value.absent(),
    this.exchangeRateUsed = const Value.absent(),
    this.subtotalUsd = const Value.absent(),
    this.discountUsd = const Value.absent(),
    this.igtfApplied = const Value.absent(),
    this.igtfAmountUsd = const Value.absent(),
    this.totalUsd = const Value.absent(),
    this.totalBs = const Value.absent(),
    this.paymentStatus = const Value.absent(),
    this.notes = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SalesCompanion.insert({
    required String id,
    this.storeId = const Value.absent(),
    this.cashSessionId = const Value.absent(),
    this.customerId = const Value.absent(),
    this.userId = const Value.absent(),
    required String invoiceNumber,
    required double exchangeRateUsed,
    required double subtotalUsd,
    this.discountUsd = const Value.absent(),
    this.igtfApplied = const Value.absent(),
    this.igtfAmountUsd = const Value.absent(),
    required double totalUsd,
    required double totalBs,
    this.paymentStatus = const Value.absent(),
    this.notes = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        invoiceNumber = Value(invoiceNumber),
        exchangeRateUsed = Value(exchangeRateUsed),
        subtotalUsd = Value(subtotalUsd),
        totalUsd = Value(totalUsd),
        totalBs = Value(totalBs);
  static Insertable<Sale> custom({
    Expression<String>? id,
    Expression<String>? storeId,
    Expression<String>? cashSessionId,
    Expression<String>? customerId,
    Expression<String>? userId,
    Expression<String>? invoiceNumber,
    Expression<double>? exchangeRateUsed,
    Expression<double>? subtotalUsd,
    Expression<double>? discountUsd,
    Expression<bool>? igtfApplied,
    Expression<double>? igtfAmountUsd,
    Expression<double>? totalUsd,
    Expression<double>? totalBs,
    Expression<String>? paymentStatus,
    Expression<String>? notes,
    Expression<bool>? isDeleted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (storeId != null) 'store_id': storeId,
      if (cashSessionId != null) 'cash_session_id': cashSessionId,
      if (customerId != null) 'customer_id': customerId,
      if (userId != null) 'user_id': userId,
      if (invoiceNumber != null) 'invoice_number': invoiceNumber,
      if (exchangeRateUsed != null) 'exchange_rate_used': exchangeRateUsed,
      if (subtotalUsd != null) 'subtotal_usd': subtotalUsd,
      if (discountUsd != null) 'discount_usd': discountUsd,
      if (igtfApplied != null) 'igtf_applied': igtfApplied,
      if (igtfAmountUsd != null) 'igtf_amount_usd': igtfAmountUsd,
      if (totalUsd != null) 'total_usd': totalUsd,
      if (totalBs != null) 'total_bs': totalBs,
      if (paymentStatus != null) 'payment_status': paymentStatus,
      if (notes != null) 'notes': notes,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SalesCompanion copyWith(
      {Value<String>? id,
      Value<String?>? storeId,
      Value<String?>? cashSessionId,
      Value<String?>? customerId,
      Value<String?>? userId,
      Value<String>? invoiceNumber,
      Value<double>? exchangeRateUsed,
      Value<double>? subtotalUsd,
      Value<double>? discountUsd,
      Value<bool>? igtfApplied,
      Value<double>? igtfAmountUsd,
      Value<double>? totalUsd,
      Value<double>? totalBs,
      Value<String>? paymentStatus,
      Value<String?>? notes,
      Value<bool>? isDeleted,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return SalesCompanion(
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
      cashSessionId: cashSessionId ?? this.cashSessionId,
      customerId: customerId ?? this.customerId,
      userId: userId ?? this.userId,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      exchangeRateUsed: exchangeRateUsed ?? this.exchangeRateUsed,
      subtotalUsd: subtotalUsd ?? this.subtotalUsd,
      discountUsd: discountUsd ?? this.discountUsd,
      igtfApplied: igtfApplied ?? this.igtfApplied,
      igtfAmountUsd: igtfAmountUsd ?? this.igtfAmountUsd,
      totalUsd: totalUsd ?? this.totalUsd,
      totalBs: totalBs ?? this.totalBs,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      notes: notes ?? this.notes,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (storeId.present) {
      map['store_id'] = Variable<String>(storeId.value);
    }
    if (cashSessionId.present) {
      map['cash_session_id'] = Variable<String>(cashSessionId.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<String>(customerId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (invoiceNumber.present) {
      map['invoice_number'] = Variable<String>(invoiceNumber.value);
    }
    if (exchangeRateUsed.present) {
      map['exchange_rate_used'] = Variable<double>(exchangeRateUsed.value);
    }
    if (subtotalUsd.present) {
      map['subtotal_usd'] = Variable<double>(subtotalUsd.value);
    }
    if (discountUsd.present) {
      map['discount_usd'] = Variable<double>(discountUsd.value);
    }
    if (igtfApplied.present) {
      map['igtf_applied'] = Variable<bool>(igtfApplied.value);
    }
    if (igtfAmountUsd.present) {
      map['igtf_amount_usd'] = Variable<double>(igtfAmountUsd.value);
    }
    if (totalUsd.present) {
      map['total_usd'] = Variable<double>(totalUsd.value);
    }
    if (totalBs.present) {
      map['total_bs'] = Variable<double>(totalBs.value);
    }
    if (paymentStatus.present) {
      map['payment_status'] = Variable<String>(paymentStatus.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalesCompanion(')
          ..write('id: $id, ')
          ..write('storeId: $storeId, ')
          ..write('cashSessionId: $cashSessionId, ')
          ..write('customerId: $customerId, ')
          ..write('userId: $userId, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('exchangeRateUsed: $exchangeRateUsed, ')
          ..write('subtotalUsd: $subtotalUsd, ')
          ..write('discountUsd: $discountUsd, ')
          ..write('igtfApplied: $igtfApplied, ')
          ..write('igtfAmountUsd: $igtfAmountUsd, ')
          ..write('totalUsd: $totalUsd, ')
          ..write('totalBs: $totalBs, ')
          ..write('paymentStatus: $paymentStatus, ')
          ..write('notes: $notes, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SaleItemsTable extends SaleItems
    with TableInfo<$SaleItemsTable, SaleItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SaleItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _saleIdMeta = const VerificationMeta('saleId');
  @override
  late final GeneratedColumn<String> saleId = GeneratedColumn<String>(
      'sale_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
      'product_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _presentationIdMeta =
      const VerificationMeta('presentationId');
  @override
  late final GeneratedColumn<String> presentationId = GeneratedColumn<String>(
      'presentation_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _variantIdMeta =
      const VerificationMeta('variantId');
  @override
  late final GeneratedColumn<String> variantId = GeneratedColumn<String>(
      'variant_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _productNameMeta =
      const VerificationMeta('productName');
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
      'product_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
      'quantity', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _unitPriceUsdMeta =
      const VerificationMeta('unitPriceUsd');
  @override
  late final GeneratedColumn<double> unitPriceUsd = GeneratedColumn<double>(
      'unit_price_usd', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _subtotalUsdMeta =
      const VerificationMeta('subtotalUsd');
  @override
  late final GeneratedColumn<double> subtotalUsd = GeneratedColumn<double>(
      'subtotal_usd', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _returnedQuantityMeta =
      const VerificationMeta('returnedQuantity');
  @override
  late final GeneratedColumn<double> returnedQuantity = GeneratedColumn<double>(
      'returned_quantity', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
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
        saleId,
        productId,
        presentationId,
        variantId,
        productName,
        quantity,
        unitPriceUsd,
        subtotalUsd,
        returnedQuantity,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sale_items';
  @override
  VerificationContext validateIntegrity(Insertable<SaleItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('sale_id')) {
      context.handle(_saleIdMeta,
          saleId.isAcceptableOrUnknown(data['sale_id']!, _saleIdMeta));
    } else if (isInserting) {
      context.missing(_saleIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('presentation_id')) {
      context.handle(
          _presentationIdMeta,
          presentationId.isAcceptableOrUnknown(
              data['presentation_id']!, _presentationIdMeta));
    }
    if (data.containsKey('variant_id')) {
      context.handle(_variantIdMeta,
          variantId.isAcceptableOrUnknown(data['variant_id']!, _variantIdMeta));
    }
    if (data.containsKey('product_name')) {
      context.handle(
          _productNameMeta,
          productName.isAcceptableOrUnknown(
              data['product_name']!, _productNameMeta));
    } else if (isInserting) {
      context.missing(_productNameMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit_price_usd')) {
      context.handle(
          _unitPriceUsdMeta,
          unitPriceUsd.isAcceptableOrUnknown(
              data['unit_price_usd']!, _unitPriceUsdMeta));
    } else if (isInserting) {
      context.missing(_unitPriceUsdMeta);
    }
    if (data.containsKey('subtotal_usd')) {
      context.handle(
          _subtotalUsdMeta,
          subtotalUsd.isAcceptableOrUnknown(
              data['subtotal_usd']!, _subtotalUsdMeta));
    } else if (isInserting) {
      context.missing(_subtotalUsdMeta);
    }
    if (data.containsKey('returned_quantity')) {
      context.handle(
          _returnedQuantityMeta,
          returnedQuantity.isAcceptableOrUnknown(
              data['returned_quantity']!, _returnedQuantityMeta));
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
  SaleItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SaleItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      saleId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sale_id'])!,
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_id'])!,
      presentationId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}presentation_id']),
      variantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}variant_id']),
      productName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_name'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}quantity'])!,
      unitPriceUsd: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}unit_price_usd'])!,
      subtotalUsd: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}subtotal_usd'])!,
      returnedQuantity: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}returned_quantity'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SaleItemsTable createAlias(String alias) {
    return $SaleItemsTable(attachedDatabase, alias);
  }
}

class SaleItem extends DataClass implements Insertable<SaleItem> {
  final String id;
  final String saleId;
  final String productId;
  final String? presentationId;
  final String? variantId;
  final String productName;
  final double quantity;
  final double unitPriceUsd;
  final double subtotalUsd;
  final double returnedQuantity;
  final DateTime createdAt;
  const SaleItem(
      {required this.id,
      required this.saleId,
      required this.productId,
      this.presentationId,
      this.variantId,
      required this.productName,
      required this.quantity,
      required this.unitPriceUsd,
      required this.subtotalUsd,
      required this.returnedQuantity,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['sale_id'] = Variable<String>(saleId);
    map['product_id'] = Variable<String>(productId);
    if (!nullToAbsent || presentationId != null) {
      map['presentation_id'] = Variable<String>(presentationId);
    }
    if (!nullToAbsent || variantId != null) {
      map['variant_id'] = Variable<String>(variantId);
    }
    map['product_name'] = Variable<String>(productName);
    map['quantity'] = Variable<double>(quantity);
    map['unit_price_usd'] = Variable<double>(unitPriceUsd);
    map['subtotal_usd'] = Variable<double>(subtotalUsd);
    map['returned_quantity'] = Variable<double>(returnedQuantity);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SaleItemsCompanion toCompanion(bool nullToAbsent) {
    return SaleItemsCompanion(
      id: Value(id),
      saleId: Value(saleId),
      productId: Value(productId),
      presentationId: presentationId == null && nullToAbsent
          ? const Value.absent()
          : Value(presentationId),
      variantId: variantId == null && nullToAbsent
          ? const Value.absent()
          : Value(variantId),
      productName: Value(productName),
      quantity: Value(quantity),
      unitPriceUsd: Value(unitPriceUsd),
      subtotalUsd: Value(subtotalUsd),
      returnedQuantity: Value(returnedQuantity),
      createdAt: Value(createdAt),
    );
  }

  factory SaleItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SaleItem(
      id: serializer.fromJson<String>(json['id']),
      saleId: serializer.fromJson<String>(json['saleId']),
      productId: serializer.fromJson<String>(json['productId']),
      presentationId: serializer.fromJson<String?>(json['presentationId']),
      variantId: serializer.fromJson<String?>(json['variantId']),
      productName: serializer.fromJson<String>(json['productName']),
      quantity: serializer.fromJson<double>(json['quantity']),
      unitPriceUsd: serializer.fromJson<double>(json['unitPriceUsd']),
      subtotalUsd: serializer.fromJson<double>(json['subtotalUsd']),
      returnedQuantity: serializer.fromJson<double>(json['returnedQuantity']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'saleId': serializer.toJson<String>(saleId),
      'productId': serializer.toJson<String>(productId),
      'presentationId': serializer.toJson<String?>(presentationId),
      'variantId': serializer.toJson<String?>(variantId),
      'productName': serializer.toJson<String>(productName),
      'quantity': serializer.toJson<double>(quantity),
      'unitPriceUsd': serializer.toJson<double>(unitPriceUsd),
      'subtotalUsd': serializer.toJson<double>(subtotalUsd),
      'returnedQuantity': serializer.toJson<double>(returnedQuantity),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SaleItem copyWith(
          {String? id,
          String? saleId,
          String? productId,
          Value<String?> presentationId = const Value.absent(),
          Value<String?> variantId = const Value.absent(),
          String? productName,
          double? quantity,
          double? unitPriceUsd,
          double? subtotalUsd,
          double? returnedQuantity,
          DateTime? createdAt}) =>
      SaleItem(
        id: id ?? this.id,
        saleId: saleId ?? this.saleId,
        productId: productId ?? this.productId,
        presentationId:
            presentationId.present ? presentationId.value : this.presentationId,
        variantId: variantId.present ? variantId.value : this.variantId,
        productName: productName ?? this.productName,
        quantity: quantity ?? this.quantity,
        unitPriceUsd: unitPriceUsd ?? this.unitPriceUsd,
        subtotalUsd: subtotalUsd ?? this.subtotalUsd,
        returnedQuantity: returnedQuantity ?? this.returnedQuantity,
        createdAt: createdAt ?? this.createdAt,
      );
  SaleItem copyWithCompanion(SaleItemsCompanion data) {
    return SaleItem(
      id: data.id.present ? data.id.value : this.id,
      saleId: data.saleId.present ? data.saleId.value : this.saleId,
      productId: data.productId.present ? data.productId.value : this.productId,
      presentationId: data.presentationId.present
          ? data.presentationId.value
          : this.presentationId,
      variantId: data.variantId.present ? data.variantId.value : this.variantId,
      productName:
          data.productName.present ? data.productName.value : this.productName,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitPriceUsd: data.unitPriceUsd.present
          ? data.unitPriceUsd.value
          : this.unitPriceUsd,
      subtotalUsd:
          data.subtotalUsd.present ? data.subtotalUsd.value : this.subtotalUsd,
      returnedQuantity: data.returnedQuantity.present
          ? data.returnedQuantity.value
          : this.returnedQuantity,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SaleItem(')
          ..write('id: $id, ')
          ..write('saleId: $saleId, ')
          ..write('productId: $productId, ')
          ..write('presentationId: $presentationId, ')
          ..write('variantId: $variantId, ')
          ..write('productName: $productName, ')
          ..write('quantity: $quantity, ')
          ..write('unitPriceUsd: $unitPriceUsd, ')
          ..write('subtotalUsd: $subtotalUsd, ')
          ..write('returnedQuantity: $returnedQuantity, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      saleId,
      productId,
      presentationId,
      variantId,
      productName,
      quantity,
      unitPriceUsd,
      subtotalUsd,
      returnedQuantity,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SaleItem &&
          other.id == this.id &&
          other.saleId == this.saleId &&
          other.productId == this.productId &&
          other.presentationId == this.presentationId &&
          other.variantId == this.variantId &&
          other.productName == this.productName &&
          other.quantity == this.quantity &&
          other.unitPriceUsd == this.unitPriceUsd &&
          other.subtotalUsd == this.subtotalUsd &&
          other.returnedQuantity == this.returnedQuantity &&
          other.createdAt == this.createdAt);
}

class SaleItemsCompanion extends UpdateCompanion<SaleItem> {
  final Value<String> id;
  final Value<String> saleId;
  final Value<String> productId;
  final Value<String?> presentationId;
  final Value<String?> variantId;
  final Value<String> productName;
  final Value<double> quantity;
  final Value<double> unitPriceUsd;
  final Value<double> subtotalUsd;
  final Value<double> returnedQuantity;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SaleItemsCompanion({
    this.id = const Value.absent(),
    this.saleId = const Value.absent(),
    this.productId = const Value.absent(),
    this.presentationId = const Value.absent(),
    this.variantId = const Value.absent(),
    this.productName = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitPriceUsd = const Value.absent(),
    this.subtotalUsd = const Value.absent(),
    this.returnedQuantity = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SaleItemsCompanion.insert({
    required String id,
    required String saleId,
    required String productId,
    this.presentationId = const Value.absent(),
    this.variantId = const Value.absent(),
    required String productName,
    required double quantity,
    required double unitPriceUsd,
    required double subtotalUsd,
    this.returnedQuantity = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        saleId = Value(saleId),
        productId = Value(productId),
        productName = Value(productName),
        quantity = Value(quantity),
        unitPriceUsd = Value(unitPriceUsd),
        subtotalUsd = Value(subtotalUsd);
  static Insertable<SaleItem> custom({
    Expression<String>? id,
    Expression<String>? saleId,
    Expression<String>? productId,
    Expression<String>? presentationId,
    Expression<String>? variantId,
    Expression<String>? productName,
    Expression<double>? quantity,
    Expression<double>? unitPriceUsd,
    Expression<double>? subtotalUsd,
    Expression<double>? returnedQuantity,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (saleId != null) 'sale_id': saleId,
      if (productId != null) 'product_id': productId,
      if (presentationId != null) 'presentation_id': presentationId,
      if (variantId != null) 'variant_id': variantId,
      if (productName != null) 'product_name': productName,
      if (quantity != null) 'quantity': quantity,
      if (unitPriceUsd != null) 'unit_price_usd': unitPriceUsd,
      if (subtotalUsd != null) 'subtotal_usd': subtotalUsd,
      if (returnedQuantity != null) 'returned_quantity': returnedQuantity,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SaleItemsCompanion copyWith(
      {Value<String>? id,
      Value<String>? saleId,
      Value<String>? productId,
      Value<String?>? presentationId,
      Value<String?>? variantId,
      Value<String>? productName,
      Value<double>? quantity,
      Value<double>? unitPriceUsd,
      Value<double>? subtotalUsd,
      Value<double>? returnedQuantity,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return SaleItemsCompanion(
      id: id ?? this.id,
      saleId: saleId ?? this.saleId,
      productId: productId ?? this.productId,
      presentationId: presentationId ?? this.presentationId,
      variantId: variantId ?? this.variantId,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      unitPriceUsd: unitPriceUsd ?? this.unitPriceUsd,
      subtotalUsd: subtotalUsd ?? this.subtotalUsd,
      returnedQuantity: returnedQuantity ?? this.returnedQuantity,
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
    if (saleId.present) {
      map['sale_id'] = Variable<String>(saleId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (presentationId.present) {
      map['presentation_id'] = Variable<String>(presentationId.value);
    }
    if (variantId.present) {
      map['variant_id'] = Variable<String>(variantId.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (unitPriceUsd.present) {
      map['unit_price_usd'] = Variable<double>(unitPriceUsd.value);
    }
    if (subtotalUsd.present) {
      map['subtotal_usd'] = Variable<double>(subtotalUsd.value);
    }
    if (returnedQuantity.present) {
      map['returned_quantity'] = Variable<double>(returnedQuantity.value);
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
    return (StringBuffer('SaleItemsCompanion(')
          ..write('id: $id, ')
          ..write('saleId: $saleId, ')
          ..write('productId: $productId, ')
          ..write('presentationId: $presentationId, ')
          ..write('variantId: $variantId, ')
          ..write('productName: $productName, ')
          ..write('quantity: $quantity, ')
          ..write('unitPriceUsd: $unitPriceUsd, ')
          ..write('subtotalUsd: $subtotalUsd, ')
          ..write('returnedQuantity: $returnedQuantity, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SalePaymentsTable extends SalePayments
    with TableInfo<$SalePaymentsTable, SalePayment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalePaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _saleIdMeta = const VerificationMeta('saleId');
  @override
  late final GeneratedColumn<String> saleId = GeneratedColumn<String>(
      'sale_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _paymentMethodMeta =
      const VerificationMeta('paymentMethod');
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
      'payment_method', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountOriginalMeta =
      const VerificationMeta('amountOriginal');
  @override
  late final GeneratedColumn<double> amountOriginal = GeneratedColumn<double>(
      'amount_original', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _currencyMeta =
      const VerificationMeta('currency');
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
      'currency', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('USD'));
  static const VerificationMeta _exchangeRateMeta =
      const VerificationMeta('exchangeRate');
  @override
  late final GeneratedColumn<double> exchangeRate = GeneratedColumn<double>(
      'exchange_rate', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _amountUsdEquivalentMeta =
      const VerificationMeta('amountUsdEquivalent');
  @override
  late final GeneratedColumn<double> amountUsdEquivalent =
      GeneratedColumn<double>('amount_usd_equivalent', aliasedName, false,
          type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _referenceNumberMeta =
      const VerificationMeta('referenceNumber');
  @override
  late final GeneratedColumn<String> referenceNumber = GeneratedColumn<String>(
      'reference_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _bankNameMeta =
      const VerificationMeta('bankName');
  @override
  late final GeneratedColumn<String> bankName = GeneratedColumn<String>(
      'bank_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
        saleId,
        paymentMethod,
        amountOriginal,
        currency,
        exchangeRate,
        amountUsdEquivalent,
        referenceNumber,
        bankName,
        notes,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sale_payments';
  @override
  VerificationContext validateIntegrity(Insertable<SalePayment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('sale_id')) {
      context.handle(_saleIdMeta,
          saleId.isAcceptableOrUnknown(data['sale_id']!, _saleIdMeta));
    } else if (isInserting) {
      context.missing(_saleIdMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
          _paymentMethodMeta,
          paymentMethod.isAcceptableOrUnknown(
              data['payment_method']!, _paymentMethodMeta));
    } else if (isInserting) {
      context.missing(_paymentMethodMeta);
    }
    if (data.containsKey('amount_original')) {
      context.handle(
          _amountOriginalMeta,
          amountOriginal.isAcceptableOrUnknown(
              data['amount_original']!, _amountOriginalMeta));
    } else if (isInserting) {
      context.missing(_amountOriginalMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(_currencyMeta,
          currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta));
    }
    if (data.containsKey('exchange_rate')) {
      context.handle(
          _exchangeRateMeta,
          exchangeRate.isAcceptableOrUnknown(
              data['exchange_rate']!, _exchangeRateMeta));
    } else if (isInserting) {
      context.missing(_exchangeRateMeta);
    }
    if (data.containsKey('amount_usd_equivalent')) {
      context.handle(
          _amountUsdEquivalentMeta,
          amountUsdEquivalent.isAcceptableOrUnknown(
              data['amount_usd_equivalent']!, _amountUsdEquivalentMeta));
    } else if (isInserting) {
      context.missing(_amountUsdEquivalentMeta);
    }
    if (data.containsKey('reference_number')) {
      context.handle(
          _referenceNumberMeta,
          referenceNumber.isAcceptableOrUnknown(
              data['reference_number']!, _referenceNumberMeta));
    }
    if (data.containsKey('bank_name')) {
      context.handle(_bankNameMeta,
          bankName.isAcceptableOrUnknown(data['bank_name']!, _bankNameMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
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
  SalePayment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SalePayment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      saleId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sale_id'])!,
      paymentMethod: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payment_method'])!,
      amountOriginal: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}amount_original'])!,
      currency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency'])!,
      exchangeRate: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}exchange_rate'])!,
      amountUsdEquivalent: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}amount_usd_equivalent'])!,
      referenceNumber: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}reference_number']),
      bankName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}bank_name']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SalePaymentsTable createAlias(String alias) {
    return $SalePaymentsTable(attachedDatabase, alias);
  }
}

class SalePayment extends DataClass implements Insertable<SalePayment> {
  final String id;
  final String saleId;
  final String paymentMethod;
  final double amountOriginal;
  final String currency;
  final double exchangeRate;
  final double amountUsdEquivalent;
  final String? referenceNumber;
  final String? bankName;
  final String? notes;
  final DateTime createdAt;
  const SalePayment(
      {required this.id,
      required this.saleId,
      required this.paymentMethod,
      required this.amountOriginal,
      required this.currency,
      required this.exchangeRate,
      required this.amountUsdEquivalent,
      this.referenceNumber,
      this.bankName,
      this.notes,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['sale_id'] = Variable<String>(saleId);
    map['payment_method'] = Variable<String>(paymentMethod);
    map['amount_original'] = Variable<double>(amountOriginal);
    map['currency'] = Variable<String>(currency);
    map['exchange_rate'] = Variable<double>(exchangeRate);
    map['amount_usd_equivalent'] = Variable<double>(amountUsdEquivalent);
    if (!nullToAbsent || referenceNumber != null) {
      map['reference_number'] = Variable<String>(referenceNumber);
    }
    if (!nullToAbsent || bankName != null) {
      map['bank_name'] = Variable<String>(bankName);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SalePaymentsCompanion toCompanion(bool nullToAbsent) {
    return SalePaymentsCompanion(
      id: Value(id),
      saleId: Value(saleId),
      paymentMethod: Value(paymentMethod),
      amountOriginal: Value(amountOriginal),
      currency: Value(currency),
      exchangeRate: Value(exchangeRate),
      amountUsdEquivalent: Value(amountUsdEquivalent),
      referenceNumber: referenceNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceNumber),
      bankName: bankName == null && nullToAbsent
          ? const Value.absent()
          : Value(bankName),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory SalePayment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SalePayment(
      id: serializer.fromJson<String>(json['id']),
      saleId: serializer.fromJson<String>(json['saleId']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      amountOriginal: serializer.fromJson<double>(json['amountOriginal']),
      currency: serializer.fromJson<String>(json['currency']),
      exchangeRate: serializer.fromJson<double>(json['exchangeRate']),
      amountUsdEquivalent:
          serializer.fromJson<double>(json['amountUsdEquivalent']),
      referenceNumber: serializer.fromJson<String?>(json['referenceNumber']),
      bankName: serializer.fromJson<String?>(json['bankName']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'saleId': serializer.toJson<String>(saleId),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'amountOriginal': serializer.toJson<double>(amountOriginal),
      'currency': serializer.toJson<String>(currency),
      'exchangeRate': serializer.toJson<double>(exchangeRate),
      'amountUsdEquivalent': serializer.toJson<double>(amountUsdEquivalent),
      'referenceNumber': serializer.toJson<String?>(referenceNumber),
      'bankName': serializer.toJson<String?>(bankName),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SalePayment copyWith(
          {String? id,
          String? saleId,
          String? paymentMethod,
          double? amountOriginal,
          String? currency,
          double? exchangeRate,
          double? amountUsdEquivalent,
          Value<String?> referenceNumber = const Value.absent(),
          Value<String?> bankName = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt}) =>
      SalePayment(
        id: id ?? this.id,
        saleId: saleId ?? this.saleId,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        amountOriginal: amountOriginal ?? this.amountOriginal,
        currency: currency ?? this.currency,
        exchangeRate: exchangeRate ?? this.exchangeRate,
        amountUsdEquivalent: amountUsdEquivalent ?? this.amountUsdEquivalent,
        referenceNumber: referenceNumber.present
            ? referenceNumber.value
            : this.referenceNumber,
        bankName: bankName.present ? bankName.value : this.bankName,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
      );
  SalePayment copyWithCompanion(SalePaymentsCompanion data) {
    return SalePayment(
      id: data.id.present ? data.id.value : this.id,
      saleId: data.saleId.present ? data.saleId.value : this.saleId,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      amountOriginal: data.amountOriginal.present
          ? data.amountOriginal.value
          : this.amountOriginal,
      currency: data.currency.present ? data.currency.value : this.currency,
      exchangeRate: data.exchangeRate.present
          ? data.exchangeRate.value
          : this.exchangeRate,
      amountUsdEquivalent: data.amountUsdEquivalent.present
          ? data.amountUsdEquivalent.value
          : this.amountUsdEquivalent,
      referenceNumber: data.referenceNumber.present
          ? data.referenceNumber.value
          : this.referenceNumber,
      bankName: data.bankName.present ? data.bankName.value : this.bankName,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SalePayment(')
          ..write('id: $id, ')
          ..write('saleId: $saleId, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('amountOriginal: $amountOriginal, ')
          ..write('currency: $currency, ')
          ..write('exchangeRate: $exchangeRate, ')
          ..write('amountUsdEquivalent: $amountUsdEquivalent, ')
          ..write('referenceNumber: $referenceNumber, ')
          ..write('bankName: $bankName, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      saleId,
      paymentMethod,
      amountOriginal,
      currency,
      exchangeRate,
      amountUsdEquivalent,
      referenceNumber,
      bankName,
      notes,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SalePayment &&
          other.id == this.id &&
          other.saleId == this.saleId &&
          other.paymentMethod == this.paymentMethod &&
          other.amountOriginal == this.amountOriginal &&
          other.currency == this.currency &&
          other.exchangeRate == this.exchangeRate &&
          other.amountUsdEquivalent == this.amountUsdEquivalent &&
          other.referenceNumber == this.referenceNumber &&
          other.bankName == this.bankName &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class SalePaymentsCompanion extends UpdateCompanion<SalePayment> {
  final Value<String> id;
  final Value<String> saleId;
  final Value<String> paymentMethod;
  final Value<double> amountOriginal;
  final Value<String> currency;
  final Value<double> exchangeRate;
  final Value<double> amountUsdEquivalent;
  final Value<String?> referenceNumber;
  final Value<String?> bankName;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SalePaymentsCompanion({
    this.id = const Value.absent(),
    this.saleId = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.amountOriginal = const Value.absent(),
    this.currency = const Value.absent(),
    this.exchangeRate = const Value.absent(),
    this.amountUsdEquivalent = const Value.absent(),
    this.referenceNumber = const Value.absent(),
    this.bankName = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SalePaymentsCompanion.insert({
    required String id,
    required String saleId,
    required String paymentMethod,
    required double amountOriginal,
    this.currency = const Value.absent(),
    required double exchangeRate,
    required double amountUsdEquivalent,
    this.referenceNumber = const Value.absent(),
    this.bankName = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        saleId = Value(saleId),
        paymentMethod = Value(paymentMethod),
        amountOriginal = Value(amountOriginal),
        exchangeRate = Value(exchangeRate),
        amountUsdEquivalent = Value(amountUsdEquivalent);
  static Insertable<SalePayment> custom({
    Expression<String>? id,
    Expression<String>? saleId,
    Expression<String>? paymentMethod,
    Expression<double>? amountOriginal,
    Expression<String>? currency,
    Expression<double>? exchangeRate,
    Expression<double>? amountUsdEquivalent,
    Expression<String>? referenceNumber,
    Expression<String>? bankName,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (saleId != null) 'sale_id': saleId,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (amountOriginal != null) 'amount_original': amountOriginal,
      if (currency != null) 'currency': currency,
      if (exchangeRate != null) 'exchange_rate': exchangeRate,
      if (amountUsdEquivalent != null)
        'amount_usd_equivalent': amountUsdEquivalent,
      if (referenceNumber != null) 'reference_number': referenceNumber,
      if (bankName != null) 'bank_name': bankName,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SalePaymentsCompanion copyWith(
      {Value<String>? id,
      Value<String>? saleId,
      Value<String>? paymentMethod,
      Value<double>? amountOriginal,
      Value<String>? currency,
      Value<double>? exchangeRate,
      Value<double>? amountUsdEquivalent,
      Value<String?>? referenceNumber,
      Value<String?>? bankName,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return SalePaymentsCompanion(
      id: id ?? this.id,
      saleId: saleId ?? this.saleId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      amountOriginal: amountOriginal ?? this.amountOriginal,
      currency: currency ?? this.currency,
      exchangeRate: exchangeRate ?? this.exchangeRate,
      amountUsdEquivalent: amountUsdEquivalent ?? this.amountUsdEquivalent,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      bankName: bankName ?? this.bankName,
      notes: notes ?? this.notes,
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
    if (saleId.present) {
      map['sale_id'] = Variable<String>(saleId.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (amountOriginal.present) {
      map['amount_original'] = Variable<double>(amountOriginal.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (exchangeRate.present) {
      map['exchange_rate'] = Variable<double>(exchangeRate.value);
    }
    if (amountUsdEquivalent.present) {
      map['amount_usd_equivalent'] =
          Variable<double>(amountUsdEquivalent.value);
    }
    if (referenceNumber.present) {
      map['reference_number'] = Variable<String>(referenceNumber.value);
    }
    if (bankName.present) {
      map['bank_name'] = Variable<String>(bankName.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
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
    return (StringBuffer('SalePaymentsCompanion(')
          ..write('id: $id, ')
          ..write('saleId: $saleId, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('amountOriginal: $amountOriginal, ')
          ..write('currency: $currency, ')
          ..write('exchangeRate: $exchangeRate, ')
          ..write('amountUsdEquivalent: $amountUsdEquivalent, ')
          ..write('referenceNumber: $referenceNumber, ')
          ..write('bankName: $bankName, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InventoryMovementsTable extends InventoryMovements
    with TableInfo<$InventoryMovementsTable, InventoryMovement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventoryMovementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _storeIdMeta =
      const VerificationMeta('storeId');
  @override
  late final GeneratedColumn<String> storeId = GeneratedColumn<String>(
      'store_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
      'product_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _movementTypeMeta =
      const VerificationMeta('movementType');
  @override
  late final GeneratedColumn<String> movementType = GeneratedColumn<String>(
      'movement_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
      'quantity', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _previousStockMeta =
      const VerificationMeta('previousStock');
  @override
  late final GeneratedColumn<double> previousStock = GeneratedColumn<double>(
      'previous_stock', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _newStockMeta =
      const VerificationMeta('newStock');
  @override
  late final GeneratedColumn<double> newStock = GeneratedColumn<double>(
      'new_stock', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _costUsdMeta =
      const VerificationMeta('costUsd');
  @override
  late final GeneratedColumn<double> costUsd = GeneratedColumn<double>(
      'cost_usd', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _referenceIdMeta =
      const VerificationMeta('referenceId');
  @override
  late final GeneratedColumn<String> referenceId = GeneratedColumn<String>(
      'reference_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
        storeId,
        productId,
        movementType,
        quantity,
        previousStock,
        newStock,
        costUsd,
        referenceId,
        notes,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventory_movements';
  @override
  VerificationContext validateIntegrity(Insertable<InventoryMovement> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('store_id')) {
      context.handle(_storeIdMeta,
          storeId.isAcceptableOrUnknown(data['store_id']!, _storeIdMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('movement_type')) {
      context.handle(
          _movementTypeMeta,
          movementType.isAcceptableOrUnknown(
              data['movement_type']!, _movementTypeMeta));
    } else if (isInserting) {
      context.missing(_movementTypeMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('previous_stock')) {
      context.handle(
          _previousStockMeta,
          previousStock.isAcceptableOrUnknown(
              data['previous_stock']!, _previousStockMeta));
    } else if (isInserting) {
      context.missing(_previousStockMeta);
    }
    if (data.containsKey('new_stock')) {
      context.handle(_newStockMeta,
          newStock.isAcceptableOrUnknown(data['new_stock']!, _newStockMeta));
    } else if (isInserting) {
      context.missing(_newStockMeta);
    }
    if (data.containsKey('cost_usd')) {
      context.handle(_costUsdMeta,
          costUsd.isAcceptableOrUnknown(data['cost_usd']!, _costUsdMeta));
    }
    if (data.containsKey('reference_id')) {
      context.handle(
          _referenceIdMeta,
          referenceId.isAcceptableOrUnknown(
              data['reference_id']!, _referenceIdMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
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
  InventoryMovement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InventoryMovement(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      storeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}store_id']),
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_id'])!,
      movementType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}movement_type'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}quantity'])!,
      previousStock: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}previous_stock'])!,
      newStock: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}new_stock'])!,
      costUsd: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}cost_usd']),
      referenceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reference_id']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $InventoryMovementsTable createAlias(String alias) {
    return $InventoryMovementsTable(attachedDatabase, alias);
  }
}

class InventoryMovement extends DataClass
    implements Insertable<InventoryMovement> {
  final String id;
  final String? storeId;
  final String productId;
  final String movementType;
  final double quantity;
  final double previousStock;
  final double newStock;
  final double? costUsd;
  final String? referenceId;
  final String? notes;
  final DateTime createdAt;
  const InventoryMovement(
      {required this.id,
      this.storeId,
      required this.productId,
      required this.movementType,
      required this.quantity,
      required this.previousStock,
      required this.newStock,
      this.costUsd,
      this.referenceId,
      this.notes,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || storeId != null) {
      map['store_id'] = Variable<String>(storeId);
    }
    map['product_id'] = Variable<String>(productId);
    map['movement_type'] = Variable<String>(movementType);
    map['quantity'] = Variable<double>(quantity);
    map['previous_stock'] = Variable<double>(previousStock);
    map['new_stock'] = Variable<double>(newStock);
    if (!nullToAbsent || costUsd != null) {
      map['cost_usd'] = Variable<double>(costUsd);
    }
    if (!nullToAbsent || referenceId != null) {
      map['reference_id'] = Variable<String>(referenceId);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  InventoryMovementsCompanion toCompanion(bool nullToAbsent) {
    return InventoryMovementsCompanion(
      id: Value(id),
      storeId: storeId == null && nullToAbsent
          ? const Value.absent()
          : Value(storeId),
      productId: Value(productId),
      movementType: Value(movementType),
      quantity: Value(quantity),
      previousStock: Value(previousStock),
      newStock: Value(newStock),
      costUsd: costUsd == null && nullToAbsent
          ? const Value.absent()
          : Value(costUsd),
      referenceId: referenceId == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceId),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory InventoryMovement.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InventoryMovement(
      id: serializer.fromJson<String>(json['id']),
      storeId: serializer.fromJson<String?>(json['storeId']),
      productId: serializer.fromJson<String>(json['productId']),
      movementType: serializer.fromJson<String>(json['movementType']),
      quantity: serializer.fromJson<double>(json['quantity']),
      previousStock: serializer.fromJson<double>(json['previousStock']),
      newStock: serializer.fromJson<double>(json['newStock']),
      costUsd: serializer.fromJson<double?>(json['costUsd']),
      referenceId: serializer.fromJson<String?>(json['referenceId']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'storeId': serializer.toJson<String?>(storeId),
      'productId': serializer.toJson<String>(productId),
      'movementType': serializer.toJson<String>(movementType),
      'quantity': serializer.toJson<double>(quantity),
      'previousStock': serializer.toJson<double>(previousStock),
      'newStock': serializer.toJson<double>(newStock),
      'costUsd': serializer.toJson<double?>(costUsd),
      'referenceId': serializer.toJson<String?>(referenceId),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  InventoryMovement copyWith(
          {String? id,
          Value<String?> storeId = const Value.absent(),
          String? productId,
          String? movementType,
          double? quantity,
          double? previousStock,
          double? newStock,
          Value<double?> costUsd = const Value.absent(),
          Value<String?> referenceId = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt}) =>
      InventoryMovement(
        id: id ?? this.id,
        storeId: storeId.present ? storeId.value : this.storeId,
        productId: productId ?? this.productId,
        movementType: movementType ?? this.movementType,
        quantity: quantity ?? this.quantity,
        previousStock: previousStock ?? this.previousStock,
        newStock: newStock ?? this.newStock,
        costUsd: costUsd.present ? costUsd.value : this.costUsd,
        referenceId: referenceId.present ? referenceId.value : this.referenceId,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
      );
  InventoryMovement copyWithCompanion(InventoryMovementsCompanion data) {
    return InventoryMovement(
      id: data.id.present ? data.id.value : this.id,
      storeId: data.storeId.present ? data.storeId.value : this.storeId,
      productId: data.productId.present ? data.productId.value : this.productId,
      movementType: data.movementType.present
          ? data.movementType.value
          : this.movementType,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      previousStock: data.previousStock.present
          ? data.previousStock.value
          : this.previousStock,
      newStock: data.newStock.present ? data.newStock.value : this.newStock,
      costUsd: data.costUsd.present ? data.costUsd.value : this.costUsd,
      referenceId:
          data.referenceId.present ? data.referenceId.value : this.referenceId,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InventoryMovement(')
          ..write('id: $id, ')
          ..write('storeId: $storeId, ')
          ..write('productId: $productId, ')
          ..write('movementType: $movementType, ')
          ..write('quantity: $quantity, ')
          ..write('previousStock: $previousStock, ')
          ..write('newStock: $newStock, ')
          ..write('costUsd: $costUsd, ')
          ..write('referenceId: $referenceId, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      storeId,
      productId,
      movementType,
      quantity,
      previousStock,
      newStock,
      costUsd,
      referenceId,
      notes,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InventoryMovement &&
          other.id == this.id &&
          other.storeId == this.storeId &&
          other.productId == this.productId &&
          other.movementType == this.movementType &&
          other.quantity == this.quantity &&
          other.previousStock == this.previousStock &&
          other.newStock == this.newStock &&
          other.costUsd == this.costUsd &&
          other.referenceId == this.referenceId &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class InventoryMovementsCompanion extends UpdateCompanion<InventoryMovement> {
  final Value<String> id;
  final Value<String?> storeId;
  final Value<String> productId;
  final Value<String> movementType;
  final Value<double> quantity;
  final Value<double> previousStock;
  final Value<double> newStock;
  final Value<double?> costUsd;
  final Value<String?> referenceId;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const InventoryMovementsCompanion({
    this.id = const Value.absent(),
    this.storeId = const Value.absent(),
    this.productId = const Value.absent(),
    this.movementType = const Value.absent(),
    this.quantity = const Value.absent(),
    this.previousStock = const Value.absent(),
    this.newStock = const Value.absent(),
    this.costUsd = const Value.absent(),
    this.referenceId = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InventoryMovementsCompanion.insert({
    required String id,
    this.storeId = const Value.absent(),
    required String productId,
    required String movementType,
    required double quantity,
    required double previousStock,
    required double newStock,
    this.costUsd = const Value.absent(),
    this.referenceId = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        productId = Value(productId),
        movementType = Value(movementType),
        quantity = Value(quantity),
        previousStock = Value(previousStock),
        newStock = Value(newStock);
  static Insertable<InventoryMovement> custom({
    Expression<String>? id,
    Expression<String>? storeId,
    Expression<String>? productId,
    Expression<String>? movementType,
    Expression<double>? quantity,
    Expression<double>? previousStock,
    Expression<double>? newStock,
    Expression<double>? costUsd,
    Expression<String>? referenceId,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (storeId != null) 'store_id': storeId,
      if (productId != null) 'product_id': productId,
      if (movementType != null) 'movement_type': movementType,
      if (quantity != null) 'quantity': quantity,
      if (previousStock != null) 'previous_stock': previousStock,
      if (newStock != null) 'new_stock': newStock,
      if (costUsd != null) 'cost_usd': costUsd,
      if (referenceId != null) 'reference_id': referenceId,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InventoryMovementsCompanion copyWith(
      {Value<String>? id,
      Value<String?>? storeId,
      Value<String>? productId,
      Value<String>? movementType,
      Value<double>? quantity,
      Value<double>? previousStock,
      Value<double>? newStock,
      Value<double?>? costUsd,
      Value<String?>? referenceId,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return InventoryMovementsCompanion(
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
      productId: productId ?? this.productId,
      movementType: movementType ?? this.movementType,
      quantity: quantity ?? this.quantity,
      previousStock: previousStock ?? this.previousStock,
      newStock: newStock ?? this.newStock,
      costUsd: costUsd ?? this.costUsd,
      referenceId: referenceId ?? this.referenceId,
      notes: notes ?? this.notes,
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
    if (storeId.present) {
      map['store_id'] = Variable<String>(storeId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (movementType.present) {
      map['movement_type'] = Variable<String>(movementType.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (previousStock.present) {
      map['previous_stock'] = Variable<double>(previousStock.value);
    }
    if (newStock.present) {
      map['new_stock'] = Variable<double>(newStock.value);
    }
    if (costUsd.present) {
      map['cost_usd'] = Variable<double>(costUsd.value);
    }
    if (referenceId.present) {
      map['reference_id'] = Variable<String>(referenceId.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
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
    return (StringBuffer('InventoryMovementsCompanion(')
          ..write('id: $id, ')
          ..write('storeId: $storeId, ')
          ..write('productId: $productId, ')
          ..write('movementType: $movementType, ')
          ..write('quantity: $quantity, ')
          ..write('previousStock: $previousStock, ')
          ..write('newStock: $newStock, ')
          ..write('costUsd: $costUsd, ')
          ..write('referenceId: $referenceId, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SyncQueueTable syncQueue = $SyncQueueTable(this);
  late final $StoresTable stores = $StoresTable(this);
  late final $ExchangeRatesTable exchangeRates = $ExchangeRatesTable(this);
  late final $ProfilesTable profiles = $ProfilesTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $ProductPresentationsTable productPresentations =
      $ProductPresentationsTable(this);
  late final $ProductVariantsTable productVariants =
      $ProductVariantsTable(this);
  late final $ComboItemsTable comboItems = $ComboItemsTable(this);
  late final $CustomersTable customers = $CustomersTable(this);
  late final $CashSessionsTable cashSessions = $CashSessionsTable(this);
  late final $SalesTable sales = $SalesTable(this);
  late final $SaleItemsTable saleItems = $SaleItemsTable(this);
  late final $SalePaymentsTable salePayments = $SalePaymentsTable(this);
  late final $InventoryMovementsTable inventoryMovements =
      $InventoryMovementsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        syncQueue,
        stores,
        exchangeRates,
        profiles,
        categories,
        products,
        productPresentations,
        productVariants,
        comboItems,
        customers,
        cashSessions,
        sales,
        saleItems,
        salePayments,
        inventoryMovements
      ];
}

typedef $$SyncQueueTableCreateCompanionBuilder = SyncQueueCompanion Function({
  required String id,
  required String targetTable,
  required String entityId,
  required String operation,
  required String payload,
  Value<String> status,
  Value<int> attempts,
  Value<String?> errorMessage,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$SyncQueueTableUpdateCompanionBuilder = SyncQueueCompanion Function({
  Value<String> id,
  Value<String> targetTable,
  Value<String> entityId,
  Value<String> operation,
  Value<String> payload,
  Value<String> status,
  Value<int> attempts,
  Value<String?> errorMessage,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$SyncQueueTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get targetTable => $composableBuilder(
      column: $table.targetTable, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get attempts => $composableBuilder(
      column: $table.attempts, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$SyncQueueTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get targetTable => $composableBuilder(
      column: $table.targetTable, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get attempts => $composableBuilder(
      column: $table.attempts, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$SyncQueueTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get targetTable => $composableBuilder(
      column: $table.targetTable, builder: (column) => column);

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get attempts =>
      $composableBuilder(column: $table.attempts, builder: (column) => column);

  GeneratedColumn<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SyncQueueTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncQueueTable,
    SyncQueueData,
    $$SyncQueueTableFilterComposer,
    $$SyncQueueTableOrderingComposer,
    $$SyncQueueTableAnnotationComposer,
    $$SyncQueueTableCreateCompanionBuilder,
    $$SyncQueueTableUpdateCompanionBuilder,
    (
      SyncQueueData,
      BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>
    ),
    SyncQueueData,
    PrefetchHooks Function()> {
  $$SyncQueueTableTableManager(_$AppDatabase db, $SyncQueueTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> targetTable = const Value.absent(),
            Value<String> entityId = const Value.absent(),
            Value<String> operation = const Value.absent(),
            Value<String> payload = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> attempts = const Value.absent(),
            Value<String?> errorMessage = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncQueueCompanion(
            id: id,
            targetTable: targetTable,
            entityId: entityId,
            operation: operation,
            payload: payload,
            status: status,
            attempts: attempts,
            errorMessage: errorMessage,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String targetTable,
            required String entityId,
            required String operation,
            required String payload,
            Value<String> status = const Value.absent(),
            Value<int> attempts = const Value.absent(),
            Value<String?> errorMessage = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncQueueCompanion.insert(
            id: id,
            targetTable: targetTable,
            entityId: entityId,
            operation: operation,
            payload: payload,
            status: status,
            attempts: attempts,
            errorMessage: errorMessage,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncQueueTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SyncQueueTable,
    SyncQueueData,
    $$SyncQueueTableFilterComposer,
    $$SyncQueueTableOrderingComposer,
    $$SyncQueueTableAnnotationComposer,
    $$SyncQueueTableCreateCompanionBuilder,
    $$SyncQueueTableUpdateCompanionBuilder,
    (
      SyncQueueData,
      BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>
    ),
    SyncQueueData,
    PrefetchHooks Function()>;
typedef $$StoresTableCreateCompanionBuilder = StoresCompanion Function({
  required String id,
  required String name,
  required String rif,
  Value<String?> phone,
  Value<String?> address,
  Value<String> primaryColor,
  Value<String> secondaryColor,
  Value<bool> defaultIgtfEnabled,
  Value<bool> isDeleted,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$StoresTableUpdateCompanionBuilder = StoresCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> rif,
  Value<String?> phone,
  Value<String?> address,
  Value<String> primaryColor,
  Value<String> secondaryColor,
  Value<bool> defaultIgtfEnabled,
  Value<bool> isDeleted,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$StoresTableFilterComposer
    extends Composer<_$AppDatabase, $StoresTable> {
  $$StoresTableFilterComposer({
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

  ColumnFilters<String> get rif => $composableBuilder(
      column: $table.rif, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get primaryColor => $composableBuilder(
      column: $table.primaryColor, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get secondaryColor => $composableBuilder(
      column: $table.secondaryColor,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get defaultIgtfEnabled => $composableBuilder(
      column: $table.defaultIgtfEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$StoresTableOrderingComposer
    extends Composer<_$AppDatabase, $StoresTable> {
  $$StoresTableOrderingComposer({
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

  ColumnOrderings<String> get rif => $composableBuilder(
      column: $table.rif, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get primaryColor => $composableBuilder(
      column: $table.primaryColor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get secondaryColor => $composableBuilder(
      column: $table.secondaryColor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get defaultIgtfEnabled => $composableBuilder(
      column: $table.defaultIgtfEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$StoresTableAnnotationComposer
    extends Composer<_$AppDatabase, $StoresTable> {
  $$StoresTableAnnotationComposer({
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

  GeneratedColumn<String> get rif =>
      $composableBuilder(column: $table.rif, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get primaryColor => $composableBuilder(
      column: $table.primaryColor, builder: (column) => column);

  GeneratedColumn<String> get secondaryColor => $composableBuilder(
      column: $table.secondaryColor, builder: (column) => column);

  GeneratedColumn<bool> get defaultIgtfEnabled => $composableBuilder(
      column: $table.defaultIgtfEnabled, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$StoresTableTableManager extends RootTableManager<
    _$AppDatabase,
    $StoresTable,
    Store,
    $$StoresTableFilterComposer,
    $$StoresTableOrderingComposer,
    $$StoresTableAnnotationComposer,
    $$StoresTableCreateCompanionBuilder,
    $$StoresTableUpdateCompanionBuilder,
    (Store, BaseReferences<_$AppDatabase, $StoresTable, Store>),
    Store,
    PrefetchHooks Function()> {
  $$StoresTableTableManager(_$AppDatabase db, $StoresTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StoresTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StoresTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StoresTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> rif = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<String> primaryColor = const Value.absent(),
            Value<String> secondaryColor = const Value.absent(),
            Value<bool> defaultIgtfEnabled = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              StoresCompanion(
            id: id,
            name: name,
            rif: rif,
            phone: phone,
            address: address,
            primaryColor: primaryColor,
            secondaryColor: secondaryColor,
            defaultIgtfEnabled: defaultIgtfEnabled,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String rif,
            Value<String?> phone = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<String> primaryColor = const Value.absent(),
            Value<String> secondaryColor = const Value.absent(),
            Value<bool> defaultIgtfEnabled = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              StoresCompanion.insert(
            id: id,
            name: name,
            rif: rif,
            phone: phone,
            address: address,
            primaryColor: primaryColor,
            secondaryColor: secondaryColor,
            defaultIgtfEnabled: defaultIgtfEnabled,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$StoresTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $StoresTable,
    Store,
    $$StoresTableFilterComposer,
    $$StoresTableOrderingComposer,
    $$StoresTableAnnotationComposer,
    $$StoresTableCreateCompanionBuilder,
    $$StoresTableUpdateCompanionBuilder,
    (Store, BaseReferences<_$AppDatabase, $StoresTable, Store>),
    Store,
    PrefetchHooks Function()>;
typedef $$ExchangeRatesTableCreateCompanionBuilder = ExchangeRatesCompanion
    Function({
  required String id,
  Value<String?> storeId,
  required String source,
  required double rate,
  Value<bool> isActive,
  Value<bool> isDeleted,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$ExchangeRatesTableUpdateCompanionBuilder = ExchangeRatesCompanion
    Function({
  Value<String> id,
  Value<String?> storeId,
  Value<String> source,
  Value<double> rate,
  Value<bool> isActive,
  Value<bool> isDeleted,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$ExchangeRatesTableFilterComposer
    extends Composer<_$AppDatabase, $ExchangeRatesTable> {
  $$ExchangeRatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get storeId => $composableBuilder(
      column: $table.storeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get rate => $composableBuilder(
      column: $table.rate, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$ExchangeRatesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExchangeRatesTable> {
  $$ExchangeRatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get storeId => $composableBuilder(
      column: $table.storeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get rate => $composableBuilder(
      column: $table.rate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$ExchangeRatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExchangeRatesTable> {
  $$ExchangeRatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get storeId =>
      $composableBuilder(column: $table.storeId, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<double> get rate =>
      $composableBuilder(column: $table.rate, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ExchangeRatesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExchangeRatesTable,
    ExchangeRate,
    $$ExchangeRatesTableFilterComposer,
    $$ExchangeRatesTableOrderingComposer,
    $$ExchangeRatesTableAnnotationComposer,
    $$ExchangeRatesTableCreateCompanionBuilder,
    $$ExchangeRatesTableUpdateCompanionBuilder,
    (
      ExchangeRate,
      BaseReferences<_$AppDatabase, $ExchangeRatesTable, ExchangeRate>
    ),
    ExchangeRate,
    PrefetchHooks Function()> {
  $$ExchangeRatesTableTableManager(_$AppDatabase db, $ExchangeRatesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExchangeRatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExchangeRatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExchangeRatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> storeId = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<double> rate = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExchangeRatesCompanion(
            id: id,
            storeId: storeId,
            source: source,
            rate: rate,
            isActive: isActive,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> storeId = const Value.absent(),
            required String source,
            required double rate,
            Value<bool> isActive = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExchangeRatesCompanion.insert(
            id: id,
            storeId: storeId,
            source: source,
            rate: rate,
            isActive: isActive,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ExchangeRatesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExchangeRatesTable,
    ExchangeRate,
    $$ExchangeRatesTableFilterComposer,
    $$ExchangeRatesTableOrderingComposer,
    $$ExchangeRatesTableAnnotationComposer,
    $$ExchangeRatesTableCreateCompanionBuilder,
    $$ExchangeRatesTableUpdateCompanionBuilder,
    (
      ExchangeRate,
      BaseReferences<_$AppDatabase, $ExchangeRatesTable, ExchangeRate>
    ),
    ExchangeRate,
    PrefetchHooks Function()>;
typedef $$ProfilesTableCreateCompanionBuilder = ProfilesCompanion Function({
  required String id,
  Value<String?> storeId,
  required String fullName,
  Value<String?> email,
  Value<String> role,
  Value<String?> quickPin,
  Value<bool> isActive,
  Value<bool> isDeleted,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$ProfilesTableUpdateCompanionBuilder = ProfilesCompanion Function({
  Value<String> id,
  Value<String?> storeId,
  Value<String> fullName,
  Value<String?> email,
  Value<String> role,
  Value<String?> quickPin,
  Value<bool> isActive,
  Value<bool> isDeleted,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$ProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get storeId => $composableBuilder(
      column: $table.storeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fullName => $composableBuilder(
      column: $table.fullName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get quickPin => $composableBuilder(
      column: $table.quickPin, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$ProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get storeId => $composableBuilder(
      column: $table.storeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fullName => $composableBuilder(
      column: $table.fullName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get quickPin => $composableBuilder(
      column: $table.quickPin, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$ProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get storeId =>
      $composableBuilder(column: $table.storeId, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get quickPin =>
      $composableBuilder(column: $table.quickPin, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ProfilesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProfilesTable,
    Profile,
    $$ProfilesTableFilterComposer,
    $$ProfilesTableOrderingComposer,
    $$ProfilesTableAnnotationComposer,
    $$ProfilesTableCreateCompanionBuilder,
    $$ProfilesTableUpdateCompanionBuilder,
    (Profile, BaseReferences<_$AppDatabase, $ProfilesTable, Profile>),
    Profile,
    PrefetchHooks Function()> {
  $$ProfilesTableTableManager(_$AppDatabase db, $ProfilesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> storeId = const Value.absent(),
            Value<String> fullName = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<String?> quickPin = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProfilesCompanion(
            id: id,
            storeId: storeId,
            fullName: fullName,
            email: email,
            role: role,
            quickPin: quickPin,
            isActive: isActive,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> storeId = const Value.absent(),
            required String fullName,
            Value<String?> email = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<String?> quickPin = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProfilesCompanion.insert(
            id: id,
            storeId: storeId,
            fullName: fullName,
            email: email,
            role: role,
            quickPin: quickPin,
            isActive: isActive,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ProfilesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProfilesTable,
    Profile,
    $$ProfilesTableFilterComposer,
    $$ProfilesTableOrderingComposer,
    $$ProfilesTableAnnotationComposer,
    $$ProfilesTableCreateCompanionBuilder,
    $$ProfilesTableUpdateCompanionBuilder,
    (Profile, BaseReferences<_$AppDatabase, $ProfilesTable, Profile>),
    Profile,
    PrefetchHooks Function()>;
typedef $$CategoriesTableCreateCompanionBuilder = CategoriesCompanion Function({
  required String id,
  Value<String?> storeId,
  required String name,
  Value<String> iconName,
  Value<String> colorHex,
  Value<int> sortOrder,
  Value<bool> isDeleted,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$CategoriesTableUpdateCompanionBuilder = CategoriesCompanion Function({
  Value<String> id,
  Value<String?> storeId,
  Value<String> name,
  Value<String> iconName,
  Value<String> colorHex,
  Value<int> sortOrder,
  Value<bool> isDeleted,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get storeId => $composableBuilder(
      column: $table.storeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get iconName => $composableBuilder(
      column: $table.iconName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get colorHex => $composableBuilder(
      column: $table.colorHex, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get storeId => $composableBuilder(
      column: $table.storeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get iconName => $composableBuilder(
      column: $table.iconName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get colorHex => $composableBuilder(
      column: $table.colorHex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get storeId =>
      $composableBuilder(column: $table.storeId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get iconName =>
      $composableBuilder(column: $table.iconName, builder: (column) => column);

  GeneratedColumn<String> get colorHex =>
      $composableBuilder(column: $table.colorHex, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CategoriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CategoriesTable,
    Category,
    $$CategoriesTableFilterComposer,
    $$CategoriesTableOrderingComposer,
    $$CategoriesTableAnnotationComposer,
    $$CategoriesTableCreateCompanionBuilder,
    $$CategoriesTableUpdateCompanionBuilder,
    (Category, BaseReferences<_$AppDatabase, $CategoriesTable, Category>),
    Category,
    PrefetchHooks Function()> {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> storeId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> iconName = const Value.absent(),
            Value<String> colorHex = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CategoriesCompanion(
            id: id,
            storeId: storeId,
            name: name,
            iconName: iconName,
            colorHex: colorHex,
            sortOrder: sortOrder,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> storeId = const Value.absent(),
            required String name,
            Value<String> iconName = const Value.absent(),
            Value<String> colorHex = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CategoriesCompanion.insert(
            id: id,
            storeId: storeId,
            name: name,
            iconName: iconName,
            colorHex: colorHex,
            sortOrder: sortOrder,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CategoriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CategoriesTable,
    Category,
    $$CategoriesTableFilterComposer,
    $$CategoriesTableOrderingComposer,
    $$CategoriesTableAnnotationComposer,
    $$CategoriesTableCreateCompanionBuilder,
    $$CategoriesTableUpdateCompanionBuilder,
    (Category, BaseReferences<_$AppDatabase, $CategoriesTable, Category>),
    Category,
    PrefetchHooks Function()>;
typedef $$ProductsTableCreateCompanionBuilder = ProductsCompanion Function({
  required String id,
  Value<String?> storeId,
  Value<String?> categoryId,
  Value<String?> sku,
  Value<String?> barcode,
  required String name,
  Value<String?> description,
  Value<String?> imageUrl,
  Value<String> productType,
  Value<double> costUsd,
  Value<double> profitMarginPercent,
  required double priceUsd,
  Value<double> stockQuantity,
  Value<double> minStockAlert,
  Value<bool> isDeleted,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$ProductsTableUpdateCompanionBuilder = ProductsCompanion Function({
  Value<String> id,
  Value<String?> storeId,
  Value<String?> categoryId,
  Value<String?> sku,
  Value<String?> barcode,
  Value<String> name,
  Value<String?> description,
  Value<String?> imageUrl,
  Value<String> productType,
  Value<double> costUsd,
  Value<double> profitMarginPercent,
  Value<double> priceUsd,
  Value<double> stockQuantity,
  Value<double> minStockAlert,
  Value<bool> isDeleted,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get storeId => $composableBuilder(
      column: $table.storeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sku => $composableBuilder(
      column: $table.sku, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get barcode => $composableBuilder(
      column: $table.barcode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get productType => $composableBuilder(
      column: $table.productType, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get costUsd => $composableBuilder(
      column: $table.costUsd, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get profitMarginPercent => $composableBuilder(
      column: $table.profitMarginPercent,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get priceUsd => $composableBuilder(
      column: $table.priceUsd, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get stockQuantity => $composableBuilder(
      column: $table.stockQuantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get minStockAlert => $composableBuilder(
      column: $table.minStockAlert, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get storeId => $composableBuilder(
      column: $table.storeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sku => $composableBuilder(
      column: $table.sku, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get barcode => $composableBuilder(
      column: $table.barcode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get productType => $composableBuilder(
      column: $table.productType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get costUsd => $composableBuilder(
      column: $table.costUsd, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get profitMarginPercent => $composableBuilder(
      column: $table.profitMarginPercent,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get priceUsd => $composableBuilder(
      column: $table.priceUsd, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get stockQuantity => $composableBuilder(
      column: $table.stockQuantity,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get minStockAlert => $composableBuilder(
      column: $table.minStockAlert,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get storeId =>
      $composableBuilder(column: $table.storeId, builder: (column) => column);

  GeneratedColumn<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => column);

  GeneratedColumn<String> get sku =>
      $composableBuilder(column: $table.sku, builder: (column) => column);

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get productType => $composableBuilder(
      column: $table.productType, builder: (column) => column);

  GeneratedColumn<double> get costUsd =>
      $composableBuilder(column: $table.costUsd, builder: (column) => column);

  GeneratedColumn<double> get profitMarginPercent => $composableBuilder(
      column: $table.profitMarginPercent, builder: (column) => column);

  GeneratedColumn<double> get priceUsd =>
      $composableBuilder(column: $table.priceUsd, builder: (column) => column);

  GeneratedColumn<double> get stockQuantity => $composableBuilder(
      column: $table.stockQuantity, builder: (column) => column);

  GeneratedColumn<double> get minStockAlert => $composableBuilder(
      column: $table.minStockAlert, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ProductsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProductsTable,
    Product,
    $$ProductsTableFilterComposer,
    $$ProductsTableOrderingComposer,
    $$ProductsTableAnnotationComposer,
    $$ProductsTableCreateCompanionBuilder,
    $$ProductsTableUpdateCompanionBuilder,
    (Product, BaseReferences<_$AppDatabase, $ProductsTable, Product>),
    Product,
    PrefetchHooks Function()> {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> storeId = const Value.absent(),
            Value<String?> categoryId = const Value.absent(),
            Value<String?> sku = const Value.absent(),
            Value<String?> barcode = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> imageUrl = const Value.absent(),
            Value<String> productType = const Value.absent(),
            Value<double> costUsd = const Value.absent(),
            Value<double> profitMarginPercent = const Value.absent(),
            Value<double> priceUsd = const Value.absent(),
            Value<double> stockQuantity = const Value.absent(),
            Value<double> minStockAlert = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductsCompanion(
            id: id,
            storeId: storeId,
            categoryId: categoryId,
            sku: sku,
            barcode: barcode,
            name: name,
            description: description,
            imageUrl: imageUrl,
            productType: productType,
            costUsd: costUsd,
            profitMarginPercent: profitMarginPercent,
            priceUsd: priceUsd,
            stockQuantity: stockQuantity,
            minStockAlert: minStockAlert,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> storeId = const Value.absent(),
            Value<String?> categoryId = const Value.absent(),
            Value<String?> sku = const Value.absent(),
            Value<String?> barcode = const Value.absent(),
            required String name,
            Value<String?> description = const Value.absent(),
            Value<String?> imageUrl = const Value.absent(),
            Value<String> productType = const Value.absent(),
            Value<double> costUsd = const Value.absent(),
            Value<double> profitMarginPercent = const Value.absent(),
            required double priceUsd,
            Value<double> stockQuantity = const Value.absent(),
            Value<double> minStockAlert = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductsCompanion.insert(
            id: id,
            storeId: storeId,
            categoryId: categoryId,
            sku: sku,
            barcode: barcode,
            name: name,
            description: description,
            imageUrl: imageUrl,
            productType: productType,
            costUsd: costUsd,
            profitMarginPercent: profitMarginPercent,
            priceUsd: priceUsd,
            stockQuantity: stockQuantity,
            minStockAlert: minStockAlert,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ProductsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProductsTable,
    Product,
    $$ProductsTableFilterComposer,
    $$ProductsTableOrderingComposer,
    $$ProductsTableAnnotationComposer,
    $$ProductsTableCreateCompanionBuilder,
    $$ProductsTableUpdateCompanionBuilder,
    (Product, BaseReferences<_$AppDatabase, $ProductsTable, Product>),
    Product,
    PrefetchHooks Function()>;
typedef $$ProductPresentationsTableCreateCompanionBuilder
    = ProductPresentationsCompanion Function({
  required String id,
  required String productId,
  required String name,
  Value<String?> barcode,
  required double quantityEquivalent,
  required double priceUsd,
  Value<bool> isDeleted,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$ProductPresentationsTableUpdateCompanionBuilder
    = ProductPresentationsCompanion Function({
  Value<String> id,
  Value<String> productId,
  Value<String> name,
  Value<String?> barcode,
  Value<double> quantityEquivalent,
  Value<double> priceUsd,
  Value<bool> isDeleted,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$ProductPresentationsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductPresentationsTable> {
  $$ProductPresentationsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get barcode => $composableBuilder(
      column: $table.barcode, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get quantityEquivalent => $composableBuilder(
      column: $table.quantityEquivalent,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get priceUsd => $composableBuilder(
      column: $table.priceUsd, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$ProductPresentationsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductPresentationsTable> {
  $$ProductPresentationsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get barcode => $composableBuilder(
      column: $table.barcode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get quantityEquivalent => $composableBuilder(
      column: $table.quantityEquivalent,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get priceUsd => $composableBuilder(
      column: $table.priceUsd, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$ProductPresentationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductPresentationsTable> {
  $$ProductPresentationsTableAnnotationComposer({
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

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<double> get quantityEquivalent => $composableBuilder(
      column: $table.quantityEquivalent, builder: (column) => column);

  GeneratedColumn<double> get priceUsd =>
      $composableBuilder(column: $table.priceUsd, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ProductPresentationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProductPresentationsTable,
    ProductPresentation,
    $$ProductPresentationsTableFilterComposer,
    $$ProductPresentationsTableOrderingComposer,
    $$ProductPresentationsTableAnnotationComposer,
    $$ProductPresentationsTableCreateCompanionBuilder,
    $$ProductPresentationsTableUpdateCompanionBuilder,
    (
      ProductPresentation,
      BaseReferences<_$AppDatabase, $ProductPresentationsTable,
          ProductPresentation>
    ),
    ProductPresentation,
    PrefetchHooks Function()> {
  $$ProductPresentationsTableTableManager(
      _$AppDatabase db, $ProductPresentationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductPresentationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductPresentationsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductPresentationsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> productId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> barcode = const Value.absent(),
            Value<double> quantityEquivalent = const Value.absent(),
            Value<double> priceUsd = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductPresentationsCompanion(
            id: id,
            productId: productId,
            name: name,
            barcode: barcode,
            quantityEquivalent: quantityEquivalent,
            priceUsd: priceUsd,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String productId,
            required String name,
            Value<String?> barcode = const Value.absent(),
            required double quantityEquivalent,
            required double priceUsd,
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductPresentationsCompanion.insert(
            id: id,
            productId: productId,
            name: name,
            barcode: barcode,
            quantityEquivalent: quantityEquivalent,
            priceUsd: priceUsd,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ProductPresentationsTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $ProductPresentationsTable,
        ProductPresentation,
        $$ProductPresentationsTableFilterComposer,
        $$ProductPresentationsTableOrderingComposer,
        $$ProductPresentationsTableAnnotationComposer,
        $$ProductPresentationsTableCreateCompanionBuilder,
        $$ProductPresentationsTableUpdateCompanionBuilder,
        (
          ProductPresentation,
          BaseReferences<_$AppDatabase, $ProductPresentationsTable,
              ProductPresentation>
        ),
        ProductPresentation,
        PrefetchHooks Function()>;
typedef $$ProductVariantsTableCreateCompanionBuilder = ProductVariantsCompanion
    Function({
  required String id,
  required String productId,
  required String variantName,
  Value<String?> sku,
  Value<String?> barcode,
  Value<double> additionalPriceUsd,
  Value<double> stockQuantity,
  Value<bool> isDeleted,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$ProductVariantsTableUpdateCompanionBuilder = ProductVariantsCompanion
    Function({
  Value<String> id,
  Value<String> productId,
  Value<String> variantName,
  Value<String?> sku,
  Value<String?> barcode,
  Value<double> additionalPriceUsd,
  Value<double> stockQuantity,
  Value<bool> isDeleted,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$ProductVariantsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductVariantsTable> {
  $$ProductVariantsTableFilterComposer({
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

  ColumnFilters<String> get variantName => $composableBuilder(
      column: $table.variantName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sku => $composableBuilder(
      column: $table.sku, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get barcode => $composableBuilder(
      column: $table.barcode, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get additionalPriceUsd => $composableBuilder(
      column: $table.additionalPriceUsd,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get stockQuantity => $composableBuilder(
      column: $table.stockQuantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$ProductVariantsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductVariantsTable> {
  $$ProductVariantsTableOrderingComposer({
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

  ColumnOrderings<String> get variantName => $composableBuilder(
      column: $table.variantName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sku => $composableBuilder(
      column: $table.sku, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get barcode => $composableBuilder(
      column: $table.barcode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get additionalPriceUsd => $composableBuilder(
      column: $table.additionalPriceUsd,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get stockQuantity => $composableBuilder(
      column: $table.stockQuantity,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$ProductVariantsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductVariantsTable> {
  $$ProductVariantsTableAnnotationComposer({
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

  GeneratedColumn<String> get variantName => $composableBuilder(
      column: $table.variantName, builder: (column) => column);

  GeneratedColumn<String> get sku =>
      $composableBuilder(column: $table.sku, builder: (column) => column);

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<double> get additionalPriceUsd => $composableBuilder(
      column: $table.additionalPriceUsd, builder: (column) => column);

  GeneratedColumn<double> get stockQuantity => $composableBuilder(
      column: $table.stockQuantity, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ProductVariantsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProductVariantsTable,
    ProductVariant,
    $$ProductVariantsTableFilterComposer,
    $$ProductVariantsTableOrderingComposer,
    $$ProductVariantsTableAnnotationComposer,
    $$ProductVariantsTableCreateCompanionBuilder,
    $$ProductVariantsTableUpdateCompanionBuilder,
    (
      ProductVariant,
      BaseReferences<_$AppDatabase, $ProductVariantsTable, ProductVariant>
    ),
    ProductVariant,
    PrefetchHooks Function()> {
  $$ProductVariantsTableTableManager(
      _$AppDatabase db, $ProductVariantsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductVariantsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductVariantsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductVariantsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> productId = const Value.absent(),
            Value<String> variantName = const Value.absent(),
            Value<String?> sku = const Value.absent(),
            Value<String?> barcode = const Value.absent(),
            Value<double> additionalPriceUsd = const Value.absent(),
            Value<double> stockQuantity = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductVariantsCompanion(
            id: id,
            productId: productId,
            variantName: variantName,
            sku: sku,
            barcode: barcode,
            additionalPriceUsd: additionalPriceUsd,
            stockQuantity: stockQuantity,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String productId,
            required String variantName,
            Value<String?> sku = const Value.absent(),
            Value<String?> barcode = const Value.absent(),
            Value<double> additionalPriceUsd = const Value.absent(),
            Value<double> stockQuantity = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductVariantsCompanion.insert(
            id: id,
            productId: productId,
            variantName: variantName,
            sku: sku,
            barcode: barcode,
            additionalPriceUsd: additionalPriceUsd,
            stockQuantity: stockQuantity,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ProductVariantsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProductVariantsTable,
    ProductVariant,
    $$ProductVariantsTableFilterComposer,
    $$ProductVariantsTableOrderingComposer,
    $$ProductVariantsTableAnnotationComposer,
    $$ProductVariantsTableCreateCompanionBuilder,
    $$ProductVariantsTableUpdateCompanionBuilder,
    (
      ProductVariant,
      BaseReferences<_$AppDatabase, $ProductVariantsTable, ProductVariant>
    ),
    ProductVariant,
    PrefetchHooks Function()>;
typedef $$ComboItemsTableCreateCompanionBuilder = ComboItemsCompanion Function({
  required String id,
  required String comboProductId,
  required String componentProductId,
  Value<double> quantityRequired,
  Value<bool> isDeleted,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$ComboItemsTableUpdateCompanionBuilder = ComboItemsCompanion Function({
  Value<String> id,
  Value<String> comboProductId,
  Value<String> componentProductId,
  Value<double> quantityRequired,
  Value<bool> isDeleted,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$ComboItemsTableFilterComposer
    extends Composer<_$AppDatabase, $ComboItemsTable> {
  $$ComboItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get comboProductId => $composableBuilder(
      column: $table.comboProductId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get componentProductId => $composableBuilder(
      column: $table.componentProductId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get quantityRequired => $composableBuilder(
      column: $table.quantityRequired,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$ComboItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ComboItemsTable> {
  $$ComboItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get comboProductId => $composableBuilder(
      column: $table.comboProductId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get componentProductId => $composableBuilder(
      column: $table.componentProductId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get quantityRequired => $composableBuilder(
      column: $table.quantityRequired,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$ComboItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ComboItemsTable> {
  $$ComboItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get comboProductId => $composableBuilder(
      column: $table.comboProductId, builder: (column) => column);

  GeneratedColumn<String> get componentProductId => $composableBuilder(
      column: $table.componentProductId, builder: (column) => column);

  GeneratedColumn<double> get quantityRequired => $composableBuilder(
      column: $table.quantityRequired, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ComboItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ComboItemsTable,
    ComboItem,
    $$ComboItemsTableFilterComposer,
    $$ComboItemsTableOrderingComposer,
    $$ComboItemsTableAnnotationComposer,
    $$ComboItemsTableCreateCompanionBuilder,
    $$ComboItemsTableUpdateCompanionBuilder,
    (ComboItem, BaseReferences<_$AppDatabase, $ComboItemsTable, ComboItem>),
    ComboItem,
    PrefetchHooks Function()> {
  $$ComboItemsTableTableManager(_$AppDatabase db, $ComboItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ComboItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ComboItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ComboItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> comboProductId = const Value.absent(),
            Value<String> componentProductId = const Value.absent(),
            Value<double> quantityRequired = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ComboItemsCompanion(
            id: id,
            comboProductId: comboProductId,
            componentProductId: componentProductId,
            quantityRequired: quantityRequired,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String comboProductId,
            required String componentProductId,
            Value<double> quantityRequired = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ComboItemsCompanion.insert(
            id: id,
            comboProductId: comboProductId,
            componentProductId: componentProductId,
            quantityRequired: quantityRequired,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ComboItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ComboItemsTable,
    ComboItem,
    $$ComboItemsTableFilterComposer,
    $$ComboItemsTableOrderingComposer,
    $$ComboItemsTableAnnotationComposer,
    $$ComboItemsTableCreateCompanionBuilder,
    $$ComboItemsTableUpdateCompanionBuilder,
    (ComboItem, BaseReferences<_$AppDatabase, $ComboItemsTable, ComboItem>),
    ComboItem,
    PrefetchHooks Function()>;
typedef $$CustomersTableCreateCompanionBuilder = CustomersCompanion Function({
  required String id,
  Value<String?> storeId,
  required String fullName,
  Value<String?> idDocument,
  Value<String?> phone,
  Value<String?> email,
  Value<String?> address,
  Value<double> creditLimitUsd,
  Value<double> currentDebtUsd,
  Value<bool> isDeleted,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$CustomersTableUpdateCompanionBuilder = CustomersCompanion Function({
  Value<String> id,
  Value<String?> storeId,
  Value<String> fullName,
  Value<String?> idDocument,
  Value<String?> phone,
  Value<String?> email,
  Value<String?> address,
  Value<double> creditLimitUsd,
  Value<double> currentDebtUsd,
  Value<bool> isDeleted,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$CustomersTableFilterComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get storeId => $composableBuilder(
      column: $table.storeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fullName => $composableBuilder(
      column: $table.fullName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get idDocument => $composableBuilder(
      column: $table.idDocument, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get creditLimitUsd => $composableBuilder(
      column: $table.creditLimitUsd,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get currentDebtUsd => $composableBuilder(
      column: $table.currentDebtUsd,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$CustomersTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get storeId => $composableBuilder(
      column: $table.storeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fullName => $composableBuilder(
      column: $table.fullName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get idDocument => $composableBuilder(
      column: $table.idDocument, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get creditLimitUsd => $composableBuilder(
      column: $table.creditLimitUsd,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get currentDebtUsd => $composableBuilder(
      column: $table.currentDebtUsd,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$CustomersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get storeId =>
      $composableBuilder(column: $table.storeId, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get idDocument => $composableBuilder(
      column: $table.idDocument, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<double> get creditLimitUsd => $composableBuilder(
      column: $table.creditLimitUsd, builder: (column) => column);

  GeneratedColumn<double> get currentDebtUsd => $composableBuilder(
      column: $table.currentDebtUsd, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CustomersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CustomersTable,
    Customer,
    $$CustomersTableFilterComposer,
    $$CustomersTableOrderingComposer,
    $$CustomersTableAnnotationComposer,
    $$CustomersTableCreateCompanionBuilder,
    $$CustomersTableUpdateCompanionBuilder,
    (Customer, BaseReferences<_$AppDatabase, $CustomersTable, Customer>),
    Customer,
    PrefetchHooks Function()> {
  $$CustomersTableTableManager(_$AppDatabase db, $CustomersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> storeId = const Value.absent(),
            Value<String> fullName = const Value.absent(),
            Value<String?> idDocument = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<double> creditLimitUsd = const Value.absent(),
            Value<double> currentDebtUsd = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CustomersCompanion(
            id: id,
            storeId: storeId,
            fullName: fullName,
            idDocument: idDocument,
            phone: phone,
            email: email,
            address: address,
            creditLimitUsd: creditLimitUsd,
            currentDebtUsd: currentDebtUsd,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> storeId = const Value.absent(),
            required String fullName,
            Value<String?> idDocument = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<double> creditLimitUsd = const Value.absent(),
            Value<double> currentDebtUsd = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CustomersCompanion.insert(
            id: id,
            storeId: storeId,
            fullName: fullName,
            idDocument: idDocument,
            phone: phone,
            email: email,
            address: address,
            creditLimitUsd: creditLimitUsd,
            currentDebtUsd: currentDebtUsd,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CustomersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CustomersTable,
    Customer,
    $$CustomersTableFilterComposer,
    $$CustomersTableOrderingComposer,
    $$CustomersTableAnnotationComposer,
    $$CustomersTableCreateCompanionBuilder,
    $$CustomersTableUpdateCompanionBuilder,
    (Customer, BaseReferences<_$AppDatabase, $CustomersTable, Customer>),
    Customer,
    PrefetchHooks Function()>;
typedef $$CashSessionsTableCreateCompanionBuilder = CashSessionsCompanion
    Function({
  required String id,
  Value<String?> storeId,
  Value<String?> userId,
  Value<String> status,
  Value<DateTime> openedAt,
  Value<DateTime?> closedAt,
  Value<double> openingCashUsd,
  Value<double> openingCashBs,
  Value<double> expectedCashUsd,
  Value<double> expectedCashBs,
  Value<double?> declaredCashUsd,
  Value<double?> declaredCashBs,
  Value<double?> differenceUsd,
  Value<double?> differenceBs,
  Value<String?> notes,
  Value<bool> isDeleted,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$CashSessionsTableUpdateCompanionBuilder = CashSessionsCompanion
    Function({
  Value<String> id,
  Value<String?> storeId,
  Value<String?> userId,
  Value<String> status,
  Value<DateTime> openedAt,
  Value<DateTime?> closedAt,
  Value<double> openingCashUsd,
  Value<double> openingCashBs,
  Value<double> expectedCashUsd,
  Value<double> expectedCashBs,
  Value<double?> declaredCashUsd,
  Value<double?> declaredCashBs,
  Value<double?> differenceUsd,
  Value<double?> differenceBs,
  Value<String?> notes,
  Value<bool> isDeleted,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$CashSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $CashSessionsTable> {
  $$CashSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get storeId => $composableBuilder(
      column: $table.storeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get openedAt => $composableBuilder(
      column: $table.openedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get closedAt => $composableBuilder(
      column: $table.closedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get openingCashUsd => $composableBuilder(
      column: $table.openingCashUsd,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get openingCashBs => $composableBuilder(
      column: $table.openingCashBs, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get expectedCashUsd => $composableBuilder(
      column: $table.expectedCashUsd,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get expectedCashBs => $composableBuilder(
      column: $table.expectedCashBs,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get declaredCashUsd => $composableBuilder(
      column: $table.declaredCashUsd,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get declaredCashBs => $composableBuilder(
      column: $table.declaredCashBs,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get differenceUsd => $composableBuilder(
      column: $table.differenceUsd, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get differenceBs => $composableBuilder(
      column: $table.differenceBs, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$CashSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $CashSessionsTable> {
  $$CashSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get storeId => $composableBuilder(
      column: $table.storeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get openedAt => $composableBuilder(
      column: $table.openedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get closedAt => $composableBuilder(
      column: $table.closedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get openingCashUsd => $composableBuilder(
      column: $table.openingCashUsd,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get openingCashBs => $composableBuilder(
      column: $table.openingCashBs,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get expectedCashUsd => $composableBuilder(
      column: $table.expectedCashUsd,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get expectedCashBs => $composableBuilder(
      column: $table.expectedCashBs,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get declaredCashUsd => $composableBuilder(
      column: $table.declaredCashUsd,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get declaredCashBs => $composableBuilder(
      column: $table.declaredCashBs,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get differenceUsd => $composableBuilder(
      column: $table.differenceUsd,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get differenceBs => $composableBuilder(
      column: $table.differenceBs,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$CashSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CashSessionsTable> {
  $$CashSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get storeId =>
      $composableBuilder(column: $table.storeId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get openedAt =>
      $composableBuilder(column: $table.openedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get closedAt =>
      $composableBuilder(column: $table.closedAt, builder: (column) => column);

  GeneratedColumn<double> get openingCashUsd => $composableBuilder(
      column: $table.openingCashUsd, builder: (column) => column);

  GeneratedColumn<double> get openingCashBs => $composableBuilder(
      column: $table.openingCashBs, builder: (column) => column);

  GeneratedColumn<double> get expectedCashUsd => $composableBuilder(
      column: $table.expectedCashUsd, builder: (column) => column);

  GeneratedColumn<double> get expectedCashBs => $composableBuilder(
      column: $table.expectedCashBs, builder: (column) => column);

  GeneratedColumn<double> get declaredCashUsd => $composableBuilder(
      column: $table.declaredCashUsd, builder: (column) => column);

  GeneratedColumn<double> get declaredCashBs => $composableBuilder(
      column: $table.declaredCashBs, builder: (column) => column);

  GeneratedColumn<double> get differenceUsd => $composableBuilder(
      column: $table.differenceUsd, builder: (column) => column);

  GeneratedColumn<double> get differenceBs => $composableBuilder(
      column: $table.differenceBs, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CashSessionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CashSessionsTable,
    CashSession,
    $$CashSessionsTableFilterComposer,
    $$CashSessionsTableOrderingComposer,
    $$CashSessionsTableAnnotationComposer,
    $$CashSessionsTableCreateCompanionBuilder,
    $$CashSessionsTableUpdateCompanionBuilder,
    (
      CashSession,
      BaseReferences<_$AppDatabase, $CashSessionsTable, CashSession>
    ),
    CashSession,
    PrefetchHooks Function()> {
  $$CashSessionsTableTableManager(_$AppDatabase db, $CashSessionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CashSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CashSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CashSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> storeId = const Value.absent(),
            Value<String?> userId = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> openedAt = const Value.absent(),
            Value<DateTime?> closedAt = const Value.absent(),
            Value<double> openingCashUsd = const Value.absent(),
            Value<double> openingCashBs = const Value.absent(),
            Value<double> expectedCashUsd = const Value.absent(),
            Value<double> expectedCashBs = const Value.absent(),
            Value<double?> declaredCashUsd = const Value.absent(),
            Value<double?> declaredCashBs = const Value.absent(),
            Value<double?> differenceUsd = const Value.absent(),
            Value<double?> differenceBs = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CashSessionsCompanion(
            id: id,
            storeId: storeId,
            userId: userId,
            status: status,
            openedAt: openedAt,
            closedAt: closedAt,
            openingCashUsd: openingCashUsd,
            openingCashBs: openingCashBs,
            expectedCashUsd: expectedCashUsd,
            expectedCashBs: expectedCashBs,
            declaredCashUsd: declaredCashUsd,
            declaredCashBs: declaredCashBs,
            differenceUsd: differenceUsd,
            differenceBs: differenceBs,
            notes: notes,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> storeId = const Value.absent(),
            Value<String?> userId = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> openedAt = const Value.absent(),
            Value<DateTime?> closedAt = const Value.absent(),
            Value<double> openingCashUsd = const Value.absent(),
            Value<double> openingCashBs = const Value.absent(),
            Value<double> expectedCashUsd = const Value.absent(),
            Value<double> expectedCashBs = const Value.absent(),
            Value<double?> declaredCashUsd = const Value.absent(),
            Value<double?> declaredCashBs = const Value.absent(),
            Value<double?> differenceUsd = const Value.absent(),
            Value<double?> differenceBs = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CashSessionsCompanion.insert(
            id: id,
            storeId: storeId,
            userId: userId,
            status: status,
            openedAt: openedAt,
            closedAt: closedAt,
            openingCashUsd: openingCashUsd,
            openingCashBs: openingCashBs,
            expectedCashUsd: expectedCashUsd,
            expectedCashBs: expectedCashBs,
            declaredCashUsd: declaredCashUsd,
            declaredCashBs: declaredCashBs,
            differenceUsd: differenceUsd,
            differenceBs: differenceBs,
            notes: notes,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CashSessionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CashSessionsTable,
    CashSession,
    $$CashSessionsTableFilterComposer,
    $$CashSessionsTableOrderingComposer,
    $$CashSessionsTableAnnotationComposer,
    $$CashSessionsTableCreateCompanionBuilder,
    $$CashSessionsTableUpdateCompanionBuilder,
    (
      CashSession,
      BaseReferences<_$AppDatabase, $CashSessionsTable, CashSession>
    ),
    CashSession,
    PrefetchHooks Function()>;
typedef $$SalesTableCreateCompanionBuilder = SalesCompanion Function({
  required String id,
  Value<String?> storeId,
  Value<String?> cashSessionId,
  Value<String?> customerId,
  Value<String?> userId,
  required String invoiceNumber,
  required double exchangeRateUsed,
  required double subtotalUsd,
  Value<double> discountUsd,
  Value<bool> igtfApplied,
  Value<double> igtfAmountUsd,
  required double totalUsd,
  required double totalBs,
  Value<String> paymentStatus,
  Value<String?> notes,
  Value<bool> isDeleted,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$SalesTableUpdateCompanionBuilder = SalesCompanion Function({
  Value<String> id,
  Value<String?> storeId,
  Value<String?> cashSessionId,
  Value<String?> customerId,
  Value<String?> userId,
  Value<String> invoiceNumber,
  Value<double> exchangeRateUsed,
  Value<double> subtotalUsd,
  Value<double> discountUsd,
  Value<bool> igtfApplied,
  Value<double> igtfAmountUsd,
  Value<double> totalUsd,
  Value<double> totalBs,
  Value<String> paymentStatus,
  Value<String?> notes,
  Value<bool> isDeleted,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$SalesTableFilterComposer extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get storeId => $composableBuilder(
      column: $table.storeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cashSessionId => $composableBuilder(
      column: $table.cashSessionId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get customerId => $composableBuilder(
      column: $table.customerId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get invoiceNumber => $composableBuilder(
      column: $table.invoiceNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get exchangeRateUsed => $composableBuilder(
      column: $table.exchangeRateUsed,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get subtotalUsd => $composableBuilder(
      column: $table.subtotalUsd, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get discountUsd => $composableBuilder(
      column: $table.discountUsd, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get igtfApplied => $composableBuilder(
      column: $table.igtfApplied, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get igtfAmountUsd => $composableBuilder(
      column: $table.igtfAmountUsd, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalUsd => $composableBuilder(
      column: $table.totalUsd, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalBs => $composableBuilder(
      column: $table.totalBs, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get paymentStatus => $composableBuilder(
      column: $table.paymentStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$SalesTableOrderingComposer
    extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get storeId => $composableBuilder(
      column: $table.storeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cashSessionId => $composableBuilder(
      column: $table.cashSessionId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get customerId => $composableBuilder(
      column: $table.customerId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get invoiceNumber => $composableBuilder(
      column: $table.invoiceNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get exchangeRateUsed => $composableBuilder(
      column: $table.exchangeRateUsed,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get subtotalUsd => $composableBuilder(
      column: $table.subtotalUsd, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get discountUsd => $composableBuilder(
      column: $table.discountUsd, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get igtfApplied => $composableBuilder(
      column: $table.igtfApplied, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get igtfAmountUsd => $composableBuilder(
      column: $table.igtfAmountUsd,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalUsd => $composableBuilder(
      column: $table.totalUsd, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalBs => $composableBuilder(
      column: $table.totalBs, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get paymentStatus => $composableBuilder(
      column: $table.paymentStatus,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$SalesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get storeId =>
      $composableBuilder(column: $table.storeId, builder: (column) => column);

  GeneratedColumn<String> get cashSessionId => $composableBuilder(
      column: $table.cashSessionId, builder: (column) => column);

  GeneratedColumn<String> get customerId => $composableBuilder(
      column: $table.customerId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get invoiceNumber => $composableBuilder(
      column: $table.invoiceNumber, builder: (column) => column);

  GeneratedColumn<double> get exchangeRateUsed => $composableBuilder(
      column: $table.exchangeRateUsed, builder: (column) => column);

  GeneratedColumn<double> get subtotalUsd => $composableBuilder(
      column: $table.subtotalUsd, builder: (column) => column);

  GeneratedColumn<double> get discountUsd => $composableBuilder(
      column: $table.discountUsd, builder: (column) => column);

  GeneratedColumn<bool> get igtfApplied => $composableBuilder(
      column: $table.igtfApplied, builder: (column) => column);

  GeneratedColumn<double> get igtfAmountUsd => $composableBuilder(
      column: $table.igtfAmountUsd, builder: (column) => column);

  GeneratedColumn<double> get totalUsd =>
      $composableBuilder(column: $table.totalUsd, builder: (column) => column);

  GeneratedColumn<double> get totalBs =>
      $composableBuilder(column: $table.totalBs, builder: (column) => column);

  GeneratedColumn<String> get paymentStatus => $composableBuilder(
      column: $table.paymentStatus, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SalesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SalesTable,
    Sale,
    $$SalesTableFilterComposer,
    $$SalesTableOrderingComposer,
    $$SalesTableAnnotationComposer,
    $$SalesTableCreateCompanionBuilder,
    $$SalesTableUpdateCompanionBuilder,
    (Sale, BaseReferences<_$AppDatabase, $SalesTable, Sale>),
    Sale,
    PrefetchHooks Function()> {
  $$SalesTableTableManager(_$AppDatabase db, $SalesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SalesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SalesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SalesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> storeId = const Value.absent(),
            Value<String?> cashSessionId = const Value.absent(),
            Value<String?> customerId = const Value.absent(),
            Value<String?> userId = const Value.absent(),
            Value<String> invoiceNumber = const Value.absent(),
            Value<double> exchangeRateUsed = const Value.absent(),
            Value<double> subtotalUsd = const Value.absent(),
            Value<double> discountUsd = const Value.absent(),
            Value<bool> igtfApplied = const Value.absent(),
            Value<double> igtfAmountUsd = const Value.absent(),
            Value<double> totalUsd = const Value.absent(),
            Value<double> totalBs = const Value.absent(),
            Value<String> paymentStatus = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SalesCompanion(
            id: id,
            storeId: storeId,
            cashSessionId: cashSessionId,
            customerId: customerId,
            userId: userId,
            invoiceNumber: invoiceNumber,
            exchangeRateUsed: exchangeRateUsed,
            subtotalUsd: subtotalUsd,
            discountUsd: discountUsd,
            igtfApplied: igtfApplied,
            igtfAmountUsd: igtfAmountUsd,
            totalUsd: totalUsd,
            totalBs: totalBs,
            paymentStatus: paymentStatus,
            notes: notes,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> storeId = const Value.absent(),
            Value<String?> cashSessionId = const Value.absent(),
            Value<String?> customerId = const Value.absent(),
            Value<String?> userId = const Value.absent(),
            required String invoiceNumber,
            required double exchangeRateUsed,
            required double subtotalUsd,
            Value<double> discountUsd = const Value.absent(),
            Value<bool> igtfApplied = const Value.absent(),
            Value<double> igtfAmountUsd = const Value.absent(),
            required double totalUsd,
            required double totalBs,
            Value<String> paymentStatus = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SalesCompanion.insert(
            id: id,
            storeId: storeId,
            cashSessionId: cashSessionId,
            customerId: customerId,
            userId: userId,
            invoiceNumber: invoiceNumber,
            exchangeRateUsed: exchangeRateUsed,
            subtotalUsd: subtotalUsd,
            discountUsd: discountUsd,
            igtfApplied: igtfApplied,
            igtfAmountUsd: igtfAmountUsd,
            totalUsd: totalUsd,
            totalBs: totalBs,
            paymentStatus: paymentStatus,
            notes: notes,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SalesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SalesTable,
    Sale,
    $$SalesTableFilterComposer,
    $$SalesTableOrderingComposer,
    $$SalesTableAnnotationComposer,
    $$SalesTableCreateCompanionBuilder,
    $$SalesTableUpdateCompanionBuilder,
    (Sale, BaseReferences<_$AppDatabase, $SalesTable, Sale>),
    Sale,
    PrefetchHooks Function()>;
typedef $$SaleItemsTableCreateCompanionBuilder = SaleItemsCompanion Function({
  required String id,
  required String saleId,
  required String productId,
  Value<String?> presentationId,
  Value<String?> variantId,
  required String productName,
  required double quantity,
  required double unitPriceUsd,
  required double subtotalUsd,
  Value<double> returnedQuantity,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$SaleItemsTableUpdateCompanionBuilder = SaleItemsCompanion Function({
  Value<String> id,
  Value<String> saleId,
  Value<String> productId,
  Value<String?> presentationId,
  Value<String?> variantId,
  Value<String> productName,
  Value<double> quantity,
  Value<double> unitPriceUsd,
  Value<double> subtotalUsd,
  Value<double> returnedQuantity,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$SaleItemsTableFilterComposer
    extends Composer<_$AppDatabase, $SaleItemsTable> {
  $$SaleItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get saleId => $composableBuilder(
      column: $table.saleId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get productId => $composableBuilder(
      column: $table.productId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get presentationId => $composableBuilder(
      column: $table.presentationId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get variantId => $composableBuilder(
      column: $table.variantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get productName => $composableBuilder(
      column: $table.productName, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get unitPriceUsd => $composableBuilder(
      column: $table.unitPriceUsd, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get subtotalUsd => $composableBuilder(
      column: $table.subtotalUsd, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get returnedQuantity => $composableBuilder(
      column: $table.returnedQuantity,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$SaleItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $SaleItemsTable> {
  $$SaleItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get saleId => $composableBuilder(
      column: $table.saleId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get productId => $composableBuilder(
      column: $table.productId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get presentationId => $composableBuilder(
      column: $table.presentationId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get variantId => $composableBuilder(
      column: $table.variantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get productName => $composableBuilder(
      column: $table.productName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get unitPriceUsd => $composableBuilder(
      column: $table.unitPriceUsd,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get subtotalUsd => $composableBuilder(
      column: $table.subtotalUsd, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get returnedQuantity => $composableBuilder(
      column: $table.returnedQuantity,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$SaleItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SaleItemsTable> {
  $$SaleItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get saleId =>
      $composableBuilder(column: $table.saleId, builder: (column) => column);

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get presentationId => $composableBuilder(
      column: $table.presentationId, builder: (column) => column);

  GeneratedColumn<String> get variantId =>
      $composableBuilder(column: $table.variantId, builder: (column) => column);

  GeneratedColumn<String> get productName => $composableBuilder(
      column: $table.productName, builder: (column) => column);

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get unitPriceUsd => $composableBuilder(
      column: $table.unitPriceUsd, builder: (column) => column);

  GeneratedColumn<double> get subtotalUsd => $composableBuilder(
      column: $table.subtotalUsd, builder: (column) => column);

  GeneratedColumn<double> get returnedQuantity => $composableBuilder(
      column: $table.returnedQuantity, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SaleItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SaleItemsTable,
    SaleItem,
    $$SaleItemsTableFilterComposer,
    $$SaleItemsTableOrderingComposer,
    $$SaleItemsTableAnnotationComposer,
    $$SaleItemsTableCreateCompanionBuilder,
    $$SaleItemsTableUpdateCompanionBuilder,
    (SaleItem, BaseReferences<_$AppDatabase, $SaleItemsTable, SaleItem>),
    SaleItem,
    PrefetchHooks Function()> {
  $$SaleItemsTableTableManager(_$AppDatabase db, $SaleItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SaleItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SaleItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SaleItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> saleId = const Value.absent(),
            Value<String> productId = const Value.absent(),
            Value<String?> presentationId = const Value.absent(),
            Value<String?> variantId = const Value.absent(),
            Value<String> productName = const Value.absent(),
            Value<double> quantity = const Value.absent(),
            Value<double> unitPriceUsd = const Value.absent(),
            Value<double> subtotalUsd = const Value.absent(),
            Value<double> returnedQuantity = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SaleItemsCompanion(
            id: id,
            saleId: saleId,
            productId: productId,
            presentationId: presentationId,
            variantId: variantId,
            productName: productName,
            quantity: quantity,
            unitPriceUsd: unitPriceUsd,
            subtotalUsd: subtotalUsd,
            returnedQuantity: returnedQuantity,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String saleId,
            required String productId,
            Value<String?> presentationId = const Value.absent(),
            Value<String?> variantId = const Value.absent(),
            required String productName,
            required double quantity,
            required double unitPriceUsd,
            required double subtotalUsd,
            Value<double> returnedQuantity = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SaleItemsCompanion.insert(
            id: id,
            saleId: saleId,
            productId: productId,
            presentationId: presentationId,
            variantId: variantId,
            productName: productName,
            quantity: quantity,
            unitPriceUsd: unitPriceUsd,
            subtotalUsd: subtotalUsd,
            returnedQuantity: returnedQuantity,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SaleItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SaleItemsTable,
    SaleItem,
    $$SaleItemsTableFilterComposer,
    $$SaleItemsTableOrderingComposer,
    $$SaleItemsTableAnnotationComposer,
    $$SaleItemsTableCreateCompanionBuilder,
    $$SaleItemsTableUpdateCompanionBuilder,
    (SaleItem, BaseReferences<_$AppDatabase, $SaleItemsTable, SaleItem>),
    SaleItem,
    PrefetchHooks Function()>;
typedef $$SalePaymentsTableCreateCompanionBuilder = SalePaymentsCompanion
    Function({
  required String id,
  required String saleId,
  required String paymentMethod,
  required double amountOriginal,
  Value<String> currency,
  required double exchangeRate,
  required double amountUsdEquivalent,
  Value<String?> referenceNumber,
  Value<String?> bankName,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$SalePaymentsTableUpdateCompanionBuilder = SalePaymentsCompanion
    Function({
  Value<String> id,
  Value<String> saleId,
  Value<String> paymentMethod,
  Value<double> amountOriginal,
  Value<String> currency,
  Value<double> exchangeRate,
  Value<double> amountUsdEquivalent,
  Value<String?> referenceNumber,
  Value<String?> bankName,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$SalePaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $SalePaymentsTable> {
  $$SalePaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get saleId => $composableBuilder(
      column: $table.saleId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amountOriginal => $composableBuilder(
      column: $table.amountOriginal,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get exchangeRate => $composableBuilder(
      column: $table.exchangeRate, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amountUsdEquivalent => $composableBuilder(
      column: $table.amountUsdEquivalent,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get referenceNumber => $composableBuilder(
      column: $table.referenceNumber,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get bankName => $composableBuilder(
      column: $table.bankName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$SalePaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $SalePaymentsTable> {
  $$SalePaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get saleId => $composableBuilder(
      column: $table.saleId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amountOriginal => $composableBuilder(
      column: $table.amountOriginal,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get exchangeRate => $composableBuilder(
      column: $table.exchangeRate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amountUsdEquivalent => $composableBuilder(
      column: $table.amountUsdEquivalent,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get referenceNumber => $composableBuilder(
      column: $table.referenceNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get bankName => $composableBuilder(
      column: $table.bankName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$SalePaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SalePaymentsTable> {
  $$SalePaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get saleId =>
      $composableBuilder(column: $table.saleId, builder: (column) => column);

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod, builder: (column) => column);

  GeneratedColumn<double> get amountOriginal => $composableBuilder(
      column: $table.amountOriginal, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<double> get exchangeRate => $composableBuilder(
      column: $table.exchangeRate, builder: (column) => column);

  GeneratedColumn<double> get amountUsdEquivalent => $composableBuilder(
      column: $table.amountUsdEquivalent, builder: (column) => column);

  GeneratedColumn<String> get referenceNumber => $composableBuilder(
      column: $table.referenceNumber, builder: (column) => column);

  GeneratedColumn<String> get bankName =>
      $composableBuilder(column: $table.bankName, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SalePaymentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SalePaymentsTable,
    SalePayment,
    $$SalePaymentsTableFilterComposer,
    $$SalePaymentsTableOrderingComposer,
    $$SalePaymentsTableAnnotationComposer,
    $$SalePaymentsTableCreateCompanionBuilder,
    $$SalePaymentsTableUpdateCompanionBuilder,
    (
      SalePayment,
      BaseReferences<_$AppDatabase, $SalePaymentsTable, SalePayment>
    ),
    SalePayment,
    PrefetchHooks Function()> {
  $$SalePaymentsTableTableManager(_$AppDatabase db, $SalePaymentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SalePaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SalePaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SalePaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> saleId = const Value.absent(),
            Value<String> paymentMethod = const Value.absent(),
            Value<double> amountOriginal = const Value.absent(),
            Value<String> currency = const Value.absent(),
            Value<double> exchangeRate = const Value.absent(),
            Value<double> amountUsdEquivalent = const Value.absent(),
            Value<String?> referenceNumber = const Value.absent(),
            Value<String?> bankName = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SalePaymentsCompanion(
            id: id,
            saleId: saleId,
            paymentMethod: paymentMethod,
            amountOriginal: amountOriginal,
            currency: currency,
            exchangeRate: exchangeRate,
            amountUsdEquivalent: amountUsdEquivalent,
            referenceNumber: referenceNumber,
            bankName: bankName,
            notes: notes,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String saleId,
            required String paymentMethod,
            required double amountOriginal,
            Value<String> currency = const Value.absent(),
            required double exchangeRate,
            required double amountUsdEquivalent,
            Value<String?> referenceNumber = const Value.absent(),
            Value<String?> bankName = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SalePaymentsCompanion.insert(
            id: id,
            saleId: saleId,
            paymentMethod: paymentMethod,
            amountOriginal: amountOriginal,
            currency: currency,
            exchangeRate: exchangeRate,
            amountUsdEquivalent: amountUsdEquivalent,
            referenceNumber: referenceNumber,
            bankName: bankName,
            notes: notes,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SalePaymentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SalePaymentsTable,
    SalePayment,
    $$SalePaymentsTableFilterComposer,
    $$SalePaymentsTableOrderingComposer,
    $$SalePaymentsTableAnnotationComposer,
    $$SalePaymentsTableCreateCompanionBuilder,
    $$SalePaymentsTableUpdateCompanionBuilder,
    (
      SalePayment,
      BaseReferences<_$AppDatabase, $SalePaymentsTable, SalePayment>
    ),
    SalePayment,
    PrefetchHooks Function()>;
typedef $$InventoryMovementsTableCreateCompanionBuilder
    = InventoryMovementsCompanion Function({
  required String id,
  Value<String?> storeId,
  required String productId,
  required String movementType,
  required double quantity,
  required double previousStock,
  required double newStock,
  Value<double?> costUsd,
  Value<String?> referenceId,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$InventoryMovementsTableUpdateCompanionBuilder
    = InventoryMovementsCompanion Function({
  Value<String> id,
  Value<String?> storeId,
  Value<String> productId,
  Value<String> movementType,
  Value<double> quantity,
  Value<double> previousStock,
  Value<double> newStock,
  Value<double?> costUsd,
  Value<String?> referenceId,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$InventoryMovementsTableFilterComposer
    extends Composer<_$AppDatabase, $InventoryMovementsTable> {
  $$InventoryMovementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get storeId => $composableBuilder(
      column: $table.storeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get productId => $composableBuilder(
      column: $table.productId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get movementType => $composableBuilder(
      column: $table.movementType, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get previousStock => $composableBuilder(
      column: $table.previousStock, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get newStock => $composableBuilder(
      column: $table.newStock, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get costUsd => $composableBuilder(
      column: $table.costUsd, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get referenceId => $composableBuilder(
      column: $table.referenceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$InventoryMovementsTableOrderingComposer
    extends Composer<_$AppDatabase, $InventoryMovementsTable> {
  $$InventoryMovementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get storeId => $composableBuilder(
      column: $table.storeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get productId => $composableBuilder(
      column: $table.productId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get movementType => $composableBuilder(
      column: $table.movementType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get previousStock => $composableBuilder(
      column: $table.previousStock,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get newStock => $composableBuilder(
      column: $table.newStock, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get costUsd => $composableBuilder(
      column: $table.costUsd, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get referenceId => $composableBuilder(
      column: $table.referenceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$InventoryMovementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InventoryMovementsTable> {
  $$InventoryMovementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get storeId =>
      $composableBuilder(column: $table.storeId, builder: (column) => column);

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get movementType => $composableBuilder(
      column: $table.movementType, builder: (column) => column);

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get previousStock => $composableBuilder(
      column: $table.previousStock, builder: (column) => column);

  GeneratedColumn<double> get newStock =>
      $composableBuilder(column: $table.newStock, builder: (column) => column);

  GeneratedColumn<double> get costUsd =>
      $composableBuilder(column: $table.costUsd, builder: (column) => column);

  GeneratedColumn<String> get referenceId => $composableBuilder(
      column: $table.referenceId, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$InventoryMovementsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $InventoryMovementsTable,
    InventoryMovement,
    $$InventoryMovementsTableFilterComposer,
    $$InventoryMovementsTableOrderingComposer,
    $$InventoryMovementsTableAnnotationComposer,
    $$InventoryMovementsTableCreateCompanionBuilder,
    $$InventoryMovementsTableUpdateCompanionBuilder,
    (
      InventoryMovement,
      BaseReferences<_$AppDatabase, $InventoryMovementsTable, InventoryMovement>
    ),
    InventoryMovement,
    PrefetchHooks Function()> {
  $$InventoryMovementsTableTableManager(
      _$AppDatabase db, $InventoryMovementsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InventoryMovementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InventoryMovementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InventoryMovementsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> storeId = const Value.absent(),
            Value<String> productId = const Value.absent(),
            Value<String> movementType = const Value.absent(),
            Value<double> quantity = const Value.absent(),
            Value<double> previousStock = const Value.absent(),
            Value<double> newStock = const Value.absent(),
            Value<double?> costUsd = const Value.absent(),
            Value<String?> referenceId = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              InventoryMovementsCompanion(
            id: id,
            storeId: storeId,
            productId: productId,
            movementType: movementType,
            quantity: quantity,
            previousStock: previousStock,
            newStock: newStock,
            costUsd: costUsd,
            referenceId: referenceId,
            notes: notes,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> storeId = const Value.absent(),
            required String productId,
            required String movementType,
            required double quantity,
            required double previousStock,
            required double newStock,
            Value<double?> costUsd = const Value.absent(),
            Value<String?> referenceId = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              InventoryMovementsCompanion.insert(
            id: id,
            storeId: storeId,
            productId: productId,
            movementType: movementType,
            quantity: quantity,
            previousStock: previousStock,
            newStock: newStock,
            costUsd: costUsd,
            referenceId: referenceId,
            notes: notes,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$InventoryMovementsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $InventoryMovementsTable,
    InventoryMovement,
    $$InventoryMovementsTableFilterComposer,
    $$InventoryMovementsTableOrderingComposer,
    $$InventoryMovementsTableAnnotationComposer,
    $$InventoryMovementsTableCreateCompanionBuilder,
    $$InventoryMovementsTableUpdateCompanionBuilder,
    (
      InventoryMovement,
      BaseReferences<_$AppDatabase, $InventoryMovementsTable, InventoryMovement>
    ),
    InventoryMovement,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db, _db.syncQueue);
  $$StoresTableTableManager get stores =>
      $$StoresTableTableManager(_db, _db.stores);
  $$ExchangeRatesTableTableManager get exchangeRates =>
      $$ExchangeRatesTableTableManager(_db, _db.exchangeRates);
  $$ProfilesTableTableManager get profiles =>
      $$ProfilesTableTableManager(_db, _db.profiles);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$ProductPresentationsTableTableManager get productPresentations =>
      $$ProductPresentationsTableTableManager(_db, _db.productPresentations);
  $$ProductVariantsTableTableManager get productVariants =>
      $$ProductVariantsTableTableManager(_db, _db.productVariants);
  $$ComboItemsTableTableManager get comboItems =>
      $$ComboItemsTableTableManager(_db, _db.comboItems);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db, _db.customers);
  $$CashSessionsTableTableManager get cashSessions =>
      $$CashSessionsTableTableManager(_db, _db.cashSessions);
  $$SalesTableTableManager get sales =>
      $$SalesTableTableManager(_db, _db.sales);
  $$SaleItemsTableTableManager get saleItems =>
      $$SaleItemsTableTableManager(_db, _db.saleItems);
  $$SalePaymentsTableTableManager get salePayments =>
      $$SalePaymentsTableTableManager(_db, _db.salePayments);
  $$InventoryMovementsTableTableManager get inventoryMovements =>
      $$InventoryMovementsTableTableManager(_db, _db.inventoryMovements);
}
