import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/components/custom_appbar/custom_appbar_widget.dart';
import '/pages/components/shopping_list_component/shopping_list_component_widget.dart';
import 'dart:ui';
import 'item_list_widget.dart' show ItemListWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ItemListModel extends FlutterFlowModel<ItemListWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for customAppbar component.
  late CustomAppbarModel customAppbarModel;
  // Model for shoppingListComponent component.
  late ShoppingListComponentModel shoppingListComponentModel;

  @override
  void initState(BuildContext context) {
    customAppbarModel = createModel(context, () => CustomAppbarModel());
    shoppingListComponentModel =
        createModel(context, () => ShoppingListComponentModel());
  }

  @override
  void dispose() {
    customAppbarModel.dispose();
    shoppingListComponentModel.dispose();
  }
}
