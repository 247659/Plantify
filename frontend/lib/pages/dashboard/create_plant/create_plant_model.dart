import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import '/pages/components/custom_appbar/custom_appbar_widget.dart';
import '/pages/components/error_component/error_component_widget.dart';
import 'dart:ui';
import '/backend/schema/structs/index.dart';
import '/index.dart';
import 'create_plant_widget.dart' show CreatePlantWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CreatePlantModel extends FlutterFlowModel<CreatePlantWidget> {
  ///  Local state fields for this page.

  String addImageURL =
      'https://dekomotyw.pl/environment/cache/images/500_500_productGfx_63109/IMG_6100.webp';

  String? recognizedSpecies;

  bool? recognizingPage;

  bool errorName = false;

  bool errorSpecies = false;

  bool errorCategory = false;

  String? wateringEng;

  String? sunlightEng;

  String? pruningEng;

  String? fertilizationEng;

  String? wateringPl;

  String? sunlightPl;

  String? pruningPl;

  String? fertilizationPl;

  ///  State fields for stateful widgets in this page.

  final formKey2 = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  // Model for customAppbar component.
  late CustomAppbarModel customAppbarModel;
  bool isDataUploading_uploadDataPx5 = false;
  FFUploadedFile uploadedLocalFile_uploadDataPx5 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadDataPx5 = '';

  // Stores action output result for [Backend Call - API (getSpeciesByUrl)] action in Button widget.
  ApiCallResponse? apiResult3s8;
  // State field(s) for organs widget.
  String? organsValue;
  FormFieldController<String>? organsValueController;
  // State field(s) for DropDown widget.
  int? dropDownValue;
  FormFieldController<int>? dropDownValueController;
  // State field(s) for name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  String? _nameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        '2mjj6v5w' /*  Name is required */,
      );
    }

    return null;
  }

  // State field(s) for description widget.
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionTextController;
  String? Function(BuildContext, String?)? descriptionTextControllerValidator;
  // State field(s) for location widget.
  FocusNode? locationFocusNode;
  TextEditingController? locationTextController;
  String? Function(BuildContext, String?)? locationTextControllerValidator;
  // State field(s) for species widget.
  FocusNode? speciesFocusNode;
  TextEditingController? speciesTextController;
  String? Function(BuildContext, String?)? speciesTextControllerValidator;
  String? _speciesTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'hm8f05yr' /*  Species is required */,
      );
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    customAppbarModel = createModel(context, () => CustomAppbarModel());
    nameTextControllerValidator = _nameTextControllerValidator;
    speciesTextControllerValidator = _speciesTextControllerValidator;
  }

  @override
  void dispose() {
    customAppbarModel.dispose();
    nameFocusNode?.dispose();
    nameTextController?.dispose();

    descriptionFocusNode?.dispose();
    descriptionTextController?.dispose();

    locationFocusNode?.dispose();
    locationTextController?.dispose();

    speciesFocusNode?.dispose();
    speciesTextController?.dispose();
  }
}
