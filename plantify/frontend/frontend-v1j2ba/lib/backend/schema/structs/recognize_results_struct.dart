// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RecognizeResultsStruct extends BaseStruct {
  RecognizeResultsStruct({
    double? score,
  }) : _score = score;

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
}) =>
    RecognizeResultsStruct(
      score: score,
    );
