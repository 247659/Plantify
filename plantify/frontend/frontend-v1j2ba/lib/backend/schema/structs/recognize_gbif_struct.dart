// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RecognizeGbifStruct extends BaseStruct {
  RecognizeGbifStruct({
    String? id,
  }) : _id = id;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  static RecognizeGbifStruct fromMap(Map<String, dynamic> data) =>
      RecognizeGbifStruct(
        id: data['id'] as String?,
      );

  static RecognizeGbifStruct? maybeFromMap(dynamic data) => data is Map
      ? RecognizeGbifStruct.fromMap(data.cast<String, dynamic>())
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

  static RecognizeGbifStruct fromSerializableMap(Map<String, dynamic> data) =>
      RecognizeGbifStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'RecognizeGbifStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is RecognizeGbifStruct && id == other.id;
  }

  @override
  int get hashCode => const ListEquality().hash([id]);
}

RecognizeGbifStruct createRecognizeGbifStruct({
  String? id,
}) =>
    RecognizeGbifStruct(
      id: id,
    );
