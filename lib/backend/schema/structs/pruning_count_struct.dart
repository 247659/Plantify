// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PruningCountStruct extends FFFirebaseStruct {
  PruningCountStruct({
    int? amount,
    String? interval,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _amount = amount,
        _interval = interval,
        super(firestoreUtilData);

  // "amount" field.
  int? _amount;
  int get amount => _amount ?? 0;
  set amount(int? val) => _amount = val;

  void incrementAmount(int amount) => amount = amount + amount;

  bool hasAmount() => _amount != null;

  // "interval" field.
  String? _interval;
  String get interval => _interval ?? '';
  set interval(String? val) => _interval = val;

  bool hasInterval() => _interval != null;

  static PruningCountStruct fromMap(Map<String, dynamic> data) =>
      PruningCountStruct(
        amount: castToType<int>(data['amount']),
        interval: data['interval'] as String?,
      );

  static PruningCountStruct? maybeFromMap(dynamic data) => data is Map
      ? PruningCountStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'amount': _amount,
        'interval': _interval,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'amount': serializeParam(
          _amount,
          ParamType.int,
        ),
        'interval': serializeParam(
          _interval,
          ParamType.String,
        ),
      }.withoutNulls;

  static PruningCountStruct fromSerializableMap(Map<String, dynamic> data) =>
      PruningCountStruct(
        amount: deserializeParam(
          data['amount'],
          ParamType.int,
          false,
        ),
        interval: deserializeParam(
          data['interval'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'PruningCountStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PruningCountStruct &&
        amount == other.amount &&
        interval == other.interval;
  }

  @override
  int get hashCode => const ListEquality().hash([amount, interval]);
}

PruningCountStruct createPruningCountStruct({
  int? amount,
  String? interval,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PruningCountStruct(
      amount: amount,
      interval: interval,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PruningCountStruct? updatePruningCountStruct(
  PruningCountStruct? pruningCount, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    pruningCount
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPruningCountStructData(
  Map<String, dynamic> firestoreData,
  PruningCountStruct? pruningCount,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (pruningCount == null) {
    return;
  }
  if (pruningCount.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && pruningCount.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final pruningCountData =
      getPruningCountFirestoreData(pruningCount, forFieldValue);
  final nestedData =
      pruningCountData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = pruningCount.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPruningCountFirestoreData(
  PruningCountStruct? pruningCount, [
  bool forFieldValue = false,
]) {
  if (pruningCount == null) {
    return {};
  }
  final firestoreData = mapToFirestore(pruningCount.toMap());

  // Add any Firestore field values
  pruningCount.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPruningCountListFirestoreData(
  List<PruningCountStruct>? pruningCounts,
) =>
    pruningCounts?.map((e) => getPruningCountFirestoreData(e, true)).toList() ??
    [];
