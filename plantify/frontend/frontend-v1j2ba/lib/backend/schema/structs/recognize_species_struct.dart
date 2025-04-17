// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RecognizeSpeciesStruct extends BaseStruct {
  RecognizeSpeciesStruct({
    String? scientificNameWithoutAuthor,
    String? scientificNameWithAuthorship,
    RecognizeGenusStruct? genus,
    RecognizeFamilyStruct? family,
    List<String>? commonNames,
    String? scientificName,
  })  : _scientificNameWithoutAuthor = scientificNameWithoutAuthor,
        _scientificNameWithAuthorship = scientificNameWithAuthorship,
        _genus = genus,
        _family = family,
        _commonNames = commonNames,
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

  // "genus" field.
  RecognizeGenusStruct? _genus;
  RecognizeGenusStruct get genus => _genus ?? RecognizeGenusStruct();
  set genus(RecognizeGenusStruct? val) => _genus = val;

  void updateGenus(Function(RecognizeGenusStruct) updateFn) {
    updateFn(_genus ??= RecognizeGenusStruct());
  }

  bool hasGenus() => _genus != null;

  // "family" field.
  RecognizeFamilyStruct? _family;
  RecognizeFamilyStruct get family => _family ?? RecognizeFamilyStruct();
  set family(RecognizeFamilyStruct? val) => _family = val;

  void updateFamily(Function(RecognizeFamilyStruct) updateFn) {
    updateFn(_family ??= RecognizeFamilyStruct());
  }

  bool hasFamily() => _family != null;

  // "commonNames" field.
  List<String>? _commonNames;
  List<String> get commonNames => _commonNames ?? const [];
  set commonNames(List<String>? val) => _commonNames = val;

  void updateCommonNames(Function(List<String>) updateFn) {
    updateFn(_commonNames ??= []);
  }

  bool hasCommonNames() => _commonNames != null;

  // "scientificName" field.
  String? _scientificName;
  String get scientificName => _scientificName ?? '';
  set scientificName(String? val) => _scientificName = val;

  bool hasScientificName() => _scientificName != null;

  static RecognizeSpeciesStruct fromMap(Map<String, dynamic> data) =>
      RecognizeSpeciesStruct(
        scientificNameWithoutAuthor:
            data['scientificNameWithoutAuthor'] as String?,
        scientificNameWithAuthorship:
            data['scientificNameWithAuthorship'] as String?,
        genus: data['genus'] is RecognizeGenusStruct
            ? data['genus']
            : RecognizeGenusStruct.maybeFromMap(data['genus']),
        family: data['family'] is RecognizeFamilyStruct
            ? data['family']
            : RecognizeFamilyStruct.maybeFromMap(data['family']),
        commonNames: getDataList(data['commonNames']),
        scientificName: data['scientificName'] as String?,
      );

  static RecognizeSpeciesStruct? maybeFromMap(dynamic data) => data is Map
      ? RecognizeSpeciesStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'scientificNameWithoutAuthor': _scientificNameWithoutAuthor,
        'scientificNameWithAuthorship': _scientificNameWithAuthorship,
        'genus': _genus?.toMap(),
        'family': _family?.toMap(),
        'commonNames': _commonNames,
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
        'genus': serializeParam(
          _genus,
          ParamType.DataStruct,
        ),
        'family': serializeParam(
          _family,
          ParamType.DataStruct,
        ),
        'commonNames': serializeParam(
          _commonNames,
          ParamType.String,
          isList: true,
        ),
        'scientificName': serializeParam(
          _scientificName,
          ParamType.String,
        ),
      }.withoutNulls;

  static RecognizeSpeciesStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      RecognizeSpeciesStruct(
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
        genus: deserializeStructParam(
          data['genus'],
          ParamType.DataStruct,
          false,
          structBuilder: RecognizeGenusStruct.fromSerializableMap,
        ),
        family: deserializeStructParam(
          data['family'],
          ParamType.DataStruct,
          false,
          structBuilder: RecognizeFamilyStruct.fromSerializableMap,
        ),
        commonNames: deserializeParam<String>(
          data['commonNames'],
          ParamType.String,
          true,
        ),
        scientificName: deserializeParam(
          data['scientificName'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'RecognizeSpeciesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is RecognizeSpeciesStruct &&
        scientificNameWithoutAuthor == other.scientificNameWithoutAuthor &&
        scientificNameWithAuthorship == other.scientificNameWithAuthorship &&
        genus == other.genus &&
        family == other.family &&
        listEquality.equals(commonNames, other.commonNames) &&
        scientificName == other.scientificName;
  }

  @override
  int get hashCode => const ListEquality().hash([
        scientificNameWithoutAuthor,
        scientificNameWithAuthorship,
        genus,
        family,
        commonNames,
        scientificName
      ]);
}

RecognizeSpeciesStruct createRecognizeSpeciesStruct({
  String? scientificNameWithoutAuthor,
  String? scientificNameWithAuthorship,
  RecognizeGenusStruct? genus,
  RecognizeFamilyStruct? family,
  String? scientificName,
}) =>
    RecognizeSpeciesStruct(
      scientificNameWithoutAuthor: scientificNameWithoutAuthor,
      scientificNameWithAuthorship: scientificNameWithAuthorship,
      genus: genus ?? RecognizeGenusStruct(),
      family: family ?? RecognizeFamilyStruct(),
      scientificName: scientificName,
    );
