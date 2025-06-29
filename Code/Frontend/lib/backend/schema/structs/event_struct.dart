// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EventStruct extends FFFirebaseStruct {
  EventStruct({
    String? eventName,
    DateTime? eventDate,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _eventName = eventName,
        _eventDate = eventDate,
        super(firestoreUtilData);

  // "eventName" field.
  String? _eventName;
  String get eventName => _eventName ?? '';
  set eventName(String? val) => _eventName = val;

  bool hasEventName() => _eventName != null;

  // "eventDate" field.
  DateTime? _eventDate;
  DateTime? get eventDate => _eventDate;
  set eventDate(DateTime? val) => _eventDate = val;

  bool hasEventDate() => _eventDate != null;

  static EventStruct fromMap(Map<String, dynamic> data) => EventStruct(
        eventName: data['eventName'] as String?,
        eventDate: data['eventDate'] as DateTime?,
      );

  static EventStruct? maybeFromMap(dynamic data) =>
      data is Map ? EventStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'eventName': _eventName,
        'eventDate': _eventDate,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'eventName': serializeParam(
          _eventName,
          ParamType.String,
        ),
        'eventDate': serializeParam(
          _eventDate,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static EventStruct fromSerializableMap(Map<String, dynamic> data) =>
      EventStruct(
        eventName: deserializeParam(
          data['eventName'],
          ParamType.String,
          false,
        ),
        eventDate: deserializeParam(
          data['eventDate'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'EventStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is EventStruct &&
        eventName == other.eventName &&
        eventDate == other.eventDate;
  }

  @override
  int get hashCode => const ListEquality().hash([eventName, eventDate]);
}

EventStruct createEventStruct({
  String? eventName,
  DateTime? eventDate,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    EventStruct(
      eventName: eventName,
      eventDate: eventDate,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

EventStruct? updateEventStruct(
  EventStruct? event, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    event
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addEventStructData(
  Map<String, dynamic> firestoreData,
  EventStruct? event,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (event == null) {
    return;
  }
  if (event.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && event.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final eventData = getEventFirestoreData(event, forFieldValue);
  final nestedData = eventData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = event.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getEventFirestoreData(
  EventStruct? event, [
  bool forFieldValue = false,
]) {
  if (event == null) {
    return {};
  }
  final firestoreData = mapToFirestore(event.toMap());

  // Add any Firestore field values
  event.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getEventListFirestoreData(
  List<EventStruct>? events,
) =>
    events?.map((e) => getEventFirestoreData(e, true)).toList() ?? [];
