// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ErrorStruct extends FFFirebaseStruct {
  ErrorStruct({
    int? status,
    String? message,
    String? timestamp,
    String? path,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _status = status,
        _message = message,
        _timestamp = timestamp,
        _path = path,
        super(firestoreUtilData);

  // "status" field.
  int? _status;
  int get status => _status ?? 0;
  set status(int? val) => _status = val;

  void incrementStatus(int amount) => status = status + amount;

  bool hasStatus() => _status != null;

  // "message" field.
  String? _message;
  String get message => _message ?? '';
  set message(String? val) => _message = val;

  bool hasMessage() => _message != null;

  // "timestamp" field.
  String? _timestamp;
  String get timestamp => _timestamp ?? '';
  set timestamp(String? val) => _timestamp = val;

  bool hasTimestamp() => _timestamp != null;

  // "path" field.
  String? _path;
  String get path => _path ?? '';
  set path(String? val) => _path = val;

  bool hasPath() => _path != null;

  static ErrorStruct fromMap(Map<String, dynamic> data) => ErrorStruct(
        status: castToType<int>(data['status']),
        message: data['message'] as String?,
        timestamp: data['timestamp'] as String?,
        path: data['path'] as String?,
      );

  static ErrorStruct? maybeFromMap(dynamic data) =>
      data is Map ? ErrorStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'status': _status,
        'message': _message,
        'timestamp': _timestamp,
        'path': _path,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'status': serializeParam(
          _status,
          ParamType.int,
        ),
        'message': serializeParam(
          _message,
          ParamType.String,
        ),
        'timestamp': serializeParam(
          _timestamp,
          ParamType.String,
        ),
        'path': serializeParam(
          _path,
          ParamType.String,
        ),
      }.withoutNulls;

  static ErrorStruct fromSerializableMap(Map<String, dynamic> data) =>
      ErrorStruct(
        status: deserializeParam(
          data['status'],
          ParamType.int,
          false,
        ),
        message: deserializeParam(
          data['message'],
          ParamType.String,
          false,
        ),
        timestamp: deserializeParam(
          data['timestamp'],
          ParamType.String,
          false,
        ),
        path: deserializeParam(
          data['path'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ErrorStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ErrorStruct &&
        status == other.status &&
        message == other.message &&
        timestamp == other.timestamp &&
        path == other.path;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([status, message, timestamp, path]);
}

ErrorStruct createErrorStruct({
  int? status,
  String? message,
  String? timestamp,
  String? path,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ErrorStruct(
      status: status,
      message: message,
      timestamp: timestamp,
      path: path,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ErrorStruct? updateErrorStruct(
  ErrorStruct? error, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    error
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addErrorStructData(
  Map<String, dynamic> firestoreData,
  ErrorStruct? error,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (error == null) {
    return;
  }
  if (error.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && error.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final errorData = getErrorFirestoreData(error, forFieldValue);
  final nestedData = errorData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = error.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getErrorFirestoreData(
  ErrorStruct? error, [
  bool forFieldValue = false,
]) {
  if (error == null) {
    return {};
  }
  final firestoreData = mapToFirestore(error.toMap());

  // Add any Firestore field values
  error.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getErrorListFirestoreData(
  List<ErrorStruct>? errors,
) =>
    errors?.map((e) => getErrorFirestoreData(e, true)).toList() ?? [];
