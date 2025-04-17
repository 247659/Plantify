// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class WateringBenchmarkStruct extends BaseStruct {
  WateringBenchmarkStruct({
    String? value,
    String? unit,
  })  : _value = value,
        _unit = unit;

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
}) =>
    WateringBenchmarkStruct(
      value: value,
      unit: unit,
    );
