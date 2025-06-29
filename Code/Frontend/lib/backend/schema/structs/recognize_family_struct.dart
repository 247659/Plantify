// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RecognizeFamilyStruct extends FFFirebaseStruct {
  RecognizeFamilyStruct({
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
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    RecognizeFamilyStruct(
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

RecognizeFamilyStruct? updateRecognizeFamilyStruct(
  RecognizeFamilyStruct? recognizeFamily, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    recognizeFamily
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addRecognizeFamilyStructData(
  Map<String, dynamic> firestoreData,
  RecognizeFamilyStruct? recognizeFamily,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (recognizeFamily == null) {
    return;
  }
  if (recognizeFamily.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && recognizeFamily.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final recognizeFamilyData =
      getRecognizeFamilyFirestoreData(recognizeFamily, forFieldValue);
  final nestedData =
      recognizeFamilyData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = recognizeFamily.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getRecognizeFamilyFirestoreData(
  RecognizeFamilyStruct? recognizeFamily, [
  bool forFieldValue = false,
]) {
  if (recognizeFamily == null) {
    return {};
  }
  final firestoreData = mapToFirestore(recognizeFamily.toMap());

  // Add any Firestore field values
  recognizeFamily.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getRecognizeFamilyListFirestoreData(
  List<RecognizeFamilyStruct>? recognizeFamilys,
) =>
    recognizeFamilys
        ?.map((e) => getRecognizeFamilyFirestoreData(e, true))
        .toList() ??
    [];
