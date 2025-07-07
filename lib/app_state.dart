import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/api_requests/api_manager.dart';
import 'backend/supabase/supabase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'dart:convert';

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
    _safeInit(() {
      _selectedList = prefs.getString('ff_selectedList') ?? _selectedList;
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

  bool _isRecognizeVisible = false;
  bool get isRecognizeVisible => _isRecognizeVisible;
  set isRecognizeVisible(bool value) {
    _isRecognizeVisible = value;
  }

  bool _refreshShoppingList = false;
  bool get refreshShoppingList => _refreshShoppingList;
  set refreshShoppingList(bool value) {
    _refreshShoppingList = value;
  }

  String _selectedList = '';
  String get selectedList => _selectedList;
  set selectedList(String value) {
    _selectedList = value;
    prefs.setString('ff_selectedList', value);
  }

  String _speciesName = '';
  String get speciesName => _speciesName;
  set speciesName(String value) {
    _speciesName = value;
  }

  List<dynamic> _chatMessages = [];
  List<dynamic> get chatMessages => _chatMessages;
  set chatMessages(List<dynamic> value) {
    _chatMessages = value;
  }

  void addToChatMessages(dynamic value) {
    chatMessages.add(value);
  }

  void removeFromChatMessages(dynamic value) {
    chatMessages.remove(value);
  }

  void removeAtIndexFromChatMessages(int index) {
    chatMessages.removeAt(index);
  }

  void updateChatMessagesAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    chatMessages[index] = updateFn(_chatMessages[index]);
  }

  void insertAtIndexInChatMessages(int index, dynamic value) {
    chatMessages.insert(index, value);
  }

  bool _googleAuth = false;
  bool get googleAuth => _googleAuth;
  set googleAuth(bool value) {
    _googleAuth = value;
  }

  String _fcmToken = '';
  String get fcmToken => _fcmToken;
  set fcmToken(String value) {
    _fcmToken = value;
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
