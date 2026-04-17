// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $LocalPatientsTable extends LocalPatients
    with TableInfo<$LocalPatientsTable, LocalPatient> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalPatientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clinicIdMeta = const VerificationMeta(
    'clinicId',
  );
  @override
  late final GeneratedColumn<String> clinicId = GeneratedColumn<String>(
    'clinic_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fatherNameMeta = const VerificationMeta(
    'fatherName',
  );
  @override
  late final GeneratedColumn<String> fatherName = GeneratedColumn<String>(
    'father_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameLowerMeta = const VerificationMeta(
    'displayNameLower',
  );
  @override
  late final GeneratedColumn<String> displayNameLower = GeneratedColumn<String>(
    'display_name_lower',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
    'city',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _districtMeta = const VerificationMeta(
    'district',
  );
  @override
  late final GeneratedColumn<String> district = GeneratedColumn<String>(
    'district',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _detailedAddressMeta = const VerificationMeta(
    'detailedAddress',
  );
  @override
  late final GeneratedColumn<String> detailedAddress = GeneratedColumn<String>(
    'detailed_address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dobMeta = const VerificationMeta('dob');
  @override
  late final GeneratedColumn<DateTime> dob = GeneratedColumn<DateTime>(
    'dob',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
    'gender',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nationalIdMeta = const VerificationMeta(
    'nationalId',
  );
  @override
  late final GeneratedColumn<String> nationalId = GeneratedColumn<String>(
    'national_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reasonForVisitMeta = const VerificationMeta(
    'reasonForVisit',
  );
  @override
  late final GeneratedColumn<String> reasonForVisit = GeneratedColumn<String>(
    'reason_for_visit',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _medicalNotesMeta = const VerificationMeta(
    'medicalNotes',
  );
  @override
  late final GeneratedColumn<String> medicalNotes = GeneratedColumn<String>(
    'medical_notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _allergiesJsonMeta = const VerificationMeta(
    'allergiesJson',
  );
  @override
  late final GeneratedColumn<String> allergiesJson = GeneratedColumn<String>(
    'allergies_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _chronicDiseasesJsonMeta =
      const VerificationMeta('chronicDiseasesJson');
  @override
  late final GeneratedColumn<String> chronicDiseasesJson =
      GeneratedColumn<String>(
        'chronic_diseases_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      );
  static const VerificationMeta _attachmentUrlsJsonMeta =
      const VerificationMeta('attachmentUrlsJson');
  @override
  late final GeneratedColumn<String> attachmentUrlsJson =
      GeneratedColumn<String>(
        'attachment_urls_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
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
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clinicId,
    firstName,
    fatherName,
    lastName,
    displayName,
    displayNameLower,
    phoneNumber,
    city,
    district,
    detailedAddress,
    dob,
    gender,
    nationalId,
    reasonForVisit,
    medicalNotes,
    allergiesJson,
    chronicDiseasesJson,
    attachmentUrlsJson,
    createdAt,
    updatedAt,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_patients';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalPatient> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('clinic_id')) {
      context.handle(
        _clinicIdMeta,
        clinicId.isAcceptableOrUnknown(data['clinic_id']!, _clinicIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clinicIdMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('father_name')) {
      context.handle(
        _fatherNameMeta,
        fatherName.isAcceptableOrUnknown(data['father_name']!, _fatherNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fatherNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('display_name_lower')) {
      context.handle(
        _displayNameLowerMeta,
        displayNameLower.isAcceptableOrUnknown(
          data['display_name_lower']!,
          _displayNameLowerMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameLowerMeta);
    }
    if (data.containsKey('phone_number')) {
      context.handle(
        _phoneNumberMeta,
        phoneNumber.isAcceptableOrUnknown(
          data['phone_number']!,
          _phoneNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_phoneNumberMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
        _cityMeta,
        city.isAcceptableOrUnknown(data['city']!, _cityMeta),
      );
    }
    if (data.containsKey('district')) {
      context.handle(
        _districtMeta,
        district.isAcceptableOrUnknown(data['district']!, _districtMeta),
      );
    }
    if (data.containsKey('detailed_address')) {
      context.handle(
        _detailedAddressMeta,
        detailedAddress.isAcceptableOrUnknown(
          data['detailed_address']!,
          _detailedAddressMeta,
        ),
      );
    }
    if (data.containsKey('dob')) {
      context.handle(
        _dobMeta,
        dob.isAcceptableOrUnknown(data['dob']!, _dobMeta),
      );
    }
    if (data.containsKey('gender')) {
      context.handle(
        _genderMeta,
        gender.isAcceptableOrUnknown(data['gender']!, _genderMeta),
      );
    }
    if (data.containsKey('national_id')) {
      context.handle(
        _nationalIdMeta,
        nationalId.isAcceptableOrUnknown(data['national_id']!, _nationalIdMeta),
      );
    }
    if (data.containsKey('reason_for_visit')) {
      context.handle(
        _reasonForVisitMeta,
        reasonForVisit.isAcceptableOrUnknown(
          data['reason_for_visit']!,
          _reasonForVisitMeta,
        ),
      );
    }
    if (data.containsKey('medical_notes')) {
      context.handle(
        _medicalNotesMeta,
        medicalNotes.isAcceptableOrUnknown(
          data['medical_notes']!,
          _medicalNotesMeta,
        ),
      );
    }
    if (data.containsKey('allergies_json')) {
      context.handle(
        _allergiesJsonMeta,
        allergiesJson.isAcceptableOrUnknown(
          data['allergies_json']!,
          _allergiesJsonMeta,
        ),
      );
    }
    if (data.containsKey('chronic_diseases_json')) {
      context.handle(
        _chronicDiseasesJsonMeta,
        chronicDiseasesJson.isAcceptableOrUnknown(
          data['chronic_diseases_json']!,
          _chronicDiseasesJsonMeta,
        ),
      );
    }
    if (data.containsKey('attachment_urls_json')) {
      context.handle(
        _attachmentUrlsJsonMeta,
        attachmentUrlsJson.isAcceptableOrUnknown(
          data['attachment_urls_json']!,
          _attachmentUrlsJsonMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
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
  LocalPatient map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalPatient(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      clinicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}clinic_id'],
      )!,
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name'],
      )!,
      fatherName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}father_name'],
      )!,
      lastName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_name'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      displayNameLower: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name_lower'],
      )!,
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      )!,
      city: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city'],
      ),
      district: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}district'],
      ),
      detailedAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}detailed_address'],
      ),
      dob: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}dob'],
      ),
      gender: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gender'],
      ),
      nationalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}national_id'],
      ),
      reasonForVisit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason_for_visit'],
      ),
      medicalNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}medical_notes'],
      ),
      allergiesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}allergies_json'],
      )!,
      chronicDiseasesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chronic_diseases_json'],
      )!,
      attachmentUrlsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attachment_urls_json'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $LocalPatientsTable createAlias(String alias) {
    return $LocalPatientsTable(attachedDatabase, alias);
  }
}

