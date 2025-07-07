// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class WateringBenchmarkStruct extends FFFirebaseStruct {
  WateringBenchmarkStruct({
    String? value,
    String? unit,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _value = value,
        _unit = unit,
        super(firestoreUtilData);

  // "value" field.
  String? _value;
  String get value => _value ?? '';
  set value(String? val) => _value = val;

  bool hasValue() => _value != null;

  // "unit" field.
  String? _unit;
  String get unit => _unit ?? '';
  set unit(String? val) => _unit = val;

  bool hasUnit() => _unit != null;

  static WateringBenchmarkStruct fromMap(Map<String, dynamic> data) =>
      WateringBenchmarkStruct(
        value: data['value'] as String?,
        unit: data['unit'] as String?,
      );

  static WateringBenchmarkStruct? maybeFromMap(dynamic data) => data is Map
      ? WateringBenchmarkStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'value': _value,
        'unit': _unit,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'value': serializeParam(
          _value,
          ParamType.String,
        ),
        'unit': serializeParam(
          _unit,
          ParamType.String,
        ),
      }.withoutNulls;

  static WateringBenchmarkStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      WateringBenchmarkStruct(
        value: deserializeParam(
          data['value'],
          ParamType.String,
          false,
        ),
        unit: deserializeParam(
          data['unit'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'WateringBenchmarkStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is WateringBenchmarkStruct &&
        value == other.value &&
        unit == other.unit;
  }

  @override
  int get hashCode => const ListEquality().hash([value, unit]);
}

WateringBenchmarkStruct createWateringBenchmarkStruct({
  String? value,
  String? unit,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    WateringBenchmarkStruct(
      value: value,
      unit: unit,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

WateringBenchmarkStruct? updateWateringBenchmarkStruct(
  WateringBenchmarkStruct? wateringBenchmark, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    wateringBenchmark
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addWateringBenchmarkStructData(
  Map<String, dynamic> firestoreData,
  WateringBenchmarkStruct? wateringBenchmark,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (wateringBenchmark == null) {
    return;
  }
  if (wateringBenchmark.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && wateringBenchmark.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final wateringBenchmarkData =
      getWateringBenchmarkFirestoreData(wateringBenchmark, forFieldValue);
  final nestedData =
      wateringBenchmarkData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = wateringBenchmark.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getWateringBenchmarkFirestoreData(
  WateringBenchmarkStruct? wateringBenchmark, [
  bool forFieldValue = false,
]) {
  if (wateringBenchmark == null) {
    return {};
  }
  final firestoreData = mapToFirestore(wateringBenchmark.toMap());

  // Add any Firestore field values
  wateringBenchmark.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getWateringBenchmarkListFirestoreData(
  List<WateringBenchmarkStruct>? wateringBenchmarks,
) =>
    wateringBenchmarks
        ?.map((e) => getWateringBenchmarkFirestoreData(e, true))
        .toList() ??
    [];
