// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ItemListStruct extends FFFirebaseStruct {
  ItemListStruct({
    String? response,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _response = response,
        super(firestoreUtilData);

  // "response" field.
  String? _response;
  String get response => _response ?? '';
  set response(String? val) => _response = val;

  bool hasResponse() => _response != null;

  static ItemListStruct fromMap(Map<String, dynamic> data) => ItemListStruct(
        response: data['response'] as String?,
      );

  static ItemListStruct? maybeFromMap(dynamic data) =>
      data is Map ? ItemListStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'response': _response,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'response': serializeParam(
          _response,
          ParamType.String,
        ),
      }.withoutNulls;

  static ItemListStruct fromSerializableMap(Map<String, dynamic> data) =>
      ItemListStruct(
        response: deserializeParam(
          data['response'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ItemListStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ItemListStruct && response == other.response;
  }

  @override
  int get hashCode => const ListEquality().hash([response]);
}

ItemListStruct createItemListStruct({
  String? response,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ItemListStruct(
      response: response,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ItemListStruct? updateItemListStruct(
  ItemListStruct? itemList, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    itemList
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addItemListStructData(
  Map<String, dynamic> firestoreData,
  ItemListStruct? itemList,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (itemList == null) {
    return;
  }
  if (itemList.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && itemList.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final itemListData = getItemListFirestoreData(itemList, forFieldValue);
  final nestedData = itemListData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = itemList.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getItemListFirestoreData(
  ItemListStruct? itemList, [
  bool forFieldValue = false,
]) {
  if (itemList == null) {
    return {};
  }
  final firestoreData = mapToFirestore(itemList.toMap());

  // Add any Firestore field values
  itemList.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getItemListListFirestoreData(
  List<ItemListStruct>? itemLists,
) =>
    itemLists?.map((e) => getItemListFirestoreData(e, true)).toList() ?? [];
