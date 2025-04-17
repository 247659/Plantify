// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PlantsInformationStruct extends BaseStruct {
  PlantsInformationStruct({
    String? id,
    String? commonName,
    String? originalUrl,
  })  : _id = id,
        _commonName = commonName,
        _originalUrl = originalUrl;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "commonName" field.
  String? _commonName;
  String get commonName => _commonName ?? '';
  set commonName(String? val) => _commonName = val;

  bool hasCommonName() => _commonName != null;

  // "originalUrl" field.
  String? _originalUrl;
  String get originalUrl => _originalUrl ?? '';
  set originalUrl(String? val) => _originalUrl = val;

  bool hasOriginalUrl() => _originalUrl != null;

  static PlantsInformationStruct fromMap(Map<String, dynamic> data) =>
      PlantsInformationStruct(
        id: data['id'] as String?,
        commonName: data['commonName'] as String?,
        originalUrl: data['originalUrl'] as String?,
      );

  static PlantsInformationStruct? maybeFromMap(dynamic data) => data is Map
      ? PlantsInformationStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'commonName': _commonName,
        'originalUrl': _originalUrl,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'commonName': serializeParam(
          _commonName,
          ParamType.String,
        ),
        'originalUrl': serializeParam(
          _originalUrl,
          ParamType.String,
        ),
      }.withoutNulls;

  static PlantsInformationStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      PlantsInformationStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        commonName: deserializeParam(
          data['commonName'],
          ParamType.String,
          false,
        ),
        originalUrl: deserializeParam(
          data['originalUrl'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'PlantsInformationStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PlantsInformationStruct &&
        id == other.id &&
        commonName == other.commonName &&
        originalUrl == other.originalUrl;
  }

  @override
  int get hashCode => const ListEquality().hash([id, commonName, originalUrl]);
}

PlantsInformationStruct createPlantsInformationStruct({
  String? id,
  String? commonName,
  String? originalUrl,
}) =>
    PlantsInformationStruct(
      id: id,
      commonName: commonName,
      originalUrl: originalUrl,
    );
