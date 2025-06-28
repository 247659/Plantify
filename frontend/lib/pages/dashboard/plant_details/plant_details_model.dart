import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import '/pages/components/custom_appbar/custom_appbar_widget.dart';
import '/pages/components/empty_state/empty_state_widget.dart';
import '/pages/components/error_component/error_component_widget.dart';
import '/pages/components/list_plant_component/list_plant_component_widget.dart';
import '/pages/components/plant_calendar/plant_calendar_widget.dart';
import '/pages/components/plant_settings_component/plant_settings_component_widget.dart';
import 'dart:ui';
import '/backend/schema/structs/index.dart';
import 'dart:async';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'plant_details_widget.dart' show PlantDetailsWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PlantDetailsModel extends FlutterFlowModel<PlantDetailsWidget> {
  ///  Local state fields for this page.

  bool isEditing = true;

  String? imgVariable;

  String? wateringEng;

  String? sunlightEng;

  String? pruningEng;

  String? fertilizeEng;

  String? wateringPl;

  String? sunlightPl;

  String? pruningPl;

  String? fertilizePl;

  bool tipsError = false;

  ///  State fields for stateful widgets in this page.

  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  Completer<List<PlantsRow>>? requestCompleter1;
  // Model for customAppbar component.
  late CustomAppbarModel customAppbarModel;
  bool isDataUploading_uploadDataJj9 = false;
  FFUploadedFile uploadedLocalFile_uploadDataJj9 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadDataJj9 = '';

  // Stores action output result for [Bottom Sheet - plantSettingsComponent] action in IconButton widget.
  bool? isEdit;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  Completer<List<PlantCategoriesRow>>? requestCompleter2;
  // Model for emptyState component.
  late EmptyStateModel emptyStateModel;
  // Stores action output result for [Backend Call - API (getTips)] action in Button widget.
  ApiCallResponse? tipsResult;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<PlantsRow>? plant;
  // Model for plantCalendar component.
  late PlantCalendarModel plantCalendarModel;
  // Model for listPlantComponent component.
  late ListPlantComponentModel listPlantComponentModel;
  // Stores action output result for [Backend Call - API (getSpeciesByUrl)] action in recognizeButton widget.
  ApiCallResponse? apiResult27l;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  String? _textController1Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        '4h1qr8eo' /* Name is required */,
      );
    }

    return null;
  }

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // State field(s) for SpeciesField widget.
  FocusNode? speciesFieldFocusNode;
  TextEditingController? speciesFieldTextController;
  String? Function(BuildContext, String?)? speciesFieldTextControllerValidator;
  String? _speciesFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        're45y0yh' /* Species is required */,
      );
    }

    return null;
  }

  // State field(s) for LocationField widget.
  FocusNode? locationFieldFocusNode;
  TextEditingController? locationFieldTextController;
  String? Function(BuildContext, String?)? locationFieldTextControllerValidator;
  // State field(s) for DropDown widget.
  int? dropDownValue;
  FormFieldController<int>? dropDownValueController;

  @override
  void initState(BuildContext context) {
    customAppbarModel = createModel(context, () => CustomAppbarModel());
    emptyStateModel = createModel(context, () => EmptyStateModel());
    plantCalendarModel = createModel(context, () => PlantCalendarModel());
    listPlantComponentModel =
        createModel(context, () => ListPlantComponentModel());
    textController1Validator = _textController1Validator;
    speciesFieldTextControllerValidator = _speciesFieldTextControllerValidator;
  }

  @override
  void dispose() {
    customAppbarModel.dispose();
    emptyStateModel.dispose();
    plantCalendarModel.dispose();
    listPlantComponentModel.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    speciesFieldFocusNode?.dispose();
    speciesFieldTextController?.dispose();

    locationFieldFocusNode?.dispose();
    locationFieldTextController?.dispose();
  }

  /// Additional helper methods.
  Future waitForRequestCompleted1({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = requestCompleter1?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }

  Future waitForRequestCompleted2({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = requestCompleter2?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
