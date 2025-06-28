// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RecognizeResponseStruct extends FFFirebaseStruct {
  RecognizeResponseStruct({
    String? bestMatch,
    List<RecognizeResultsStruct>? results,
    String? wateringEng,
    String? sunlightEng,
    String? pruningEng,
    String? fertilizationEng,
    String? wateringPl,
    String? sunlightPl,
    String? pruningPl,
    String? fertilizationPl,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _bestMatch = bestMatch,
        _results = results,
        _wateringEng = wateringEng,
        _sunlightEng = sunlightEng,
        _pruningEng = pruningEng,
        _fertilizationEng = fertilizationEng,
        _wateringPl = wateringPl,
        _sunlightPl = sunlightPl,
        _pruningPl = pruningPl,
        _fertilizationPl = fertilizationPl,
        super(firestoreUtilData);

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

  // "watering_eng" field.
  String? _wateringEng;
  String get wateringEng => _wateringEng ?? '';
  set wateringEng(String? val) => _wateringEng = val;

  bool hasWateringEng() => _wateringEng != null;

  // "sunlight_eng" field.
  String? _sunlightEng;
  String get sunlightEng => _sunlightEng ?? '';
  set sunlightEng(String? val) => _sunlightEng = val;

  bool hasSunlightEng() => _sunlightEng != null;

  // "pruning_eng" field.
  String? _pruningEng;
  String get pruningEng => _pruningEng ?? '';
  set pruningEng(String? val) => _pruningEng = val;

  bool hasPruningEng() => _pruningEng != null;

  // "fertilization_eng" field.
  String? _fertilizationEng;
  String get fertilizationEng => _fertilizationEng ?? '';
  set fertilizationEng(String? val) => _fertilizationEng = val;

  bool hasFertilizationEng() => _fertilizationEng != null;

  // "watering_pl" field.
  String? _wateringPl;
  String get wateringPl => _wateringPl ?? '';
  set wateringPl(String? val) => _wateringPl = val;

  bool hasWateringPl() => _wateringPl != null;

  // "sunlight_pl" field.
  String? _sunlightPl;
  String get sunlightPl => _sunlightPl ?? '';
  set sunlightPl(String? val) => _sunlightPl = val;

  bool hasSunlightPl() => _sunlightPl != null;

  // "pruning_pl" field.
  String? _pruningPl;
  String get pruningPl => _pruningPl ?? '';
  set pruningPl(String? val) => _pruningPl = val;

  bool hasPruningPl() => _pruningPl != null;

  // "fertilization_pl" field.
  String? _fertilizationPl;
  String get fertilizationPl => _fertilizationPl ?? '';
  set fertilizationPl(String? val) => _fertilizationPl = val;

  bool hasFertilizationPl() => _fertilizationPl != null;

  static RecognizeResponseStruct fromMap(Map<String, dynamic> data) =>
      RecognizeResponseStruct(
        bestMatch: data['bestMatch'] as String?,
        results: getStructList(
          data['results'],
          RecognizeResultsStruct.fromMap,
        ),
        wateringEng: data['watering_eng'] as String?,
        sunlightEng: data['sunlight_eng'] as String?,
        pruningEng: data['pruning_eng'] as String?,
        fertilizationEng: data['fertilization_eng'] as String?,
        wateringPl: data['watering_pl'] as String?,
        sunlightPl: data['sunlight_pl'] as String?,
        pruningPl: data['pruning_pl'] as String?,
        fertilizationPl: data['fertilization_pl'] as String?,
      );

  static RecognizeResponseStruct? maybeFromMap(dynamic data) => data is Map
      ? RecognizeResponseStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'bestMatch': _bestMatch,
        'results': _results?.map((e) => e.toMap()).toList(),
        'watering_eng': _wateringEng,
        'sunlight_eng': _sunlightEng,
        'pruning_eng': _pruningEng,
        'fertilization_eng': _fertilizationEng,
        'watering_pl': _wateringPl,
        'sunlight_pl': _sunlightPl,
        'pruning_pl': _pruningPl,
        'fertilization_pl': _fertilizationPl,
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
        'watering_eng': serializeParam(
          _wateringEng,
          ParamType.String,
        ),
        'sunlight_eng': serializeParam(
          _sunlightEng,
          ParamType.String,
        ),
        'pruning_eng': serializeParam(
          _pruningEng,
          ParamType.String,
        ),
        'fertilization_eng': serializeParam(
          _fertilizationEng,
          ParamType.String,
        ),
        'watering_pl': serializeParam(
          _wateringPl,
          ParamType.String,
        ),
        'sunlight_pl': serializeParam(
          _sunlightPl,
          ParamType.String,
        ),
        'pruning_pl': serializeParam(
          _pruningPl,
          ParamType.String,
        ),
        'fertilization_pl': serializeParam(
          _fertilizationPl,
          ParamType.String,
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
        wateringEng: deserializeParam(
          data['watering_eng'],
          ParamType.String,
          false,
        ),
        sunlightEng: deserializeParam(
          data['sunlight_eng'],
          ParamType.String,
          false,
        ),
        pruningEng: deserializeParam(
          data['pruning_eng'],
          ParamType.String,
          false,
        ),
        fertilizationEng: deserializeParam(
          data['fertilization_eng'],
          ParamType.String,
          false,
        ),
        wateringPl: deserializeParam(
          data['watering_pl'],
          ParamType.String,
          false,
        ),
        sunlightPl: deserializeParam(
          data['sunlight_pl'],
          ParamType.String,
          false,
        ),
        pruningPl: deserializeParam(
          data['pruning_pl'],
          ParamType.String,
          false,
        ),
        fertilizationPl: deserializeParam(
          data['fertilization_pl'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'RecognizeResponseStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is RecognizeResponseStruct &&
        bestMatch == other.bestMatch &&
        listEquality.equals(results, other.results) &&
        wateringEng == other.wateringEng &&
        sunlightEng == other.sunlightEng &&
        pruningEng == other.pruningEng &&
        fertilizationEng == other.fertilizationEng &&
        wateringPl == other.wateringPl &&
        sunlightPl == other.sunlightPl &&
        pruningPl == other.pruningPl &&
        fertilizationPl == other.fertilizationPl;
  }

  @override
  int get hashCode => const ListEquality().hash([
        bestMatch,
        results,
        wateringEng,
        sunlightEng,
        pruningEng,
        fertilizationEng,
        wateringPl,
        sunlightPl,
        pruningPl,
        fertilizationPl
      ]);
}

RecognizeResponseStruct createRecognizeResponseStruct({
  String? bestMatch,
  String? wateringEng,
  String? sunlightEng,
  String? pruningEng,
  String? fertilizationEng,
  String? wateringPl,
  String? sunlightPl,
  String? pruningPl,
  String? fertilizationPl,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    RecognizeResponseStruct(
      bestMatch: bestMatch,
      wateringEng: wateringEng,
      sunlightEng: sunlightEng,
      pruningEng: pruningEng,
      fertilizationEng: fertilizationEng,
      wateringPl: wateringPl,
      sunlightPl: sunlightPl,
      pruningPl: pruningPl,
      fertilizationPl: fertilizationPl,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

RecognizeResponseStruct? updateRecognizeResponseStruct(
  RecognizeResponseStruct? recognizeResponse, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    recognizeResponse
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addRecognizeResponseStructData(
  Map<String, dynamic> firestoreData,
  RecognizeResponseStruct? recognizeResponse,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (recognizeResponse == null) {
    return;
  }
  if (recognizeResponse.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && recognizeResponse.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final recognizeResponseData =
      getRecognizeResponseFirestoreData(recognizeResponse, forFieldValue);
  final nestedData =
      recognizeResponseData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = recognizeResponse.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getRecognizeResponseFirestoreData(
  RecognizeResponseStruct? recognizeResponse, [
  bool forFieldValue = false,
]) {
  if (recognizeResponse == null) {
    return {};
  }
  final firestoreData = mapToFirestore(recognizeResponse.toMap());

  // Add any Firestore field values
  recognizeResponse.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getRecognizeResponseListFirestoreData(
  List<RecognizeResponseStruct>? recognizeResponses,
) =>
    recognizeResponses
        ?.map((e) => getRecognizeResponseFirestoreData(e, true))
        .toList() ??
    [];
