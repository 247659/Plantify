import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/loader_item/loader_item_widget.dart';
import 'dart:ui';
import '/flutter_flow/random_data_util.dart' as random_data;
import 'plant_card_loading_widget.dart' show PlantCardLoadingWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PlantCardLoadingModel extends FlutterFlowModel<PlantCardLoadingWidget> {
  ///  State fields for stateful widgets in this component.

  // Models for loaderItem dynamic component.
  late FlutterFlowDynamicModels<LoaderItemModel> loaderItemModels;

  @override
  void initState(BuildContext context) {
    loaderItemModels = FlutterFlowDynamicModels(() => LoaderItemModel());
  }

  @override
  void dispose() {
    loaderItemModels.dispose();
  }
}
