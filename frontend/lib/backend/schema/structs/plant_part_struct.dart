// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PlantPartStruct extends FFFirebaseStruct {
  PlantPartStruct({
    String? part,
    List<String>? color,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _part = part,
        _color = color,
        super(firestoreUtilData);

  // "part" field.
  String? _part;
  String get part => _part ?? '';
  set part(String? val) => _part = val;

  bool hasPart() => _part != null;

  // "color" field.
  List<String>? _color;
  List<String> get color => _color ?? const [];
  set color(List<String>? val) => _color = val;

  void updateColor(Function(List<String>) updateFn) {
    updateFn(_color ??= []);
  }

  bool hasColor() => _color != null;

  static PlantPartStruct fromMap(Map<String, dynamic> data) => PlantPartStruct(
        part: data['part'] as String?,
        color: getDataList(data['color']),
      );

  static PlantPartStruct? maybeFromMap(dynamic data) => data is Map
      ? PlantPartStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'part': _part,
        'color': _color,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'part': serializeParam(
          _part,
          ParamType.String,
        ),
        'color': serializeParam(
          _color,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static PlantPartStruct fromSerializableMap(Map<String, dynamic> data) =>
      PlantPartStruct(
        part: deserializeParam(
          data['part'],
          ParamType.String,
          false,
        ),
        color: deserializeParam<String>(
          data['color'],
          ParamType.String,
          true,
        ),
      );

  @override
  String toString() => 'PlantPartStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is PlantPartStruct &&
        part == other.part &&
        listEquality.equals(color, other.color);
  }

  @override
  int get hashCode => const ListEquality().hash([part, color]);
}

PlantPartStruct createPlantPartStruct({
  String? part,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PlantPartStruct(
      part: part,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PlantPartStruct? updatePlantPartStruct(
  PlantPartStruct? plantPart, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    plantPart
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPlantPartStructData(
  Map<String, dynamic> firestoreData,
  PlantPartStruct? plantPart,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (plantPart == null) {
    return;
  }
  if (plantPart.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && plantPart.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final plantPartData = getPlantPartFirestoreData(plantPart, forFieldValue);
  final nestedData = plantPartData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = plantPart.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPlantPartFirestoreData(
  PlantPartStruct? plantPart, [
  bool forFieldValue = false,
]) {
  if (plantPart == null) {
    return {};
  }
  final firestoreData = mapToFirestore(plantPart.toMap());

  // Add any Firestore field values
  plantPart.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPlantPartListFirestoreData(
  List<PlantPartStruct>? plantParts,
) =>
    plantParts?.map((e) => getPlantPartFirestoreData(e, true)).toList() ?? [];
