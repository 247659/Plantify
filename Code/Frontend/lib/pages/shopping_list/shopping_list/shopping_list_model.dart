import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/components/list_component/list_component_widget.dart';
import 'dart:ui';
import 'shopping_list_widget.dart' show ShoppingListWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ShoppingListModel extends FlutterFlowModel<ShoppingListWidget> {
  ///  Local state fields for this page.

  String? selectedList;

  ///  State fields for stateful widgets in this page.

  // Model for listComponent component.
  late ListComponentModel listComponentModel;

  @override
  void initState(BuildContext context) {
    listComponentModel = createModel(context, () => ListComponentModel());
  }

  @override
  void dispose() {
    listComponentModel.dispose();
  }
}
