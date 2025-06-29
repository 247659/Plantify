// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RecognizeGenusStruct extends FFFirebaseStruct {
  RecognizeGenusStruct({
    String? scientificNameWithoutAuthor,
    String? scientificNameWithAuthorship,
    String? scientificName,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _scientificNameWithoutAuthor = scientificNameWithoutAuthor,
        _scientificNameWithAuthorship = scientificNameWithAuthorship,
        _scientificName = scientificName,
        super(firestoreUtilData);

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

  static RecognizeGenusStruct fromMap(Map<String, dynamic> data) =>
      RecognizeGenusStruct(
        scientificNameWithoutAuthor:
            data['scientificNameWithoutAuthor'] as String?,
        scientificNameWithAuthorship:
            data['scientificNameWithAuthorship'] as String?,
        scientificName: data['scientificName'] as String?,
      );

  static RecognizeGenusStruct? maybeFromMap(dynamic data) => data is Map
      ? RecognizeGenusStruct.fromMap(data.cast<String, dynamic>())
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

  static RecognizeGenusStruct fromSerializableMap(Map<String, dynamic> data) =>
      RecognizeGenusStruct(
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
  String toString() => 'RecognizeGenusStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is RecognizeGenusStruct &&
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

RecognizeGenusStruct createRecognizeGenusStruct({
  String? scientificNameWithoutAuthor,
  String? scientificNameWithAuthorship,
  String? scientificName,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    RecognizeGenusStruct(
      scientificNameWithoutAuthor: scientificNameWithoutAuthor,
      scientificNameWithAuthorship: scientificNameWithAuthorship,
      scientificName: scientificName,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

RecognizeGenusStruct? updateRecognizeGenusStruct(
  RecognizeGenusStruct? recognizeGenus, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    recognizeGenus
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addRecognizeGenusStructData(
  Map<String, dynamic> firestoreData,
  RecognizeGenusStruct? recognizeGenus,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (recognizeGenus == null) {
    return;
  }
  if (recognizeGenus.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && recognizeGenus.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final recognizeGenusData =
      getRecognizeGenusFirestoreData(recognizeGenus, forFieldValue);
  final nestedData =
      recognizeGenusData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = recognizeGenus.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getRecognizeGenusFirestoreData(
  RecognizeGenusStruct? recognizeGenus, [
  bool forFieldValue = false,
]) {
  if (recognizeGenus == null) {
    return {};
  }
  final firestoreData = mapToFirestore(recognizeGenus.toMap());

  // Add any Firestore field values
  recognizeGenus.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getRecognizeGenusListFirestoreData(
  List<RecognizeGenusStruct>? recognizeGenuss,
) =>
    recognizeGenuss
        ?.map((e) => getRecognizeGenusFirestoreData(e, true))
        .toList() ??
    [];
