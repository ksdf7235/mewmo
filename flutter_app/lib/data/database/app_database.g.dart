// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $MemoEntriesTable extends MemoEntries
    with TableInfo<$MemoEntriesTable, MemoEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MemoEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<int> serverId = GeneratedColumn<int>(
    'server_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _petResponseMeta = const VerificationMeta(
    'petResponse',
  );
  @override
  late final GeneratedColumn<String> petResponse = GeneratedColumn<String>(
    'pet_response',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serverId,
    content,
    petResponse,
    imageUrl,
    createdAt,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'memo_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<MemoEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('pet_response')) {
      context.handle(
        _petResponseMeta,
        petResponse.isAcceptableOrUnknown(
          data['pet_response']!,
          _petResponseMeta,
        ),
      );
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MemoEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MemoEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_id'],
      ),
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      petResponse: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pet_response'],
      ),
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $MemoEntriesTable createAlias(String alias) {
    return $MemoEntriesTable(attachedDatabase, alias);
  }
}

class MemoEntry extends DataClass implements Insertable<MemoEntry> {
  final int id;
  final int? serverId;
  final String content;
  final String? petResponse;
  final String? imageUrl;
  final DateTime createdAt;
  final bool isSynced;
  const MemoEntry({
    required this.id,
    this.serverId,
    required this.content,
    this.petResponse,
    this.imageUrl,
    required this.createdAt,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || serverId != null) {
      map['server_id'] = Variable<int>(serverId);
    }
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || petResponse != null) {
      map['pet_response'] = Variable<String>(petResponse);
    }
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  MemoEntriesCompanion toCompanion(bool nullToAbsent) {
    return MemoEntriesCompanion(
      id: Value(id),
      serverId: serverId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverId),
      content: Value(content),
      petResponse: petResponse == null && nullToAbsent
          ? const Value.absent()
          : Value(petResponse),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      createdAt: Value(createdAt),
      isSynced: Value(isSynced),
    );
  }

  factory MemoEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MemoEntry(
      id: serializer.fromJson<int>(json['id']),
      serverId: serializer.fromJson<int?>(json['serverId']),
      content: serializer.fromJson<String>(json['content']),
      petResponse: serializer.fromJson<String?>(json['petResponse']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'serverId': serializer.toJson<int?>(serverId),
      'content': serializer.toJson<String>(content),
      'petResponse': serializer.toJson<String?>(petResponse),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  MemoEntry copyWith({
    int? id,
    Value<int?> serverId = const Value.absent(),
    String? content,
    Value<String?> petResponse = const Value.absent(),
    Value<String?> imageUrl = const Value.absent(),
    DateTime? createdAt,
    bool? isSynced,
  }) => MemoEntry(
    id: id ?? this.id,
    serverId: serverId.present ? serverId.value : this.serverId,
    content: content ?? this.content,
    petResponse: petResponse.present ? petResponse.value : this.petResponse,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    createdAt: createdAt ?? this.createdAt,
    isSynced: isSynced ?? this.isSynced,
  );
  MemoEntry copyWithCompanion(MemoEntriesCompanion data) {
    return MemoEntry(
      id: data.id.present ? data.id.value : this.id,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      content: data.content.present ? data.content.value : this.content,
      petResponse: data.petResponse.present
          ? data.petResponse.value
          : this.petResponse,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MemoEntry(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('content: $content, ')
          ..write('petResponse: $petResponse, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    serverId,
    content,
    petResponse,
    imageUrl,
    createdAt,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MemoEntry &&
          other.id == this.id &&
          other.serverId == this.serverId &&
          other.content == this.content &&
          other.petResponse == this.petResponse &&
          other.imageUrl == this.imageUrl &&
          other.createdAt == this.createdAt &&
          other.isSynced == this.isSynced);
}

class MemoEntriesCompanion extends UpdateCompanion<MemoEntry> {
  final Value<int> id;
  final Value<int?> serverId;
  final Value<String> content;
  final Value<String?> petResponse;
  final Value<String?> imageUrl;
  final Value<DateTime> createdAt;
  final Value<bool> isSynced;
  const MemoEntriesCompanion({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    this.content = const Value.absent(),
    this.petResponse = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isSynced = const Value.absent(),
  });
  MemoEntriesCompanion.insert({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    required String content,
    this.petResponse = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isSynced = const Value.absent(),
  }) : content = Value(content);
  static Insertable<MemoEntry> custom({
    Expression<int>? id,
    Expression<int>? serverId,
    Expression<String>? content,
    Expression<String>? petResponse,
    Expression<String>? imageUrl,
    Expression<DateTime>? createdAt,
    Expression<bool>? isSynced,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverId != null) 'server_id': serverId,
      if (content != null) 'content': content,
      if (petResponse != null) 'pet_response': petResponse,
      if (imageUrl != null) 'image_url': imageUrl,
      if (createdAt != null) 'created_at': createdAt,
      if (isSynced != null) 'is_synced': isSynced,
    });
  }

  MemoEntriesCompanion copyWith({
    Value<int>? id,
    Value<int?>? serverId,
    Value<String>? content,
    Value<String?>? petResponse,
    Value<String?>? imageUrl,
    Value<DateTime>? createdAt,
    Value<bool>? isSynced,
  }) {
    return MemoEntriesCompanion(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      content: content ?? this.content,
      petResponse: petResponse ?? this.petResponse,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      isSynced: isSynced ?? this.isSynced,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<int>(serverId.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (petResponse.present) {
      map['pet_response'] = Variable<String>(petResponse.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MemoEntriesCompanion(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('content: $content, ')
          ..write('petResponse: $petResponse, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }
}

class $PetEntriesTable extends PetEntries
    with TableInfo<$PetEntriesTable, PetEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PetEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _petTypeMeta = const VerificationMeta(
    'petType',
  );
  @override
  late final GeneratedColumn<String> petType = GeneratedColumn<String>(
    'pet_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _petNameMeta = const VerificationMeta(
    'petName',
  );
  @override
  late final GeneratedColumn<String> petName = GeneratedColumn<String>(
    'pet_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _petSoundMeta = const VerificationMeta(
    'petSound',
  );
  @override
  late final GeneratedColumn<String> petSound = GeneratedColumn<String>(
    'pet_sound',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    petType,
    petName,
    petSound,
    createdAt,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pet_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<PetEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('pet_type')) {
      context.handle(
        _petTypeMeta,
        petType.isAcceptableOrUnknown(data['pet_type']!, _petTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_petTypeMeta);
    }
    if (data.containsKey('pet_name')) {
      context.handle(
        _petNameMeta,
        petName.isAcceptableOrUnknown(data['pet_name']!, _petNameMeta),
      );
    }
    if (data.containsKey('pet_sound')) {
      context.handle(
        _petSoundMeta,
        petSound.isAcceptableOrUnknown(data['pet_sound']!, _petSoundMeta),
      );
    } else if (isInserting) {
      context.missing(_petSoundMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PetEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PetEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      petType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pet_type'],
      )!,
      petName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pet_name'],
      ),
      petSound: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pet_sound'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $PetEntriesTable createAlias(String alias) {
    return $PetEntriesTable(attachedDatabase, alias);
  }
}

class PetEntry extends DataClass implements Insertable<PetEntry> {
  final int id;
  final String petType;
  final String? petName;
  final String petSound;
  final DateTime createdAt;
  final bool isActive;
  const PetEntry({
    required this.id,
    required this.petType,
    this.petName,
    required this.petSound,
    required this.createdAt,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['pet_type'] = Variable<String>(petType);
    if (!nullToAbsent || petName != null) {
      map['pet_name'] = Variable<String>(petName);
    }
    map['pet_sound'] = Variable<String>(petSound);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  PetEntriesCompanion toCompanion(bool nullToAbsent) {
    return PetEntriesCompanion(
      id: Value(id),
      petType: Value(petType),
      petName: petName == null && nullToAbsent
          ? const Value.absent()
          : Value(petName),
      petSound: Value(petSound),
      createdAt: Value(createdAt),
      isActive: Value(isActive),
    );
  }

  factory PetEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PetEntry(
      id: serializer.fromJson<int>(json['id']),
      petType: serializer.fromJson<String>(json['petType']),
      petName: serializer.fromJson<String?>(json['petName']),
      petSound: serializer.fromJson<String>(json['petSound']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'petType': serializer.toJson<String>(petType),
      'petName': serializer.toJson<String?>(petName),
      'petSound': serializer.toJson<String>(petSound),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  PetEntry copyWith({
    int? id,
    String? petType,
    Value<String?> petName = const Value.absent(),
    String? petSound,
    DateTime? createdAt,
    bool? isActive,
  }) => PetEntry(
    id: id ?? this.id,
    petType: petType ?? this.petType,
    petName: petName.present ? petName.value : this.petName,
    petSound: petSound ?? this.petSound,
    createdAt: createdAt ?? this.createdAt,
    isActive: isActive ?? this.isActive,
  );
  PetEntry copyWithCompanion(PetEntriesCompanion data) {
    return PetEntry(
      id: data.id.present ? data.id.value : this.id,
      petType: data.petType.present ? data.petType.value : this.petType,
      petName: data.petName.present ? data.petName.value : this.petName,
      petSound: data.petSound.present ? data.petSound.value : this.petSound,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PetEntry(')
          ..write('id: $id, ')
          ..write('petType: $petType, ')
          ..write('petName: $petName, ')
          ..write('petSound: $petSound, ')
          ..write('createdAt: $createdAt, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, petType, petName, petSound, createdAt, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PetEntry &&
          other.id == this.id &&
          other.petType == this.petType &&
          other.petName == this.petName &&
          other.petSound == this.petSound &&
          other.createdAt == this.createdAt &&
          other.isActive == this.isActive);
}

class PetEntriesCompanion extends UpdateCompanion<PetEntry> {
  final Value<int> id;
  final Value<String> petType;
  final Value<String?> petName;
  final Value<String> petSound;
  final Value<DateTime> createdAt;
  final Value<bool> isActive;
  const PetEntriesCompanion({
    this.id = const Value.absent(),
    this.petType = const Value.absent(),
    this.petName = const Value.absent(),
    this.petSound = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  PetEntriesCompanion.insert({
    this.id = const Value.absent(),
    required String petType,
    this.petName = const Value.absent(),
    required String petSound,
    this.createdAt = const Value.absent(),
    this.isActive = const Value.absent(),
  }) : petType = Value(petType),
       petSound = Value(petSound);
  static Insertable<PetEntry> custom({
    Expression<int>? id,
    Expression<String>? petType,
    Expression<String>? petName,
    Expression<String>? petSound,
    Expression<DateTime>? createdAt,
    Expression<bool>? isActive,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (petType != null) 'pet_type': petType,
      if (petName != null) 'pet_name': petName,
      if (petSound != null) 'pet_sound': petSound,
      if (createdAt != null) 'created_at': createdAt,
      if (isActive != null) 'is_active': isActive,
    });
  }

  PetEntriesCompanion copyWith({
    Value<int>? id,
    Value<String>? petType,
    Value<String?>? petName,
    Value<String>? petSound,
    Value<DateTime>? createdAt,
    Value<bool>? isActive,
  }) {
    return PetEntriesCompanion(
      id: id ?? this.id,
      petType: petType ?? this.petType,
      petName: petName ?? this.petName,
      petSound: petSound ?? this.petSound,
      createdAt: createdAt ?? this.createdAt,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (petType.present) {
      map['pet_type'] = Variable<String>(petType.value);
    }
    if (petName.present) {
      map['pet_name'] = Variable<String>(petName.value);
    }
    if (petSound.present) {
      map['pet_sound'] = Variable<String>(petSound.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PetEntriesCompanion(')
          ..write('id: $id, ')
          ..write('petType: $petType, ')
          ..write('petName: $petName, ')
          ..write('petSound: $petSound, ')
          ..write('createdAt: $createdAt, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

class $UserSettingsEntriesTable extends UserSettingsEntries
    with TableInfo<$UserSettingsEntriesTable, UserSettingsEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserSettingsEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _serverUrlMeta = const VerificationMeta(
    'serverUrl',
  );
  @override
  late final GeneratedColumn<String> serverUrl = GeneratedColumn<String>(
    'server_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _onboardingCompleteMeta =
      const VerificationMeta('onboardingComplete');
  @override
  late final GeneratedColumn<bool> onboardingComplete = GeneratedColumn<bool>(
    'onboarding_complete',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("onboarding_complete" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _gachaCompleteMeta = const VerificationMeta(
    'gachaComplete',
  );
  @override
  late final GeneratedColumn<bool> gachaComplete = GeneratedColumn<bool>(
    'gacha_complete',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("gacha_complete" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _namingCompleteMeta = const VerificationMeta(
    'namingComplete',
  );
  @override
  late final GeneratedColumn<bool> namingComplete = GeneratedColumn<bool>(
    'naming_complete',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("naming_complete" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serverUrl,
    onboardingComplete,
    gachaComplete,
    namingComplete,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_settings_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserSettingsEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('server_url')) {
      context.handle(
        _serverUrlMeta,
        serverUrl.isAcceptableOrUnknown(data['server_url']!, _serverUrlMeta),
      );
    }
    if (data.containsKey('onboarding_complete')) {
      context.handle(
        _onboardingCompleteMeta,
        onboardingComplete.isAcceptableOrUnknown(
          data['onboarding_complete']!,
          _onboardingCompleteMeta,
        ),
      );
    }
    if (data.containsKey('gacha_complete')) {
      context.handle(
        _gachaCompleteMeta,
        gachaComplete.isAcceptableOrUnknown(
          data['gacha_complete']!,
          _gachaCompleteMeta,
        ),
      );
    }
    if (data.containsKey('naming_complete')) {
      context.handle(
        _namingCompleteMeta,
        namingComplete.isAcceptableOrUnknown(
          data['naming_complete']!,
          _namingCompleteMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserSettingsEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserSettingsEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      serverUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_url'],
      )!,
      onboardingComplete: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}onboarding_complete'],
      )!,
      gachaComplete: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}gacha_complete'],
      )!,
      namingComplete: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}naming_complete'],
      )!,
    );
  }

  @override
  $UserSettingsEntriesTable createAlias(String alias) {
    return $UserSettingsEntriesTable(attachedDatabase, alias);
  }
}

class UserSettingsEntry extends DataClass
    implements Insertable<UserSettingsEntry> {
  final int id;
  final String serverUrl;
  final bool onboardingComplete;
  final bool gachaComplete;
  final bool namingComplete;
  const UserSettingsEntry({
    required this.id,
    required this.serverUrl,
    required this.onboardingComplete,
    required this.gachaComplete,
    required this.namingComplete,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['server_url'] = Variable<String>(serverUrl);
    map['onboarding_complete'] = Variable<bool>(onboardingComplete);
    map['gacha_complete'] = Variable<bool>(gachaComplete);
    map['naming_complete'] = Variable<bool>(namingComplete);
    return map;
  }

  UserSettingsEntriesCompanion toCompanion(bool nullToAbsent) {
    return UserSettingsEntriesCompanion(
      id: Value(id),
      serverUrl: Value(serverUrl),
      onboardingComplete: Value(onboardingComplete),
      gachaComplete: Value(gachaComplete),
      namingComplete: Value(namingComplete),
    );
  }

  factory UserSettingsEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserSettingsEntry(
      id: serializer.fromJson<int>(json['id']),
      serverUrl: serializer.fromJson<String>(json['serverUrl']),
      onboardingComplete: serializer.fromJson<bool>(json['onboardingComplete']),
      gachaComplete: serializer.fromJson<bool>(json['gachaComplete']),
      namingComplete: serializer.fromJson<bool>(json['namingComplete']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'serverUrl': serializer.toJson<String>(serverUrl),
      'onboardingComplete': serializer.toJson<bool>(onboardingComplete),
      'gachaComplete': serializer.toJson<bool>(gachaComplete),
      'namingComplete': serializer.toJson<bool>(namingComplete),
    };
  }

  UserSettingsEntry copyWith({
    int? id,
    String? serverUrl,
    bool? onboardingComplete,
    bool? gachaComplete,
    bool? namingComplete,
  }) => UserSettingsEntry(
    id: id ?? this.id,
    serverUrl: serverUrl ?? this.serverUrl,
    onboardingComplete: onboardingComplete ?? this.onboardingComplete,
    gachaComplete: gachaComplete ?? this.gachaComplete,
    namingComplete: namingComplete ?? this.namingComplete,
  );
  UserSettingsEntry copyWithCompanion(UserSettingsEntriesCompanion data) {
    return UserSettingsEntry(
      id: data.id.present ? data.id.value : this.id,
      serverUrl: data.serverUrl.present ? data.serverUrl.value : this.serverUrl,
      onboardingComplete: data.onboardingComplete.present
          ? data.onboardingComplete.value
          : this.onboardingComplete,
      gachaComplete: data.gachaComplete.present
          ? data.gachaComplete.value
          : this.gachaComplete,
      namingComplete: data.namingComplete.present
          ? data.namingComplete.value
          : this.namingComplete,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserSettingsEntry(')
          ..write('id: $id, ')
          ..write('serverUrl: $serverUrl, ')
          ..write('onboardingComplete: $onboardingComplete, ')
          ..write('gachaComplete: $gachaComplete, ')
          ..write('namingComplete: $namingComplete')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    serverUrl,
    onboardingComplete,
    gachaComplete,
    namingComplete,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserSettingsEntry &&
          other.id == this.id &&
          other.serverUrl == this.serverUrl &&
          other.onboardingComplete == this.onboardingComplete &&
          other.gachaComplete == this.gachaComplete &&
          other.namingComplete == this.namingComplete);
}

class UserSettingsEntriesCompanion extends UpdateCompanion<UserSettingsEntry> {
  final Value<int> id;
  final Value<String> serverUrl;
  final Value<bool> onboardingComplete;
  final Value<bool> gachaComplete;
  final Value<bool> namingComplete;
  const UserSettingsEntriesCompanion({
    this.id = const Value.absent(),
    this.serverUrl = const Value.absent(),
    this.onboardingComplete = const Value.absent(),
    this.gachaComplete = const Value.absent(),
    this.namingComplete = const Value.absent(),
  });
  UserSettingsEntriesCompanion.insert({
    this.id = const Value.absent(),
    this.serverUrl = const Value.absent(),
    this.onboardingComplete = const Value.absent(),
    this.gachaComplete = const Value.absent(),
    this.namingComplete = const Value.absent(),
  });
  static Insertable<UserSettingsEntry> custom({
    Expression<int>? id,
    Expression<String>? serverUrl,
    Expression<bool>? onboardingComplete,
    Expression<bool>? gachaComplete,
    Expression<bool>? namingComplete,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverUrl != null) 'server_url': serverUrl,
      if (onboardingComplete != null) 'onboarding_complete': onboardingComplete,
      if (gachaComplete != null) 'gacha_complete': gachaComplete,
      if (namingComplete != null) 'naming_complete': namingComplete,
    });
  }

  UserSettingsEntriesCompanion copyWith({
    Value<int>? id,
    Value<String>? serverUrl,
    Value<bool>? onboardingComplete,
    Value<bool>? gachaComplete,
    Value<bool>? namingComplete,
  }) {
    return UserSettingsEntriesCompanion(
      id: id ?? this.id,
      serverUrl: serverUrl ?? this.serverUrl,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
      gachaComplete: gachaComplete ?? this.gachaComplete,
      namingComplete: namingComplete ?? this.namingComplete,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (serverUrl.present) {
      map['server_url'] = Variable<String>(serverUrl.value);
    }
    if (onboardingComplete.present) {
      map['onboarding_complete'] = Variable<bool>(onboardingComplete.value);
    }
    if (gachaComplete.present) {
      map['gacha_complete'] = Variable<bool>(gachaComplete.value);
    }
    if (namingComplete.present) {
      map['naming_complete'] = Variable<bool>(namingComplete.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserSettingsEntriesCompanion(')
          ..write('id: $id, ')
          ..write('serverUrl: $serverUrl, ')
          ..write('onboardingComplete: $onboardingComplete, ')
          ..write('gachaComplete: $gachaComplete, ')
          ..write('namingComplete: $namingComplete')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MemoEntriesTable memoEntries = $MemoEntriesTable(this);
  late final $PetEntriesTable petEntries = $PetEntriesTable(this);
  late final $UserSettingsEntriesTable userSettingsEntries =
      $UserSettingsEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    memoEntries,
    petEntries,
    userSettingsEntries,
  ];
}

typedef $$MemoEntriesTableCreateCompanionBuilder =
    MemoEntriesCompanion Function({
      Value<int> id,
      Value<int?> serverId,
      required String content,
      Value<String?> petResponse,
      Value<String?> imageUrl,
      Value<DateTime> createdAt,
      Value<bool> isSynced,
    });
typedef $$MemoEntriesTableUpdateCompanionBuilder =
    MemoEntriesCompanion Function({
      Value<int> id,
      Value<int?> serverId,
      Value<String> content,
      Value<String?> petResponse,
      Value<String?> imageUrl,
      Value<DateTime> createdAt,
      Value<bool> isSynced,
    });

class $$MemoEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $MemoEntriesTable> {
  $$MemoEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get petResponse => $composableBuilder(
    column: $table.petResponse,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MemoEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $MemoEntriesTable> {
  $$MemoEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get petResponse => $composableBuilder(
    column: $table.petResponse,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MemoEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MemoEntriesTable> {
  $$MemoEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get petResponse => $composableBuilder(
    column: $table.petResponse,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$MemoEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MemoEntriesTable,
          MemoEntry,
          $$MemoEntriesTableFilterComposer,
          $$MemoEntriesTableOrderingComposer,
          $$MemoEntriesTableAnnotationComposer,
          $$MemoEntriesTableCreateCompanionBuilder,
          $$MemoEntriesTableUpdateCompanionBuilder,
          (
            MemoEntry,
            BaseReferences<_$AppDatabase, $MemoEntriesTable, MemoEntry>,
          ),
          MemoEntry,
          PrefetchHooks Function()
        > {
  $$MemoEntriesTableTableManager(_$AppDatabase db, $MemoEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MemoEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MemoEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MemoEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> serverId = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String?> petResponse = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
              }) => MemoEntriesCompanion(
                id: id,
                serverId: serverId,
                content: content,
                petResponse: petResponse,
                imageUrl: imageUrl,
                createdAt: createdAt,
                isSynced: isSynced,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> serverId = const Value.absent(),
                required String content,
                Value<String?> petResponse = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
              }) => MemoEntriesCompanion.insert(
                id: id,
                serverId: serverId,
                content: content,
                petResponse: petResponse,
                imageUrl: imageUrl,
                createdAt: createdAt,
                isSynced: isSynced,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MemoEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MemoEntriesTable,
      MemoEntry,
      $$MemoEntriesTableFilterComposer,
      $$MemoEntriesTableOrderingComposer,
      $$MemoEntriesTableAnnotationComposer,
      $$MemoEntriesTableCreateCompanionBuilder,
      $$MemoEntriesTableUpdateCompanionBuilder,
      (MemoEntry, BaseReferences<_$AppDatabase, $MemoEntriesTable, MemoEntry>),
      MemoEntry,
      PrefetchHooks Function()
    >;
typedef $$PetEntriesTableCreateCompanionBuilder =
    PetEntriesCompanion Function({
      Value<int> id,
      required String petType,
      Value<String?> petName,
      required String petSound,
      Value<DateTime> createdAt,
      Value<bool> isActive,
    });
typedef $$PetEntriesTableUpdateCompanionBuilder =
    PetEntriesCompanion Function({
      Value<int> id,
      Value<String> petType,
      Value<String?> petName,
      Value<String> petSound,
      Value<DateTime> createdAt,
      Value<bool> isActive,
    });

class $$PetEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $PetEntriesTable> {
  $$PetEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get petType => $composableBuilder(
    column: $table.petType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get petName => $composableBuilder(
    column: $table.petName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get petSound => $composableBuilder(
    column: $table.petSound,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PetEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $PetEntriesTable> {
  $$PetEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get petType => $composableBuilder(
    column: $table.petType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get petName => $composableBuilder(
    column: $table.petName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get petSound => $composableBuilder(
    column: $table.petSound,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PetEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PetEntriesTable> {
  $$PetEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get petType =>
      $composableBuilder(column: $table.petType, builder: (column) => column);

  GeneratedColumn<String> get petName =>
      $composableBuilder(column: $table.petName, builder: (column) => column);

  GeneratedColumn<String> get petSound =>
      $composableBuilder(column: $table.petSound, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);
}

class $$PetEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PetEntriesTable,
          PetEntry,
          $$PetEntriesTableFilterComposer,
          $$PetEntriesTableOrderingComposer,
          $$PetEntriesTableAnnotationComposer,
          $$PetEntriesTableCreateCompanionBuilder,
          $$PetEntriesTableUpdateCompanionBuilder,
          (PetEntry, BaseReferences<_$AppDatabase, $PetEntriesTable, PetEntry>),
          PetEntry,
          PrefetchHooks Function()
        > {
  $$PetEntriesTableTableManager(_$AppDatabase db, $PetEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PetEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PetEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PetEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> petType = const Value.absent(),
                Value<String?> petName = const Value.absent(),
                Value<String> petSound = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
              }) => PetEntriesCompanion(
                id: id,
                petType: petType,
                petName: petName,
                petSound: petSound,
                createdAt: createdAt,
                isActive: isActive,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String petType,
                Value<String?> petName = const Value.absent(),
                required String petSound,
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
              }) => PetEntriesCompanion.insert(
                id: id,
                petType: petType,
                petName: petName,
                petSound: petSound,
                createdAt: createdAt,
                isActive: isActive,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PetEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PetEntriesTable,
      PetEntry,
      $$PetEntriesTableFilterComposer,
      $$PetEntriesTableOrderingComposer,
      $$PetEntriesTableAnnotationComposer,
      $$PetEntriesTableCreateCompanionBuilder,
      $$PetEntriesTableUpdateCompanionBuilder,
      (PetEntry, BaseReferences<_$AppDatabase, $PetEntriesTable, PetEntry>),
      PetEntry,
      PrefetchHooks Function()
    >;
typedef $$UserSettingsEntriesTableCreateCompanionBuilder =
    UserSettingsEntriesCompanion Function({
      Value<int> id,
      Value<String> serverUrl,
      Value<bool> onboardingComplete,
      Value<bool> gachaComplete,
      Value<bool> namingComplete,
    });
typedef $$UserSettingsEntriesTableUpdateCompanionBuilder =
    UserSettingsEntriesCompanion Function({
      Value<int> id,
      Value<String> serverUrl,
      Value<bool> onboardingComplete,
      Value<bool> gachaComplete,
      Value<bool> namingComplete,
    });

class $$UserSettingsEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $UserSettingsEntriesTable> {
  $$UserSettingsEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverUrl => $composableBuilder(
    column: $table.serverUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get gachaComplete => $composableBuilder(
    column: $table.gachaComplete,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get namingComplete => $composableBuilder(
    column: $table.namingComplete,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserSettingsEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserSettingsEntriesTable> {
  $$UserSettingsEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverUrl => $composableBuilder(
    column: $table.serverUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get gachaComplete => $composableBuilder(
    column: $table.gachaComplete,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get namingComplete => $composableBuilder(
    column: $table.namingComplete,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserSettingsEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserSettingsEntriesTable> {
  $$UserSettingsEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get serverUrl =>
      $composableBuilder(column: $table.serverUrl, builder: (column) => column);

  GeneratedColumn<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get gachaComplete => $composableBuilder(
    column: $table.gachaComplete,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get namingComplete => $composableBuilder(
    column: $table.namingComplete,
    builder: (column) => column,
  );
}

class $$UserSettingsEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserSettingsEntriesTable,
          UserSettingsEntry,
          $$UserSettingsEntriesTableFilterComposer,
          $$UserSettingsEntriesTableOrderingComposer,
          $$UserSettingsEntriesTableAnnotationComposer,
          $$UserSettingsEntriesTableCreateCompanionBuilder,
          $$UserSettingsEntriesTableUpdateCompanionBuilder,
          (
            UserSettingsEntry,
            BaseReferences<
              _$AppDatabase,
              $UserSettingsEntriesTable,
              UserSettingsEntry
            >,
          ),
          UserSettingsEntry,
          PrefetchHooks Function()
        > {
  $$UserSettingsEntriesTableTableManager(
    _$AppDatabase db,
    $UserSettingsEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserSettingsEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserSettingsEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$UserSettingsEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> serverUrl = const Value.absent(),
                Value<bool> onboardingComplete = const Value.absent(),
                Value<bool> gachaComplete = const Value.absent(),
                Value<bool> namingComplete = const Value.absent(),
              }) => UserSettingsEntriesCompanion(
                id: id,
                serverUrl: serverUrl,
                onboardingComplete: onboardingComplete,
                gachaComplete: gachaComplete,
                namingComplete: namingComplete,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> serverUrl = const Value.absent(),
                Value<bool> onboardingComplete = const Value.absent(),
                Value<bool> gachaComplete = const Value.absent(),
                Value<bool> namingComplete = const Value.absent(),
              }) => UserSettingsEntriesCompanion.insert(
                id: id,
                serverUrl: serverUrl,
                onboardingComplete: onboardingComplete,
                gachaComplete: gachaComplete,
                namingComplete: namingComplete,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserSettingsEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserSettingsEntriesTable,
      UserSettingsEntry,
      $$UserSettingsEntriesTableFilterComposer,
      $$UserSettingsEntriesTableOrderingComposer,
      $$UserSettingsEntriesTableAnnotationComposer,
      $$UserSettingsEntriesTableCreateCompanionBuilder,
      $$UserSettingsEntriesTableUpdateCompanionBuilder,
      (
        UserSettingsEntry,
        BaseReferences<
          _$AppDatabase,
          $UserSettingsEntriesTable,
          UserSettingsEntry
        >,
      ),
      UserSettingsEntry,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MemoEntriesTableTableManager get memoEntries =>
      $$MemoEntriesTableTableManager(_db, _db.memoEntries);
  $$PetEntriesTableTableManager get petEntries =>
      $$PetEntriesTableTableManager(_db, _db.petEntries);
  $$UserSettingsEntriesTableTableManager get userSettingsEntries =>
      $$UserSettingsEntriesTableTableManager(_db, _db.userSettingsEntries);
}
