// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RecognizeGbifStruct extends FFFirebaseStruct {
  RecognizeGbifStruct({
    String? id,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        super(firestoreUtilData);

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
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    RecognizeGbifStruct(
      id: id,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

RecognizeGbifStruct? updateRecognizeGbifStruct(
  RecognizeGbifStruct? recognizeGbif, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    recognizeGbif
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addRecognizeGbifStructData(
  Map<String, dynamic> firestoreData,
  RecognizeGbifStruct? recognizeGbif,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (recognizeGbif == null) {
    return;
  }
  if (recognizeGbif.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && recognizeGbif.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final recognizeGbifData =
      getRecognizeGbifFirestoreData(recognizeGbif, forFieldValue);
  final nestedData =
      recognizeGbifData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = recognizeGbif.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getRecognizeGbifFirestoreData(
  RecognizeGbifStruct? recognizeGbif, [
  bool forFieldValue = false,
]) {
  if (recognizeGbif == null) {
    return {};
  }
  final firestoreData = mapToFirestore(recognizeGbif.toMap());

  // Add any Firestore field values
  recognizeGbif.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getRecognizeGbifListFirestoreData(
  List<RecognizeGbifStruct>? recognizeGbifs,
) =>
    recognizeGbifs
        ?.map((e) => getRecognizeGbifFirestoreData(e, true))
        .toList() ??
    [];
