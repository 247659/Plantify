import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/error_component/error_component_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'plant_care_component_widget.dart' show PlantCareComponentWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PlantCareComponentModel
    extends FlutterFlowModel<PlantCareComponentWidget> {
  ///  Local state fields for this component.

  GuideStruct? guide;
  void updateGuideStruct(Function(GuideStruct) updateFn) {
    updateFn(guide ??= GuideStruct());
  }

  bool watering = false;

  bool sunlight = false;

  bool pruning = false;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (getPlantInstructions)] action in Text widget.
  ApiCallResponse? apiResult0o4;
  // Stores action output result for [Backend Call - API (getPlantInstructions)] action in Text widget.
  ApiCallResponse? apiResultmg0;
  // Stores action output result for [Backend Call - API (getPlantInstructions)] action in Text widget.
  ApiCallResponse? apiResultte9;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
