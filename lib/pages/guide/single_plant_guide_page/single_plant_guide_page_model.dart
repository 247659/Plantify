import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/components/plant_care_component/plant_care_component_widget.dart';
import '/pages/components/plant_overview_component/plant_overview_component_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'single_plant_guide_page_widget.dart' show SinglePlantGuidePageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SinglePlantGuidePageModel
    extends FlutterFlowModel<SinglePlantGuidePageWidget> {
  ///  Local state fields for this page.

  bool isExpanded = false;

  String infoType = ' ';

  List<String> infoList = [];
  void addToInfoList(String item) => infoList.add(item);
  void removeFromInfoList(String item) => infoList.remove(item);
  void removeAtIndexFromInfoList(int index) => infoList.removeAt(index);
  void insertAtIndexInInfoList(int index, String item) =>
      infoList.insert(index, item);
  void updateInfoListAtIndex(int index, Function(String) updateFn) =>
      infoList[index] = updateFn(infoList[index]);

  GuideStruct? guide;
  void updateGuideStruct(Function(GuideStruct) updateFn) {
    updateFn(guide ??= GuideStruct());
  }

  String selectedTab = 'overview';

  ///  State fields for stateful widgets in this page.

  // Model for PlantOverviewComponent component.
  late PlantOverviewComponentModel plantOverviewComponentModel;
  // Model for PlantCareComponent component.
  late PlantCareComponentModel plantCareComponentModel;

  @override
  void initState(BuildContext context) {
    plantOverviewComponentModel =
        createModel(context, () => PlantOverviewComponentModel());
    plantCareComponentModel =
        createModel(context, () => PlantCareComponentModel());
  }

  @override
  void dispose() {
    plantOverviewComponentModel.dispose();
    plantCareComponentModel.dispose();
  }
}
