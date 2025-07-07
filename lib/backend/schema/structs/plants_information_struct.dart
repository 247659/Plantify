// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PlantsInformationStruct extends FFFirebaseStruct {
  PlantsInformationStruct({
    String? id,
    String? commonName,
    String? originalUrl,
    String? scientificName,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _commonName = commonName,
        _originalUrl = originalUrl,
        _scientificName = scientificName,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "commonName" field.
  String? _commonName;
  String get commonName => _commonName ?? '';
  set commonName(String? val) => _commonName = val;

  bool hasCommonName() => _commonName != null;

  // "originalUrl" field.
  String? _originalUrl;
  String get originalUrl => _originalUrl ?? '';
  set originalUrl(String? val) => _originalUrl = val;

  bool hasOriginalUrl() => _originalUrl != null;

  // "scientificName" field.
  String? _scientificName;
  String get scientificName => _scientificName ?? '';
  set scientificName(String? val) => _scientificName = val;

  bool hasScientificName() => _scientificName != null;

  static PlantsInformationStruct fromMap(Map<String, dynamic> data) =>
      PlantsInformationStruct(
        id: data['id'] as String?,
        commonName: data['commonName'] as String?,
        originalUrl: data['originalUrl'] as String?,
        scientificName: data['scientificName'] as String?,
      );

  static PlantsInformationStruct? maybeFromMap(dynamic data) => data is Map
      ? PlantsInformationStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'commonName': _commonName,
        'originalUrl': _originalUrl,
        'scientificName': _scientificName,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'commonName': serializeParam(
          _commonName,
          ParamType.String,
        ),
        'originalUrl': serializeParam(
          _originalUrl,
          ParamType.String,
        ),
        'scientificName': serializeParam(
          _scientificName,
          ParamType.String,
        ),
      }.withoutNulls;

  static PlantsInformationStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      PlantsInformationStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        commonName: deserializeParam(
          data['commonName'],
          ParamType.String,
          false,
        ),
        originalUrl: deserializeParam(
          data['originalUrl'],
          ParamType.String,
          false,
        ),
        scientificName: deserializeParam(
          data['scientificName'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'PlantsInformationStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PlantsInformationStruct &&
        id == other.id &&
        commonName == other.commonName &&
        originalUrl == other.originalUrl &&
        scientificName == other.scientificName;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([id, commonName, originalUrl, scientificName]);
}

PlantsInformationStruct createPlantsInformationStruct({
  String? id,
  String? commonName,
  String? originalUrl,
  String? scientificName,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PlantsInformationStruct(
      id: id,
      commonName: commonName,
      originalUrl: originalUrl,
      scientificName: scientificName,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PlantsInformationStruct? updatePlantsInformationStruct(
  PlantsInformationStruct? plantsInformation, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    plantsInformation
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPlantsInformationStructData(
  Map<String, dynamic> firestoreData,
  PlantsInformationStruct? plantsInformation,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (plantsInformation == null) {
    return;
  }
  if (plantsInformation.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && plantsInformation.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final plantsInformationData =
      getPlantsInformationFirestoreData(plantsInformation, forFieldValue);
  final nestedData =
      plantsInformationData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = plantsInformation.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPlantsInformationFirestoreData(
  PlantsInformationStruct? plantsInformation, [
  bool forFieldValue = false,
]) {
  if (plantsInformation == null) {
    return {};
  }
  final firestoreData = mapToFirestore(plantsInformation.toMap());

  // Add any Firestore field values
  plantsInformation.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPlantsInformationListFirestoreData(
  List<PlantsInformationStruct>? plantsInformations,
) =>
    plantsInformations
        ?.map((e) => getPlantsInformationFirestoreData(e, true))
        .toList() ??
    [];
