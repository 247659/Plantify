// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChatResponseStruct extends FFFirebaseStruct {
  ChatResponseStruct({
    String? role,
    String? content,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _role = role,
        _content = content,
        super(firestoreUtilData);

  // "role" field.
  String? _role;
  String get role => _role ?? '';
  set role(String? val) => _role = val;

  bool hasRole() => _role != null;

  // "content" field.
  String? _content;
  String get content => _content ?? '';
  set content(String? val) => _content = val;

  bool hasContent() => _content != null;

  static ChatResponseStruct fromMap(Map<String, dynamic> data) =>
      ChatResponseStruct(
        role: data['role'] as String?,
        content: data['content'] as String?,
      );

  static ChatResponseStruct? maybeFromMap(dynamic data) => data is Map
      ? ChatResponseStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'role': _role,
        'content': _content,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'role': serializeParam(
          _role,
          ParamType.String,
        ),
        'content': serializeParam(
          _content,
          ParamType.String,
        ),
      }.withoutNulls;

  static ChatResponseStruct fromSerializableMap(Map<String, dynamic> data) =>
      ChatResponseStruct(
        role: deserializeParam(
          data['role'],
          ParamType.String,
          false,
        ),
        content: deserializeParam(
          data['content'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ChatResponseStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ChatResponseStruct &&
        role == other.role &&
        content == other.content;
  }

  @override
  int get hashCode => const ListEquality().hash([role, content]);
}

ChatResponseStruct createChatResponseStruct({
  String? role,
  String? content,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ChatResponseStruct(
      role: role,
      content: content,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ChatResponseStruct? updateChatResponseStruct(
  ChatResponseStruct? chatResponse, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    chatResponse
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addChatResponseStructData(
  Map<String, dynamic> firestoreData,
  ChatResponseStruct? chatResponse,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (chatResponse == null) {
    return;
  }
  if (chatResponse.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && chatResponse.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final chatResponseData =
      getChatResponseFirestoreData(chatResponse, forFieldValue);
  final nestedData =
      chatResponseData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = chatResponse.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getChatResponseFirestoreData(
  ChatResponseStruct? chatResponse, [
  bool forFieldValue = false,
]) {
  if (chatResponse == null) {
    return {};
  }
  final firestoreData = mapToFirestore(chatResponse.toMap());

  // Add any Firestore field values
  chatResponse.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getChatResponseListFirestoreData(
  List<ChatResponseStruct>? chatResponses,
) =>
    chatResponses?.map((e) => getChatResponseFirestoreData(e, true)).toList() ??
    [];
