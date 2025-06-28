// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FaqStruct extends FFFirebaseStruct {
  FaqStruct({
    List<QuestionStruct>? questions,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _questions = questions,
        super(firestoreUtilData);

  // "questions" field.
  List<QuestionStruct>? _questions;
  List<QuestionStruct> get questions => _questions ?? const [];
  set questions(List<QuestionStruct>? val) => _questions = val;

  void updateQuestions(Function(List<QuestionStruct>) updateFn) {
    updateFn(_questions ??= []);
  }

  bool hasQuestions() => _questions != null;

  static FaqStruct fromMap(Map<String, dynamic> data) => FaqStruct(
        questions: getStructList(
          data['questions'],
          QuestionStruct.fromMap,
        ),
      );

  static FaqStruct? maybeFromMap(dynamic data) =>
      data is Map ? FaqStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'questions': _questions?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'questions': serializeParam(
          _questions,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static FaqStruct fromSerializableMap(Map<String, dynamic> data) => FaqStruct(
        questions: deserializeStructParam<QuestionStruct>(
          data['questions'],
          ParamType.DataStruct,
          true,
          structBuilder: QuestionStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'FaqStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is FaqStruct &&
        listEquality.equals(questions, other.questions);
  }

  @override
  int get hashCode => const ListEquality().hash([questions]);
}

FaqStruct createFaqStruct({
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    FaqStruct(
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

FaqStruct? updateFaqStruct(
  FaqStruct? faq, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    faq
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addFaqStructData(
  Map<String, dynamic> firestoreData,
  FaqStruct? faq,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (faq == null) {
    return;
  }
  if (faq.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue && faq.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final faqData = getFaqFirestoreData(faq, forFieldValue);
  final nestedData = faqData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = faq.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getFaqFirestoreData(
  FaqStruct? faq, [
  bool forFieldValue = false,
]) {
  if (faq == null) {
    return {};
  }
  final firestoreData = mapToFirestore(faq.toMap());

  // Add any Firestore field values
  faq.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getFaqListFirestoreData(
  List<FaqStruct>? faqs,
) =>
    faqs?.map((e) => getFaqFirestoreData(e, true)).toList() ?? [];
