import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/add_item_component/add_item_component_widget.dart';
import '/pages/components/change_item_component/change_item_component_widget.dart';
import 'dart:ui';
import 'dart:async';
import 'shopping_list_component_widget.dart' show ShoppingListComponentWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ShoppingListComponentModel
    extends FlutterFlowModel<ShoppingListComponentWidget> {
  ///  State fields for stateful widgets in this component.

  Completer<List<ListItemsRow>>? requestCompleter;
  // State field(s) for Checkbox widget.
  Map<ListItemsRow, bool> checkboxValueMap = {};
  List<ListItemsRow> get checkboxCheckedItems =>
      checkboxValueMap.entries.where((e) => e.value).map((e) => e.key).toList();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Additional helper methods.
  Future waitForRequestCompleted({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = requestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
