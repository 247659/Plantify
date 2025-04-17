// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RecognizeFamilyStruct extends BaseStruct {
  RecognizeFamilyStruct({
    String? scientificNameWithoutAuthor,
    String? scientificNameWithAuthorship,
    String? scientificName,
  })  : _scientificNameWithoutAuthor = scientificNameWithoutAuthor,
        _scientificNameWithAuthorship = scientificNameWithAuthorship,
        _scientificName = scientificName;

  // "scientificNameWithoutAuthor" field.
  String? _scientificNameWithoutAuthor;
  String get scientificNameWithoutAuthor => _scientificNameWithoutAuthor ?? '';
  set scientificNameWithoutAuthor(String? val) =>
      _scientificNameWithoutAuthor = val;

  bool hasScientificNameWithoutAuthor() => _scientificNameWithoutAuthor != null;

  // "scientificNameWithAuthorship" field.
  String? _scientificNameWithAuthorship;
  String get scientificNameWithAuthorship =>
      _scientificNameWithAuthorship ?? '';
  set scientificNameWithAuthorship(String? val) =>
      _scientificNameWithAuthorship = val;

  bool hasScientificNameWithAuthorship() =>
      _scientificNameWithAuthorship != null;

  // "scientificName" field.
  String? _scientificName;
  String get scientificName => _scientificName ?? '';
  set scientificName(String? val) => _scientificName = val;

  bool hasScientificName() => _scientificName != null;

  static RecognizeFamilyStruct fromMap(Map<String, dynamic> data) =>
      RecognizeFamilyStruct(
        scientificNameWithoutAuthor:
            data['scientificNameWithoutAuthor'] as String?,
        scientificNameWithAuthorship:
            data['scientificNameWithAuthorship'] as String?,
        scientificName: data['scientificName'] as String?,
      );

  static RecognizeFamilyStruct? maybeFromMap(dynamic data) => data is Map
      ? RecognizeFamilyStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'scientificNameWithoutAuthor': _scientificNameWithoutAuthor,
        'scientificNameWithAuthorship': _scientificNameWithAuthorship,
        'scientificName': _scientificName,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'scientificNameWithoutAuthor': serializeParam(
          _scientificNameWithoutAuthor,
          ParamType.String,
        ),
        'scientificNameWithAuthorship': serializeParam(
          _scientificNameWithAuthorship,
          ParamType.String,
        ),
        'scientificName': serializeParam(
          _scientificName,
          ParamType.String,
        ),
      }.withoutNulls;

  static RecognizeFamilyStruct fromSerializableMap(Map<String, dynamic> data) =>
      RecognizeFamilyStruct(
        scientificNameWithoutAuthor: deserializeParam(
          data['scientificNameWithoutAuthor'],
          ParamType.String,
          false,
        ),
        scientificNameWithAuthorship: deserializeParam(
          data['scientificNameWithAuthorship'],
          ParamType.String,
          false,
        ),
        scientificName: deserializeParam(
          data['scientificName'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'RecognizeFamilyStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is RecognizeFamilyStruct &&
        scientificNameWithoutAuthor == other.scientificNameWithoutAuthor &&
        scientificNameWithAuthorship == other.scientificNameWithAuthorship &&
        scientificName == other.scientificName;
  }

  @override
  int get hashCode => const ListEquality().hash([
        scientificNameWithoutAuthor,
        scientificNameWithAuthorship,
        scientificName
      ]);
}

RecognizeFamilyStruct createRecognizeFamilyStruct({
  String? scientificNameWithoutAuthor,
  String? scientificNameWithAuthorship,
  String? scientificName,
}) =>
    RecognizeFamilyStruct(
      scientificNameWithoutAuthor: scientificNameWithoutAuthor,
      scientificNameWithAuthorship: scientificNameWithAuthorship,
      scientificName: scientificName,
    );
