// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PlantPartStruct extends BaseStruct {
  PlantPartStruct({
    String? part,
    List<String>? color,
  })  : _part = part,
        _color = color;

  // "part" field.
  String? _part;
  String get part => _part ?? '';
  set part(String? val) => _part = val;

  bool hasPart() => _part != null;

  // "color" field.
  List<String>? _color;
  List<String> get color => _color ?? const [];
  set color(List<String>? val) => _color = val;

  void updateColor(Function(List<String>) updateFn) {
    updateFn(_color ??= []);
  }

  bool hasColor() => _color != null;

  static PlantPartStruct fromMap(Map<String, dynamic> data) => PlantPartStruct(
        part: data['part'] as String?,
        color: getDataList(data['color']),
      );

  static PlantPartStruct? maybeFromMap(dynamic data) => data is Map
      ? PlantPartStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'part': _part,
        'color': _color,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'part': serializeParam(
          _part,
          ParamType.String,
        ),
        'color': serializeParam(
          _color,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static PlantPartStruct fromSerializableMap(Map<String, dynamic> data) =>
      PlantPartStruct(
        part: deserializeParam(
          data['part'],
          ParamType.String,
          false,
        ),
        color: deserializeParam<String>(
          data['color'],
          ParamType.String,
          true,
        ),
      );

  @override
  String toString() => 'PlantPartStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is PlantPartStruct &&
        part == other.part &&
        listEquality.equals(color, other.color);
  }

  @override
  int get hashCode => const ListEquality().hash([part, color]);
}

PlantPartStruct createPlantPartStruct({
  String? part,
}) =>
    PlantPartStruct(
      part: part,
    );
