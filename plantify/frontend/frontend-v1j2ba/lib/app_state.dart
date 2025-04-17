import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import '/backend/api_requests/api_manager.dart';
import 'backend/supabase/supabase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _AllPlantsBySpecies = prefs
              .getStringList('ff_AllPlantsBySpecies')
              ?.map((x) {
                try {
                  return PlantsInformationStruct.fromSerializableMap(
                      jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _AllPlantsBySpecies;
    });
    _safeInit(() {
      _selectedOption = prefs.getString('ff_selectedOption') ?? _selectedOption;
    });
    _safeInit(() {
      _lang = prefs.getString('ff_lang') ?? _lang;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  List<PlantsInformationStruct> _AllPlantsBySpecies = [];
  List<PlantsInformationStruct> get AllPlantsBySpecies => _AllPlantsBySpecies;
  set AllPlantsBySpecies(List<PlantsInformationStruct> value) {
    _AllPlantsBySpecies = value;
    prefs.setStringList(
        'ff_AllPlantsBySpecies', value.map((x) => x.serialize()).toList());
  }

  void addToAllPlantsBySpecies(PlantsInformationStruct value) {
    AllPlantsBySpecies.add(value);
    prefs.setStringList('ff_AllPlantsBySpecies',
        _AllPlantsBySpecies.map((x) => x.serialize()).toList());
  }

  void removeFromAllPlantsBySpecies(PlantsInformationStruct value) {
    AllPlantsBySpecies.remove(value);
    prefs.setStringList('ff_AllPlantsBySpecies',
        _AllPlantsBySpecies.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromAllPlantsBySpecies(int index) {
    AllPlantsBySpecies.removeAt(index);
    prefs.setStringList('ff_AllPlantsBySpecies',
        _AllPlantsBySpecies.map((x) => x.serialize()).toList());
  }

  void updateAllPlantsBySpeciesAtIndex(
    int index,
    PlantsInformationStruct Function(PlantsInformationStruct) updateFn,
  ) {
    AllPlantsBySpecies[index] = updateFn(_AllPlantsBySpecies[index]);
    prefs.setStringList('ff_AllPlantsBySpecies',
        _AllPlantsBySpecies.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInAllPlantsBySpecies(
      int index, PlantsInformationStruct value) {
    AllPlantsBySpecies.insert(index, value);
    prefs.setStringList('ff_AllPlantsBySpecies',
        _AllPlantsBySpecies.map((x) => x.serialize()).toList());
  }

  String _selectedOption = '';
  String get selectedOption => _selectedOption;
  set selectedOption(String value) {
    _selectedOption = value;
    prefs.setString('ff_selectedOption', value);
  }

  String _recognizedSpecies = '';
  String get recognizedSpecies => _recognizedSpecies;
  set recognizedSpecies(String value) {
    _recognizedSpecies = value;
  }

  String _lang = 'en';
  String get lang => _lang;
  set lang(String value) {
    _lang = value;
    prefs.setString('ff_lang', value);
  }

  String _createUploadedImage = '';
  String get createUploadedImage => _createUploadedImage;
  set createUploadedImage(String value) {
    _createUploadedImage = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
