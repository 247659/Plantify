// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GuideStruct extends FFFirebaseStruct {
  GuideStruct({
    String? id,
    String? speciesId,
    String? commonName,
    String? watering,
    String? sunLight,
    String? pruning,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _speciesId = speciesId,
        _commonName = commonName,
        _watering = watering,
        _sunLight = sunLight,
        _pruning = pruning,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "speciesId" field.
  String? _speciesId;
  String get speciesId => _speciesId ?? '';
  set speciesId(String? val) => _speciesId = val;

  bool hasSpeciesId() => _speciesId != null;

  // "commonName" field.
  String? _commonName;
  String get commonName => _commonName ?? '';
  set commonName(String? val) => _commonName = val;

  bool hasCommonName() => _commonName != null;

  // "watering" field.
  String? _watering;
  String get watering => _watering ?? '';
  set watering(String? val) => _watering = val;

  bool hasWatering() => _watering != null;

  // "sunLight" field.
  String? _sunLight;
  String get sunLight => _sunLight ?? '';
  set sunLight(String? val) => _sunLight = val;

  bool hasSunLight() => _sunLight != null;

  // "pruning" field.
  String? _pruning;
  String get pruning => _pruning ?? '';
  set pruning(String? val) => _pruning = val;

  bool hasPruning() => _pruning != null;

  static GuideStruct fromMap(Map<String, dynamic> data) => GuideStruct(
        id: data['id'] as String?,
        speciesId: data['speciesId'] as String?,
        commonName: data['commonName'] as String?,
        watering: data['watering'] as String?,
        sunLight: data['sunLight'] as String?,
        pruning: data['pruning'] as String?,
      );

  static GuideStruct? maybeFromMap(dynamic data) =>
      data is Map ? GuideStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'speciesId': _speciesId,
        'commonName': _commonName,
        'watering': _watering,
        'sunLight': _sunLight,
        'pruning': _pruning,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'speciesId': serializeParam(
          _speciesId,
          ParamType.String,
        ),
        'commonName': serializeParam(
          _commonName,
          ParamType.String,
        ),
        'watering': serializeParam(
          _watering,
          ParamType.String,
        ),
        'sunLight': serializeParam(
          _sunLight,
          ParamType.String,
        ),
        'pruning': serializeParam(
          _pruning,
          ParamType.String,
        ),
      }.withoutNulls;

  static GuideStruct fromSerializableMap(Map<String, dynamic> data) =>
      GuideStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        speciesId: deserializeParam(
          data['speciesId'],
          ParamType.String,
          false,
        ),
        commonName: deserializeParam(
          data['commonName'],
          ParamType.String,
          false,
        ),
        watering: deserializeParam(
          data['watering'],
          ParamType.String,
          false,
        ),
        sunLight: deserializeParam(
          data['sunLight'],
          ParamType.String,
          false,
        ),
        pruning: deserializeParam(
          data['pruning'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'GuideStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is GuideStruct &&
        id == other.id &&
        speciesId == other.speciesId &&
        commonName == other.commonName &&
        watering == other.watering &&
        sunLight == other.sunLight &&
        pruning == other.pruning;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([id, speciesId, commonName, watering, sunLight, pruning]);
}

GuideStruct createGuideStruct({
  String? id,
  String? speciesId,
  String? commonName,
  String? watering,
  String? sunLight,
  String? pruning,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    GuideStruct(
      id: id,
      speciesId: speciesId,
      commonName: commonName,
      watering: watering,
      sunLight: sunLight,
      pruning: pruning,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

GuideStruct? updateGuideStruct(
  GuideStruct? guide, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    guide
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addGuideStructData(
  Map<String, dynamic> firestoreData,
  GuideStruct? guide,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (guide == null) {
    return;
  }
  if (guide.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && guide.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final guideData = getGuideFirestoreData(guide, forFieldValue);
  final nestedData = guideData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = guide.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getGuideFirestoreData(
  GuideStruct? guide, [
  bool forFieldValue = false,
]) {
  if (guide == null) {
    return {};
  }
  final firestoreData = mapToFirestore(guide.toMap());

  // Add any Firestore field values
  guide.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getGuideListFirestoreData(
  List<GuideStruct>? guides,
) =>
    guides?.map((e) => getGuideFirestoreData(e, true)).toList() ?? [];
