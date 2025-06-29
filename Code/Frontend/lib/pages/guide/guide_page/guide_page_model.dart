import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/components/answer_component/answer_component_widget.dart';
import '/pages/components/error_component/error_component_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'guide_page_widget.dart' show GuidePageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class GuidePageModel extends FlutterFlowModel<GuidePageWidget> {
  ///  Local state fields for this page.

  SinglePlantInformationStruct? plantDetails;
  void updatePlantDetailsStruct(
      Function(SinglePlantInformationStruct) updateFn) {
    updateFn(plantDetails ??= SinglePlantInformationStruct());
  }

  String? selectedOption = 'plants';

  List<QuestionStruct> faq = [];
  void addToFaq(QuestionStruct item) => faq.add(item);
  void removeFromFaq(QuestionStruct item) => faq.remove(item);
  void removeAtIndexFromFaq(int index) => faq.removeAt(index);
  void insertAtIndexInFaq(int index, QuestionStruct item) =>
      faq.insert(index, item);
  void updateFaqAtIndex(int index, Function(QuestionStruct) updateFn) =>
      faq[index] = updateFn(faq[index]);

  String? name;

  bool isLoading = false;

  bool faqLoading = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  String? _nameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        '74nagpv3' /*  Name is required */,
      );
    }

    return null;
  }

  // Stores action output result for [Backend Call - API (getAllPlantsBySpecies)] action in Button widget.
  ApiCallResponse? allPlantsInfoBySpecies;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // Stores action output result for [Backend Call - API (getFaq)] action in ChoiceChips widget.
  ApiCallResponse? faqResult;
  // Stores action output result for [Backend Call - API (getSinglePlantGuide)] action in Button widget.
  ApiCallResponse? apiResultifl;

  @override
  void initState(BuildContext context) {
    nameTextControllerValidator = _nameTextControllerValidator;
  }

  @override
  void dispose() {
    nameFocusNode?.dispose();
    nameTextController?.dispose();
  }
}
