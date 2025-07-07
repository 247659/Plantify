// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RecognizeResultsStruct extends FFFirebaseStruct {
  RecognizeResultsStruct({
    double? score,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _score = score,
        super(firestoreUtilData);

  // "score" field.
  double? _score;
  double get score => _score ?? 0.0;
  set score(double? val) => _score = val;

  void incrementScore(double amount) => score = score + amount;

  bool hasScore() => _score != null;

  static RecognizeResultsStruct fromMap(Map<String, dynamic> data) =>
      RecognizeResultsStruct(
        score: castToType<double>(data['score']),
      );

  static RecognizeResultsStruct? maybeFromMap(dynamic data) => data is Map
      ? RecognizeResultsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'score': _score,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'score': serializeParam(
          _score,
          ParamType.double,
        ),
      }.withoutNulls;

  static RecognizeResultsStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      RecognizeResultsStruct(
        score: deserializeParam(
          data['score'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'RecognizeResultsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is RecognizeResultsStruct && score == other.score;
  }

  @override
  int get hashCode => const ListEquality().hash([score]);
}

RecognizeResultsStruct createRecognizeResultsStruct({
  double? score,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    RecognizeResultsStruct(
      score: score,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

RecognizeResultsStruct? updateRecognizeResultsStruct(
  RecognizeResultsStruct? recognizeResults, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    recognizeResults
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addRecognizeResultsStructData(
  Map<String, dynamic> firestoreData,
  RecognizeResultsStruct? recognizeResults,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (recognizeResults == null) {
    return;
  }
  if (recognizeResults.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && recognizeResults.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final recognizeResultsData =
      getRecognizeResultsFirestoreData(recognizeResults, forFieldValue);
  final nestedData =
      recognizeResultsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = recognizeResults.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getRecognizeResultsFirestoreData(
  RecognizeResultsStruct? recognizeResults, [
  bool forFieldValue = false,
]) {
  if (recognizeResults == null) {
    return {};
  }
  final firestoreData = mapToFirestore(recognizeResults.toMap());

  // Add any Firestore field values
  recognizeResults.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getRecognizeResultsListFirestoreData(
  List<RecognizeResultsStruct>? recognizeResultss,
) =>
    recognizeResultss
        ?.map((e) => getRecognizeResultsFirestoreData(e, true))
        .toList() ??
    [];
