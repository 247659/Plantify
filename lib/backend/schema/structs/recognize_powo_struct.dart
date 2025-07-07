// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RecognizePowoStruct extends FFFirebaseStruct {
  RecognizePowoStruct({
    String? id,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        super(firestoreUtilData);

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
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    RecognizePowoStruct(
      id: id,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

RecognizePowoStruct? updateRecognizePowoStruct(
  RecognizePowoStruct? recognizePowo, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    recognizePowo
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addRecognizePowoStructData(
  Map<String, dynamic> firestoreData,
  RecognizePowoStruct? recognizePowo,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (recognizePowo == null) {
    return;
  }
  if (recognizePowo.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && recognizePowo.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final recognizePowoData =
      getRecognizePowoFirestoreData(recognizePowo, forFieldValue);
  final nestedData =
      recognizePowoData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = recognizePowo.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getRecognizePowoFirestoreData(
  RecognizePowoStruct? recognizePowo, [
  bool forFieldValue = false,
]) {
  if (recognizePowo == null) {
    return {};
  }
  final firestoreData = mapToFirestore(recognizePowo.toMap());

  // Add any Firestore field values
  recognizePowo.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getRecognizePowoListFirestoreData(
  List<RecognizePowoStruct>? recognizePowos,
) =>
    recognizePowos
        ?.map((e) => getRecognizePowoFirestoreData(e, true))
        .toList() ??
    [];
