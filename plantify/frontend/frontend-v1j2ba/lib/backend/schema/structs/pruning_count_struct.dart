// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PruningCountStruct extends BaseStruct {
  PruningCountStruct({
    int? amount,
    String? interval,
  })  : _amount = amount,
        _interval = interval;

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
}) =>
    PruningCountStruct(
      amount: amount,
      interval: interval,
    );
