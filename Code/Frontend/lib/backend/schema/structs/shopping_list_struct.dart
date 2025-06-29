// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ShoppingListStruct extends FFFirebaseStruct {
  ShoppingListStruct({
    List<QuestionStruct>? itemList,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _itemList = itemList,
        super(firestoreUtilData);

  // "itemList" field.
  List<QuestionStruct>? _itemList;
  List<QuestionStruct> get itemList => _itemList ?? const [];
  set itemList(List<QuestionStruct>? val) => _itemList = val;

  void updateItemList(Function(List<QuestionStruct>) updateFn) {
    updateFn(_itemList ??= []);
  }

  bool hasItemList() => _itemList != null;

  static ShoppingListStruct fromMap(Map<String, dynamic> data) =>
      ShoppingListStruct(
        itemList: getStructList(
          data['itemList'],
          QuestionStruct.fromMap,
        ),
      );

  static ShoppingListStruct? maybeFromMap(dynamic data) => data is Map
      ? ShoppingListStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'itemList': _itemList?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'itemList': serializeParam(
          _itemList,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static ShoppingListStruct fromSerializableMap(Map<String, dynamic> data) =>
      ShoppingListStruct(
        itemList: deserializeStructParam<QuestionStruct>(
          data['itemList'],
          ParamType.DataStruct,
          true,
          structBuilder: QuestionStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'ShoppingListStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ShoppingListStruct &&
        listEquality.equals(itemList, other.itemList);
  }

  @override
  int get hashCode => const ListEquality().hash([itemList]);
}

ShoppingListStruct createShoppingListStruct({
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ShoppingListStruct(
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ShoppingListStruct? updateShoppingListStruct(
  ShoppingListStruct? shoppingList, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    shoppingList
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addShoppingListStructData(
  Map<String, dynamic> firestoreData,
  ShoppingListStruct? shoppingList,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (shoppingList == null) {
    return;
  }
  if (shoppingList.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && shoppingList.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final shoppingListData =
      getShoppingListFirestoreData(shoppingList, forFieldValue);
  final nestedData =
      shoppingListData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = shoppingList.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getShoppingListFirestoreData(
  ShoppingListStruct? shoppingList, [
  bool forFieldValue = false,
]) {
  if (shoppingList == null) {
    return {};
  }
  final firestoreData = mapToFirestore(shoppingList.toMap());

  // Add any Firestore field values
  shoppingList.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getShoppingListListFirestoreData(
  List<ShoppingListStruct>? shoppingLists,
) =>
    shoppingLists?.map((e) => getShoppingListFirestoreData(e, true)).toList() ??
    [];
