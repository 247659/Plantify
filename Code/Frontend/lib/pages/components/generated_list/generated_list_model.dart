import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/components/error_component/error_component_widget.dart';
import 'dart:ui';
import 'generated_list_widget.dart' show GeneratedListWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GeneratedListModel extends FlutterFlowModel<GeneratedListWidget> {
  ///  Local state fields for this component.

  List<ItemListStruct> list = [];
  void addToList(ItemListStruct item) => list.add(item);
  void removeFromList(ItemListStruct item) => list.remove(item);
  void removeAtIndexFromList(int index) => list.removeAt(index);
  void insertAtIndexInList(int index, ItemListStruct item) =>
      list.insert(index, item);
  void updateListAtIndex(int index, Function(ItemListStruct) updateFn) =>
      list[index] = updateFn(list[index]);

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (generateShoppingList)] action in generatedList widget.
  ApiCallResponse? generetedList;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  ShoppingListsRow? listID;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
