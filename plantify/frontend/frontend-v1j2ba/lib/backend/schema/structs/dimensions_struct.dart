// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DimensionsStruct extends BaseStruct {
  DimensionsStruct({
    String? type,
    String? minValue,
    String? maxValue,
    String? unit,
  })  : _type = type,
        _minValue = minValue,
        _maxValue = maxValue,
        _unit = unit;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) => _type = val;

  bool hasType() => _type != null;

  // "minValue" field.
  String? _minValue;
  String get minValue => _minValue ?? '';
  set minValue(String? val) => _minValue = val;

  bool hasMinValue() => _minValue != null;

  // "maxValue" field.
  String? _maxValue;
  String get maxValue => _maxValue ?? '';
  set maxValue(String? val) => _maxValue = val;

  bool hasMaxValue() => _maxValue != null;

  // "unit" field.
  String? _unit;
  String get unit => _unit ?? '';
  set unit(String? val) => _unit = val;

  bool hasUnit() => _unit != null;

  static DimensionsStruct fromMap(Map<String, dynamic> data) =>
      DimensionsStruct(
        type: data['type'] as String?,
        minValue: data['minValue'] as String?,
        maxValue: data['maxValue'] as String?,
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
          ParamType.String,
        ),
        'maxValue': serializeParam(
          _maxValue,
          ParamType.String,
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
          ParamType.String,
          false,
        ),
        maxValue: deserializeParam(
          data['maxValue'],
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
  String? minValue,
  String? maxValue,
  String? unit,
}) =>
    DimensionsStruct(
      type: type,
      minValue: minValue,
      maxValue: maxValue,
      unit: unit,
    );
