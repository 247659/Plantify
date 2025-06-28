import '/backend/schema/structs/index.dart';

class MintSupabaseTokenCloudFunctionCallResponse {
  MintSupabaseTokenCloudFunctionCallResponse({
    this.errorCode,
    this.succeeded,
    this.jsonBody,
  });
  String? errorCode;
  bool? succeeded;
  dynamic jsonBody;
}
