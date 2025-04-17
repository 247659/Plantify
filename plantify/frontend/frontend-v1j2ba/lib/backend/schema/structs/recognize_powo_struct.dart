// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RecognizePowoStruct extends BaseStruct {
  RecognizePowoStruct({
    String? id,
  }) : _id = id;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  static RecognizePowoStruct fromMap(Map<String, dynamic> data) =>
      RecognizePowoStruct(
        id: data['id'] as String?,
      );

  static RecognizePowoStruct? maybeFromMap(dynamic data) => data is Map
      ? RecognizePowoStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
      }.withoutNulls;

  static RecognizePowoStruct fromSerializableMap(Map<String, dynamic> data) =>
      RecognizePowoStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'RecognizePowoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is RecognizePowoStruct && id == other.id;
  }

  @override
  int get hashCode => const ListEquality().hash([id]);
}

RecognizePowoStruct createRecognizePowoStruct({
  String? id,
}) =>
    RecognizePowoStruct(
      id: id,
    );
