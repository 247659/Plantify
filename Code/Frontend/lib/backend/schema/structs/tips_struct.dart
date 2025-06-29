// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TipsStruct extends FFFirebaseStruct {
  TipsStruct({
    String? wateringEng,
    String? sunlightEng,
    String? pruningEng,
    String? fertilizationEng,
    String? wateringPl,
    String? sunlightPl,
    String? pruningPl,
    String? fertilizationPl,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _wateringEng = wateringEng,
        _sunlightEng = sunlightEng,
        _pruningEng = pruningEng,
        _fertilizationEng = fertilizationEng,
        _wateringPl = wateringPl,
        _sunlightPl = sunlightPl,
        _pruningPl = pruningPl,
        _fertilizationPl = fertilizationPl,
        super(firestoreUtilData);

  // "watering_eng" field.
  String? _wateringEng;
  String get wateringEng => _wateringEng ?? '';
  set wateringEng(String? val) => _wateringEng = val;

  bool hasWateringEng() => _wateringEng != null;

  // "sunlight_eng" field.
  String? _sunlightEng;
  String get sunlightEng => _sunlightEng ?? '';
  set sunlightEng(String? val) => _sunlightEng = val;

  bool hasSunlightEng() => _sunlightEng != null;

  // "pruning_eng" field.
  String? _pruningEng;
  String get pruningEng => _pruningEng ?? '';
  set pruningEng(String? val) => _pruningEng = val;

  bool hasPruningEng() => _pruningEng != null;

  // "fertilization_eng" field.
  String? _fertilizationEng;
  String get fertilizationEng => _fertilizationEng ?? '';
  set fertilizationEng(String? val) => _fertilizationEng = val;

  bool hasFertilizationEng() => _fertilizationEng != null;

  // "watering_pl" field.
  String? _wateringPl;
  String get wateringPl => _wateringPl ?? '';
  set wateringPl(String? val) => _wateringPl = val;

  bool hasWateringPl() => _wateringPl != null;

  // "sunlight_pl" field.
  String? _sunlightPl;
  String get sunlightPl => _sunlightPl ?? '';
  set sunlightPl(String? val) => _sunlightPl = val;

  bool hasSunlightPl() => _sunlightPl != null;

  // "pruning_pl" field.
  String? _pruningPl;
  String get pruningPl => _pruningPl ?? '';
  set pruningPl(String? val) => _pruningPl = val;

  bool hasPruningPl() => _pruningPl != null;

  // "fertilization_pl" field.
  String? _fertilizationPl;
  String get fertilizationPl => _fertilizationPl ?? '';
  set fertilizationPl(String? val) => _fertilizationPl = val;

  bool hasFertilizationPl() => _fertilizationPl != null;

  static TipsStruct fromMap(Map<String, dynamic> data) => TipsStruct(
        wateringEng: data['watering_eng'] as String?,
        sunlightEng: data['sunlight_eng'] as String?,
        pruningEng: data['pruning_eng'] as String?,
        fertilizationEng: data['fertilization_eng'] as String?,
        wateringPl: data['watering_pl'] as String?,
        sunlightPl: data['sunlight_pl'] as String?,
        pruningPl: data['pruning_pl'] as String?,
        fertilizationPl: data['fertilization_pl'] as String?,
      );

  static TipsStruct? maybeFromMap(dynamic data) =>
      data is Map ? TipsStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'watering_eng': _wateringEng,
        'sunlight_eng': _sunlightEng,
        'pruning_eng': _pruningEng,
        'fertilization_eng': _fertilizationEng,
        'watering_pl': _wateringPl,
        'sunlight_pl': _sunlightPl,
        'pruning_pl': _pruningPl,
        'fertilization_pl': _fertilizationPl,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'watering_eng': serializeParam(
          _wateringEng,
          ParamType.String,
        ),
        'sunlight_eng': serializeParam(
          _sunlightEng,
          ParamType.String,
        ),
        'pruning_eng': serializeParam(
          _pruningEng,
          ParamType.String,
        ),
        'fertilization_eng': serializeParam(
          _fertilizationEng,
          ParamType.String,
        ),
        'watering_pl': serializeParam(
          _wateringPl,
          ParamType.String,
        ),
        'sunlight_pl': serializeParam(
          _sunlightPl,
          ParamType.String,
        ),
        'pruning_pl': serializeParam(
          _pruningPl,
          ParamType.String,
        ),
        'fertilization_pl': serializeParam(
          _fertilizationPl,
          ParamType.String,
        ),
      }.withoutNulls;

  static TipsStruct fromSerializableMap(Map<String, dynamic> data) =>
      TipsStruct(
        wateringEng: deserializeParam(
          data['watering_eng'],
          ParamType.String,
          false,
        ),
        sunlightEng: deserializeParam(
          data['sunlight_eng'],
          ParamType.String,
          false,
        ),
        pruningEng: deserializeParam(
          data['pruning_eng'],
          ParamType.String,
          false,
        ),
        fertilizationEng: deserializeParam(
          data['fertilization_eng'],
          ParamType.String,
          false,
        ),
        wateringPl: deserializeParam(
          data['watering_pl'],
          ParamType.String,
          false,
        ),
        sunlightPl: deserializeParam(
          data['sunlight_pl'],
          ParamType.String,
          false,
        ),
        pruningPl: deserializeParam(
          data['pruning_pl'],
          ParamType.String,
          false,
        ),
        fertilizationPl: deserializeParam(
          data['fertilization_pl'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'TipsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TipsStruct &&
        wateringEng == other.wateringEng &&
        sunlightEng == other.sunlightEng &&
        pruningEng == other.pruningEng &&
        fertilizationEng == other.fertilizationEng &&
        wateringPl == other.wateringPl &&
        sunlightPl == other.sunlightPl &&
        pruningPl == other.pruningPl &&
        fertilizationPl == other.fertilizationPl;
  }

  @override
  int get hashCode => const ListEquality().hash([
        wateringEng,
        sunlightEng,
        pruningEng,
        fertilizationEng,
        wateringPl,
        sunlightPl,
        pruningPl,
        fertilizationPl
      ]);
}

TipsStruct createTipsStruct({
  String? wateringEng,
  String? sunlightEng,
  String? pruningEng,
  String? fertilizationEng,
  String? wateringPl,
  String? sunlightPl,
  String? pruningPl,
  String? fertilizationPl,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    TipsStruct(
      wateringEng: wateringEng,
      sunlightEng: sunlightEng,
      pruningEng: pruningEng,
      fertilizationEng: fertilizationEng,
      wateringPl: wateringPl,
      sunlightPl: sunlightPl,
      pruningPl: pruningPl,
      fertilizationPl: fertilizationPl,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

TipsStruct? updateTipsStruct(
  TipsStruct? tips, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    tips
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addTipsStructData(
  Map<String, dynamic> firestoreData,
  TipsStruct? tips,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (tips == null) {
    return;
  }
  if (tips.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue && tips.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final tipsData = getTipsFirestoreData(tips, forFieldValue);
  final nestedData = tipsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = tips.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getTipsFirestoreData(
  TipsStruct? tips, [
  bool forFieldValue = false,
]) {
  if (tips == null) {
    return {};
  }
  final firestoreData = mapToFirestore(tips.toMap());

  // Add any Firestore field values
  tips.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getTipsListFirestoreData(
  List<TipsStruct>? tipss,
) =>
    tipss?.map((e) => getTipsFirestoreData(e, true)).toList() ?? [];
