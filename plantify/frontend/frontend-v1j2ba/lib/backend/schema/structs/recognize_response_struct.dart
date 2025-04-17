// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RecognizeResponseStruct extends BaseStruct {
  RecognizeResponseStruct({
    String? bestMatch,
    List<RecognizeResultsStruct>? results,
  })  : _bestMatch = bestMatch,
        _results = results;

  // "bestMatch" field.
  String? _bestMatch;
  String get bestMatch => _bestMatch ?? '';
  set bestMatch(String? val) => _bestMatch = val;

  bool hasBestMatch() => _bestMatch != null;

  // "results" field.
  List<RecognizeResultsStruct>? _results;
  List<RecognizeResultsStruct> get results => _results ?? const [];
  set results(List<RecognizeResultsStruct>? val) => _results = val;

  void updateResults(Function(List<RecognizeResultsStruct>) updateFn) {
    updateFn(_results ??= []);
  }

  bool hasResults() => _results != null;

  static RecognizeResponseStruct fromMap(Map<String, dynamic> data) =>
      RecognizeResponseStruct(
        bestMatch: data['bestMatch'] as String?,
        results: getStructList(
          data['results'],
          RecognizeResultsStruct.fromMap,
        ),
      );

  static RecognizeResponseStruct? maybeFromMap(dynamic data) => data is Map
      ? RecognizeResponseStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'bestMatch': _bestMatch,
        'results': _results?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'bestMatch': serializeParam(
          _bestMatch,
          ParamType.String,
        ),
        'results': serializeParam(
          _results,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static RecognizeResponseStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      RecognizeResponseStruct(
        bestMatch: deserializeParam(
          data['bestMatch'],
          ParamType.String,
          false,
        ),
        results: deserializeStructParam<RecognizeResultsStruct>(
          data['results'],
          ParamType.DataStruct,
          true,
          structBuilder: RecognizeResultsStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'RecognizeResponseStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is RecognizeResponseStruct &&
        bestMatch == other.bestMatch &&
        listEquality.equals(results, other.results);
  }

  @override
  int get hashCode => const ListEquality().hash([bestMatch, results]);
}

RecognizeResponseStruct createRecognizeResponseStruct({
  String? bestMatch,
}) =>
    RecognizeResponseStruct(
      bestMatch: bestMatch,
    );
