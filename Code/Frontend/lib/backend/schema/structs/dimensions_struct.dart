// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DimensionsStruct extends FFFirebaseStruct {
  DimensionsStruct({
    String? type,
    int? minValue,
    int? maxValue,
    String? unit,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _type = type,
        _minValue = minValue,
        _maxValue = maxValue,
        _unit = unit,
        super(firestoreUtilData);

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) => _type = val;

  bool hasType() => _type != null;

  // "minValue" field.
  int? _minValue;
  int get minValue => _minValue ?? 0;
  set minValue(int? val) => _minValue = val;

  void incrementMinValue(int amount) => minValue = minValue + amount;

  bool hasMinValue() => _minValue != null;

  // "maxValue" field.
  int? _maxValue;
  int get maxValue => _maxValue ?? 0;
  set maxValue(int? val) => _maxValue = val;

  void incrementMaxValue(int amount) => maxValue = maxValue + amount;

  bool hasMaxValue() => _maxValue != null;

  // "unit" field.
  String? _unit;
  String get unit => _unit ?? '';
  set unit(String? val) => _unit = val;

  bool hasUnit() => _unit != null;

  static DimensionsStruct fromMap(Map<String, dynamic> data) =>
      DimensionsStruct(
        type: data['type'] as String?,
        minValue: castToType<int>(data['minValue']),
        maxValue: castToType<int>(data['maxValue']),
        unit: data['unit'] as String?,
      );

  static DimensionsStruct? maybeFromMap(dynamic data) => data is Map
      ? DimensionsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'type': _type,
        'minValue': _minValue,
        'maxValue': _maxValue,
        'unit': _unit,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'type': serializeParam(
          _type,
          ParamType.String,
        ),
        'minValue': serializeParam(
          _minValue,
          ParamType.int,
        ),
        'maxValue': serializeParam(
          _maxValue,
          ParamType.int,
        ),
        'unit': serializeParam(
          _unit,
          ParamType.String,
        ),
      }.withoutNulls;

  static DimensionsStruct fromSerializableMap(Map<String, dynamic> data) =>
      DimensionsStruct(
        type: deserializeParam(
          data['type'],
          ParamType.String,
          false,
        ),
        minValue: deserializeParam(
          data['minValue'],
          ParamType.int,
          false,
        ),
        maxValue: deserializeParam(
          data['maxValue'],
          ParamType.int,
          false,
        ),
        unit: deserializeParam(
          data['unit'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'DimensionsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DimensionsStruct &&
        type == other.type &&
        minValue == other.minValue &&
        maxValue == other.maxValue &&
        unit == other.unit;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([type, minValue, maxValue, unit]);
}

DimensionsStruct createDimensionsStruct({
  String? type,
  int? minValue,
  int? maxValue,
  String? unit,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    DimensionsStruct(
      type: type,
      minValue: minValue,
      maxValue: maxValue,
      unit: unit,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

DimensionsStruct? updateDimensionsStruct(
  DimensionsStruct? dimensions, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    dimensions
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addDimensionsStructData(
  Map<String, dynamic> firestoreData,
  DimensionsStruct? dimensions,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (dimensions == null) {
    return;
  }
  if (dimensions.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && dimensions.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final dimensionsData = getDimensionsFirestoreData(dimensions, forFieldValue);
  final nestedData = dimensionsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = dimensions.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getDimensionsFirestoreData(
  DimensionsStruct? dimensions, [
  bool forFieldValue = false,
]) {
  if (dimensions == null) {
    return {};
  }
  final firestoreData = mapToFirestore(dimensions.toMap());

  // Add any Firestore field values
  dimensions.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getDimensionsListFirestoreData(
  List<DimensionsStruct>? dimensionss,
) =>
    dimensionss?.map((e) => getDimensionsFirestoreData(e, true)).toList() ?? [];
