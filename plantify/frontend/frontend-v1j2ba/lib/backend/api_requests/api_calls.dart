import 'dart:convert';
import 'dart:typed_data';
import '../schema/structs/index.dart';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class GetAllPlantsBySpeciesCall {
  static Future<ApiCallResponse> call({
    String? authToken = '',
    String? name = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getAllPlantsBySpecies',
      apiUrl: 'http://10.0.2.2:8080/api/plantify/guide/getPlantsBySpecies',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
      },
      params: {
        'species': name,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetSpeciesCall {
  static Future<ApiCallResponse> call({
    FFUploadedFile? uploadedImages,
    String? organs = 'auto',
    String? authToken = '',
    String? lang = 'en',
    int? nbresults = 3,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getSpecies',
      apiUrl: 'http://localhost:8080/api/plantify/ai/getSpecies',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer ${authToken}',
      },
      params: {
        'images': uploadedImages,
        'organs': organs,
        'lang': lang,
        'nbresults': nbresults,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetSinglePlantGuideCall {
  static Future<ApiCallResponse> call({
    String? authToken = '',
    String? id = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getSinglePlantGuide',
      apiUrl: 'http://10.0.2.2:8080/api/plantify/guide/getSinglePlant',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
      },
      params: {
        'id': id,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