class LocalPatient extends DataClass implements Insertable<LocalPatient> {
  final String id;
  final String clinicId;
  final String firstName;
  final String fatherName;
  final String lastName;
  final String displayName;
  final String displayNameLower;
  final String phoneNumber;
  final String? city;
  final String? district;
  final String? detailedAddress;
  final DateTime? dob;
  final String? gender;
  final String? nationalId;
  final String? reasonForVisit;
  final String? medicalNotes;
  final String allergiesJson;
  final String chronicDiseasesJson;
  final String attachmentUrlsJson;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isSynced;
  const LocalPatient({
    required this.id,
    required this.clinicId,
    required this.firstName,
    required this.fatherName,
    required this.lastName,
    required this.displayName,
    required this.displayNameLower,
    required this.phoneNumber,
    this.city,
    this.district,
    this.detailedAddress,
    this.dob,
    this.gender,
    this.nationalId,
    this.reasonForVisit,
    this.medicalNotes,
    required this.allergiesJson,
    required this.chronicDiseasesJson,
    required this.attachmentUrlsJson,
    required this.createdAt,
    required this.updatedAt,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['clinic_id'] = Variable<String>(clinicId);
    map['first_name'] = Variable<String>(firstName);
    map['father_name'] = Variable<String>(fatherName);
    map['last_name'] = Variable<String>(lastName);
    map['display_name'] = Variable<String>(displayName);
    map['display_name_lower'] = Variable<String>(displayNameLower);
    map['phone_number'] = Variable<String>(phoneNumber);
    if (!nullToAbsent || city != null) {
      map['city'] = Variable<String>(city);
    }
    if (!nullToAbsent || district != null) {
      map['district'] = Variable<String>(district);
    }
    if (!nullToAbsent || detailedAddress != null) {
      map['detailed_address'] = Variable<String>(detailedAddress);
    }
    if (!nullToAbsent || dob != null) {
      map['dob'] = Variable<DateTime>(dob);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(gender);
    }
    if (!nullToAbsent || nationalId != null) {
      map['national_id'] = Variable<String>(nationalId);
    }
    if (!nullToAbsent || reasonForVisit != null) {
      map['reason_for_visit'] = Variable<String>(reasonForVisit);
    }
    if (!nullToAbsent || medicalNotes != null) {
      map['medical_notes'] = Variable<String>(medicalNotes);
    }
    map['allergies_json'] = Variable<String>(allergiesJson);
    map['chronic_diseases_json'] = Variable<String>(chronicDiseasesJson);
    map['attachment_urls_json'] = Variable<String>(attachmentUrlsJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  LocalPatientsCompanion toCompanion(bool nullToAbsent) {
    return LocalPatientsCompanion(
      id: Value(id),
      clinicId: Value(clinicId),
      firstName: Value(firstName),
      fatherName: Value(fatherName),
      lastName: Value(lastName),
      displayName: Value(displayName),
      displayNameLower: Value(displayNameLower),
      phoneNumber: Value(phoneNumber),
      city: city == null && nullToAbsent ? const Value.absent() : Value(city),
      district: district == null && nullToAbsent
          ? const Value.absent()
          : Value(district),
      detailedAddress: detailedAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(detailedAddress),
      dob: dob == null && nullToAbsent ? const Value.absent() : Value(dob),
      gender: gender == null && nullToAbsent
          ? const Value.absent()
          : Value(gender),
      nationalId: nationalId == null && nullToAbsent
          ? const Value.absent()
          : Value(nationalId),
      reasonForVisit: reasonForVisit == null && nullToAbsent
          ? const Value.absent()
          : Value(reasonForVisit),
      medicalNotes: medicalNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(medicalNotes),
      allergiesJson: Value(allergiesJson),
      chronicDiseasesJson: Value(chronicDiseasesJson),
      attachmentUrlsJson: Value(attachmentUrlsJson),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isSynced: Value(isSynced),
    );
  }

  factory LocalPatient.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalPatient(
      id: serializer.fromJson<String>(json['id']),
      clinicId: serializer.fromJson<String>(json['clinicId']),
      firstName: serializer.fromJson<String>(json['firstName']),
      fatherName: serializer.fromJson<String>(json['fatherName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      displayName: serializer.fromJson<String>(json['displayName']),
      displayNameLower: serializer.fromJson<String>(json['displayNameLower']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      city: serializer.fromJson<String?>(json['city']),
      district: serializer.fromJson<String?>(json['district']),
      detailedAddress: serializer.fromJson<String?>(json['detailedAddress']),
      dob: serializer.fromJson<DateTime?>(json['dob']),
      gender: serializer.fromJson<String?>(json['gender']),
      nationalId: serializer.fromJson<String?>(json['nationalId']),
      reasonForVisit: serializer.fromJson<String?>(json['reasonForVisit']),
      medicalNotes: serializer.fromJson<String?>(json['medicalNotes']),
      allergiesJson: serializer.fromJson<String>(json['allergiesJson']),
      chronicDiseasesJson: serializer.fromJson<String>(
        json['chronicDiseasesJson'],
      ),
      attachmentUrlsJson: serializer.fromJson<String>(
        json['attachmentUrlsJson'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'clinicId': serializer.toJson<String>(clinicId),
      'firstName': serializer.toJson<String>(firstName),
      'fatherName': serializer.toJson<String>(fatherName),
      'lastName': serializer.toJson<String>(lastName),
      'displayName': serializer.toJson<String>(displayName),
      'displayNameLower': serializer.toJson<String>(displayNameLower),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'city': serializer.toJson<String?>(city),
      'district': serializer.toJson<String?>(district),
      'detailedAddress': serializer.toJson<String?>(detailedAddress),
      'dob': serializer.toJson<DateTime?>(dob),
      'gender': serializer.toJson<String?>(gender),
      'nationalId': serializer.toJson<String?>(nationalId),
      'reasonForVisit': serializer.toJson<String?>(reasonForVisit),
      'medicalNotes': serializer.toJson<String?>(medicalNotes),
      'allergiesJson': serializer.toJson<String>(allergiesJson),
      'chronicDiseasesJson': serializer.toJson<String>(chronicDiseasesJson),
      'attachmentUrlsJson': serializer.toJson<String>(attachmentUrlsJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  LocalPatient copyWith({
    String? id,
    String? clinicId,
    String? firstName,
    String? fatherName,
    String? lastName,
    String? displayName,
    String? displayNameLower,
    String? phoneNumber,
    Value<String?> city = const Value.absent(),
    Value<String?> district = const Value.absent(),
    Value<String?> detailedAddress = const Value.absent(),
    Value<DateTime?> dob = const Value.absent(),
    Value<String?> gender = const Value.absent(),
    Value<String?> nationalId = const Value.absent(),
    Value<String?> reasonForVisit = const Value.absent(),
    Value<String?> medicalNotes = const Value.absent(),
    String? allergiesJson,
    String? chronicDiseasesJson,
    String? attachmentUrlsJson,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isSynced,
  }) => LocalPatient(
    id: id ?? this.id,
    clinicId: clinicId ?? this.clinicId,
    firstName: firstName ?? this.firstName,
    fatherName: fatherName ?? this.fatherName,
    lastName: lastName ?? this.lastName,
    displayName: displayName ?? this.displayName,
    displayNameLower: displayNameLower ?? this.displayNameLower,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    city: city.present ? city.value : this.city,
    district: district.present ? district.value : this.district,
    detailedAddress: detailedAddress.present
        ? detailedAddress.value
        : this.detailedAddress,
    dob: dob.present ? dob.value : this.dob,
    gender: gender.present ? gender.value : this.gender,
    nationalId: nationalId.present ? nationalId.value : this.nationalId,
    reasonForVisit: reasonForVisit.present
        ? reasonForVisit.value
        : this.reasonForVisit,
    medicalNotes: medicalNotes.present ? medicalNotes.value : this.medicalNotes,
    allergiesJson: allergiesJson ?? this.allergiesJson,
    chronicDiseasesJson: chronicDiseasesJson ?? this.chronicDiseasesJson,
    attachmentUrlsJson: attachmentUrlsJson ?? this.attachmentUrlsJson,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    isSynced: isSynced ?? this.isSynced,
  );
  LocalPatient copyWithCompanion(LocalPatientsCompanion data) {
    return LocalPatient(
      id: data.id.present ? data.id.value : this.id,
      clinicId: data.clinicId.present ? data.clinicId.value : this.clinicId,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      fatherName: data.fatherName.present
          ? data.fatherName.value
          : this.fatherName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      displayNameLower: data.displayNameLower.present
          ? data.displayNameLower.value
          : this.displayNameLower,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      city: data.city.present ? data.city.value : this.city,
      district: data.district.present ? data.district.value : this.district,
      detailedAddress: data.detailedAddress.present
          ? data.detailedAddress.value
          : this.detailedAddress,
      dob: data.dob.present ? data.dob.value : this.dob,
      gender: data.gender.present ? data.gender.value : this.gender,
      nationalId: data.nationalId.present
          ? data.nationalId.value
          : this.nationalId,
      reasonForVisit: data.reasonForVisit.present
          ? data.reasonForVisit.value
          : this.reasonForVisit,
      medicalNotes: data.medicalNotes.present
          ? data.medicalNotes.value
          : this.medicalNotes,
      allergiesJson: data.allergiesJson.present
          ? data.allergiesJson.value
          : this.allergiesJson,
      chronicDiseasesJson: data.chronicDiseasesJson.present
          ? data.chronicDiseasesJson.value
          : this.chronicDiseasesJson,
      attachmentUrlsJson: data.attachmentUrlsJson.present
          ? data.attachmentUrlsJson.value
          : this.attachmentUrlsJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalPatient(')
          ..write('id: $id, ')
          ..write('clinicId: $clinicId, ')
          ..write('firstName: $firstName, ')
          ..write('fatherName: $fatherName, ')
          ..write('lastName: $lastName, ')
          ..write('displayName: $displayName, ')
          ..write('displayNameLower: $displayNameLower, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('city: $city, ')
          ..write('district: $district, ')
          ..write('detailedAddress: $detailedAddress, ')
          ..write('dob: $dob, ')
          ..write('gender: $gender, ')
          ..write('nationalId: $nationalId, ')
          ..write('reasonForVisit: $reasonForVisit, ')
          ..write('medicalNotes: $medicalNotes, ')
          ..write('allergiesJson: $allergiesJson, ')
          ..write('chronicDiseasesJson: $chronicDiseasesJson, ')
          ..write('attachmentUrlsJson: $attachmentUrlsJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    clinicId,
    firstName,
    fatherName,
    lastName,
    displayName,
    displayNameLower,
    phoneNumber,
    city,
    district,
    detailedAddress,
    dob,
    gender,
    nationalId,
    reasonForVisit,
    medicalNotes,
    allergiesJson,
    chronicDiseasesJson,
    attachmentUrlsJson,
    createdAt,
    updatedAt,
    isSynced,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalPatient &&
          other.id == this.id &&
          other.clinicId == this.clinicId &&
          other.firstName == this.firstName &&
          other.fatherName == this.fatherName &&
          other.lastName == this.lastName &&
          other.displayName == this.displayName &&
          other.displayNameLower == this.displayNameLower &&
          other.phoneNumber == this.phoneNumber &&
          other.city == this.city &&
          other.district == this.district &&
          other.detailedAddress == this.detailedAddress &&
          other.dob == this.dob &&
          other.gender == this.gender &&
          other.nationalId == this.nationalId &&
          other.reasonForVisit == this.reasonForVisit &&
          other.medicalNotes == this.medicalNotes &&
          other.allergiesJson == this.allergiesJson &&
          other.chronicDiseasesJson == this.chronicDiseasesJson &&
          other.attachmentUrlsJson == this.attachmentUrlsJson &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isSynced == this.isSynced);
}

class LocalPatientsCompanion extends UpdateCompanion<LocalPatient> {
  final Value<String> id;
  final Value<String> clinicId;
  final Value<String> firstName;
  final Value<String> fatherName;
  final Value<String> lastName;
  final Value<String> displayName;
  final Value<String> displayNameLower;
  final Value<String> phoneNumber;
  final Value<String?> city;
  final Value<String?> district;
  final Value<String?> detailedAddress;
  final Value<DateTime?> dob;
  final Value<String?> gender;
  final Value<String?> nationalId;
  final Value<String?> reasonForVisit;
  final Value<String?> medicalNotes;
  final Value<String> allergiesJson;
  final Value<String> chronicDiseasesJson;
  final Value<String> attachmentUrlsJson;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const LocalPatientsCompanion({
    this.id = const Value.absent(),
    this.clinicId = const Value.absent(),
    this.firstName = const Value.absent(),
    this.fatherName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.displayName = const Value.absent(),
    this.displayNameLower = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.city = const Value.absent(),
    this.district = const Value.absent(),
    this.detailedAddress = const Value.absent(),
    this.dob = const Value.absent(),
    this.gender = const Value.absent(),
    this.nationalId = const Value.absent(),
    this.reasonForVisit = const Value.absent(),
    this.medicalNotes = const Value.absent(),
    this.allergiesJson = const Value.absent(),
    this.chronicDiseasesJson = const Value.absent(),
    this.attachmentUrlsJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalPatientsCompanion.insert({
    required String id,
    required String clinicId,
    required String firstName,
    required String fatherName,
    required String lastName,
    required String displayName,
    required String displayNameLower,
    required String phoneNumber,
    this.city = const Value.absent(),
    this.district = const Value.absent(),
    this.detailedAddress = const Value.absent(),
    this.dob = const Value.absent(),
    this.gender = const Value.absent(),
    this.nationalId = const Value.absent(),
    this.reasonForVisit = const Value.absent(),
    this.medicalNotes = const Value.absent(),
    this.allergiesJson = const Value.absent(),
    this.chronicDiseasesJson = const Value.absent(),
    this.attachmentUrlsJson = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       clinicId = Value(clinicId),
       firstName = Value(firstName),
       fatherName = Value(fatherName),
       lastName = Value(lastName),
       displayName = Value(displayName),
       displayNameLower = Value(displayNameLower),
       phoneNumber = Value(phoneNumber),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LocalPatient> custom({
    Expression<String>? id,
    Expression<String>? clinicId,
    Expression<String>? firstName,
    Expression<String>? fatherName,
    Expression<String>? lastName,
    Expression<String>? displayName,
    Expression<String>? displayNameLower,
    Expression<String>? phoneNumber,
    Expression<String>? city,
    Expression<String>? district,
    Expression<String>? detailedAddress,
    Expression<DateTime>? dob,
    Expression<String>? gender,
    Expression<String>? nationalId,
    Expression<String>? reasonForVisit,
    Expression<String>? medicalNotes,
    Expression<String>? allergiesJson,
    Expression<String>? chronicDiseasesJson,
    Expression<String>? attachmentUrlsJson,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clinicId != null) 'clinic_id': clinicId,
      if (firstName != null) 'first_name': firstName,
      if (fatherName != null) 'father_name': fatherName,
      if (lastName != null) 'last_name': lastName,
      if (displayName != null) 'display_name': displayName,
      if (displayNameLower != null) 'display_name_lower': displayNameLower,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (city != null) 'city': city,
      if (district != null) 'district': district,
      if (detailedAddress != null) 'detailed_address': detailedAddress,
      if (dob != null) 'dob': dob,
      if (gender != null) 'gender': gender,
      if (nationalId != null) 'national_id': nationalId,
      if (reasonForVisit != null) 'reason_for_visit': reasonForVisit,
      if (medicalNotes != null) 'medical_notes': medicalNotes,
      if (allergiesJson != null) 'allergies_json': allergiesJson,
      if (chronicDiseasesJson != null)
        'chronic_diseases_json': chronicDiseasesJson,
      if (attachmentUrlsJson != null)
        'attachment_urls_json': attachmentUrlsJson,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalPatientsCompanion copyWith({
    Value<String>? id,
    Value<String>? clinicId,
    Value<String>? firstName,
    Value<String>? fatherName,
    Value<String>? lastName,
    Value<String>? displayName,
    Value<String>? displayNameLower,
    Value<String>? phoneNumber,
    Value<String?>? city,
    Value<String?>? district,
    Value<String?>? detailedAddress,
    Value<DateTime?>? dob,
    Value<String?>? gender,
    Value<String?>? nationalId,
    Value<String?>? reasonForVisit,
    Value<String?>? medicalNotes,
    Value<String>? allergiesJson,
    Value<String>? chronicDiseasesJson,
    Value<String>? attachmentUrlsJson,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return LocalPatientsCompanion(
      id: id ?? this.id,
      clinicId: clinicId ?? this.clinicId,
      firstName: firstName ?? this.firstName,
      fatherName: fatherName ?? this.fatherName,
      lastName: lastName ?? this.lastName,
      displayName: displayName ?? this.displayName,
      displayNameLower: displayNameLower ?? this.displayNameLower,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      city: city ?? this.city,
      district: district ?? this.district,
      detailedAddress: detailedAddress ?? this.detailedAddress,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      nationalId: nationalId ?? this.nationalId,
      reasonForVisit: reasonForVisit ?? this.reasonForVisit,
      medicalNotes: medicalNotes ?? this.medicalNotes,
      allergiesJson: allergiesJson ?? this.allergiesJson,
      chronicDiseasesJson: chronicDiseasesJson ?? this.chronicDiseasesJson,
      attachmentUrlsJson: attachmentUrlsJson ?? this.attachmentUrlsJson,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (clinicId.present) {
      map['clinic_id'] = Variable<String>(clinicId.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (fatherName.present) {
      map['father_name'] = Variable<String>(fatherName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (displayNameLower.present) {
      map['display_name_lower'] = Variable<String>(displayNameLower.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (district.present) {
      map['district'] = Variable<String>(district.value);
    }
    if (detailedAddress.present) {
      map['detailed_address'] = Variable<String>(detailedAddress.value);
    }
    if (dob.present) {
      map['dob'] = Variable<DateTime>(dob.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (nationalId.present) {
      map['national_id'] = Variable<String>(nationalId.value);
    }
    if (reasonForVisit.present) {
      map['reason_for_visit'] = Variable<String>(reasonForVisit.value);
    }
    if (medicalNotes.present) {
      map['medical_notes'] = Variable<String>(medicalNotes.value);
    }
    if (allergiesJson.present) {
      map['allergies_json'] = Variable<String>(allergiesJson.value);
    }
    if (chronicDiseasesJson.present) {
      map['chronic_diseases_json'] = Variable<String>(
        chronicDiseasesJson.value,
      );
    }
    if (attachmentUrlsJson.present) {
      map['attachment_urls_json'] = Variable<String>(attachmentUrlsJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalPatientsCompanion(')
          ..write('id: $id, ')
          ..write('clinicId: $clinicId, ')
          ..write('firstName: $firstName, ')
          ..write('fatherName: $fatherName, ')
          ..write('lastName: $lastName, ')
          ..write('displayName: $displayName, ')
          ..write('displayNameLower: $displayNameLower, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('city: $city, ')
          ..write('district: $district, ')
          ..write('detailedAddress: $detailedAddress, ')
          ..write('dob: $dob, ')
          ..write('gender: $gender, ')
          ..write('nationalId: $nationalId, ')
          ..write('reasonForVisit: $reasonForVisit, ')
          ..write('medicalNotes: $medicalNotes, ')
          ..write('allergiesJson: $allergiesJson, ')
          ..write('chronicDiseasesJson: $chronicDiseasesJson, ')
          ..write('attachmentUrlsJson: $attachmentUrlsJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalAppointmentsTable extends LocalAppointments
    with TableInfo<$LocalAppointmentsTable, LocalAppointment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalAppointmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clinicIdMeta = const VerificationMeta(
    'clinicId',
  );
  @override
  late final GeneratedColumn<String> clinicId = GeneratedColumn<String>(
    'clinic_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patientIdMeta = const VerificationMeta(
    'patientId',
  );
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
    'patient_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patientNameMeta = const VerificationMeta(
    'patientName',
  );
  @override
  late final GeneratedColumn<String> patientName = GeneratedColumn<String>(
    'patient_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patientPhoneMeta = const VerificationMeta(
    'patientPhone',
  );
  @override
  late final GeneratedColumn<String> patientPhone = GeneratedColumn<String>(
    'patient_phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startAtMeta = const VerificationMeta(
    'startAt',
  );
  @override
  late final GeneratedColumn<DateTime> startAt = GeneratedColumn<DateTime>(
    'start_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMinutesMeta = const VerificationMeta(
    'durationMinutes',
  );
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
    'duration_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _doctorIdMeta = const VerificationMeta(
    'doctorId',
  );
  @override
  late final GeneratedColumn<String> doctorId = GeneratedColumn<String>(
    'doctor_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _doctorNameMeta = const VerificationMeta(
    'doctorName',
  );
  @override
  late final GeneratedColumn<String> doctorName = GeneratedColumn<String>(
    'doctor_name',
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reminderSentMeta = const VerificationMeta(
    'reminderSent',
  );
  @override
  late final GeneratedColumn<bool> reminderSent = GeneratedColumn<bool>(
    'reminder_sent',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("reminder_sent" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clinicId,
    patientId,
    patientName,
    patientPhone,
    startAt,
    durationMinutes,
    reason,
    status,
    doctorId,
    doctorName,
    createdAt,
    updatedAt,
    reminderSent,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_appointments';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalAppointment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('clinic_id')) {
      context.handle(
        _clinicIdMeta,
        clinicId.isAcceptableOrUnknown(data['clinic_id']!, _clinicIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clinicIdMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(
        _patientIdMeta,
        patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('patient_name')) {
      context.handle(
        _patientNameMeta,
        patientName.isAcceptableOrUnknown(
          data['patient_name']!,
          _patientNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_patientNameMeta);
    }
    if (data.containsKey('patient_phone')) {
      context.handle(
        _patientPhoneMeta,
        patientPhone.isAcceptableOrUnknown(
          data['patient_phone']!,
          _patientPhoneMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_patientPhoneMeta);
    }
    if (data.containsKey('start_at')) {
      context.handle(
        _startAtMeta,
        startAt.isAcceptableOrUnknown(data['start_at']!, _startAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startAtMeta);
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
        _durationMinutesMeta,
        durationMinutes.isAcceptableOrUnknown(
          data['duration_minutes']!,
          _durationMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationMinutesMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    } else if (isInserting) {
      context.missing(_reasonMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('doctor_id')) {
      context.handle(
        _doctorIdMeta,
        doctorId.isAcceptableOrUnknown(data['doctor_id']!, _doctorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_doctorIdMeta);
    }
    if (data.containsKey('doctor_name')) {
      context.handle(
        _doctorNameMeta,
        doctorName.isAcceptableOrUnknown(data['doctor_name']!, _doctorNameMeta),
      );
    } else if (isInserting) {
      context.missing(_doctorNameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('reminder_sent')) {
      context.handle(
        _reminderSentMeta,
        reminderSent.isAcceptableOrUnknown(
          data['reminder_sent']!,
          _reminderSentMeta,
        ),
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
  LocalAppointment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalAppointment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      clinicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}clinic_id'],
      )!,
      patientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_id'],
      )!,
      patientName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_name'],
      )!,
      patientPhone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_phone'],
      )!,
      startAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_at'],
      )!,
      durationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_minutes'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      doctorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}doctor_id'],
      )!,
      doctorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}doctor_name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      reminderSent: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}reminder_sent'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $LocalAppointmentsTable createAlias(String alias) {
    return $LocalAppointmentsTable(attachedDatabase, alias);
  }
}

class LocalAppointment extends DataClass
    implements Insertable<LocalAppointment> {
  final String id;
  final String clinicId;
  final String patientId;
  final String patientName;
  final String patientPhone;
  final DateTime startAt;
  final int durationMinutes;
  final String reason;
  final String status;
  final String doctorId;
  final String doctorName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool reminderSent;
  final bool isSynced;
  const LocalAppointment({
    required this.id,
    required this.clinicId,
    required this.patientId,
    required this.patientName,
    required this.patientPhone,
    required this.startAt,
    required this.durationMinutes,
    required this.reason,
    required this.status,
    required this.doctorId,
    required this.doctorName,
    required this.createdAt,
    required this.updatedAt,
    required this.reminderSent,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['clinic_id'] = Variable<String>(clinicId);
    map['patient_id'] = Variable<String>(patientId);
    map['patient_name'] = Variable<String>(patientName);
    map['patient_phone'] = Variable<String>(patientPhone);
    map['start_at'] = Variable<DateTime>(startAt);
    map['duration_minutes'] = Variable<int>(durationMinutes);
    map['reason'] = Variable<String>(reason);
    map['status'] = Variable<String>(status);
    map['doctor_id'] = Variable<String>(doctorId);
    map['doctor_name'] = Variable<String>(doctorName);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['reminder_sent'] = Variable<bool>(reminderSent);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  LocalAppointmentsCompanion toCompanion(bool nullToAbsent) {
    return LocalAppointmentsCompanion(
      id: Value(id),
      clinicId: Value(clinicId),
      patientId: Value(patientId),
      patientName: Value(patientName),
      patientPhone: Value(patientPhone),
      startAt: Value(startAt),
      durationMinutes: Value(durationMinutes),
      reason: Value(reason),
      status: Value(status),
      doctorId: Value(doctorId),
      doctorName: Value(doctorName),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      reminderSent: Value(reminderSent),
      isSynced: Value(isSynced),
    );
  }

  factory LocalAppointment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalAppointment(
      id: serializer.fromJson<String>(json['id']),
      clinicId: serializer.fromJson<String>(json['clinicId']),
      patientId: serializer.fromJson<String>(json['patientId']),
      patientName: serializer.fromJson<String>(json['patientName']),
      patientPhone: serializer.fromJson<String>(json['patientPhone']),
      startAt: serializer.fromJson<DateTime>(json['startAt']),
      durationMinutes: serializer.fromJson<int>(json['durationMinutes']),
      reason: serializer.fromJson<String>(json['reason']),
      status: serializer.fromJson<String>(json['status']),
      doctorId: serializer.fromJson<String>(json['doctorId']),
      doctorName: serializer.fromJson<String>(json['doctorName']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      reminderSent: serializer.fromJson<bool>(json['reminderSent']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'clinicId': serializer.toJson<String>(clinicId),
      'patientId': serializer.toJson<String>(patientId),
      'patientName': serializer.toJson<String>(patientName),
      'patientPhone': serializer.toJson<String>(patientPhone),
      'startAt': serializer.toJson<DateTime>(startAt),
      'durationMinutes': serializer.toJson<int>(durationMinutes),
      'reason': serializer.toJson<String>(reason),
      'status': serializer.toJson<String>(status),
      'doctorId': serializer.toJson<String>(doctorId),
      'doctorName': serializer.toJson<String>(doctorName),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'reminderSent': serializer.toJson<bool>(reminderSent),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  LocalAppointment copyWith({
    String? id,
    String? clinicId,
    String? patientId,
    String? patientName,
    String? patientPhone,
    DateTime? startAt,
    int? durationMinutes,
    String? reason,
    String? status,
    String? doctorId,
    String? doctorName,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? reminderSent,
    bool? isSynced,
  }) => LocalAppointment(
    id: id ?? this.id,
    clinicId: clinicId ?? this.clinicId,
    patientId: patientId ?? this.patientId,
    patientName: patientName ?? this.patientName,
    patientPhone: patientPhone ?? this.patientPhone,
    startAt: startAt ?? this.startAt,
    durationMinutes: durationMinutes ?? this.durationMinutes,
    reason: reason ?? this.reason,
    status: status ?? this.status,
    doctorId: doctorId ?? this.doctorId,
    doctorName: doctorName ?? this.doctorName,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    reminderSent: reminderSent ?? this.reminderSent,
    isSynced: isSynced ?? this.isSynced,
  );
  LocalAppointment copyWithCompanion(LocalAppointmentsCompanion data) {
    return LocalAppointment(
      id: data.id.present ? data.id.value : this.id,
      clinicId: data.clinicId.present ? data.clinicId.value : this.clinicId,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      patientName: data.patientName.present
          ? data.patientName.value
          : this.patientName,
      patientPhone: data.patientPhone.present
          ? data.patientPhone.value
          : this.patientPhone,
      startAt: data.startAt.present ? data.startAt.value : this.startAt,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      reason: data.reason.present ? data.reason.value : this.reason,
      status: data.status.present ? data.status.value : this.status,
      doctorId: data.doctorId.present ? data.doctorId.value : this.doctorId,
      doctorName: data.doctorName.present
          ? data.doctorName.value
          : this.doctorName,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      reminderSent: data.reminderSent.present
          ? data.reminderSent.value
          : this.reminderSent,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalAppointment(')
          ..write('id: $id, ')
          ..write('clinicId: $clinicId, ')
          ..write('patientId: $patientId, ')
          ..write('patientName: $patientName, ')
          ..write('patientPhone: $patientPhone, ')
          ..write('startAt: $startAt, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('reason: $reason, ')
          ..write('status: $status, ')
          ..write('doctorId: $doctorId, ')
          ..write('doctorName: $doctorName, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('reminderSent: $reminderSent, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    clinicId,
    patientId,
    patientName,
    patientPhone,
    startAt,
    durationMinutes,
    reason,
    status,
    doctorId,
    doctorName,
    createdAt,
    updatedAt,
    reminderSent,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalAppointment &&
          other.id == this.id &&
          other.clinicId == this.clinicId &&
          other.patientId == this.patientId &&
          other.patientName == this.patientName &&
          other.patientPhone == this.patientPhone &&
          other.startAt == this.startAt &&
          other.durationMinutes == this.durationMinutes &&
          other.reason == this.reason &&
          other.status == this.status &&
          other.doctorId == this.doctorId &&
          other.doctorName == this.doctorName &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.reminderSent == this.reminderSent &&
          other.isSynced == this.isSynced);
}

class LocalAppointmentsCompanion extends UpdateCompanion<LocalAppointment> {
  final Value<String> id;
  final Value<String> clinicId;
  final Value<String> patientId;
  final Value<String> patientName;
  final Value<String> patientPhone;
  final Value<DateTime> startAt;
  final Value<int> durationMinutes;
  final Value<String> reason;
  final Value<String> status;
  final Value<String> doctorId;
  final Value<String> doctorName;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> reminderSent;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const LocalAppointmentsCompanion({
    this.id = const Value.absent(),
    this.clinicId = const Value.absent(),
    this.patientId = const Value.absent(),
    this.patientName = const Value.absent(),
    this.patientPhone = const Value.absent(),
    this.startAt = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.reason = const Value.absent(),
    this.status = const Value.absent(),
    this.doctorId = const Value.absent(),
    this.doctorName = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.reminderSent = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalAppointmentsCompanion.insert({
    required String id,
    required String clinicId,
    required String patientId,
    required String patientName,
    required String patientPhone,
    required DateTime startAt,
    required int durationMinutes,
    required String reason,
    required String status,
    required String doctorId,
    required String doctorName,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.reminderSent = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       clinicId = Value(clinicId),
       patientId = Value(patientId),
       patientName = Value(patientName),
       patientPhone = Value(patientPhone),
       startAt = Value(startAt),
       durationMinutes = Value(durationMinutes),
       reason = Value(reason),
       status = Value(status),
       doctorId = Value(doctorId),
       doctorName = Value(doctorName),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LocalAppointment> custom({
    Expression<String>? id,
    Expression<String>? clinicId,
    Expression<String>? patientId,
    Expression<String>? patientName,
    Expression<String>? patientPhone,
    Expression<DateTime>? startAt,
    Expression<int>? durationMinutes,
    Expression<String>? reason,
    Expression<String>? status,
    Expression<String>? doctorId,
    Expression<String>? doctorName,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? reminderSent,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clinicId != null) 'clinic_id': clinicId,
      if (patientId != null) 'patient_id': patientId,
      if (patientName != null) 'patient_name': patientName,
      if (patientPhone != null) 'patient_phone': patientPhone,
      if (startAt != null) 'start_at': startAt,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (reason != null) 'reason': reason,
      if (status != null) 'status': status,
      if (doctorId != null) 'doctor_id': doctorId,
      if (doctorName != null) 'doctor_name': doctorName,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (reminderSent != null) 'reminder_sent': reminderSent,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalAppointmentsCompanion copyWith({
    Value<String>? id,
    Value<String>? clinicId,
    Value<String>? patientId,
    Value<String>? patientName,
    Value<String>? patientPhone,
    Value<DateTime>? startAt,
    Value<int>? durationMinutes,
    Value<String>? reason,
    Value<String>? status,
    Value<String>? doctorId,
    Value<String>? doctorName,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<bool>? reminderSent,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return LocalAppointmentsCompanion(
      id: id ?? this.id,
      clinicId: clinicId ?? this.clinicId,
      patientId: patientId ?? this.patientId,
      patientName: patientName ?? this.patientName,
      patientPhone: patientPhone ?? this.patientPhone,
      startAt: startAt ?? this.startAt,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      reason: reason ?? this.reason,
      status: status ?? this.status,
      doctorId: doctorId ?? this.doctorId,
      doctorName: doctorName ?? this.doctorName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      reminderSent: reminderSent ?? this.reminderSent,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (clinicId.present) {
      map['clinic_id'] = Variable<String>(clinicId.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (patientName.present) {
      map['patient_name'] = Variable<String>(patientName.value);
    }
    if (patientPhone.present) {
      map['patient_phone'] = Variable<String>(patientPhone.value);
    }
    if (startAt.present) {
      map['start_at'] = Variable<DateTime>(startAt.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (doctorId.present) {
      map['doctor_id'] = Variable<String>(doctorId.value);
    }
    if (doctorName.present) {
      map['doctor_name'] = Variable<String>(doctorName.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (reminderSent.present) {
      map['reminder_sent'] = Variable<bool>(reminderSent.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalAppointmentsCompanion(')
          ..write('id: $id, ')
          ..write('clinicId: $clinicId, ')
          ..write('patientId: $patientId, ')
          ..write('patientName: $patientName, ')
          ..write('patientPhone: $patientPhone, ')
          ..write('startAt: $startAt, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('reason: $reason, ')
          ..write('status: $status, ')
          ..write('doctorId: $doctorId, ')
          ..write('doctorName: $doctorName, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('reminderSent: $reminderSent, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalDoctorsTable extends LocalDoctors
    with TableInfo<$LocalDoctorsTable, LocalDoctor> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalDoctorsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clinicIdMeta = const VerificationMeta(
    'clinicId',
  );
  @override
  late final GeneratedColumn<String> clinicId = GeneratedColumn<String>(
    'clinic_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fullNameMeta = const VerificationMeta(
    'fullName',
  );
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
    'full_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _specialtyMeta = const VerificationMeta(
    'specialty',
  );
  @override
  late final GeneratedColumn<String> specialty = GeneratedColumn<String>(
    'specialty',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _profilePictureUrlMeta = const VerificationMeta(
    'profilePictureUrl',
  );
  @override
  late final GeneratedColumn<String> profilePictureUrl =
      GeneratedColumn<String>(
        'profile_picture_url',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _monthlySalaryIqdMeta = const VerificationMeta(
    'monthlySalaryIqd',
  );
  @override
  late final GeneratedColumn<double> monthlySalaryIqd = GeneratedColumn<double>(
    'monthly_salary_iqd',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _commissionPercentMeta = const VerificationMeta(
    'commissionPercent',
  );
  @override
  late final GeneratedColumn<double> commissionPercent =
      GeneratedColumn<double>(
        'commission_percent',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      );
  static const VerificationMeta _paymentTypeMeta = const VerificationMeta(
    'paymentType',
  );
  @override
  late final GeneratedColumn<String> paymentType = GeneratedColumn<String>(
    'payment_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('commission'),
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
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
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clinicId,
    fullName,
    phone,
    specialty,
    address,
    notes,
    profilePictureUrl,
    monthlySalaryIqd,
    commissionPercent,
    paymentType,
    createdAt,
    updatedAt,
    isActive,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_doctors';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalDoctor> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('clinic_id')) {
      context.handle(
        _clinicIdMeta,
        clinicId.isAcceptableOrUnknown(data['clinic_id']!, _clinicIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clinicIdMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(
        _fullNameMeta,
        fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('specialty')) {
      context.handle(
        _specialtyMeta,
        specialty.isAcceptableOrUnknown(data['specialty']!, _specialtyMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('profile_picture_url')) {
      context.handle(
        _profilePictureUrlMeta,
        profilePictureUrl.isAcceptableOrUnknown(
          data['profile_picture_url']!,
          _profilePictureUrlMeta,
        ),
      );
    }
    if (data.containsKey('monthly_salary_iqd')) {
      context.handle(
        _monthlySalaryIqdMeta,
        monthlySalaryIqd.isAcceptableOrUnknown(
          data['monthly_salary_iqd']!,
          _monthlySalaryIqdMeta,
        ),
      );
    }
    if (data.containsKey('commission_percent')) {
      context.handle(
        _commissionPercentMeta,
        commissionPercent.isAcceptableOrUnknown(
          data['commission_percent']!,
          _commissionPercentMeta,
        ),
      );
    }
    if (data.containsKey('payment_type')) {
      context.handle(
        _paymentTypeMeta,
        paymentType.isAcceptableOrUnknown(
          data['payment_type']!,
          _paymentTypeMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
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
  LocalDoctor map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalDoctor(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      clinicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}clinic_id'],
      )!,
      fullName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      specialty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}specialty'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      profilePictureUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_picture_url'],
      ),
      monthlySalaryIqd: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}monthly_salary_iqd'],
      )!,
      commissionPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}commission_percent'],
      )!,
      paymentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_type'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $LocalDoctorsTable createAlias(String alias) {
    return $LocalDoctorsTable(attachedDatabase, alias);
  }
}

class LocalDoctor extends DataClass implements Insertable<LocalDoctor> {
  final String id;
  final String clinicId;
  final String fullName;
  final String? phone;
  final String? specialty;
  final String? address;
  final String? notes;
  final String? profilePictureUrl;
  final double monthlySalaryIqd;
  final double commissionPercent;
  final String paymentType;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;
  final bool isSynced;
  const LocalDoctor({
    required this.id,
    required this.clinicId,
    required this.fullName,
    this.phone,
    this.specialty,
    this.address,
    this.notes,
    this.profilePictureUrl,
    required this.monthlySalaryIqd,
    required this.commissionPercent,
    required this.paymentType,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['clinic_id'] = Variable<String>(clinicId);
    map['full_name'] = Variable<String>(fullName);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || specialty != null) {
      map['specialty'] = Variable<String>(specialty);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || profilePictureUrl != null) {
      map['profile_picture_url'] = Variable<String>(profilePictureUrl);
    }
    map['monthly_salary_iqd'] = Variable<double>(monthlySalaryIqd);
    map['commission_percent'] = Variable<double>(commissionPercent);
    map['payment_type'] = Variable<String>(paymentType);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_active'] = Variable<bool>(isActive);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  LocalDoctorsCompanion toCompanion(bool nullToAbsent) {
    return LocalDoctorsCompanion(
      id: Value(id),
      clinicId: Value(clinicId),
      fullName: Value(fullName),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      specialty: specialty == null && nullToAbsent
          ? const Value.absent()
          : Value(specialty),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      profilePictureUrl: profilePictureUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(profilePictureUrl),
      monthlySalaryIqd: Value(monthlySalaryIqd),
      commissionPercent: Value(commissionPercent),
      paymentType: Value(paymentType),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isActive: Value(isActive),
      isSynced: Value(isSynced),
    );
  }

  factory LocalDoctor.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalDoctor(
      id: serializer.fromJson<String>(json['id']),
      clinicId: serializer.fromJson<String>(json['clinicId']),
      fullName: serializer.fromJson<String>(json['fullName']),
      phone: serializer.fromJson<String?>(json['phone']),
      specialty: serializer.fromJson<String?>(json['specialty']),
      address: serializer.fromJson<String?>(json['address']),
      notes: serializer.fromJson<String?>(json['notes']),
      profilePictureUrl: serializer.fromJson<String?>(
        json['profilePictureUrl'],
      ),
      monthlySalaryIqd: serializer.fromJson<double>(json['monthlySalaryIqd']),
      commissionPercent: serializer.fromJson<double>(json['commissionPercent']),
      paymentType: serializer.fromJson<String>(json['paymentType']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'clinicId': serializer.toJson<String>(clinicId),
      'fullName': serializer.toJson<String>(fullName),
      'phone': serializer.toJson<String?>(phone),
      'specialty': serializer.toJson<String?>(specialty),
      'address': serializer.toJson<String?>(address),
      'notes': serializer.toJson<String?>(notes),
      'profilePictureUrl': serializer.toJson<String?>(profilePictureUrl),
      'monthlySalaryIqd': serializer.toJson<double>(monthlySalaryIqd),
      'commissionPercent': serializer.toJson<double>(commissionPercent),
      'paymentType': serializer.toJson<String>(paymentType),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isActive': serializer.toJson<bool>(isActive),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  LocalDoctor copyWith({
    String? id,
    String? clinicId,
    String? fullName,
    Value<String?> phone = const Value.absent(),
    Value<String?> specialty = const Value.absent(),
    Value<String?> address = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<String?> profilePictureUrl = const Value.absent(),
    double? monthlySalaryIqd,
    double? commissionPercent,
    String? paymentType,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
    bool? isSynced,
  }) => LocalDoctor(
    id: id ?? this.id,
    clinicId: clinicId ?? this.clinicId,
    fullName: fullName ?? this.fullName,
    phone: phone.present ? phone.value : this.phone,
    specialty: specialty.present ? specialty.value : this.specialty,
    address: address.present ? address.value : this.address,
    notes: notes.present ? notes.value : this.notes,
    profilePictureUrl: profilePictureUrl.present
        ? profilePictureUrl.value
        : this.profilePictureUrl,
    monthlySalaryIqd: monthlySalaryIqd ?? this.monthlySalaryIqd,
    commissionPercent: commissionPercent ?? this.commissionPercent,
    paymentType: paymentType ?? this.paymentType,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    isActive: isActive ?? this.isActive,
    isSynced: isSynced ?? this.isSynced,
  );
  LocalDoctor copyWithCompanion(LocalDoctorsCompanion data) {
    return LocalDoctor(
      id: data.id.present ? data.id.value : this.id,
      clinicId: data.clinicId.present ? data.clinicId.value : this.clinicId,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      phone: data.phone.present ? data.phone.value : this.phone,
      specialty: data.specialty.present ? data.specialty.value : this.specialty,
      address: data.address.present ? data.address.value : this.address,
      notes: data.notes.present ? data.notes.value : this.notes,
      profilePictureUrl: data.profilePictureUrl.present
          ? data.profilePictureUrl.value
          : this.profilePictureUrl,
      monthlySalaryIqd: data.monthlySalaryIqd.present
          ? data.monthlySalaryIqd.value
          : this.monthlySalaryIqd,
      commissionPercent: data.commissionPercent.present
          ? data.commissionPercent.value
          : this.commissionPercent,
      paymentType: data.paymentType.present
          ? data.paymentType.value
          : this.paymentType,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalDoctor(')
          ..write('id: $id, ')
          ..write('clinicId: $clinicId, ')
          ..write('fullName: $fullName, ')
          ..write('phone: $phone, ')
          ..write('specialty: $specialty, ')
          ..write('address: $address, ')
          ..write('notes: $notes, ')
          ..write('profilePictureUrl: $profilePictureUrl, ')
          ..write('monthlySalaryIqd: $monthlySalaryIqd, ')
          ..write('commissionPercent: $commissionPercent, ')
          ..write('paymentType: $paymentType, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isActive: $isActive, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    clinicId,
    fullName,
    phone,
    specialty,
    address,
    notes,
    profilePictureUrl,
    monthlySalaryIqd,
    commissionPercent,
    paymentType,
    createdAt,
    updatedAt,
    isActive,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalDoctor &&
          other.id == this.id &&
          other.clinicId == this.clinicId &&
          other.fullName == this.fullName &&
          other.phone == this.phone &&
          other.specialty == this.specialty &&
          other.address == this.address &&
          other.notes == this.notes &&
          other.profilePictureUrl == this.profilePictureUrl &&
          other.monthlySalaryIqd == this.monthlySalaryIqd &&
          other.commissionPercent == this.commissionPercent &&
          other.paymentType == this.paymentType &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isActive == this.isActive &&
          other.isSynced == this.isSynced);
}

class LocalDoctorsCompanion extends UpdateCompanion<LocalDoctor> {
  final Value<String> id;
  final Value<String> clinicId;
  final Value<String> fullName;
  final Value<String?> phone;
  final Value<String?> specialty;
  final Value<String?> address;
  final Value<String?> notes;
  final Value<String?> profilePictureUrl;
  final Value<double> monthlySalaryIqd;
  final Value<double> commissionPercent;
  final Value<String> paymentType;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isActive;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const LocalDoctorsCompanion({
    this.id = const Value.absent(),
    this.clinicId = const Value.absent(),
    this.fullName = const Value.absent(),
    this.phone = const Value.absent(),
    this.specialty = const Value.absent(),
    this.address = const Value.absent(),
    this.notes = const Value.absent(),
    this.profilePictureUrl = const Value.absent(),
    this.monthlySalaryIqd = const Value.absent(),
    this.commissionPercent = const Value.absent(),
    this.paymentType = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalDoctorsCompanion.insert({
    required String id,
    required String clinicId,
    this.fullName = const Value.absent(),
    this.phone = const Value.absent(),
    this.specialty = const Value.absent(),
    this.address = const Value.absent(),
    this.notes = const Value.absent(),
    this.profilePictureUrl = const Value.absent(),
    this.monthlySalaryIqd = const Value.absent(),
    this.commissionPercent = const Value.absent(),
    this.paymentType = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.isActive = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       clinicId = Value(clinicId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LocalDoctor> custom({
    Expression<String>? id,
    Expression<String>? clinicId,
    Expression<String>? fullName,
    Expression<String>? phone,
    Expression<String>? specialty,
    Expression<String>? address,
    Expression<String>? notes,
    Expression<String>? profilePictureUrl,
    Expression<double>? monthlySalaryIqd,
    Expression<double>? commissionPercent,
    Expression<String>? paymentType,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isActive,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clinicId != null) 'clinic_id': clinicId,
      if (fullName != null) 'full_name': fullName,
      if (phone != null) 'phone': phone,
      if (specialty != null) 'specialty': specialty,
      if (address != null) 'address': address,
      if (notes != null) 'notes': notes,
      if (profilePictureUrl != null) 'profile_picture_url': profilePictureUrl,
      if (monthlySalaryIqd != null) 'monthly_salary_iqd': monthlySalaryIqd,
      if (commissionPercent != null) 'commission_percent': commissionPercent,
      if (paymentType != null) 'payment_type': paymentType,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isActive != null) 'is_active': isActive,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalDoctorsCompanion copyWith({
    Value<String>? id,
    Value<String>? clinicId,
    Value<String>? fullName,
    Value<String?>? phone,
    Value<String?>? specialty,
    Value<String?>? address,
    Value<String?>? notes,
    Value<String?>? profilePictureUrl,
    Value<double>? monthlySalaryIqd,
    Value<double>? commissionPercent,
    Value<String>? paymentType,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<bool>? isActive,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return LocalDoctorsCompanion(
      id: id ?? this.id,
      clinicId: clinicId ?? this.clinicId,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      specialty: specialty ?? this.specialty,
      address: address ?? this.address,
      notes: notes ?? this.notes,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      monthlySalaryIqd: monthlySalaryIqd ?? this.monthlySalaryIqd,
      commissionPercent: commissionPercent ?? this.commissionPercent,
      paymentType: paymentType ?? this.paymentType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (clinicId.present) {
      map['clinic_id'] = Variable<String>(clinicId.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (specialty.present) {
      map['specialty'] = Variable<String>(specialty.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (profilePictureUrl.present) {
      map['profile_picture_url'] = Variable<String>(profilePictureUrl.value);
    }
    if (monthlySalaryIqd.present) {
      map['monthly_salary_iqd'] = Variable<double>(monthlySalaryIqd.value);
    }
    if (commissionPercent.present) {
      map['commission_percent'] = Variable<double>(commissionPercent.value);
    }
    if (paymentType.present) {
      map['payment_type'] = Variable<String>(paymentType.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalDoctorsCompanion(')
          ..write('id: $id, ')
          ..write('clinicId: $clinicId, ')
          ..write('fullName: $fullName, ')
          ..write('phone: $phone, ')
          ..write('specialty: $specialty, ')
          ..write('address: $address, ')
          ..write('notes: $notes, ')
          ..write('profilePictureUrl: $profilePictureUrl, ')
          ..write('monthlySalaryIqd: $monthlySalaryIqd, ')
          ..write('commissionPercent: $commissionPercent, ')
          ..write('paymentType: $paymentType, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isActive: $isActive, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalPaymentsTable extends LocalPayments
    with TableInfo<$LocalPaymentsTable, LocalPayment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalPaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clinicIdMeta = const VerificationMeta(
    'clinicId',
  );
  @override
  late final GeneratedColumn<String> clinicId = GeneratedColumn<String>(
    'clinic_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patientIdMeta = const VerificationMeta(
    'patientId',
  );
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
    'patient_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patientNameMeta = const VerificationMeta(
    'patientName',
  );
  @override
  late final GeneratedColumn<String> patientName = GeneratedColumn<String>(
    'patient_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _doctorIdMeta = const VerificationMeta(
    'doctorId',
  );
  @override
  late final GeneratedColumn<String> doctorId = GeneratedColumn<String>(
    'doctor_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _doctorNameMeta = const VerificationMeta(
    'doctorName',
  );
  @override
  late final GeneratedColumn<String> doctorName = GeneratedColumn<String>(
    'doctor_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _doctorShareMeta = const VerificationMeta(
    'doctorShare',
  );
  @override
  late final GeneratedColumn<double> doctorShare = GeneratedColumn<double>(
    'doctor_share',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _appointmentIdMeta = const VerificationMeta(
    'appointmentId',
  );
  @override
  late final GeneratedColumn<String> appointmentId = GeneratedColumn<String>(
    'appointment_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paidMeta = const VerificationMeta('paid');
  @override
  late final GeneratedColumn<double> paid = GeneratedColumn<double>(
    'paid',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remainingMeta = const VerificationMeta(
    'remaining',
  );
  @override
  late final GeneratedColumn<double> remaining = GeneratedColumn<double>(
    'remaining',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
    'method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentNotesMeta = const VerificationMeta(
    'paymentNotes',
  );
  @override
  late final GeneratedColumn<String> paymentNotes = GeneratedColumn<String>(
    'payment_notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
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
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clinicId,
    patientId,
    patientName,
    doctorId,
    doctorName,
    doctorShare,
    appointmentId,
    amount,
    paid,
    remaining,
    method,
    date,
    paymentNotes,
    createdBy,
    createdAt,
    updatedAt,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_payments';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalPayment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('clinic_id')) {
      context.handle(
        _clinicIdMeta,
        clinicId.isAcceptableOrUnknown(data['clinic_id']!, _clinicIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clinicIdMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(
        _patientIdMeta,
        patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('patient_name')) {
      context.handle(
        _patientNameMeta,
        patientName.isAcceptableOrUnknown(
          data['patient_name']!,
          _patientNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_patientNameMeta);
    }
    if (data.containsKey('doctor_id')) {
      context.handle(
        _doctorIdMeta,
        doctorId.isAcceptableOrUnknown(data['doctor_id']!, _doctorIdMeta),
      );
    }
    if (data.containsKey('doctor_name')) {
      context.handle(
        _doctorNameMeta,
        doctorName.isAcceptableOrUnknown(data['doctor_name']!, _doctorNameMeta),
      );
    }
    if (data.containsKey('doctor_share')) {
      context.handle(
        _doctorShareMeta,
        doctorShare.isAcceptableOrUnknown(
          data['doctor_share']!,
          _doctorShareMeta,
        ),
      );
    }
    if (data.containsKey('appointment_id')) {
      context.handle(
        _appointmentIdMeta,
        appointmentId.isAcceptableOrUnknown(
          data['appointment_id']!,
          _appointmentIdMeta,
        ),
      );
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('paid')) {
      context.handle(
        _paidMeta,
        paid.isAcceptableOrUnknown(data['paid']!, _paidMeta),
      );
    } else if (isInserting) {
      context.missing(_paidMeta);
    }
    if (data.containsKey('remaining')) {
      context.handle(
        _remainingMeta,
        remaining.isAcceptableOrUnknown(data['remaining']!, _remainingMeta),
      );
    } else if (isInserting) {
      context.missing(_remainingMeta);
    }
    if (data.containsKey('method')) {
      context.handle(
        _methodMeta,
        method.isAcceptableOrUnknown(data['method']!, _methodMeta),
      );
    } else if (isInserting) {
      context.missing(_methodMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('payment_notes')) {
      context.handle(
        _paymentNotesMeta,
        paymentNotes.isAcceptableOrUnknown(
          data['payment_notes']!,
          _paymentNotesMeta,
        ),
      );
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    } else if (isInserting) {
      context.missing(_createdByMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
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
  LocalPayment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalPayment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      clinicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}clinic_id'],
      )!,
      patientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_id'],
      )!,
      patientName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_name'],
      )!,
      doctorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}doctor_id'],
      ),
      doctorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}doctor_name'],
      ),
      doctorShare: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}doctor_share'],
      )!,
      appointmentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}appointment_id'],
      ),
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      paid: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}paid'],
      )!,
      remaining: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}remaining'],
      )!,
      method: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}method'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      paymentNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_notes'],
      ),
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $LocalPaymentsTable createAlias(String alias) {
    return $LocalPaymentsTable(attachedDatabase, alias);
  }
}

class LocalPayment extends DataClass implements Insertable<LocalPayment> {
  final String id;
  final String clinicId;
  final String patientId;
  final String patientName;
  final String? doctorId;
  final String? doctorName;
  final double doctorShare;
  final String? appointmentId;
  final double amount;
  final double paid;
  final double remaining;
  final String method;
  final DateTime date;
  final String? paymentNotes;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isSynced;
  const LocalPayment({
    required this.id,
    required this.clinicId,
    required this.patientId,
    required this.patientName,
    this.doctorId,
    this.doctorName,
    required this.doctorShare,
    this.appointmentId,
    required this.amount,
    required this.paid,
    required this.remaining,
    required this.method,
    required this.date,
    this.paymentNotes,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['clinic_id'] = Variable<String>(clinicId);
    map['patient_id'] = Variable<String>(patientId);
    map['patient_name'] = Variable<String>(patientName);
    if (!nullToAbsent || doctorId != null) {
      map['doctor_id'] = Variable<String>(doctorId);
    }
    if (!nullToAbsent || doctorName != null) {
      map['doctor_name'] = Variable<String>(doctorName);
    }
    map['doctor_share'] = Variable<double>(doctorShare);
    if (!nullToAbsent || appointmentId != null) {
      map['appointment_id'] = Variable<String>(appointmentId);
    }
    map['amount'] = Variable<double>(amount);
    map['paid'] = Variable<double>(paid);
    map['remaining'] = Variable<double>(remaining);
    map['method'] = Variable<String>(method);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || paymentNotes != null) {
      map['payment_notes'] = Variable<String>(paymentNotes);
    }
    map['created_by'] = Variable<String>(createdBy);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  LocalPaymentsCompanion toCompanion(bool nullToAbsent) {
    return LocalPaymentsCompanion(
      id: Value(id),
      clinicId: Value(clinicId),
      patientId: Value(patientId),
      patientName: Value(patientName),
      doctorId: doctorId == null && nullToAbsent
          ? const Value.absent()
          : Value(doctorId),
      doctorName: doctorName == null && nullToAbsent
          ? const Value.absent()
          : Value(doctorName),
      doctorShare: Value(doctorShare),
      appointmentId: appointmentId == null && nullToAbsent
          ? const Value.absent()
          : Value(appointmentId),
      amount: Value(amount),
      paid: Value(paid),
      remaining: Value(remaining),
      method: Value(method),
      date: Value(date),
      paymentNotes: paymentNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentNotes),
      createdBy: Value(createdBy),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isSynced: Value(isSynced),
    );
  }

  factory LocalPayment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalPayment(
      id: serializer.fromJson<String>(json['id']),
      clinicId: serializer.fromJson<String>(json['clinicId']),
      patientId: serializer.fromJson<String>(json['patientId']),
      patientName: serializer.fromJson<String>(json['patientName']),
      doctorId: serializer.fromJson<String?>(json['doctorId']),
      doctorName: serializer.fromJson<String?>(json['doctorName']),
      doctorShare: serializer.fromJson<double>(json['doctorShare']),
      appointmentId: serializer.fromJson<String?>(json['appointmentId']),
      amount: serializer.fromJson<double>(json['amount']),
      paid: serializer.fromJson<double>(json['paid']),
      remaining: serializer.fromJson<double>(json['remaining']),
      method: serializer.fromJson<String>(json['method']),
      date: serializer.fromJson<DateTime>(json['date']),
      paymentNotes: serializer.fromJson<String?>(json['paymentNotes']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'clinicId': serializer.toJson<String>(clinicId),
      'patientId': serializer.toJson<String>(patientId),
      'patientName': serializer.toJson<String>(patientName),
      'doctorId': serializer.toJson<String?>(doctorId),
      'doctorName': serializer.toJson<String?>(doctorName),
      'doctorShare': serializer.toJson<double>(doctorShare),
      'appointmentId': serializer.toJson<String?>(appointmentId),
      'amount': serializer.toJson<double>(amount),
      'paid': serializer.toJson<double>(paid),
      'remaining': serializer.toJson<double>(remaining),
      'method': serializer.toJson<String>(method),
      'date': serializer.toJson<DateTime>(date),
      'paymentNotes': serializer.toJson<String?>(paymentNotes),
      'createdBy': serializer.toJson<String>(createdBy),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  LocalPayment copyWith({
    String? id,
    String? clinicId,
    String? patientId,
    String? patientName,
    Value<String?> doctorId = const Value.absent(),
    Value<String?> doctorName = const Value.absent(),
    double? doctorShare,
    Value<String?> appointmentId = const Value.absent(),
    double? amount,
    double? paid,
    double? remaining,
    String? method,
    DateTime? date,
    Value<String?> paymentNotes = const Value.absent(),
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isSynced,
  }) => LocalPayment(
    id: id ?? this.id,
    clinicId: clinicId ?? this.clinicId,
    patientId: patientId ?? this.patientId,
    patientName: patientName ?? this.patientName,
    doctorId: doctorId.present ? doctorId.value : this.doctorId,
    doctorName: doctorName.present ? doctorName.value : this.doctorName,
    doctorShare: doctorShare ?? this.doctorShare,
    appointmentId: appointmentId.present
        ? appointmentId.value
        : this.appointmentId,
    amount: amount ?? this.amount,
    paid: paid ?? this.paid,
    remaining: remaining ?? this.remaining,
    method: method ?? this.method,
    date: date ?? this.date,
    paymentNotes: paymentNotes.present ? paymentNotes.value : this.paymentNotes,
    createdBy: createdBy ?? this.createdBy,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    isSynced: isSynced ?? this.isSynced,
  );
  LocalPayment copyWithCompanion(LocalPaymentsCompanion data) {
    return LocalPayment(
      id: data.id.present ? data.id.value : this.id,
      clinicId: data.clinicId.present ? data.clinicId.value : this.clinicId,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      patientName: data.patientName.present
          ? data.patientName.value
          : this.patientName,
      doctorId: data.doctorId.present ? data.doctorId.value : this.doctorId,
      doctorName: data.doctorName.present
          ? data.doctorName.value
          : this.doctorName,
      doctorShare: data.doctorShare.present
          ? data.doctorShare.value
          : this.doctorShare,
      appointmentId: data.appointmentId.present
          ? data.appointmentId.value
          : this.appointmentId,
      amount: data.amount.present ? data.amount.value : this.amount,
      paid: data.paid.present ? data.paid.value : this.paid,
      remaining: data.remaining.present ? data.remaining.value : this.remaining,
      method: data.method.present ? data.method.value : this.method,
      date: data.date.present ? data.date.value : this.date,
      paymentNotes: data.paymentNotes.present
          ? data.paymentNotes.value
          : this.paymentNotes,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalPayment(')
          ..write('id: $id, ')
          ..write('clinicId: $clinicId, ')
          ..write('patientId: $patientId, ')
          ..write('patientName: $patientName, ')
          ..write('doctorId: $doctorId, ')
          ..write('doctorName: $doctorName, ')
          ..write('doctorShare: $doctorShare, ')
          ..write('appointmentId: $appointmentId, ')
          ..write('amount: $amount, ')
          ..write('paid: $paid, ')
          ..write('remaining: $remaining, ')
          ..write('method: $method, ')
          ..write('date: $date, ')
          ..write('paymentNotes: $paymentNotes, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    clinicId,
    patientId,
    patientName,
    doctorId,
    doctorName,
    doctorShare,
    appointmentId,
    amount,
    paid,
    remaining,
    method,
    date,
    paymentNotes,
    createdBy,
    createdAt,
    updatedAt,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalPayment &&
          other.id == this.id &&
          other.clinicId == this.clinicId &&
          other.patientId == this.patientId &&
          other.patientName == this.patientName &&
          other.doctorId == this.doctorId &&
          other.doctorName == this.doctorName &&
          other.doctorShare == this.doctorShare &&
          other.appointmentId == this.appointmentId &&
          other.amount == this.amount &&
          other.paid == this.paid &&
          other.remaining == this.remaining &&
          other.method == this.method &&
          other.date == this.date &&
          other.paymentNotes == this.paymentNotes &&
          other.createdBy == this.createdBy &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isSynced == this.isSynced);
}

class LocalPaymentsCompanion extends UpdateCompanion<LocalPayment> {
  final Value<String> id;
  final Value<String> clinicId;
  final Value<String> patientId;
  final Value<String> patientName;
  final Value<String?> doctorId;
  final Value<String?> doctorName;
  final Value<double> doctorShare;
  final Value<String?> appointmentId;
  final Value<double> amount;
  final Value<double> paid;
  final Value<double> remaining;
  final Value<String> method;
  final Value<DateTime> date;
  final Value<String?> paymentNotes;
  final Value<String> createdBy;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const LocalPaymentsCompanion({
    this.id = const Value.absent(),
    this.clinicId = const Value.absent(),
    this.patientId = const Value.absent(),
    this.patientName = const Value.absent(),
    this.doctorId = const Value.absent(),
    this.doctorName = const Value.absent(),
    this.doctorShare = const Value.absent(),
    this.appointmentId = const Value.absent(),
    this.amount = const Value.absent(),
    this.paid = const Value.absent(),
    this.remaining = const Value.absent(),
    this.method = const Value.absent(),
    this.date = const Value.absent(),
    this.paymentNotes = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalPaymentsCompanion.insert({
    required String id,
    required String clinicId,
    required String patientId,
    required String patientName,
    this.doctorId = const Value.absent(),
    this.doctorName = const Value.absent(),
    this.doctorShare = const Value.absent(),
    this.appointmentId = const Value.absent(),
    required double amount,
    required double paid,
    required double remaining,
    required String method,
    required DateTime date,
    this.paymentNotes = const Value.absent(),
    required String createdBy,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       clinicId = Value(clinicId),
       patientId = Value(patientId),
       patientName = Value(patientName),
       amount = Value(amount),
       paid = Value(paid),
       remaining = Value(remaining),
       method = Value(method),
       date = Value(date),
       createdBy = Value(createdBy),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LocalPayment> custom({
    Expression<String>? id,
    Expression<String>? clinicId,
    Expression<String>? patientId,
    Expression<String>? patientName,
    Expression<String>? doctorId,
    Expression<String>? doctorName,
    Expression<double>? doctorShare,
    Expression<String>? appointmentId,
    Expression<double>? amount,
    Expression<double>? paid,
    Expression<double>? remaining,
    Expression<String>? method,
    Expression<DateTime>? date,
    Expression<String>? paymentNotes,
    Expression<String>? createdBy,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clinicId != null) 'clinic_id': clinicId,
      if (patientId != null) 'patient_id': patientId,
      if (patientName != null) 'patient_name': patientName,
      if (doctorId != null) 'doctor_id': doctorId,
      if (doctorName != null) 'doctor_name': doctorName,
      if (doctorShare != null) 'doctor_share': doctorShare,
      if (appointmentId != null) 'appointment_id': appointmentId,
      if (amount != null) 'amount': amount,
      if (paid != null) 'paid': paid,
      if (remaining != null) 'remaining': remaining,
      if (method != null) 'method': method,
      if (date != null) 'date': date,
      if (paymentNotes != null) 'payment_notes': paymentNotes,
      if (createdBy != null) 'created_by': createdBy,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalPaymentsCompanion copyWith({
    Value<String>? id,
    Value<String>? clinicId,
    Value<String>? patientId,
    Value<String>? patientName,
    Value<String?>? doctorId,
    Value<String?>? doctorName,
    Value<double>? doctorShare,
    Value<String?>? appointmentId,
    Value<double>? amount,
    Value<double>? paid,
    Value<double>? remaining,
    Value<String>? method,
    Value<DateTime>? date,
    Value<String?>? paymentNotes,
    Value<String>? createdBy,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return LocalPaymentsCompanion(
      id: id ?? this.id,
      clinicId: clinicId ?? this.clinicId,
      patientId: patientId ?? this.patientId,
      patientName: patientName ?? this.patientName,
      doctorId: doctorId ?? this.doctorId,
      doctorName: doctorName ?? this.doctorName,
      doctorShare: doctorShare ?? this.doctorShare,
      appointmentId: appointmentId ?? this.appointmentId,
      amount: amount ?? this.amount,
      paid: paid ?? this.paid,
      remaining: remaining ?? this.remaining,
      method: method ?? this.method,
      date: date ?? this.date,
      paymentNotes: paymentNotes ?? this.paymentNotes,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (clinicId.present) {
      map['clinic_id'] = Variable<String>(clinicId.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (patientName.present) {
      map['patient_name'] = Variable<String>(patientName.value);
    }
    if (doctorId.present) {
      map['doctor_id'] = Variable<String>(doctorId.value);
    }
    if (doctorName.present) {
      map['doctor_name'] = Variable<String>(doctorName.value);
    }
    if (doctorShare.present) {
      map['doctor_share'] = Variable<double>(doctorShare.value);
    }
    if (appointmentId.present) {
      map['appointment_id'] = Variable<String>(appointmentId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (paid.present) {
      map['paid'] = Variable<double>(paid.value);
    }
    if (remaining.present) {
      map['remaining'] = Variable<double>(remaining.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (paymentNotes.present) {
      map['payment_notes'] = Variable<String>(paymentNotes.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalPaymentsCompanion(')
          ..write('id: $id, ')
          ..write('clinicId: $clinicId, ')
          ..write('patientId: $patientId, ')
          ..write('patientName: $patientName, ')
          ..write('doctorId: $doctorId, ')
          ..write('doctorName: $doctorName, ')
          ..write('doctorShare: $doctorShare, ')
          ..write('appointmentId: $appointmentId, ')
          ..write('amount: $amount, ')
          ..write('paid: $paid, ')
          ..write('remaining: $remaining, ')
          ..write('method: $method, ')
          ..write('date: $date, ')
          ..write('paymentNotes: $paymentNotes, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalToothRecordsTable extends LocalToothRecords
    with TableInfo<$LocalToothRecordsTable, LocalToothRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalToothRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _docIdMeta = const VerificationMeta('docId');
  @override
  late final GeneratedColumn<String> docId = GeneratedColumn<String>(
    'doc_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patientIdMeta = const VerificationMeta(
    'patientId',
  );
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
    'patient_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _toothIdMeta = const VerificationMeta(
    'toothId',
  );
  @override
  late final GeneratedColumn<String> toothId = GeneratedColumn<String>(
    'tooth_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clinicIdMeta = const VerificationMeta(
    'clinicId',
  );
  @override
  late final GeneratedColumn<String> clinicId = GeneratedColumn<String>(
    'clinic_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('healthy'),
  );
  static const VerificationMeta _proceduresJsonMeta = const VerificationMeta(
    'proceduresJson',
  );
  @override
  late final GeneratedColumn<String> proceduresJson = GeneratedColumn<String>(
    'procedures_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _toothNotesMeta = const VerificationMeta(
    'toothNotes',
  );
  @override
  late final GeneratedColumn<String> toothNotes = GeneratedColumn<String>(
    'tooth_notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
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
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    docId,
    patientId,
    toothId,
    clinicId,
    status,
    proceduresJson,
    toothNotes,
    updatedAt,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_tooth_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalToothRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('doc_id')) {
      context.handle(
        _docIdMeta,
        docId.isAcceptableOrUnknown(data['doc_id']!, _docIdMeta),
      );
    } else if (isInserting) {
      context.missing(_docIdMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(
        _patientIdMeta,
        patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('tooth_id')) {
      context.handle(
        _toothIdMeta,
        toothId.isAcceptableOrUnknown(data['tooth_id']!, _toothIdMeta),
      );
    } else if (isInserting) {
      context.missing(_toothIdMeta);
    }
    if (data.containsKey('clinic_id')) {
      context.handle(
        _clinicIdMeta,
        clinicId.isAcceptableOrUnknown(data['clinic_id']!, _clinicIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clinicIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('procedures_json')) {
      context.handle(
        _proceduresJsonMeta,
        proceduresJson.isAcceptableOrUnknown(
          data['procedures_json']!,
          _proceduresJsonMeta,
        ),
      );
    }
    if (data.containsKey('tooth_notes')) {
      context.handle(
        _toothNotesMeta,
        toothNotes.isAcceptableOrUnknown(data['tooth_notes']!, _toothNotesMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
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
  Set<GeneratedColumn> get $primaryKey => {docId};
  @override
  LocalToothRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalToothRecord(
      docId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}doc_id'],
      )!,
      patientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_id'],
      )!,
      toothId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tooth_id'],
      )!,
      clinicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}clinic_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      proceduresJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}procedures_json'],
      )!,
      toothNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tooth_notes'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $LocalToothRecordsTable createAlias(String alias) {
    return $LocalToothRecordsTable(attachedDatabase, alias);
  }
}

class LocalToothRecord extends DataClass
    implements Insertable<LocalToothRecord> {
  final String docId;
  final String patientId;
  final String toothId;
  final String clinicId;
  final String status;
  final String proceduresJson;
  final String? toothNotes;
  final DateTime updatedAt;
  final bool isSynced;
  const LocalToothRecord({
    required this.docId,
    required this.patientId,
    required this.toothId,
    required this.clinicId,
    required this.status,
    required this.proceduresJson,
    this.toothNotes,
    required this.updatedAt,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['doc_id'] = Variable<String>(docId);
    map['patient_id'] = Variable<String>(patientId);
    map['tooth_id'] = Variable<String>(toothId);
    map['clinic_id'] = Variable<String>(clinicId);
    map['status'] = Variable<String>(status);
    map['procedures_json'] = Variable<String>(proceduresJson);
    if (!nullToAbsent || toothNotes != null) {
      map['tooth_notes'] = Variable<String>(toothNotes);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  LocalToothRecordsCompanion toCompanion(bool nullToAbsent) {
    return LocalToothRecordsCompanion(
      docId: Value(docId),
      patientId: Value(patientId),
      toothId: Value(toothId),
      clinicId: Value(clinicId),
      status: Value(status),
      proceduresJson: Value(proceduresJson),
      toothNotes: toothNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(toothNotes),
      updatedAt: Value(updatedAt),
      isSynced: Value(isSynced),
    );
  }

  factory LocalToothRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalToothRecord(
      docId: serializer.fromJson<String>(json['docId']),
      patientId: serializer.fromJson<String>(json['patientId']),
      toothId: serializer.fromJson<String>(json['toothId']),
      clinicId: serializer.fromJson<String>(json['clinicId']),
      status: serializer.fromJson<String>(json['status']),
      proceduresJson: serializer.fromJson<String>(json['proceduresJson']),
      toothNotes: serializer.fromJson<String?>(json['toothNotes']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'docId': serializer.toJson<String>(docId),
      'patientId': serializer.toJson<String>(patientId),
      'toothId': serializer.toJson<String>(toothId),
      'clinicId': serializer.toJson<String>(clinicId),
      'status': serializer.toJson<String>(status),
      'proceduresJson': serializer.toJson<String>(proceduresJson),
      'toothNotes': serializer.toJson<String?>(toothNotes),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  LocalToothRecord copyWith({
    String? docId,
    String? patientId,
    String? toothId,
    String? clinicId,
    String? status,
    String? proceduresJson,
    Value<String?> toothNotes = const Value.absent(),
    DateTime? updatedAt,
    bool? isSynced,
  }) => LocalToothRecord(
    docId: docId ?? this.docId,
    patientId: patientId ?? this.patientId,
    toothId: toothId ?? this.toothId,
    clinicId: clinicId ?? this.clinicId,
    status: status ?? this.status,
    proceduresJson: proceduresJson ?? this.proceduresJson,
    toothNotes: toothNotes.present ? toothNotes.value : this.toothNotes,
    updatedAt: updatedAt ?? this.updatedAt,
    isSynced: isSynced ?? this.isSynced,
  );
  LocalToothRecord copyWithCompanion(LocalToothRecordsCompanion data) {
    return LocalToothRecord(
      docId: data.docId.present ? data.docId.value : this.docId,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      toothId: data.toothId.present ? data.toothId.value : this.toothId,
      clinicId: data.clinicId.present ? data.clinicId.value : this.clinicId,
      status: data.status.present ? data.status.value : this.status,
      proceduresJson: data.proceduresJson.present
          ? data.proceduresJson.value
          : this.proceduresJson,
      toothNotes: data.toothNotes.present
          ? data.toothNotes.value
          : this.toothNotes,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalToothRecord(')
          ..write('docId: $docId, ')
          ..write('patientId: $patientId, ')
          ..write('toothId: $toothId, ')
          ..write('clinicId: $clinicId, ')
          ..write('status: $status, ')
          ..write('proceduresJson: $proceduresJson, ')
          ..write('toothNotes: $toothNotes, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    docId,
    patientId,
    toothId,
    clinicId,
    status,
    proceduresJson,
    toothNotes,
    updatedAt,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalToothRecord &&
          other.docId == this.docId &&
          other.patientId == this.patientId &&
          other.toothId == this.toothId &&
          other.clinicId == this.clinicId &&
          other.status == this.status &&
          other.proceduresJson == this.proceduresJson &&
          other.toothNotes == this.toothNotes &&
          other.updatedAt == this.updatedAt &&
          other.isSynced == this.isSynced);
}

class LocalToothRecordsCompanion extends UpdateCompanion<LocalToothRecord> {
  final Value<String> docId;
  final Value<String> patientId;
  final Value<String> toothId;
  final Value<String> clinicId;
  final Value<String> status;
  final Value<String> proceduresJson;
  final Value<String?> toothNotes;
  final Value<DateTime> updatedAt;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const LocalToothRecordsCompanion({
    this.docId = const Value.absent(),
    this.patientId = const Value.absent(),
    this.toothId = const Value.absent(),
    this.clinicId = const Value.absent(),
    this.status = const Value.absent(),
    this.proceduresJson = const Value.absent(),
    this.toothNotes = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalToothRecordsCompanion.insert({
    required String docId,
    required String patientId,
    required String toothId,
    required String clinicId,
    this.status = const Value.absent(),
    this.proceduresJson = const Value.absent(),
    this.toothNotes = const Value.absent(),
    required DateTime updatedAt,
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : docId = Value(docId),
       patientId = Value(patientId),
       toothId = Value(toothId),
       clinicId = Value(clinicId),
       updatedAt = Value(updatedAt);
  static Insertable<LocalToothRecord> custom({
    Expression<String>? docId,
    Expression<String>? patientId,
    Expression<String>? toothId,
    Expression<String>? clinicId,
    Expression<String>? status,
    Expression<String>? proceduresJson,
    Expression<String>? toothNotes,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (docId != null) 'doc_id': docId,
      if (patientId != null) 'patient_id': patientId,
      if (toothId != null) 'tooth_id': toothId,
      if (clinicId != null) 'clinic_id': clinicId,
      if (status != null) 'status': status,
      if (proceduresJson != null) 'procedures_json': proceduresJson,
      if (toothNotes != null) 'tooth_notes': toothNotes,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalToothRecordsCompanion copyWith({
    Value<String>? docId,
    Value<String>? patientId,
    Value<String>? toothId,
    Value<String>? clinicId,
    Value<String>? status,
    Value<String>? proceduresJson,
    Value<String?>? toothNotes,
    Value<DateTime>? updatedAt,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return LocalToothRecordsCompanion(
      docId: docId ?? this.docId,
      patientId: patientId ?? this.patientId,
      toothId: toothId ?? this.toothId,
      clinicId: clinicId ?? this.clinicId,
      status: status ?? this.status,
      proceduresJson: proceduresJson ?? this.proceduresJson,
      toothNotes: toothNotes ?? this.toothNotes,
      updatedAt: updatedAt ?? this.updatedAt,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (docId.present) {
      map['doc_id'] = Variable<String>(docId.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (toothId.present) {
      map['tooth_id'] = Variable<String>(toothId.value);
    }
    if (clinicId.present) {
      map['clinic_id'] = Variable<String>(clinicId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (proceduresJson.present) {
      map['procedures_json'] = Variable<String>(proceduresJson.value);
    }
    if (toothNotes.present) {
      map['tooth_notes'] = Variable<String>(toothNotes.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalToothRecordsCompanion(')
          ..write('docId: $docId, ')
          ..write('patientId: $patientId, ')
          ..write('toothId: $toothId, ')
          ..write('clinicId: $clinicId, ')
          ..write('status: $status, ')
          ..write('proceduresJson: $proceduresJson, ')
          ..write('toothNotes: $toothNotes, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalDentalPlansTable extends LocalDentalPlans
    with TableInfo<$LocalDentalPlansTable, LocalDentalPlan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalDentalPlansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clinicIdMeta = const VerificationMeta(
    'clinicId',
  );
  @override
  late final GeneratedColumn<String> clinicId = GeneratedColumn<String>(
    'clinic_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patientIdMeta = const VerificationMeta(
    'patientId',
  );
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
    'patient_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _toothIdMeta = const VerificationMeta(
    'toothId',
  );
  @override
  late final GeneratedColumn<String> toothId = GeneratedColumn<String>(
    'tooth_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numberingSystemMeta = const VerificationMeta(
    'numberingSystem',
  );
  @override
  late final GeneratedColumn<String> numberingSystem = GeneratedColumn<String>(
    'numbering_system',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actionLabelMeta = const VerificationMeta(
    'actionLabel',
  );
  @override
  late final GeneratedColumn<String> actionLabel = GeneratedColumn<String>(
    'action_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _doctorIdMeta = const VerificationMeta(
    'doctorId',
  );
  @override
  late final GeneratedColumn<String> doctorId = GeneratedColumn<String>(
    'doctor_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clinicId,
    patientId,
    toothId,
    numberingSystem,
    actionLabel,
    note,
    timestamp,
    doctorId,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_dental_plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalDentalPlan> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('clinic_id')) {
      context.handle(
        _clinicIdMeta,
        clinicId.isAcceptableOrUnknown(data['clinic_id']!, _clinicIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clinicIdMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(
        _patientIdMeta,
        patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('tooth_id')) {
      context.handle(
        _toothIdMeta,
        toothId.isAcceptableOrUnknown(data['tooth_id']!, _toothIdMeta),
      );
    } else if (isInserting) {
      context.missing(_toothIdMeta);
    }
    if (data.containsKey('numbering_system')) {
      context.handle(
        _numberingSystemMeta,
        numberingSystem.isAcceptableOrUnknown(
          data['numbering_system']!,
          _numberingSystemMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_numberingSystemMeta);
    }
    if (data.containsKey('action_label')) {
      context.handle(
        _actionLabelMeta,
        actionLabel.isAcceptableOrUnknown(
          data['action_label']!,
          _actionLabelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_actionLabelMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    } else if (isInserting) {
      context.missing(_noteMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('doctor_id')) {
      context.handle(
        _doctorIdMeta,
        doctorId.isAcceptableOrUnknown(data['doctor_id']!, _doctorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_doctorIdMeta);
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
  LocalDentalPlan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalDentalPlan(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      clinicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}clinic_id'],
      )!,
      patientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_id'],
      )!,
      toothId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tooth_id'],
      )!,
      numberingSystem: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}numbering_system'],
      )!,
      actionLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action_label'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      doctorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}doctor_id'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $LocalDentalPlansTable createAlias(String alias) {
    return $LocalDentalPlansTable(attachedDatabase, alias);
  }
}

class LocalDentalPlan extends DataClass implements Insertable<LocalDentalPlan> {
  final String id;
  final String clinicId;
  final String patientId;
  final String toothId;
  final String numberingSystem;
  final String actionLabel;
  final String note;
  final DateTime timestamp;
  final String doctorId;
  final bool isSynced;
  const LocalDentalPlan({
    required this.id,
    required this.clinicId,
    required this.patientId,
    required this.toothId,
    required this.numberingSystem,
    required this.actionLabel,
    required this.note,
    required this.timestamp,
    required this.doctorId,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['clinic_id'] = Variable<String>(clinicId);
    map['patient_id'] = Variable<String>(patientId);
    map['tooth_id'] = Variable<String>(toothId);
    map['numbering_system'] = Variable<String>(numberingSystem);
    map['action_label'] = Variable<String>(actionLabel);
    map['note'] = Variable<String>(note);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['doctor_id'] = Variable<String>(doctorId);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  LocalDentalPlansCompanion toCompanion(bool nullToAbsent) {
    return LocalDentalPlansCompanion(
      id: Value(id),
      clinicId: Value(clinicId),
      patientId: Value(patientId),
      toothId: Value(toothId),
      numberingSystem: Value(numberingSystem),
      actionLabel: Value(actionLabel),
      note: Value(note),
      timestamp: Value(timestamp),
      doctorId: Value(doctorId),
      isSynced: Value(isSynced),
    );
  }

  factory LocalDentalPlan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalDentalPlan(
      id: serializer.fromJson<String>(json['id']),
      clinicId: serializer.fromJson<String>(json['clinicId']),
      patientId: serializer.fromJson<String>(json['patientId']),
      toothId: serializer.fromJson<String>(json['toothId']),
      numberingSystem: serializer.fromJson<String>(json['numberingSystem']),
      actionLabel: serializer.fromJson<String>(json['actionLabel']),
      note: serializer.fromJson<String>(json['note']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      doctorId: serializer.fromJson<String>(json['doctorId']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'clinicId': serializer.toJson<String>(clinicId),
      'patientId': serializer.toJson<String>(patientId),
      'toothId': serializer.toJson<String>(toothId),
      'numberingSystem': serializer.toJson<String>(numberingSystem),
      'actionLabel': serializer.toJson<String>(actionLabel),
      'note': serializer.toJson<String>(note),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'doctorId': serializer.toJson<String>(doctorId),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  LocalDentalPlan copyWith({
    String? id,
    String? clinicId,
    String? patientId,
    String? toothId,
    String? numberingSystem,
    String? actionLabel,
    String? note,
    DateTime? timestamp,
    String? doctorId,
    bool? isSynced,
  }) => LocalDentalPlan(
    id: id ?? this.id,
    clinicId: clinicId ?? this.clinicId,
    patientId: patientId ?? this.patientId,
    toothId: toothId ?? this.toothId,
    numberingSystem: numberingSystem ?? this.numberingSystem,
    actionLabel: actionLabel ?? this.actionLabel,
    note: note ?? this.note,
    timestamp: timestamp ?? this.timestamp,
    doctorId: doctorId ?? this.doctorId,
    isSynced: isSynced ?? this.isSynced,
  );
  LocalDentalPlan copyWithCompanion(LocalDentalPlansCompanion data) {
    return LocalDentalPlan(
      id: data.id.present ? data.id.value : this.id,
      clinicId: data.clinicId.present ? data.clinicId.value : this.clinicId,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      toothId: data.toothId.present ? data.toothId.value : this.toothId,
      numberingSystem: data.numberingSystem.present
          ? data.numberingSystem.value
          : this.numberingSystem,
      actionLabel: data.actionLabel.present
          ? data.actionLabel.value
          : this.actionLabel,
      note: data.note.present ? data.note.value : this.note,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      doctorId: data.doctorId.present ? data.doctorId.value : this.doctorId,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalDentalPlan(')
          ..write('id: $id, ')
          ..write('clinicId: $clinicId, ')
          ..write('patientId: $patientId, ')
          ..write('toothId: $toothId, ')
          ..write('numberingSystem: $numberingSystem, ')
          ..write('actionLabel: $actionLabel, ')
          ..write('note: $note, ')
          ..write('timestamp: $timestamp, ')
          ..write('doctorId: $doctorId, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    clinicId,
    patientId,
    toothId,
    numberingSystem,
    actionLabel,
    note,
    timestamp,
    doctorId,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalDentalPlan &&
          other.id == this.id &&
          other.clinicId == this.clinicId &&
          other.patientId == this.patientId &&
          other.toothId == this.toothId &&
          other.numberingSystem == this.numberingSystem &&
          other.actionLabel == this.actionLabel &&
          other.note == this.note &&
          other.timestamp == this.timestamp &&
          other.doctorId == this.doctorId &&
          other.isSynced == this.isSynced);
}

class LocalDentalPlansCompanion extends UpdateCompanion<LocalDentalPlan> {
  final Value<String> id;
  final Value<String> clinicId;
  final Value<String> patientId;
  final Value<String> toothId;
  final Value<String> numberingSystem;
  final Value<String> actionLabel;
  final Value<String> note;
  final Value<DateTime> timestamp;
  final Value<String> doctorId;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const LocalDentalPlansCompanion({
    this.id = const Value.absent(),
    this.clinicId = const Value.absent(),
    this.patientId = const Value.absent(),
    this.toothId = const Value.absent(),
    this.numberingSystem = const Value.absent(),
    this.actionLabel = const Value.absent(),
    this.note = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.doctorId = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalDentalPlansCompanion.insert({
    required String id,
    required String clinicId,
    required String patientId,
    required String toothId,
    required String numberingSystem,
    required String actionLabel,
    required String note,
    required DateTime timestamp,
    required String doctorId,
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       clinicId = Value(clinicId),
       patientId = Value(patientId),
       toothId = Value(toothId),
       numberingSystem = Value(numberingSystem),
       actionLabel = Value(actionLabel),
       note = Value(note),
       timestamp = Value(timestamp),
       doctorId = Value(doctorId);
  static Insertable<LocalDentalPlan> custom({
    Expression<String>? id,
    Expression<String>? clinicId,
    Expression<String>? patientId,
    Expression<String>? toothId,
    Expression<String>? numberingSystem,
    Expression<String>? actionLabel,
    Expression<String>? note,
    Expression<DateTime>? timestamp,
    Expression<String>? doctorId,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clinicId != null) 'clinic_id': clinicId,
      if (patientId != null) 'patient_id': patientId,
      if (toothId != null) 'tooth_id': toothId,
      if (numberingSystem != null) 'numbering_system': numberingSystem,
      if (actionLabel != null) 'action_label': actionLabel,
      if (note != null) 'note': note,
      if (timestamp != null) 'timestamp': timestamp,
      if (doctorId != null) 'doctor_id': doctorId,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalDentalPlansCompanion copyWith({
    Value<String>? id,
    Value<String>? clinicId,
    Value<String>? patientId,
    Value<String>? toothId,
    Value<String>? numberingSystem,
    Value<String>? actionLabel,
    Value<String>? note,
    Value<DateTime>? timestamp,
    Value<String>? doctorId,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return LocalDentalPlansCompanion(
      id: id ?? this.id,
      clinicId: clinicId ?? this.clinicId,
      patientId: patientId ?? this.patientId,
      toothId: toothId ?? this.toothId,
      numberingSystem: numberingSystem ?? this.numberingSystem,
      actionLabel: actionLabel ?? this.actionLabel,
      note: note ?? this.note,
      timestamp: timestamp ?? this.timestamp,
      doctorId: doctorId ?? this.doctorId,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (clinicId.present) {
      map['clinic_id'] = Variable<String>(clinicId.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (toothId.present) {
      map['tooth_id'] = Variable<String>(toothId.value);
    }
    if (numberingSystem.present) {
      map['numbering_system'] = Variable<String>(numberingSystem.value);
    }
    if (actionLabel.present) {
      map['action_label'] = Variable<String>(actionLabel.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (doctorId.present) {
      map['doctor_id'] = Variable<String>(doctorId.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalDentalPlansCompanion(')
          ..write('id: $id, ')
          ..write('clinicId: $clinicId, ')
          ..write('patientId: $patientId, ')
          ..write('toothId: $toothId, ')
          ..write('numberingSystem: $numberingSystem, ')
          ..write('actionLabel: $actionLabel, ')
          ..write('note: $note, ')
          ..write('timestamp: $timestamp, ')
          ..write('doctorId: $doctorId, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalClinicsTable extends LocalClinics
    with TableInfo<$LocalClinicsTable, LocalClinic> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalClinicsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
    'city',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _districtMeta = const VerificationMeta(
    'district',
  );
  @override
  late final GeneratedColumn<String> district = GeneratedColumn<String>(
    'district',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _expiresAtMeta = const VerificationMeta(
    'expiresAt',
  );
  @override
  late final GeneratedColumn<DateTime> expiresAt = GeneratedColumn<DateTime>(
    'expires_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _reactivationHistoryJsonMeta =
      const VerificationMeta('reactivationHistoryJson');
  @override
  late final GeneratedColumn<String> reactivationHistoryJson =
      GeneratedColumn<String>(
        'reactivation_history_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
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
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    phone,
    city,
    district,
    address,
    updatedAt,
    createdAt,
    expiresAt,
    active,
    reactivationHistoryJson,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_clinics';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalClinic> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('city')) {
      context.handle(
        _cityMeta,
        city.isAcceptableOrUnknown(data['city']!, _cityMeta),
      );
    }
    if (data.containsKey('district')) {
      context.handle(
        _districtMeta,
        district.isAcceptableOrUnknown(data['district']!, _districtMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    }
    if (data.containsKey('reactivation_history_json')) {
      context.handle(
        _reactivationHistoryJsonMeta,
        reactivationHistoryJson.isAcceptableOrUnknown(
          data['reactivation_history_json']!,
          _reactivationHistoryJsonMeta,
        ),
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
  LocalClinic map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalClinic(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      city: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city'],
      ),
      district: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}district'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      ),
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expires_at'],
      ),
      active: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}active'],
      )!,
      reactivationHistoryJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reactivation_history_json'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $LocalClinicsTable createAlias(String alias) {
    return $LocalClinicsTable(attachedDatabase, alias);
  }
}

class LocalClinic extends DataClass implements Insertable<LocalClinic> {
  final String id;
  final String name;
  final String? phone;
  final String? city;
  final String? district;
  final String? address;
  final DateTime updatedAt;
  final DateTime? createdAt;
  final DateTime? expiresAt;
  final bool active;
  final String reactivationHistoryJson;
  final bool isSynced;
  const LocalClinic({
    required this.id,
    required this.name,
    this.phone,
    this.city,
    this.district,
    this.address,
    required this.updatedAt,
    this.createdAt,
    this.expiresAt,
    required this.active,
    required this.reactivationHistoryJson,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || city != null) {
      map['city'] = Variable<String>(city);
    }
    if (!nullToAbsent || district != null) {
      map['district'] = Variable<String>(district);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || expiresAt != null) {
      map['expires_at'] = Variable<DateTime>(expiresAt);
    }
    map['active'] = Variable<bool>(active);
    map['reactivation_history_json'] = Variable<String>(
      reactivationHistoryJson,
    );
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  LocalClinicsCompanion toCompanion(bool nullToAbsent) {
    return LocalClinicsCompanion(
      id: Value(id),
      name: Value(name),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      city: city == null && nullToAbsent ? const Value.absent() : Value(city),
      district: district == null && nullToAbsent
          ? const Value.absent()
          : Value(district),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      updatedAt: Value(updatedAt),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      expiresAt: expiresAt == null && nullToAbsent
          ? const Value.absent()
          : Value(expiresAt),
      active: Value(active),
      reactivationHistoryJson: Value(reactivationHistoryJson),
      isSynced: Value(isSynced),
    );
  }

  factory LocalClinic.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalClinic(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      city: serializer.fromJson<String?>(json['city']),
      district: serializer.fromJson<String?>(json['district']),
      address: serializer.fromJson<String?>(json['address']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      expiresAt: serializer.fromJson<DateTime?>(json['expiresAt']),
      active: serializer.fromJson<bool>(json['active']),
      reactivationHistoryJson: serializer.fromJson<String>(
        json['reactivationHistoryJson'],
      ),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String?>(phone),
      'city': serializer.toJson<String?>(city),
      'district': serializer.toJson<String?>(district),
      'address': serializer.toJson<String?>(address),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'expiresAt': serializer.toJson<DateTime?>(expiresAt),
      'active': serializer.toJson<bool>(active),
      'reactivationHistoryJson': serializer.toJson<String>(
        reactivationHistoryJson,
      ),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  LocalClinic copyWith({
    String? id,
    String? name,
    Value<String?> phone = const Value.absent(),
    Value<String?> city = const Value.absent(),
    Value<String?> district = const Value.absent(),
    Value<String?> address = const Value.absent(),
    DateTime? updatedAt,
    Value<DateTime?> createdAt = const Value.absent(),
    Value<DateTime?> expiresAt = const Value.absent(),
    bool? active,
    String? reactivationHistoryJson,
    bool? isSynced,
  }) => LocalClinic(
    id: id ?? this.id,
    name: name ?? this.name,
    phone: phone.present ? phone.value : this.phone,
    city: city.present ? city.value : this.city,
    district: district.present ? district.value : this.district,
    address: address.present ? address.value : this.address,
    updatedAt: updatedAt ?? this.updatedAt,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
    expiresAt: expiresAt.present ? expiresAt.value : this.expiresAt,
    active: active ?? this.active,
    reactivationHistoryJson:
        reactivationHistoryJson ?? this.reactivationHistoryJson,
    isSynced: isSynced ?? this.isSynced,
  );
  LocalClinic copyWithCompanion(LocalClinicsCompanion data) {
    return LocalClinic(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      city: data.city.present ? data.city.value : this.city,
      district: data.district.present ? data.district.value : this.district,
      address: data.address.present ? data.address.value : this.address,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
      active: data.active.present ? data.active.value : this.active,
      reactivationHistoryJson: data.reactivationHistoryJson.present
          ? data.reactivationHistoryJson.value
          : this.reactivationHistoryJson,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalClinic(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('city: $city, ')
          ..write('district: $district, ')
          ..write('address: $address, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('active: $active, ')
          ..write('reactivationHistoryJson: $reactivationHistoryJson, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    phone,
    city,
    district,
    address,
    updatedAt,
    createdAt,
    expiresAt,
    active,
    reactivationHistoryJson,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalClinic &&
          other.id == this.id &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.city == this.city &&
          other.district == this.district &&
          other.address == this.address &&
          other.updatedAt == this.updatedAt &&
          other.createdAt == this.createdAt &&
          other.expiresAt == this.expiresAt &&
          other.active == this.active &&
          other.reactivationHistoryJson == this.reactivationHistoryJson &&
          other.isSynced == this.isSynced);
}

class LocalClinicsCompanion extends UpdateCompanion<LocalClinic> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> phone;
  final Value<String?> city;
  final Value<String?> district;
  final Value<String?> address;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> expiresAt;
  final Value<bool> active;
  final Value<String> reactivationHistoryJson;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const LocalClinicsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.city = const Value.absent(),
    this.district = const Value.absent(),
    this.address = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.active = const Value.absent(),
    this.reactivationHistoryJson = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalClinicsCompanion.insert({
    required String id,
    required String name,
    this.phone = const Value.absent(),
    this.city = const Value.absent(),
    this.district = const Value.absent(),
    this.address = const Value.absent(),
    required DateTime updatedAt,
    this.createdAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.active = const Value.absent(),
    this.reactivationHistoryJson = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       updatedAt = Value(updatedAt);
  static Insertable<LocalClinic> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? city,
    Expression<String>? district,
    Expression<String>? address,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? expiresAt,
    Expression<bool>? active,
    Expression<String>? reactivationHistoryJson,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (city != null) 'city': city,
      if (district != null) 'district': district,
      if (address != null) 'address': address,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (active != null) 'active': active,
      if (reactivationHistoryJson != null)
        'reactivation_history_json': reactivationHistoryJson,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalClinicsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? phone,
    Value<String?>? city,
    Value<String?>? district,
    Value<String?>? address,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? createdAt,
    Value<DateTime?>? expiresAt,
    Value<bool>? active,
    Value<String>? reactivationHistoryJson,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return LocalClinicsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      city: city ?? this.city,
      district: district ?? this.district,
      address: address ?? this.address,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
      active: active ?? this.active,
      reactivationHistoryJson:
          reactivationHistoryJson ?? this.reactivationHistoryJson,
      isSynced: isSynced ?? this.isSynced,
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
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (district.present) {
      map['district'] = Variable<String>(district.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (reactivationHistoryJson.present) {
      map['reactivation_history_json'] = Variable<String>(
        reactivationHistoryJson.value,
      );
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalClinicsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('city: $city, ')
          ..write('district: $district, ')
          ..write('address: $address, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('active: $active, ')
          ..write('reactivationHistoryJson: $reactivationHistoryJson, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalClinicSettingsTable extends LocalClinicSettings
    with TableInfo<$LocalClinicSettingsTable, LocalClinicSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalClinicSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _clinicIdMeta = const VerificationMeta(
    'clinicId',
  );
  @override
  late final GeneratedColumn<String> clinicId = GeneratedColumn<String>(
    'clinic_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reminderOffsetHoursMeta =
      const VerificationMeta('reminderOffsetHours');
  @override
  late final GeneratedColumn<int> reminderOffsetHours = GeneratedColumn<int>(
    'reminder_offset_hours',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2),
  );
  static const VerificationMeta _teethNumberingSystemMeta =
      const VerificationMeta('teethNumberingSystem');
  @override
  late final GeneratedColumn<String> teethNumberingSystem =
      GeneratedColumn<String>(
        'teeth_numbering_system',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('fdi'),
      );
  static const VerificationMeta _toothActionsJsonMeta = const VerificationMeta(
    'toothActionsJson',
  );
  @override
  late final GeneratedColumn<String> toothActionsJson = GeneratedColumn<String>(
    'tooth_actions_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(
      '["Extraction","Filling","Cleaning","Orthodontics","Root canal"]',
    ),
  );
  static const VerificationMeta _whatsAppEnabledMeta = const VerificationMeta(
    'whatsAppEnabled',
  );
  @override
  late final GeneratedColumn<bool> whatsAppEnabled = GeneratedColumn<bool>(
    'whats_app_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("whats_app_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _whatsAppSenderNumberMeta =
      const VerificationMeta('whatsAppSenderNumber');
  @override
  late final GeneratedColumn<String> whatsAppSenderNumber =
      GeneratedColumn<String>(
        'whats_app_sender_number',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _whatsAppPhoneNumberIdMeta =
      const VerificationMeta('whatsAppPhoneNumberId');
  @override
  late final GeneratedColumn<String> whatsAppPhoneNumberId =
      GeneratedColumn<String>(
        'whats_app_phone_number_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _smsEnabledMeta = const VerificationMeta(
    'smsEnabled',
  );
  @override
  late final GeneratedColumn<bool> smsEnabled = GeneratedColumn<bool>(
    'sms_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("sms_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _emailEnabledMeta = const VerificationMeta(
    'emailEnabled',
  );
  @override
  late final GeneratedColumn<bool> emailEnabled = GeneratedColumn<bool>(
    'email_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("email_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _phoneAuthEnabledMeta = const VerificationMeta(
    'phoneAuthEnabled',
  );
  @override
  late final GeneratedColumn<bool> phoneAuthEnabled = GeneratedColumn<bool>(
    'phone_auth_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("phone_auth_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    clinicId,
    reminderOffsetHours,
    teethNumberingSystem,
    toothActionsJson,
    whatsAppEnabled,
    whatsAppSenderNumber,
    whatsAppPhoneNumberId,
    smsEnabled,
    emailEnabled,
    phoneAuthEnabled,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_clinic_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalClinicSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('clinic_id')) {
      context.handle(
        _clinicIdMeta,
        clinicId.isAcceptableOrUnknown(data['clinic_id']!, _clinicIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clinicIdMeta);
    }
    if (data.containsKey('reminder_offset_hours')) {
      context.handle(
        _reminderOffsetHoursMeta,
        reminderOffsetHours.isAcceptableOrUnknown(
          data['reminder_offset_hours']!,
          _reminderOffsetHoursMeta,
        ),
      );
    }
    if (data.containsKey('teeth_numbering_system')) {
      context.handle(
        _teethNumberingSystemMeta,
        teethNumberingSystem.isAcceptableOrUnknown(
          data['teeth_numbering_system']!,
          _teethNumberingSystemMeta,
        ),
      );
    }
    if (data.containsKey('tooth_actions_json')) {
      context.handle(
        _toothActionsJsonMeta,
        toothActionsJson.isAcceptableOrUnknown(
          data['tooth_actions_json']!,
          _toothActionsJsonMeta,
        ),
      );
    }
    if (data.containsKey('whats_app_enabled')) {
      context.handle(
        _whatsAppEnabledMeta,
        whatsAppEnabled.isAcceptableOrUnknown(
          data['whats_app_enabled']!,
          _whatsAppEnabledMeta,
        ),
      );
    }
    if (data.containsKey('whats_app_sender_number')) {
      context.handle(
        _whatsAppSenderNumberMeta,
        whatsAppSenderNumber.isAcceptableOrUnknown(
          data['whats_app_sender_number']!,
          _whatsAppSenderNumberMeta,
        ),
      );
    }
    if (data.containsKey('whats_app_phone_number_id')) {
      context.handle(
        _whatsAppPhoneNumberIdMeta,
        whatsAppPhoneNumberId.isAcceptableOrUnknown(
          data['whats_app_phone_number_id']!,
          _whatsAppPhoneNumberIdMeta,
        ),
      );
    }
    if (data.containsKey('sms_enabled')) {
      context.handle(
        _smsEnabledMeta,
        smsEnabled.isAcceptableOrUnknown(data['sms_enabled']!, _smsEnabledMeta),
      );
    }
    if (data.containsKey('email_enabled')) {
      context.handle(
        _emailEnabledMeta,
        emailEnabled.isAcceptableOrUnknown(
          data['email_enabled']!,
          _emailEnabledMeta,
        ),
      );
    }
    if (data.containsKey('phone_auth_enabled')) {
      context.handle(
        _phoneAuthEnabledMeta,
        phoneAuthEnabled.isAcceptableOrUnknown(
          data['phone_auth_enabled']!,
          _phoneAuthEnabledMeta,
        ),
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
  Set<GeneratedColumn> get $primaryKey => {clinicId};
  @override
  LocalClinicSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalClinicSetting(
      clinicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}clinic_id'],
      )!,
      reminderOffsetHours: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reminder_offset_hours'],
      )!,
      teethNumberingSystem: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}teeth_numbering_system'],
      )!,
      toothActionsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tooth_actions_json'],
      )!,
      whatsAppEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}whats_app_enabled'],
      )!,
      whatsAppSenderNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}whats_app_sender_number'],
      ),
      whatsAppPhoneNumberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}whats_app_phone_number_id'],
      ),
      smsEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}sms_enabled'],
      )!,
      emailEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}email_enabled'],
      )!,
      phoneAuthEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}phone_auth_enabled'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $LocalClinicSettingsTable createAlias(String alias) {
    return $LocalClinicSettingsTable(attachedDatabase, alias);
  }
}

class LocalClinicSetting extends DataClass
    implements Insertable<LocalClinicSetting> {
  final String clinicId;
  final int reminderOffsetHours;
  final String teethNumberingSystem;
  final String toothActionsJson;
  final bool whatsAppEnabled;
  final String? whatsAppSenderNumber;
  final String? whatsAppPhoneNumberId;
  final bool smsEnabled;
  final bool emailEnabled;
  final bool phoneAuthEnabled;
  final bool isSynced;
  const LocalClinicSetting({
    required this.clinicId,
    required this.reminderOffsetHours,
    required this.teethNumberingSystem,
    required this.toothActionsJson,
    required this.whatsAppEnabled,
    this.whatsAppSenderNumber,
    this.whatsAppPhoneNumberId,
    required this.smsEnabled,
    required this.emailEnabled,
    required this.phoneAuthEnabled,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['clinic_id'] = Variable<String>(clinicId);
    map['reminder_offset_hours'] = Variable<int>(reminderOffsetHours);
    map['teeth_numbering_system'] = Variable<String>(teethNumberingSystem);
    map['tooth_actions_json'] = Variable<String>(toothActionsJson);
    map['whats_app_enabled'] = Variable<bool>(whatsAppEnabled);
    if (!nullToAbsent || whatsAppSenderNumber != null) {
      map['whats_app_sender_number'] = Variable<String>(whatsAppSenderNumber);
    }
    if (!nullToAbsent || whatsAppPhoneNumberId != null) {
      map['whats_app_phone_number_id'] = Variable<String>(
        whatsAppPhoneNumberId,
      );
    }
    map['sms_enabled'] = Variable<bool>(smsEnabled);
    map['email_enabled'] = Variable<bool>(emailEnabled);
    map['phone_auth_enabled'] = Variable<bool>(phoneAuthEnabled);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  LocalClinicSettingsCompanion toCompanion(bool nullToAbsent) {
    return LocalClinicSettingsCompanion(
      clinicId: Value(clinicId),
      reminderOffsetHours: Value(reminderOffsetHours),
      teethNumberingSystem: Value(teethNumberingSystem),
      toothActionsJson: Value(toothActionsJson),
      whatsAppEnabled: Value(whatsAppEnabled),
      whatsAppSenderNumber: whatsAppSenderNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(whatsAppSenderNumber),
      whatsAppPhoneNumberId: whatsAppPhoneNumberId == null && nullToAbsent
          ? const Value.absent()
          : Value(whatsAppPhoneNumberId),
      smsEnabled: Value(smsEnabled),
      emailEnabled: Value(emailEnabled),
      phoneAuthEnabled: Value(phoneAuthEnabled),
      isSynced: Value(isSynced),
    );
  }

  factory LocalClinicSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalClinicSetting(
      clinicId: serializer.fromJson<String>(json['clinicId']),
      reminderOffsetHours: serializer.fromJson<int>(
        json['reminderOffsetHours'],
      ),
      teethNumberingSystem: serializer.fromJson<String>(
        json['teethNumberingSystem'],
      ),
      toothActionsJson: serializer.fromJson<String>(json['toothActionsJson']),
      whatsAppEnabled: serializer.fromJson<bool>(json['whatsAppEnabled']),
      whatsAppSenderNumber: serializer.fromJson<String?>(
        json['whatsAppSenderNumber'],
      ),
      whatsAppPhoneNumberId: serializer.fromJson<String?>(
        json['whatsAppPhoneNumberId'],
      ),
      smsEnabled: serializer.fromJson<bool>(json['smsEnabled']),
      emailEnabled: serializer.fromJson<bool>(json['emailEnabled']),
      phoneAuthEnabled: serializer.fromJson<bool>(json['phoneAuthEnabled']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'clinicId': serializer.toJson<String>(clinicId),
      'reminderOffsetHours': serializer.toJson<int>(reminderOffsetHours),
      'teethNumberingSystem': serializer.toJson<String>(teethNumberingSystem),
      'toothActionsJson': serializer.toJson<String>(toothActionsJson),
      'whatsAppEnabled': serializer.toJson<bool>(whatsAppEnabled),
      'whatsAppSenderNumber': serializer.toJson<String?>(whatsAppSenderNumber),
      'whatsAppPhoneNumberId': serializer.toJson<String?>(
        whatsAppPhoneNumberId,
      ),
      'smsEnabled': serializer.toJson<bool>(smsEnabled),
      'emailEnabled': serializer.toJson<bool>(emailEnabled),
      'phoneAuthEnabled': serializer.toJson<bool>(phoneAuthEnabled),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  LocalClinicSetting copyWith({
    String? clinicId,
    int? reminderOffsetHours,
    String? teethNumberingSystem,
    String? toothActionsJson,
    bool? whatsAppEnabled,
    Value<String?> whatsAppSenderNumber = const Value.absent(),
    Value<String?> whatsAppPhoneNumberId = const Value.absent(),
    bool? smsEnabled,
    bool? emailEnabled,
    bool? phoneAuthEnabled,
    bool? isSynced,
  }) => LocalClinicSetting(
    clinicId: clinicId ?? this.clinicId,
    reminderOffsetHours: reminderOffsetHours ?? this.reminderOffsetHours,
    teethNumberingSystem: teethNumberingSystem ?? this.teethNumberingSystem,
    toothActionsJson: toothActionsJson ?? this.toothActionsJson,
    whatsAppEnabled: whatsAppEnabled ?? this.whatsAppEnabled,
    whatsAppSenderNumber: whatsAppSenderNumber.present
        ? whatsAppSenderNumber.value
        : this.whatsAppSenderNumber,
    whatsAppPhoneNumberId: whatsAppPhoneNumberId.present
        ? whatsAppPhoneNumberId.value
        : this.whatsAppPhoneNumberId,
    smsEnabled: smsEnabled ?? this.smsEnabled,
    emailEnabled: emailEnabled ?? this.emailEnabled,
    phoneAuthEnabled: phoneAuthEnabled ?? this.phoneAuthEnabled,
    isSynced: isSynced ?? this.isSynced,
  );
  LocalClinicSetting copyWithCompanion(LocalClinicSettingsCompanion data) {
    return LocalClinicSetting(
      clinicId: data.clinicId.present ? data.clinicId.value : this.clinicId,
      reminderOffsetHours: data.reminderOffsetHours.present
          ? data.reminderOffsetHours.value
          : this.reminderOffsetHours,
      teethNumberingSystem: data.teethNumberingSystem.present
          ? data.teethNumberingSystem.value
          : this.teethNumberingSystem,
      toothActionsJson: data.toothActionsJson.present
          ? data.toothActionsJson.value
          : this.toothActionsJson,
      whatsAppEnabled: data.whatsAppEnabled.present
          ? data.whatsAppEnabled.value
          : this.whatsAppEnabled,
      whatsAppSenderNumber: data.whatsAppSenderNumber.present
          ? data.whatsAppSenderNumber.value
          : this.whatsAppSenderNumber,
      whatsAppPhoneNumberId: data.whatsAppPhoneNumberId.present
          ? data.whatsAppPhoneNumberId.value
          : this.whatsAppPhoneNumberId,
      smsEnabled: data.smsEnabled.present
          ? data.smsEnabled.value
          : this.smsEnabled,
      emailEnabled: data.emailEnabled.present
          ? data.emailEnabled.value
          : this.emailEnabled,
      phoneAuthEnabled: data.phoneAuthEnabled.present
          ? data.phoneAuthEnabled.value
          : this.phoneAuthEnabled,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalClinicSetting(')
          ..write('clinicId: $clinicId, ')
          ..write('reminderOffsetHours: $reminderOffsetHours, ')
          ..write('teethNumberingSystem: $teethNumberingSystem, ')
          ..write('toothActionsJson: $toothActionsJson, ')
          ..write('whatsAppEnabled: $whatsAppEnabled, ')
          ..write('whatsAppSenderNumber: $whatsAppSenderNumber, ')
          ..write('whatsAppPhoneNumberId: $whatsAppPhoneNumberId, ')
          ..write('smsEnabled: $smsEnabled, ')
          ..write('emailEnabled: $emailEnabled, ')
          ..write('phoneAuthEnabled: $phoneAuthEnabled, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    clinicId,
    reminderOffsetHours,
    teethNumberingSystem,
    toothActionsJson,
    whatsAppEnabled,
    whatsAppSenderNumber,
    whatsAppPhoneNumberId,
    smsEnabled,
    emailEnabled,
    phoneAuthEnabled,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalClinicSetting &&
          other.clinicId == this.clinicId &&
          other.reminderOffsetHours == this.reminderOffsetHours &&
          other.teethNumberingSystem == this.teethNumberingSystem &&
          other.toothActionsJson == this.toothActionsJson &&
          other.whatsAppEnabled == this.whatsAppEnabled &&
          other.whatsAppSenderNumber == this.whatsAppSenderNumber &&
          other.whatsAppPhoneNumberId == this.whatsAppPhoneNumberId &&
          other.smsEnabled == this.smsEnabled &&
          other.emailEnabled == this.emailEnabled &&
          other.phoneAuthEnabled == this.phoneAuthEnabled &&
          other.isSynced == this.isSynced);
}

class LocalClinicSettingsCompanion extends UpdateCompanion<LocalClinicSetting> {
  final Value<String> clinicId;
  final Value<int> reminderOffsetHours;
  final Value<String> teethNumberingSystem;
  final Value<String> toothActionsJson;
  final Value<bool> whatsAppEnabled;
  final Value<String?> whatsAppSenderNumber;
  final Value<String?> whatsAppPhoneNumberId;
  final Value<bool> smsEnabled;
  final Value<bool> emailEnabled;
  final Value<bool> phoneAuthEnabled;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const LocalClinicSettingsCompanion({
    this.clinicId = const Value.absent(),
    this.reminderOffsetHours = const Value.absent(),
    this.teethNumberingSystem = const Value.absent(),
    this.toothActionsJson = const Value.absent(),
    this.whatsAppEnabled = const Value.absent(),
    this.whatsAppSenderNumber = const Value.absent(),
    this.whatsAppPhoneNumberId = const Value.absent(),
    this.smsEnabled = const Value.absent(),
    this.emailEnabled = const Value.absent(),
    this.phoneAuthEnabled = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalClinicSettingsCompanion.insert({
    required String clinicId,
    this.reminderOffsetHours = const Value.absent(),
    this.teethNumberingSystem = const Value.absent(),
    this.toothActionsJson = const Value.absent(),
    this.whatsAppEnabled = const Value.absent(),
    this.whatsAppSenderNumber = const Value.absent(),
    this.whatsAppPhoneNumberId = const Value.absent(),
    this.smsEnabled = const Value.absent(),
    this.emailEnabled = const Value.absent(),
    this.phoneAuthEnabled = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : clinicId = Value(clinicId);
  static Insertable<LocalClinicSetting> custom({
    Expression<String>? clinicId,
    Expression<int>? reminderOffsetHours,
    Expression<String>? teethNumberingSystem,
    Expression<String>? toothActionsJson,
    Expression<bool>? whatsAppEnabled,
    Expression<String>? whatsAppSenderNumber,
    Expression<String>? whatsAppPhoneNumberId,
    Expression<bool>? smsEnabled,
    Expression<bool>? emailEnabled,
    Expression<bool>? phoneAuthEnabled,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (clinicId != null) 'clinic_id': clinicId,
      if (reminderOffsetHours != null)
        'reminder_offset_hours': reminderOffsetHours,
      if (teethNumberingSystem != null)
        'teeth_numbering_system': teethNumberingSystem,
      if (toothActionsJson != null) 'tooth_actions_json': toothActionsJson,
      if (whatsAppEnabled != null) 'whats_app_enabled': whatsAppEnabled,
      if (whatsAppSenderNumber != null)
        'whats_app_sender_number': whatsAppSenderNumber,
      if (whatsAppPhoneNumberId != null)
        'whats_app_phone_number_id': whatsAppPhoneNumberId,
      if (smsEnabled != null) 'sms_enabled': smsEnabled,
      if (emailEnabled != null) 'email_enabled': emailEnabled,
      if (phoneAuthEnabled != null) 'phone_auth_enabled': phoneAuthEnabled,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalClinicSettingsCompanion copyWith({
    Value<String>? clinicId,
    Value<int>? reminderOffsetHours,
    Value<String>? teethNumberingSystem,
    Value<String>? toothActionsJson,
    Value<bool>? whatsAppEnabled,
    Value<String?>? whatsAppSenderNumber,
    Value<String?>? whatsAppPhoneNumberId,
    Value<bool>? smsEnabled,
    Value<bool>? emailEnabled,
    Value<bool>? phoneAuthEnabled,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return LocalClinicSettingsCompanion(
      clinicId: clinicId ?? this.clinicId,
      reminderOffsetHours: reminderOffsetHours ?? this.reminderOffsetHours,
      teethNumberingSystem: teethNumberingSystem ?? this.teethNumberingSystem,
      toothActionsJson: toothActionsJson ?? this.toothActionsJson,
      whatsAppEnabled: whatsAppEnabled ?? this.whatsAppEnabled,
      whatsAppSenderNumber: whatsAppSenderNumber ?? this.whatsAppSenderNumber,
      whatsAppPhoneNumberId:
          whatsAppPhoneNumberId ?? this.whatsAppPhoneNumberId,
      smsEnabled: smsEnabled ?? this.smsEnabled,
      emailEnabled: emailEnabled ?? this.emailEnabled,
      phoneAuthEnabled: phoneAuthEnabled ?? this.phoneAuthEnabled,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (clinicId.present) {
      map['clinic_id'] = Variable<String>(clinicId.value);
    }
    if (reminderOffsetHours.present) {
      map['reminder_offset_hours'] = Variable<int>(reminderOffsetHours.value);
    }
    if (teethNumberingSystem.present) {
      map['teeth_numbering_system'] = Variable<String>(
        teethNumberingSystem.value,
      );
    }
    if (toothActionsJson.present) {
      map['tooth_actions_json'] = Variable<String>(toothActionsJson.value);
    }
    if (whatsAppEnabled.present) {
      map['whats_app_enabled'] = Variable<bool>(whatsAppEnabled.value);
    }
    if (whatsAppSenderNumber.present) {
      map['whats_app_sender_number'] = Variable<String>(
        whatsAppSenderNumber.value,
      );
    }
    if (whatsAppPhoneNumberId.present) {
      map['whats_app_phone_number_id'] = Variable<String>(
        whatsAppPhoneNumberId.value,
      );
    }
    if (smsEnabled.present) {
      map['sms_enabled'] = Variable<bool>(smsEnabled.value);
    }
    if (emailEnabled.present) {
      map['email_enabled'] = Variable<bool>(emailEnabled.value);
    }
    if (phoneAuthEnabled.present) {
      map['phone_auth_enabled'] = Variable<bool>(phoneAuthEnabled.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalClinicSettingsCompanion(')
          ..write('clinicId: $clinicId, ')
          ..write('reminderOffsetHours: $reminderOffsetHours, ')
          ..write('teethNumberingSystem: $teethNumberingSystem, ')
          ..write('toothActionsJson: $toothActionsJson, ')
          ..write('whatsAppEnabled: $whatsAppEnabled, ')
          ..write('whatsAppSenderNumber: $whatsAppSenderNumber, ')
          ..write('whatsAppPhoneNumberId: $whatsAppPhoneNumberId, ')
          ..write('smsEnabled: $smsEnabled, ')
          ..write('emailEnabled: $emailEnabled, ')
          ..write('phoneAuthEnabled: $phoneAuthEnabled, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTable extends SyncQueue
    with TableInfo<$SyncQueueTable, SyncQueueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _targetTableMeta = const VerificationMeta(
    'targetTable',
  );
  @override
  late final GeneratedColumn<String> targetTable = GeneratedColumn<String>(
    'target_table',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordIdMeta = const VerificationMeta(
    'recordId',
  );
  @override
  late final GeneratedColumn<String> recordId = GeneratedColumn<String>(
    'record_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _operationMeta = const VerificationMeta(
    'operation',
  );
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
    'operation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    targetTable,
    recordId,
    operation,
    payload,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncQueueData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('target_table')) {
      context.handle(
        _targetTableMeta,
        targetTable.isAcceptableOrUnknown(
          data['target_table']!,
          _targetTableMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetTableMeta);
    }
    if (data.containsKey('record_id')) {
      context.handle(
        _recordIdMeta,
        recordId.isAcceptableOrUnknown(data['record_id']!, _recordIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recordIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(
        _operationMeta,
        operation.isAcceptableOrUnknown(data['operation']!, _operationMeta),
      );
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      targetTable: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_table'],
      )!,
      recordId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}record_id'],
      )!,
      operation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SyncQueueTable createAlias(String alias) {
    return $SyncQueueTable(attachedDatabase, alias);
  }
}

class SyncQueueData extends DataClass implements Insertable<SyncQueueData> {
  final int id;
  final String targetTable;
  final String recordId;
  final String operation;
  final String payload;
  final DateTime createdAt;
  const SyncQueueData({
    required this.id,
    required this.targetTable,
    required this.recordId,
    required this.operation,
    required this.payload,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['target_table'] = Variable<String>(targetTable);
    map['record_id'] = Variable<String>(recordId);
    map['operation'] = Variable<String>(operation);
    map['payload'] = Variable<String>(payload);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SyncQueueCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueCompanion(
      id: Value(id),
      targetTable: Value(targetTable),
      recordId: Value(recordId),
      operation: Value(operation),
      payload: Value(payload),
      createdAt: Value(createdAt),
    );
  }

  factory SyncQueueData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueData(
      id: serializer.fromJson<int>(json['id']),
      targetTable: serializer.fromJson<String>(json['targetTable']),
      recordId: serializer.fromJson<String>(json['recordId']),
      operation: serializer.fromJson<String>(json['operation']),
      payload: serializer.fromJson<String>(json['payload']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'targetTable': serializer.toJson<String>(targetTable),
      'recordId': serializer.toJson<String>(recordId),
      'operation': serializer.toJson<String>(operation),
      'payload': serializer.toJson<String>(payload),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SyncQueueData copyWith({
    int? id,
    String? targetTable,
    String? recordId,
    String? operation,
    String? payload,
    DateTime? createdAt,
  }) => SyncQueueData(
    id: id ?? this.id,
    targetTable: targetTable ?? this.targetTable,
    recordId: recordId ?? this.recordId,
    operation: operation ?? this.operation,
    payload: payload ?? this.payload,
    createdAt: createdAt ?? this.createdAt,
  );
  SyncQueueData copyWithCompanion(SyncQueueCompanion data) {
    return SyncQueueData(
      id: data.id.present ? data.id.value : this.id,
      targetTable: data.targetTable.present
          ? data.targetTable.value
          : this.targetTable,
      recordId: data.recordId.present ? data.recordId.value : this.recordId,
      operation: data.operation.present ? data.operation.value : this.operation,
      payload: data.payload.present ? data.payload.value : this.payload,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueData(')
          ..write('id: $id, ')
          ..write('targetTable: $targetTable, ')
          ..write('recordId: $recordId, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, targetTable, recordId, operation, payload, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueData &&
          other.id == this.id &&
          other.targetTable == this.targetTable &&
          other.recordId == this.recordId &&
          other.operation == this.operation &&
          other.payload == this.payload &&
          other.createdAt == this.createdAt);
}

class SyncQueueCompanion extends UpdateCompanion<SyncQueueData> {
  final Value<int> id;
  final Value<String> targetTable;
  final Value<String> recordId;
  final Value<String> operation;
  final Value<String> payload;
  final Value<DateTime> createdAt;
  const SyncQueueCompanion({
    this.id = const Value.absent(),
    this.targetTable = const Value.absent(),
    this.recordId = const Value.absent(),
    this.operation = const Value.absent(),
    this.payload = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SyncQueueCompanion.insert({
    this.id = const Value.absent(),
    required String targetTable,
    required String recordId,
    required String operation,
    required String payload,
    required DateTime createdAt,
  }) : targetTable = Value(targetTable),
       recordId = Value(recordId),
       operation = Value(operation),
       payload = Value(payload),
       createdAt = Value(createdAt);
  static Insertable<SyncQueueData> custom({
    Expression<int>? id,
    Expression<String>? targetTable,
    Expression<String>? recordId,
    Expression<String>? operation,
    Expression<String>? payload,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (targetTable != null) 'target_table': targetTable,
      if (recordId != null) 'record_id': recordId,
      if (operation != null) 'operation': operation,
      if (payload != null) 'payload': payload,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SyncQueueCompanion copyWith({
    Value<int>? id,
    Value<String>? targetTable,
    Value<String>? recordId,
    Value<String>? operation,
    Value<String>? payload,
    Value<DateTime>? createdAt,
  }) {
    return SyncQueueCompanion(
      id: id ?? this.id,
      targetTable: targetTable ?? this.targetTable,
      recordId: recordId ?? this.recordId,
      operation: operation ?? this.operation,
      payload: payload ?? this.payload,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (targetTable.present) {
      map['target_table'] = Variable<String>(targetTable.value);
    }
    if (recordId.present) {
      map['record_id'] = Variable<String>(recordId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueCompanion(')
          ..write('id: $id, ')
          ..write('targetTable: $targetTable, ')
          ..write('recordId: $recordId, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $SyncMetaTable extends SyncMeta
    with TableInfo<$SyncMetaTable, SyncMetaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncMetaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _collectionNameMeta = const VerificationMeta(
    'collectionName',
  );
  @override
  late final GeneratedColumn<String> collectionName = GeneratedColumn<String>(
    'collection_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastPullAtMeta = const VerificationMeta(
    'lastPullAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastPullAt = GeneratedColumn<DateTime>(
    'last_pull_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [collectionName, lastPullAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_meta';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncMetaData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('collection_name')) {
      context.handle(
        _collectionNameMeta,
        collectionName.isAcceptableOrUnknown(
          data['collection_name']!,
          _collectionNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_collectionNameMeta);
    }
    if (data.containsKey('last_pull_at')) {
      context.handle(
        _lastPullAtMeta,
        lastPullAt.isAcceptableOrUnknown(
          data['last_pull_at']!,
          _lastPullAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastPullAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {collectionName};
  @override
  SyncMetaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncMetaData(
      collectionName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}collection_name'],
      )!,
      lastPullAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_pull_at'],
      )!,
    );
  }

  @override
  $SyncMetaTable createAlias(String alias) {
    return $SyncMetaTable(attachedDatabase, alias);
  }
}

class SyncMetaData extends DataClass implements Insertable<SyncMetaData> {
  final String collectionName;
  final DateTime lastPullAt;
  const SyncMetaData({required this.collectionName, required this.lastPullAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['collection_name'] = Variable<String>(collectionName);
    map['last_pull_at'] = Variable<DateTime>(lastPullAt);
    return map;
  }

  SyncMetaCompanion toCompanion(bool nullToAbsent) {
    return SyncMetaCompanion(
      collectionName: Value(collectionName),
      lastPullAt: Value(lastPullAt),
    );
  }

  factory SyncMetaData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncMetaData(
      collectionName: serializer.fromJson<String>(json['collectionName']),
      lastPullAt: serializer.fromJson<DateTime>(json['lastPullAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'collectionName': serializer.toJson<String>(collectionName),
      'lastPullAt': serializer.toJson<DateTime>(lastPullAt),
    };
  }

  SyncMetaData copyWith({String? collectionName, DateTime? lastPullAt}) =>
      SyncMetaData(
        collectionName: collectionName ?? this.collectionName,
        lastPullAt: lastPullAt ?? this.lastPullAt,
      );
  SyncMetaData copyWithCompanion(SyncMetaCompanion data) {
    return SyncMetaData(
      collectionName: data.collectionName.present
          ? data.collectionName.value
          : this.collectionName,
      lastPullAt: data.lastPullAt.present
          ? data.lastPullAt.value
          : this.lastPullAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetaData(')
          ..write('collectionName: $collectionName, ')
          ..write('lastPullAt: $lastPullAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(collectionName, lastPullAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncMetaData &&
          other.collectionName == this.collectionName &&
          other.lastPullAt == this.lastPullAt);
}

class SyncMetaCompanion extends UpdateCompanion<SyncMetaData> {
  final Value<String> collectionName;
  final Value<DateTime> lastPullAt;
  final Value<int> rowid;
  const SyncMetaCompanion({
    this.collectionName = const Value.absent(),
    this.lastPullAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncMetaCompanion.insert({
    required String collectionName,
    required DateTime lastPullAt,
    this.rowid = const Value.absent(),
  }) : collectionName = Value(collectionName),
       lastPullAt = Value(lastPullAt);
  static Insertable<SyncMetaData> custom({
    Expression<String>? collectionName,
    Expression<DateTime>? lastPullAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (collectionName != null) 'collection_name': collectionName,
      if (lastPullAt != null) 'last_pull_at': lastPullAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncMetaCompanion copyWith({
    Value<String>? collectionName,
    Value<DateTime>? lastPullAt,
    Value<int>? rowid,
  }) {
    return SyncMetaCompanion(
      collectionName: collectionName ?? this.collectionName,
      lastPullAt: lastPullAt ?? this.lastPullAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (collectionName.present) {
      map['collection_name'] = Variable<String>(collectionName.value);
    }
    if (lastPullAt.present) {
      map['last_pull_at'] = Variable<DateTime>(lastPullAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetaCompanion(')
          ..write('collectionName: $collectionName, ')
          ..write('lastPullAt: $lastPullAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LocalPatientsTable localPatients = $LocalPatientsTable(this);
  late final $LocalAppointmentsTable localAppointments =
      $LocalAppointmentsTable(this);
  late final $LocalDoctorsTable localDoctors = $LocalDoctorsTable(this);
  late final $LocalPaymentsTable localPayments = $LocalPaymentsTable(this);
  late final $LocalToothRecordsTable localToothRecords =
      $LocalToothRecordsTable(this);
  late final $LocalDentalPlansTable localDentalPlans = $LocalDentalPlansTable(
    this,
  );
  late final $LocalClinicsTable localClinics = $LocalClinicsTable(this);
  late final $LocalClinicSettingsTable localClinicSettings =
      $LocalClinicSettingsTable(this);
  late final $SyncQueueTable syncQueue = $SyncQueueTable(this);
  late final $SyncMetaTable syncMeta = $SyncMetaTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    localPatients,
    localAppointments,
    localDoctors,
    localPayments,
    localToothRecords,
    localDentalPlans,
    localClinics,
    localClinicSettings,
    syncQueue,
    syncMeta,
  ];
}

typedef $$LocalPatientsTableCreateCompanionBuilder =
    LocalPatientsCompanion Function({
      required String id,
      required String clinicId,
      required String firstName,
      required String fatherName,
      required String lastName,
      required String displayName,
      required String displayNameLower,
      required String phoneNumber,
      Value<String?> city,
      Value<String?> district,
      Value<String?> detailedAddress,
      Value<DateTime?> dob,
      Value<String?> gender,
      Value<String?> nationalId,
      Value<String?> reasonForVisit,
      Value<String?> medicalNotes,
      Value<String> allergiesJson,
      Value<String> chronicDiseasesJson,
      Value<String> attachmentUrlsJson,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$LocalPatientsTableUpdateCompanionBuilder =
    LocalPatientsCompanion Function({
      Value<String> id,
      Value<String> clinicId,
      Value<String> firstName,
      Value<String> fatherName,
      Value<String> lastName,
      Value<String> displayName,
      Value<String> displayNameLower,
      Value<String> phoneNumber,
      Value<String?> city,
      Value<String?> district,
      Value<String?> detailedAddress,
      Value<DateTime?> dob,
      Value<String?> gender,
      Value<String?> nationalId,
      Value<String?> reasonForVisit,
      Value<String?> medicalNotes,
      Value<String> allergiesJson,
      Value<String> chronicDiseasesJson,
      Value<String> attachmentUrlsJson,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });

class $$LocalPatientsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalPatientsTable> {
  $$LocalPatientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clinicId => $composableBuilder(
    column: $table.clinicId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fatherName => $composableBuilder(
    column: $table.fatherName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayNameLower => $composableBuilder(
    column: $table.displayNameLower,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get district => $composableBuilder(
    column: $table.district,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get detailedAddress => $composableBuilder(
    column: $table.detailedAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dob => $composableBuilder(
    column: $table.dob,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nationalId => $composableBuilder(
    column: $table.nationalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reasonForVisit => $composableBuilder(
    column: $table.reasonForVisit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get medicalNotes => $composableBuilder(
    column: $table.medicalNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get allergiesJson => $composableBuilder(
    column: $table.allergiesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get chronicDiseasesJson => $composableBuilder(
    column: $table.chronicDiseasesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get attachmentUrlsJson => $composableBuilder(
    column: $table.attachmentUrlsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalPatientsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalPatientsTable> {
  $$LocalPatientsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clinicId => $composableBuilder(
    column: $table.clinicId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fatherName => $composableBuilder(
    column: $table.fatherName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayNameLower => $composableBuilder(
    column: $table.displayNameLower,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get district => $composableBuilder(
    column: $table.district,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get detailedAddress => $composableBuilder(
    column: $table.detailedAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dob => $composableBuilder(
    column: $table.dob,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nationalId => $composableBuilder(
    column: $table.nationalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reasonForVisit => $composableBuilder(
    column: $table.reasonForVisit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get medicalNotes => $composableBuilder(
    column: $table.medicalNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get allergiesJson => $composableBuilder(
    column: $table.allergiesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get chronicDiseasesJson => $composableBuilder(
    column: $table.chronicDiseasesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get attachmentUrlsJson => $composableBuilder(
    column: $table.attachmentUrlsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalPatientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalPatientsTable> {
  $$LocalPatientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get clinicId =>
      $composableBuilder(column: $table.clinicId, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get fatherName => $composableBuilder(
    column: $table.fatherName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get displayNameLower => $composableBuilder(
    column: $table.displayNameLower,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get district =>
      $composableBuilder(column: $table.district, builder: (column) => column);

  GeneratedColumn<String> get detailedAddress => $composableBuilder(
    column: $table.detailedAddress,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dob =>
      $composableBuilder(column: $table.dob, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<String> get nationalId => $composableBuilder(
    column: $table.nationalId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reasonForVisit => $composableBuilder(
    column: $table.reasonForVisit,
    builder: (column) => column,
  );

  GeneratedColumn<String> get medicalNotes => $composableBuilder(
    column: $table.medicalNotes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get allergiesJson => $composableBuilder(
    column: $table.allergiesJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get chronicDiseasesJson => $composableBuilder(
    column: $table.chronicDiseasesJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get attachmentUrlsJson => $composableBuilder(
    column: $table.attachmentUrlsJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$LocalPatientsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalPatientsTable,
          LocalPatient,
          $$LocalPatientsTableFilterComposer,
          $$LocalPatientsTableOrderingComposer,
          $$LocalPatientsTableAnnotationComposer,
          $$LocalPatientsTableCreateCompanionBuilder,
          $$LocalPatientsTableUpdateCompanionBuilder,
          (
            LocalPatient,
            BaseReferences<_$AppDatabase, $LocalPatientsTable, LocalPatient>,
          ),
          LocalPatient,
          PrefetchHooks Function()
        > {
  $$LocalPatientsTableTableManager(_$AppDatabase db, $LocalPatientsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalPatientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalPatientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalPatientsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> clinicId = const Value.absent(),
                Value<String> firstName = const Value.absent(),
                Value<String> fatherName = const Value.absent(),
                Value<String> lastName = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String> displayNameLower = const Value.absent(),
                Value<String> phoneNumber = const Value.absent(),
                Value<String?> city = const Value.absent(),
                Value<String?> district = const Value.absent(),
                Value<String?> detailedAddress = const Value.absent(),
                Value<DateTime?> dob = const Value.absent(),
                Value<String?> gender = const Value.absent(),
                Value<String?> nationalId = const Value.absent(),
                Value<String?> reasonForVisit = const Value.absent(),
                Value<String?> medicalNotes = const Value.absent(),
                Value<String> allergiesJson = const Value.absent(),
                Value<String> chronicDiseasesJson = const Value.absent(),
                Value<String> attachmentUrlsJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalPatientsCompanion(
                id: id,
                clinicId: clinicId,
                firstName: firstName,
                fatherName: fatherName,
                lastName: lastName,
                displayName: displayName,
                displayNameLower: displayNameLower,
                phoneNumber: phoneNumber,
                city: city,
                district: district,
                detailedAddress: detailedAddress,
                dob: dob,
                gender: gender,
                nationalId: nationalId,
                reasonForVisit: reasonForVisit,
                medicalNotes: medicalNotes,
                allergiesJson: allergiesJson,
                chronicDiseasesJson: chronicDiseasesJson,
                attachmentUrlsJson: attachmentUrlsJson,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String clinicId,
                required String firstName,
                required String fatherName,
                required String lastName,
                required String displayName,
                required String displayNameLower,
                required String phoneNumber,
                Value<String?> city = const Value.absent(),
                Value<String?> district = const Value.absent(),
                Value<String?> detailedAddress = const Value.absent(),
                Value<DateTime?> dob = const Value.absent(),
                Value<String?> gender = const Value.absent(),
                Value<String?> nationalId = const Value.absent(),
                Value<String?> reasonForVisit = const Value.absent(),
                Value<String?> medicalNotes = const Value.absent(),
                Value<String> allergiesJson = const Value.absent(),
                Value<String> chronicDiseasesJson = const Value.absent(),
                Value<String> attachmentUrlsJson = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalPatientsCompanion.insert(
                id: id,
                clinicId: clinicId,
                firstName: firstName,
                fatherName: fatherName,
                lastName: lastName,
                displayName: displayName,
                displayNameLower: displayNameLower,
                phoneNumber: phoneNumber,
                city: city,
                district: district,
                detailedAddress: detailedAddress,
                dob: dob,
                gender: gender,
                nationalId: nationalId,
                reasonForVisit: reasonForVisit,
                medicalNotes: medicalNotes,
                allergiesJson: allergiesJson,
                chronicDiseasesJson: chronicDiseasesJson,
                attachmentUrlsJson: attachmentUrlsJson,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalPatientsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalPatientsTable,
      LocalPatient,
      $$LocalPatientsTableFilterComposer,
      $$LocalPatientsTableOrderingComposer,
      $$LocalPatientsTableAnnotationComposer,
      $$LocalPatientsTableCreateCompanionBuilder,
      $$LocalPatientsTableUpdateCompanionBuilder,
      (
        LocalPatient,
        BaseReferences<_$AppDatabase, $LocalPatientsTable, LocalPatient>,
      ),
      LocalPatient,
      PrefetchHooks Function()
    >;
typedef $$LocalAppointmentsTableCreateCompanionBuilder =
    LocalAppointmentsCompanion Function({
      required String id,
      required String clinicId,
      required String patientId,
      required String patientName,
      required String patientPhone,
      required DateTime startAt,
      required int durationMinutes,
      required String reason,
      required String status,
      required String doctorId,
      required String doctorName,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<bool> reminderSent,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$LocalAppointmentsTableUpdateCompanionBuilder =
    LocalAppointmentsCompanion Function({
      Value<String> id,
      Value<String> clinicId,
      Value<String> patientId,
      Value<String> patientName,
      Value<String> patientPhone,
      Value<DateTime> startAt,
      Value<int> durationMinutes,
      Value<String> reason,
      Value<String> status,
      Value<String> doctorId,
      Value<String> doctorName,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> reminderSent,
      Value<bool> isSynced,
      Value<int> rowid,
    });

class $$LocalAppointmentsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalAppointmentsTable> {
  $$LocalAppointmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clinicId => $composableBuilder(
    column: $table.clinicId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get patientName => $composableBuilder(
    column: $table.patientName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get patientPhone => $composableBuilder(
    column: $table.patientPhone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startAt => $composableBuilder(
    column: $table.startAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get doctorId => $composableBuilder(
    column: $table.doctorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get doctorName => $composableBuilder(
    column: $table.doctorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get reminderSent => $composableBuilder(
    column: $table.reminderSent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalAppointmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalAppointmentsTable> {
  $$LocalAppointmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clinicId => $composableBuilder(
    column: $table.clinicId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get patientName => $composableBuilder(
    column: $table.patientName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get patientPhone => $composableBuilder(
    column: $table.patientPhone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startAt => $composableBuilder(
    column: $table.startAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get doctorId => $composableBuilder(
    column: $table.doctorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get doctorName => $composableBuilder(
    column: $table.doctorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get reminderSent => $composableBuilder(
    column: $table.reminderSent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalAppointmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalAppointmentsTable> {
  $$LocalAppointmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get clinicId =>
      $composableBuilder(column: $table.clinicId, builder: (column) => column);

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<String> get patientName => $composableBuilder(
    column: $table.patientName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get patientPhone => $composableBuilder(
    column: $table.patientPhone,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startAt =>
      $composableBuilder(column: $table.startAt, builder: (column) => column);

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get doctorId =>
      $composableBuilder(column: $table.doctorId, builder: (column) => column);

  GeneratedColumn<String> get doctorName => $composableBuilder(
    column: $table.doctorName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get reminderSent => $composableBuilder(
    column: $table.reminderSent,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$LocalAppointmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalAppointmentsTable,
          LocalAppointment,
          $$LocalAppointmentsTableFilterComposer,
          $$LocalAppointmentsTableOrderingComposer,
          $$LocalAppointmentsTableAnnotationComposer,
          $$LocalAppointmentsTableCreateCompanionBuilder,
          $$LocalAppointmentsTableUpdateCompanionBuilder,
          (
            LocalAppointment,
            BaseReferences<
              _$AppDatabase,
              $LocalAppointmentsTable,
              LocalAppointment
            >,
          ),
          LocalAppointment,
          PrefetchHooks Function()
        > {
  $$LocalAppointmentsTableTableManager(
    _$AppDatabase db,
    $LocalAppointmentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalAppointmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalAppointmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalAppointmentsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> clinicId = const Value.absent(),
                Value<String> patientId = const Value.absent(),
                Value<String> patientName = const Value.absent(),
                Value<String> patientPhone = const Value.absent(),
                Value<DateTime> startAt = const Value.absent(),
                Value<int> durationMinutes = const Value.absent(),
                Value<String> reason = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> doctorId = const Value.absent(),
                Value<String> doctorName = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> reminderSent = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalAppointmentsCompanion(
                id: id,
                clinicId: clinicId,
                patientId: patientId,
                patientName: patientName,
                patientPhone: patientPhone,
                startAt: startAt,
                durationMinutes: durationMinutes,
                reason: reason,
                status: status,
                doctorId: doctorId,
                doctorName: doctorName,
                createdAt: createdAt,
                updatedAt: updatedAt,
                reminderSent: reminderSent,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String clinicId,
                required String patientId,
                required String patientName,
                required String patientPhone,
                required DateTime startAt,
                required int durationMinutes,
                required String reason,
                required String status,
                required String doctorId,
                required String doctorName,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<bool> reminderSent = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalAppointmentsCompanion.insert(
                id: id,
                clinicId: clinicId,
                patientId: patientId,
                patientName: patientName,
                patientPhone: patientPhone,
                startAt: startAt,
                durationMinutes: durationMinutes,
                reason: reason,
                status: status,
                doctorId: doctorId,
                doctorName: doctorName,
                createdAt: createdAt,
                updatedAt: updatedAt,
                reminderSent: reminderSent,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalAppointmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalAppointmentsTable,
      LocalAppointment,
      $$LocalAppointmentsTableFilterComposer,
      $$LocalAppointmentsTableOrderingComposer,
      $$LocalAppointmentsTableAnnotationComposer,
      $$LocalAppointmentsTableCreateCompanionBuilder,
      $$LocalAppointmentsTableUpdateCompanionBuilder,
      (
        LocalAppointment,
        BaseReferences<
          _$AppDatabase,
          $LocalAppointmentsTable,
          LocalAppointment
        >,
      ),
      LocalAppointment,
      PrefetchHooks Function()
    >;
typedef $$LocalDoctorsTableCreateCompanionBuilder =
    LocalDoctorsCompanion Function({
      required String id,
      required String clinicId,
      Value<String> fullName,
      Value<String?> phone,
      Value<String?> specialty,
      Value<String?> address,
      Value<String?> notes,
      Value<String?> profilePictureUrl,
      Value<double> monthlySalaryIqd,
      Value<double> commissionPercent,
      Value<String> paymentType,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<bool> isActive,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$LocalDoctorsTableUpdateCompanionBuilder =
    LocalDoctorsCompanion Function({
      Value<String> id,
      Value<String> clinicId,
      Value<String> fullName,
      Value<String?> phone,
      Value<String?> specialty,
      Value<String?> address,
      Value<String?> notes,
      Value<String?> profilePictureUrl,
      Value<double> monthlySalaryIqd,
      Value<double> commissionPercent,
      Value<String> paymentType,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isActive,
      Value<bool> isSynced,
      Value<int> rowid,
    });

class $$LocalDoctorsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalDoctorsTable> {
  $$LocalDoctorsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clinicId => $composableBuilder(
    column: $table.clinicId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get specialty => $composableBuilder(
    column: $table.specialty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get profilePictureUrl => $composableBuilder(
    column: $table.profilePictureUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get monthlySalaryIqd => $composableBuilder(
    column: $table.monthlySalaryIqd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get commissionPercent => $composableBuilder(
    column: $table.commissionPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentType => $composableBuilder(
    column: $table.paymentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalDoctorsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalDoctorsTable> {
  $$LocalDoctorsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clinicId => $composableBuilder(
    column: $table.clinicId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get specialty => $composableBuilder(
    column: $table.specialty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get profilePictureUrl => $composableBuilder(
    column: $table.profilePictureUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get monthlySalaryIqd => $composableBuilder(
    column: $table.monthlySalaryIqd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get commissionPercent => $composableBuilder(
    column: $table.commissionPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentType => $composableBuilder(
    column: $table.paymentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalDoctorsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalDoctorsTable> {
  $$LocalDoctorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get clinicId =>
      $composableBuilder(column: $table.clinicId, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get specialty =>
      $composableBuilder(column: $table.specialty, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get profilePictureUrl => $composableBuilder(
    column: $table.profilePictureUrl,
    builder: (column) => column,
  );

  GeneratedColumn<double> get monthlySalaryIqd => $composableBuilder(
    column: $table.monthlySalaryIqd,
    builder: (column) => column,
  );

  GeneratedColumn<double> get commissionPercent => $composableBuilder(
    column: $table.commissionPercent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentType => $composableBuilder(
    column: $table.paymentType,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$LocalDoctorsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalDoctorsTable,
          LocalDoctor,
          $$LocalDoctorsTableFilterComposer,
          $$LocalDoctorsTableOrderingComposer,
          $$LocalDoctorsTableAnnotationComposer,
          $$LocalDoctorsTableCreateCompanionBuilder,
          $$LocalDoctorsTableUpdateCompanionBuilder,
          (
            LocalDoctor,
            BaseReferences<_$AppDatabase, $LocalDoctorsTable, LocalDoctor>,
          ),
          LocalDoctor,
          PrefetchHooks Function()
        > {
  $$LocalDoctorsTableTableManager(_$AppDatabase db, $LocalDoctorsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalDoctorsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalDoctorsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalDoctorsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> clinicId = const Value.absent(),
                Value<String> fullName = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> specialty = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> profilePictureUrl = const Value.absent(),
                Value<double> monthlySalaryIqd = const Value.absent(),
                Value<double> commissionPercent = const Value.absent(),
                Value<String> paymentType = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalDoctorsCompanion(
                id: id,
                clinicId: clinicId,
                fullName: fullName,
                phone: phone,
                specialty: specialty,
                address: address,
                notes: notes,
                profilePictureUrl: profilePictureUrl,
                monthlySalaryIqd: monthlySalaryIqd,
                commissionPercent: commissionPercent,
                paymentType: paymentType,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isActive: isActive,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String clinicId,
                Value<String> fullName = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> specialty = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> profilePictureUrl = const Value.absent(),
                Value<double> monthlySalaryIqd = const Value.absent(),
                Value<double> commissionPercent = const Value.absent(),
                Value<String> paymentType = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<bool> isActive = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalDoctorsCompanion.insert(
                id: id,
                clinicId: clinicId,
                fullName: fullName,
                phone: phone,
                specialty: specialty,
                address: address,
                notes: notes,
                profilePictureUrl: profilePictureUrl,
                monthlySalaryIqd: monthlySalaryIqd,
                commissionPercent: commissionPercent,
                paymentType: paymentType,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isActive: isActive,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalDoctorsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalDoctorsTable,
      LocalDoctor,
      $$LocalDoctorsTableFilterComposer,
      $$LocalDoctorsTableOrderingComposer,
      $$LocalDoctorsTableAnnotationComposer,
      $$LocalDoctorsTableCreateCompanionBuilder,
      $$LocalDoctorsTableUpdateCompanionBuilder,
      (
        LocalDoctor,
        BaseReferences<_$AppDatabase, $LocalDoctorsTable, LocalDoctor>,
      ),
      LocalDoctor,
      PrefetchHooks Function()
    >;
typedef $$LocalPaymentsTableCreateCompanionBuilder =
    LocalPaymentsCompanion Function({
      required String id,
      required String clinicId,
      required String patientId,
      required String patientName,
      Value<String?> doctorId,
      Value<String?> doctorName,
      Value<double> doctorShare,
      Value<String?> appointmentId,
      required double amount,
      required double paid,
      required double remaining,
      required String method,
      required DateTime date,
      Value<String?> paymentNotes,
      required String createdBy,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$LocalPaymentsTableUpdateCompanionBuilder =
    LocalPaymentsCompanion Function({
      Value<String> id,
      Value<String> clinicId,
      Value<String> patientId,
      Value<String> patientName,
      Value<String?> doctorId,
      Value<String?> doctorName,
      Value<double> doctorShare,
      Value<String?> appointmentId,
      Value<double> amount,
      Value<double> paid,
      Value<double> remaining,
      Value<String> method,
      Value<DateTime> date,
      Value<String?> paymentNotes,
      Value<String> createdBy,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });

class $$LocalPaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalPaymentsTable> {
  $$LocalPaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clinicId => $composableBuilder(
    column: $table.clinicId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get patientName => $composableBuilder(
    column: $table.patientName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get doctorId => $composableBuilder(
    column: $table.doctorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get doctorName => $composableBuilder(
    column: $table.doctorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get doctorShare => $composableBuilder(
    column: $table.doctorShare,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get appointmentId => $composableBuilder(
    column: $table.appointmentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get paid => $composableBuilder(
    column: $table.paid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get remaining => $composableBuilder(
    column: $table.remaining,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentNotes => $composableBuilder(
    column: $table.paymentNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalPaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalPaymentsTable> {
  $$LocalPaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clinicId => $composableBuilder(
    column: $table.clinicId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get patientName => $composableBuilder(
    column: $table.patientName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get doctorId => $composableBuilder(
    column: $table.doctorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get doctorName => $composableBuilder(
    column: $table.doctorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get doctorShare => $composableBuilder(
    column: $table.doctorShare,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get appointmentId => $composableBuilder(
    column: $table.appointmentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get paid => $composableBuilder(
    column: $table.paid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get remaining => $composableBuilder(
    column: $table.remaining,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentNotes => $composableBuilder(
    column: $table.paymentNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalPaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalPaymentsTable> {
  $$LocalPaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get clinicId =>
      $composableBuilder(column: $table.clinicId, builder: (column) => column);

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<String> get patientName => $composableBuilder(
    column: $table.patientName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get doctorId =>
      $composableBuilder(column: $table.doctorId, builder: (column) => column);

  GeneratedColumn<String> get doctorName => $composableBuilder(
    column: $table.doctorName,
    builder: (column) => column,
  );

  GeneratedColumn<double> get doctorShare => $composableBuilder(
    column: $table.doctorShare,
    builder: (column) => column,
  );

  GeneratedColumn<String> get appointmentId => $composableBuilder(
    column: $table.appointmentId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<double> get paid =>
      $composableBuilder(column: $table.paid, builder: (column) => column);

  GeneratedColumn<double> get remaining =>
      $composableBuilder(column: $table.remaining, builder: (column) => column);

  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get paymentNotes => $composableBuilder(
    column: $table.paymentNotes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$LocalPaymentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalPaymentsTable,
          LocalPayment,
          $$LocalPaymentsTableFilterComposer,
          $$LocalPaymentsTableOrderingComposer,
          $$LocalPaymentsTableAnnotationComposer,
          $$LocalPaymentsTableCreateCompanionBuilder,
          $$LocalPaymentsTableUpdateCompanionBuilder,
          (
            LocalPayment,
            BaseReferences<_$AppDatabase, $LocalPaymentsTable, LocalPayment>,
          ),
          LocalPayment,
          PrefetchHooks Function()
        > {
  $$LocalPaymentsTableTableManager(_$AppDatabase db, $LocalPaymentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalPaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalPaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalPaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> clinicId = const Value.absent(),
                Value<String> patientId = const Value.absent(),
                Value<String> patientName = const Value.absent(),
                Value<String?> doctorId = const Value.absent(),
                Value<String?> doctorName = const Value.absent(),
                Value<double> doctorShare = const Value.absent(),
                Value<String?> appointmentId = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<double> paid = const Value.absent(),
                Value<double> remaining = const Value.absent(),
                Value<String> method = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String?> paymentNotes = const Value.absent(),
                Value<String> createdBy = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalPaymentsCompanion(
                id: id,
                clinicId: clinicId,
                patientId: patientId,
                patientName: patientName,
                doctorId: doctorId,
                doctorName: doctorName,
                doctorShare: doctorShare,
                appointmentId: appointmentId,
                amount: amount,
                paid: paid,
                remaining: remaining,
                method: method,
                date: date,
                paymentNotes: paymentNotes,
                createdBy: createdBy,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String clinicId,
                required String patientId,
                required String patientName,
                Value<String?> doctorId = const Value.absent(),
                Value<String?> doctorName = const Value.absent(),
                Value<double> doctorShare = const Value.absent(),
                Value<String?> appointmentId = const Value.absent(),
                required double amount,
                required double paid,
                required double remaining,
                required String method,
                required DateTime date,
                Value<String?> paymentNotes = const Value.absent(),
                required String createdBy,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalPaymentsCompanion.insert(
                id: id,
                clinicId: clinicId,
                patientId: patientId,
                patientName: patientName,
                doctorId: doctorId,
                doctorName: doctorName,
                doctorShare: doctorShare,
                appointmentId: appointmentId,
                amount: amount,
                paid: paid,
                remaining: remaining,
                method: method,
                date: date,
                paymentNotes: paymentNotes,
                createdBy: createdBy,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalPaymentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalPaymentsTable,
      LocalPayment,
      $$LocalPaymentsTableFilterComposer,
      $$LocalPaymentsTableOrderingComposer,
      $$LocalPaymentsTableAnnotationComposer,
      $$LocalPaymentsTableCreateCompanionBuilder,
      $$LocalPaymentsTableUpdateCompanionBuilder,
      (
        LocalPayment,
        BaseReferences<_$AppDatabase, $LocalPaymentsTable, LocalPayment>,
      ),
      LocalPayment,
      PrefetchHooks Function()
    >;
typedef $$LocalToothRecordsTableCreateCompanionBuilder =
    LocalToothRecordsCompanion Function({
      required String docId,
      required String patientId,
      required String toothId,
      required String clinicId,
      Value<String> status,
      Value<String> proceduresJson,
      Value<String?> toothNotes,
      required DateTime updatedAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$LocalToothRecordsTableUpdateCompanionBuilder =
    LocalToothRecordsCompanion Function({
      Value<String> docId,
      Value<String> patientId,
      Value<String> toothId,
      Value<String> clinicId,
      Value<String> status,
      Value<String> proceduresJson,
      Value<String?> toothNotes,
      Value<DateTime> updatedAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });

class $$LocalToothRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalToothRecordsTable> {
  $$LocalToothRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get docId => $composableBuilder(
    column: $table.docId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get toothId => $composableBuilder(
    column: $table.toothId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clinicId => $composableBuilder(
    column: $table.clinicId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get proceduresJson => $composableBuilder(
    column: $table.proceduresJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get toothNotes => $composableBuilder(
    column: $table.toothNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalToothRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalToothRecordsTable> {
  $$LocalToothRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get docId => $composableBuilder(
    column: $table.docId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get toothId => $composableBuilder(
    column: $table.toothId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clinicId => $composableBuilder(
    column: $table.clinicId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get proceduresJson => $composableBuilder(
    column: $table.proceduresJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get toothNotes => $composableBuilder(
    column: $table.toothNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalToothRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalToothRecordsTable> {
  $$LocalToothRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get docId =>
      $composableBuilder(column: $table.docId, builder: (column) => column);

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<String> get toothId =>
      $composableBuilder(column: $table.toothId, builder: (column) => column);

  GeneratedColumn<String> get clinicId =>
      $composableBuilder(column: $table.clinicId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get proceduresJson => $composableBuilder(
    column: $table.proceduresJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get toothNotes => $composableBuilder(
    column: $table.toothNotes,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$LocalToothRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalToothRecordsTable,
          LocalToothRecord,
          $$LocalToothRecordsTableFilterComposer,
          $$LocalToothRecordsTableOrderingComposer,
          $$LocalToothRecordsTableAnnotationComposer,
          $$LocalToothRecordsTableCreateCompanionBuilder,
          $$LocalToothRecordsTableUpdateCompanionBuilder,
          (
            LocalToothRecord,
            BaseReferences<
              _$AppDatabase,
              $LocalToothRecordsTable,
              LocalToothRecord
            >,
          ),
          LocalToothRecord,
          PrefetchHooks Function()
        > {
  $$LocalToothRecordsTableTableManager(
    _$AppDatabase db,
    $LocalToothRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalToothRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalToothRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalToothRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> docId = const Value.absent(),
                Value<String> patientId = const Value.absent(),
                Value<String> toothId = const Value.absent(),
                Value<String> clinicId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> proceduresJson = const Value.absent(),
                Value<String?> toothNotes = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalToothRecordsCompanion(
                docId: docId,
                patientId: patientId,
                toothId: toothId,
                clinicId: clinicId,
                status: status,
                proceduresJson: proceduresJson,
                toothNotes: toothNotes,
                updatedAt: updatedAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String docId,
                required String patientId,
                required String toothId,
                required String clinicId,
                Value<String> status = const Value.absent(),
                Value<String> proceduresJson = const Value.absent(),
                Value<String?> toothNotes = const Value.absent(),
                required DateTime updatedAt,
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalToothRecordsCompanion.insert(
                docId: docId,
                patientId: patientId,
                toothId: toothId,
                clinicId: clinicId,
                status: status,
                proceduresJson: proceduresJson,
                toothNotes: toothNotes,
                updatedAt: updatedAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalToothRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalToothRecordsTable,
      LocalToothRecord,
      $$LocalToothRecordsTableFilterComposer,
      $$LocalToothRecordsTableOrderingComposer,
      $$LocalToothRecordsTableAnnotationComposer,
      $$LocalToothRecordsTableCreateCompanionBuilder,
      $$LocalToothRecordsTableUpdateCompanionBuilder,
      (
        LocalToothRecord,
        BaseReferences<
          _$AppDatabase,
          $LocalToothRecordsTable,
          LocalToothRecord
        >,
      ),
      LocalToothRecord,
      PrefetchHooks Function()
    >;
typedef $$LocalDentalPlansTableCreateCompanionBuilder =
    LocalDentalPlansCompanion Function({
      required String id,
      required String clinicId,
      required String patientId,
      required String toothId,
      required String numberingSystem,
      required String actionLabel,
      required String note,
      required DateTime timestamp,
      required String doctorId,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$LocalDentalPlansTableUpdateCompanionBuilder =
    LocalDentalPlansCompanion Function({
      Value<String> id,
      Value<String> clinicId,
      Value<String> patientId,
      Value<String> toothId,
      Value<String> numberingSystem,
      Value<String> actionLabel,
      Value<String> note,
      Value<DateTime> timestamp,
      Value<String> doctorId,
      Value<bool> isSynced,
      Value<int> rowid,
    });

class $$LocalDentalPlansTableFilterComposer
    extends Composer<_$AppDatabase, $LocalDentalPlansTable> {
  $$LocalDentalPlansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clinicId => $composableBuilder(
    column: $table.clinicId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get toothId => $composableBuilder(
    column: $table.toothId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get numberingSystem => $composableBuilder(
    column: $table.numberingSystem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get actionLabel => $composableBuilder(
    column: $table.actionLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get doctorId => $composableBuilder(
    column: $table.doctorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalDentalPlansTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalDentalPlansTable> {
  $$LocalDentalPlansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clinicId => $composableBuilder(
    column: $table.clinicId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get toothId => $composableBuilder(
    column: $table.toothId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get numberingSystem => $composableBuilder(
    column: $table.numberingSystem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actionLabel => $composableBuilder(
    column: $table.actionLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get doctorId => $composableBuilder(
    column: $table.doctorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalDentalPlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalDentalPlansTable> {
  $$LocalDentalPlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get clinicId =>
      $composableBuilder(column: $table.clinicId, builder: (column) => column);

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<String> get toothId =>
      $composableBuilder(column: $table.toothId, builder: (column) => column);

  GeneratedColumn<String> get numberingSystem => $composableBuilder(
    column: $table.numberingSystem,
    builder: (column) => column,
  );

  GeneratedColumn<String> get actionLabel => $composableBuilder(
    column: $table.actionLabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get doctorId =>
      $composableBuilder(column: $table.doctorId, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$LocalDentalPlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalDentalPlansTable,
          LocalDentalPlan,
          $$LocalDentalPlansTableFilterComposer,
          $$LocalDentalPlansTableOrderingComposer,
          $$LocalDentalPlansTableAnnotationComposer,
          $$LocalDentalPlansTableCreateCompanionBuilder,
          $$LocalDentalPlansTableUpdateCompanionBuilder,
          (
            LocalDentalPlan,
            BaseReferences<
              _$AppDatabase,
              $LocalDentalPlansTable,
              LocalDentalPlan
            >,
          ),
          LocalDentalPlan,
          PrefetchHooks Function()
        > {
  $$LocalDentalPlansTableTableManager(
    _$AppDatabase db,
    $LocalDentalPlansTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalDentalPlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalDentalPlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalDentalPlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> clinicId = const Value.absent(),
                Value<String> patientId = const Value.absent(),
                Value<String> toothId = const Value.absent(),
                Value<String> numberingSystem = const Value.absent(),
                Value<String> actionLabel = const Value.absent(),
                Value<String> note = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<String> doctorId = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalDentalPlansCompanion(
                id: id,
                clinicId: clinicId,
                patientId: patientId,
                toothId: toothId,
                numberingSystem: numberingSystem,
                actionLabel: actionLabel,
                note: note,
                timestamp: timestamp,
                doctorId: doctorId,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String clinicId,
                required String patientId,
                required String toothId,
                required String numberingSystem,
                required String actionLabel,
                required String note,
                required DateTime timestamp,
                required String doctorId,
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalDentalPlansCompanion.insert(
                id: id,
                clinicId: clinicId,
                patientId: patientId,
                toothId: toothId,
                numberingSystem: numberingSystem,
                actionLabel: actionLabel,
                note: note,
                timestamp: timestamp,
                doctorId: doctorId,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalDentalPlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalDentalPlansTable,
      LocalDentalPlan,
      $$LocalDentalPlansTableFilterComposer,
      $$LocalDentalPlansTableOrderingComposer,
      $$LocalDentalPlansTableAnnotationComposer,
      $$LocalDentalPlansTableCreateCompanionBuilder,
      $$LocalDentalPlansTableUpdateCompanionBuilder,
      (
        LocalDentalPlan,
        BaseReferences<_$AppDatabase, $LocalDentalPlansTable, LocalDentalPlan>,
      ),
      LocalDentalPlan,
      PrefetchHooks Function()
    >;
typedef $$LocalClinicsTableCreateCompanionBuilder =
    LocalClinicsCompanion Function({
      required String id,
      required String name,
      Value<String?> phone,
      Value<String?> city,
      Value<String?> district,
      Value<String?> address,
      required DateTime updatedAt,
      Value<DateTime?> createdAt,
      Value<DateTime?> expiresAt,
      Value<bool> active,
      Value<String> reactivationHistoryJson,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$LocalClinicsTableUpdateCompanionBuilder =
    LocalClinicsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> phone,
      Value<String?> city,
      Value<String?> district,
      Value<String?> address,
      Value<DateTime> updatedAt,
      Value<DateTime?> createdAt,
      Value<DateTime?> expiresAt,
      Value<bool> active,
      Value<String> reactivationHistoryJson,
      Value<bool> isSynced,
      Value<int> rowid,
    });

class $$LocalClinicsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalClinicsTable> {
  $$LocalClinicsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get district => $composableBuilder(
    column: $table.district,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reactivationHistoryJson => $composableBuilder(
    column: $table.reactivationHistoryJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalClinicsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalClinicsTable> {
  $$LocalClinicsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get district => $composableBuilder(
    column: $table.district,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reactivationHistoryJson => $composableBuilder(
    column: $table.reactivationHistoryJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalClinicsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalClinicsTable> {
  $$LocalClinicsTableAnnotationComposer({
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

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get district =>
      $composableBuilder(column: $table.district, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<String> get reactivationHistoryJson => $composableBuilder(
    column: $table.reactivationHistoryJson,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$LocalClinicsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalClinicsTable,
          LocalClinic,
          $$LocalClinicsTableFilterComposer,
          $$LocalClinicsTableOrderingComposer,
          $$LocalClinicsTableAnnotationComposer,
          $$LocalClinicsTableCreateCompanionBuilder,
          $$LocalClinicsTableUpdateCompanionBuilder,
          (
            LocalClinic,
            BaseReferences<_$AppDatabase, $LocalClinicsTable, LocalClinic>,
          ),
          LocalClinic,
          PrefetchHooks Function()
        > {
  $$LocalClinicsTableTableManager(_$AppDatabase db, $LocalClinicsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalClinicsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalClinicsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalClinicsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> city = const Value.absent(),
                Value<String?> district = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<DateTime?> expiresAt = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<String> reactivationHistoryJson = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalClinicsCompanion(
                id: id,
                name: name,
                phone: phone,
                city: city,
                district: district,
                address: address,
                updatedAt: updatedAt,
                createdAt: createdAt,
                expiresAt: expiresAt,
                active: active,
                reactivationHistoryJson: reactivationHistoryJson,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> phone = const Value.absent(),
                Value<String?> city = const Value.absent(),
                Value<String?> district = const Value.absent(),
                Value<String?> address = const Value.absent(),
                required DateTime updatedAt,
                Value<DateTime?> createdAt = const Value.absent(),
                Value<DateTime?> expiresAt = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<String> reactivationHistoryJson = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalClinicsCompanion.insert(
                id: id,
                name: name,
                phone: phone,
                city: city,
                district: district,
                address: address,
                updatedAt: updatedAt,
                createdAt: createdAt,
                expiresAt: expiresAt,
                active: active,
                reactivationHistoryJson: reactivationHistoryJson,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalClinicsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalClinicsTable,
      LocalClinic,
      $$LocalClinicsTableFilterComposer,
      $$LocalClinicsTableOrderingComposer,
      $$LocalClinicsTableAnnotationComposer,
      $$LocalClinicsTableCreateCompanionBuilder,
      $$LocalClinicsTableUpdateCompanionBuilder,
      (
        LocalClinic,
        BaseReferences<_$AppDatabase, $LocalClinicsTable, LocalClinic>,
      ),
      LocalClinic,
      PrefetchHooks Function()
    >;
typedef $$LocalClinicSettingsTableCreateCompanionBuilder =
    LocalClinicSettingsCompanion Function({
      required String clinicId,
      Value<int> reminderOffsetHours,
      Value<String> teethNumberingSystem,
      Value<String> toothActionsJson,
      Value<bool> whatsAppEnabled,
      Value<String?> whatsAppSenderNumber,
      Value<String?> whatsAppPhoneNumberId,
      Value<bool> smsEnabled,
      Value<bool> emailEnabled,
      Value<bool> phoneAuthEnabled,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$LocalClinicSettingsTableUpdateCompanionBuilder =
    LocalClinicSettingsCompanion Function({
      Value<String> clinicId,
      Value<int> reminderOffsetHours,
      Value<String> teethNumberingSystem,
      Value<String> toothActionsJson,
      Value<bool> whatsAppEnabled,
      Value<String?> whatsAppSenderNumber,
      Value<String?> whatsAppPhoneNumberId,
      Value<bool> smsEnabled,
      Value<bool> emailEnabled,
      Value<bool> phoneAuthEnabled,
      Value<bool> isSynced,
      Value<int> rowid,
    });

class $$LocalClinicSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalClinicSettingsTable> {
  $$LocalClinicSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get clinicId => $composableBuilder(
    column: $table.clinicId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reminderOffsetHours => $composableBuilder(
    column: $table.reminderOffsetHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get teethNumberingSystem => $composableBuilder(
    column: $table.teethNumberingSystem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get toothActionsJson => $composableBuilder(
    column: $table.toothActionsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get whatsAppEnabled => $composableBuilder(
    column: $table.whatsAppEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get whatsAppSenderNumber => $composableBuilder(
    column: $table.whatsAppSenderNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get whatsAppPhoneNumberId => $composableBuilder(
    column: $table.whatsAppPhoneNumberId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get smsEnabled => $composableBuilder(
    column: $table.smsEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get emailEnabled => $composableBuilder(
    column: $table.emailEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get phoneAuthEnabled => $composableBuilder(
    column: $table.phoneAuthEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalClinicSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalClinicSettingsTable> {
  $$LocalClinicSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get clinicId => $composableBuilder(
    column: $table.clinicId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reminderOffsetHours => $composableBuilder(
    column: $table.reminderOffsetHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get teethNumberingSystem => $composableBuilder(
    column: $table.teethNumberingSystem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get toothActionsJson => $composableBuilder(
    column: $table.toothActionsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get whatsAppEnabled => $composableBuilder(
    column: $table.whatsAppEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get whatsAppSenderNumber => $composableBuilder(
    column: $table.whatsAppSenderNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get whatsAppPhoneNumberId => $composableBuilder(
    column: $table.whatsAppPhoneNumberId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get smsEnabled => $composableBuilder(
    column: $table.smsEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get emailEnabled => $composableBuilder(
    column: $table.emailEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get phoneAuthEnabled => $composableBuilder(
    column: $table.phoneAuthEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalClinicSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalClinicSettingsTable> {
  $$LocalClinicSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get clinicId =>
      $composableBuilder(column: $table.clinicId, builder: (column) => column);

  GeneratedColumn<int> get reminderOffsetHours => $composableBuilder(
    column: $table.reminderOffsetHours,
    builder: (column) => column,
  );

  GeneratedColumn<String> get teethNumberingSystem => $composableBuilder(
    column: $table.teethNumberingSystem,
    builder: (column) => column,
  );

  GeneratedColumn<String> get toothActionsJson => $composableBuilder(
    column: $table.toothActionsJson,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get whatsAppEnabled => $composableBuilder(
    column: $table.whatsAppEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<String> get whatsAppSenderNumber => $composableBuilder(
    column: $table.whatsAppSenderNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get whatsAppPhoneNumberId => $composableBuilder(
    column: $table.whatsAppPhoneNumberId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get smsEnabled => $composableBuilder(
    column: $table.smsEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get emailEnabled => $composableBuilder(
    column: $table.emailEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get phoneAuthEnabled => $composableBuilder(
    column: $table.phoneAuthEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$LocalClinicSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalClinicSettingsTable,
          LocalClinicSetting,
          $$LocalClinicSettingsTableFilterComposer,
          $$LocalClinicSettingsTableOrderingComposer,
          $$LocalClinicSettingsTableAnnotationComposer,
          $$LocalClinicSettingsTableCreateCompanionBuilder,
          $$LocalClinicSettingsTableUpdateCompanionBuilder,
          (
            LocalClinicSetting,
            BaseReferences<
              _$AppDatabase,
              $LocalClinicSettingsTable,
              LocalClinicSetting
            >,
          ),
          LocalClinicSetting,
          PrefetchHooks Function()
        > {
  $$LocalClinicSettingsTableTableManager(
    _$AppDatabase db,
    $LocalClinicSettingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalClinicSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalClinicSettingsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalClinicSettingsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> clinicId = const Value.absent(),
                Value<int> reminderOffsetHours = const Value.absent(),
                Value<String> teethNumberingSystem = const Value.absent(),
                Value<String> toothActionsJson = const Value.absent(),
                Value<bool> whatsAppEnabled = const Value.absent(),
                Value<String?> whatsAppSenderNumber = const Value.absent(),
                Value<String?> whatsAppPhoneNumberId = const Value.absent(),
                Value<bool> smsEnabled = const Value.absent(),
                Value<bool> emailEnabled = const Value.absent(),
                Value<bool> phoneAuthEnabled = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalClinicSettingsCompanion(
                clinicId: clinicId,
                reminderOffsetHours: reminderOffsetHours,
                teethNumberingSystem: teethNumberingSystem,
                toothActionsJson: toothActionsJson,
                whatsAppEnabled: whatsAppEnabled,
                whatsAppSenderNumber: whatsAppSenderNumber,
                whatsAppPhoneNumberId: whatsAppPhoneNumberId,
                smsEnabled: smsEnabled,
                emailEnabled: emailEnabled,
                phoneAuthEnabled: phoneAuthEnabled,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String clinicId,
                Value<int> reminderOffsetHours = const Value.absent(),
                Value<String> teethNumberingSystem = const Value.absent(),
                Value<String> toothActionsJson = const Value.absent(),
                Value<bool> whatsAppEnabled = const Value.absent(),
                Value<String?> whatsAppSenderNumber = const Value.absent(),
                Value<String?> whatsAppPhoneNumberId = const Value.absent(),
                Value<bool> smsEnabled = const Value.absent(),
                Value<bool> emailEnabled = const Value.absent(),
                Value<bool> phoneAuthEnabled = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalClinicSettingsCompanion.insert(
                clinicId: clinicId,
                reminderOffsetHours: reminderOffsetHours,
                teethNumberingSystem: teethNumberingSystem,
                toothActionsJson: toothActionsJson,
                whatsAppEnabled: whatsAppEnabled,
                whatsAppSenderNumber: whatsAppSenderNumber,
                whatsAppPhoneNumberId: whatsAppPhoneNumberId,
                smsEnabled: smsEnabled,
                emailEnabled: emailEnabled,
                phoneAuthEnabled: phoneAuthEnabled,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalClinicSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalClinicSettingsTable,
      LocalClinicSetting,
      $$LocalClinicSettingsTableFilterComposer,
      $$LocalClinicSettingsTableOrderingComposer,
      $$LocalClinicSettingsTableAnnotationComposer,
      $$LocalClinicSettingsTableCreateCompanionBuilder,
      $$LocalClinicSettingsTableUpdateCompanionBuilder,
      (
        LocalClinicSetting,
        BaseReferences<
          _$AppDatabase,
          $LocalClinicSettingsTable,
          LocalClinicSetting
        >,
      ),
      LocalClinicSetting,
      PrefetchHooks Function()
    >;
typedef $$SyncQueueTableCreateCompanionBuilder =
    SyncQueueCompanion Function({
      Value<int> id,
      required String targetTable,
      required String recordId,
      required String operation,
      required String payload,
      required DateTime createdAt,
    });
typedef $$SyncQueueTableUpdateCompanionBuilder =
    SyncQueueCompanion Function({
      Value<int> id,
      Value<String> targetTable,
      Value<String> recordId,
      Value<String> operation,
      Value<String> payload,
      Value<DateTime> createdAt,
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
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetTable => $composableBuilder(
    column: $table.targetTable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recordId => $composableBuilder(
    column: $table.recordId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
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
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetTable => $composableBuilder(
    column: $table.targetTable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recordId => $composableBuilder(
    column: $table.recordId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
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
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get targetTable => $composableBuilder(
    column: $table.targetTable,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recordId =>
      $composableBuilder(column: $table.recordId, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SyncQueueTableTableManager
    extends
        RootTableManager<
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
            BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>,
          ),
          SyncQueueData,
          PrefetchHooks Function()
        > {
  $$SyncQueueTableTableManager(_$AppDatabase db, $SyncQueueTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> targetTable = const Value.absent(),
                Value<String> recordId = const Value.absent(),
                Value<String> operation = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SyncQueueCompanion(
                id: id,
                targetTable: targetTable,
                recordId: recordId,
                operation: operation,
                payload: payload,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String targetTable,
                required String recordId,
                required String operation,
                required String payload,
                required DateTime createdAt,
              }) => SyncQueueCompanion.insert(
                id: id,
                targetTable: targetTable,
                recordId: recordId,
                operation: operation,
                payload: payload,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncQueueTableProcessedTableManager =
    ProcessedTableManager<
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
        BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>,
      ),
      SyncQueueData,
      PrefetchHooks Function()
    >;
typedef $$SyncMetaTableCreateCompanionBuilder =
    SyncMetaCompanion Function({
      required String collectionName,
      required DateTime lastPullAt,
      Value<int> rowid,
    });
typedef $$SyncMetaTableUpdateCompanionBuilder =
    SyncMetaCompanion Function({
      Value<String> collectionName,
      Value<DateTime> lastPullAt,
      Value<int> rowid,
    });

class $$SyncMetaTableFilterComposer
    extends Composer<_$AppDatabase, $SyncMetaTable> {
  $$SyncMetaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get collectionName => $composableBuilder(
    column: $table.collectionName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastPullAt => $composableBuilder(
    column: $table.lastPullAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncMetaTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncMetaTable> {
  $$SyncMetaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get collectionName => $composableBuilder(
    column: $table.collectionName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastPullAt => $composableBuilder(
    column: $table.lastPullAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncMetaTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncMetaTable> {
  $$SyncMetaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get collectionName => $composableBuilder(
    column: $table.collectionName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastPullAt => $composableBuilder(
    column: $table.lastPullAt,
    builder: (column) => column,
  );
}

class $$SyncMetaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncMetaTable,
          SyncMetaData,
          $$SyncMetaTableFilterComposer,
          $$SyncMetaTableOrderingComposer,
          $$SyncMetaTableAnnotationComposer,
          $$SyncMetaTableCreateCompanionBuilder,
          $$SyncMetaTableUpdateCompanionBuilder,
          (
            SyncMetaData,
            BaseReferences<_$AppDatabase, $SyncMetaTable, SyncMetaData>,
          ),
          SyncMetaData,
          PrefetchHooks Function()
        > {
  $$SyncMetaTableTableManager(_$AppDatabase db, $SyncMetaTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncMetaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncMetaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncMetaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> collectionName = const Value.absent(),
                Value<DateTime> lastPullAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncMetaCompanion(
                collectionName: collectionName,
                lastPullAt: lastPullAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String collectionName,
                required DateTime lastPullAt,
                Value<int> rowid = const Value.absent(),
              }) => SyncMetaCompanion.insert(
                collectionName: collectionName,
                lastPullAt: lastPullAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncMetaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncMetaTable,
      SyncMetaData,
      $$SyncMetaTableFilterComposer,
      $$SyncMetaTableOrderingComposer,
      $$SyncMetaTableAnnotationComposer,
      $$SyncMetaTableCreateCompanionBuilder,
      $$SyncMetaTableUpdateCompanionBuilder,
      (
        SyncMetaData,
        BaseReferences<_$AppDatabase, $SyncMetaTable, SyncMetaData>,
      ),
      SyncMetaData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LocalPatientsTableTableManager get localPatients =>
      $$LocalPatientsTableTableManager(_db, _db.localPatients);
  $$LocalAppointmentsTableTableManager get localAppointments =>
      $$LocalAppointmentsTableTableManager(_db, _db.localAppointments);
  $$LocalDoctorsTableTableManager get localDoctors =>
      $$LocalDoctorsTableTableManager(_db, _db.localDoctors);
  $$LocalPaymentsTableTableManager get localPayments =>
      $$LocalPaymentsTableTableManager(_db, _db.localPayments);
  $$LocalToothRecordsTableTableManager get localToothRecords =>
      $$LocalToothRecordsTableTableManager(_db, _db.localToothRecords);
  $$LocalDentalPlansTableTableManager get localDentalPlans =>
      $$LocalDentalPlansTableTableManager(_db, _db.localDentalPlans);
  $$LocalClinicsTableTableManager get localClinics =>
      $$LocalClinicsTableTableManager(_db, _db.localClinics);
  $$LocalClinicSettingsTableTableManager get localClinicSettings =>
      $$LocalClinicSettingsTableTableManager(_db, _db.localClinicSettings);
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db, _db.syncQueue);
  $$SyncMetaTableTableManager get syncMeta =>
      $$SyncMetaTableTableManager(_db, _db.syncMeta);
}
