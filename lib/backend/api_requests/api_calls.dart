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
    String? lang = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getAllPlantsBySpecies',
      apiUrl: 'http://localhost:8080/api/plantify/guide/getPlantsBySpecies',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': '${lang}',
      },
      params: {
        'species': name,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
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
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetSpeciesByUrlCall {
  static Future<ApiCallResponse> call({
    String? url = '',
    String? organs = 'auto',
    String? authToken = '',
    String? lang = 'en',
    int? nbresults = 1,
  }) async {
    final ffApiRequestBody = '''
{
  "url": "${escapeStringForJson(url)}",
  "organs": "${escapeStringForJson(organs)}",
  "auth_token": "${escapeStringForJson(authToken)}",
  "lang": "${escapeStringForJson(lang)}",
  "nbresults": ${nbresults}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'getSpeciesByUrl',
      apiUrl: 'http://localhost:8080/api/plantify/ai/getSpeciesByUrl',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': '${lang}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
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
    String? lang = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getSinglePlantGuide',
      apiUrl: 'http://localhost:8080/api/plantify/guide/getSinglePlant',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': '${lang}',
      },
      params: {
        'id': id,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetPlantInstructionsCall {
  static Future<ApiCallResponse> call({
    String? authToken = '',
    String? id = '',
    String? name = '',
    String? lang = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getPlantInstructions',
      apiUrl: 'http://localhost:8080/api/plantify/guide/getPlantsGuideById',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': '${lang}',
      },
      params: {
        'speciesId': id,
        'speciesName': name,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetFaqCall {
  static Future<ApiCallResponse> call({
    String? name = '',
    String? authToken = '',
    String? lang = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getFaq',
      apiUrl: 'http://localhost:8080/api/plantify/guide/getPlantsFAQ',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': '${lang}',
      },
      params: {
        'name': name,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GenerateShoppingListCall {
  static Future<ApiCallResponse> call({
    String? authToken = '',
    String? species = '',
    String? lang = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'generateShoppingList',
      apiUrl: 'http://localhost:8080/api/plantify/ai/generateShoppingList',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Lang': '${lang}',
      },
      params: {
        'species': species,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ChatCall {
  static Future<ApiCallResponse> call({
    String? mes = '',
    String? authToken = '',
    String? userId = '',
    String? lang = '',
  }) async {
    final ffApiRequestBody = '''
{
  "mes": "${escapeStringForJson(mes)}",
  "userId": "${escapeStringForJson(userId)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'chat',
      apiUrl: 'http://localhost:8080/api/plantify/chat/generate',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': '${lang}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ChatRefreshCall {
  static Future<ApiCallResponse> call({
    String? userId = '',
    String? authToken = '',
    String? lang = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'ChatRefresh',
      apiUrl: 'http://localhost:8080/api/plantify/chat/refresh',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': '${lang}',
      },
      params: {
        'userId': userId,
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

class AddEventCall {
  static Future<ApiCallResponse> call({
    String? eventName = '',
    String? authToken = '',
    String? eventDate = '',
  }) async {
    final ffApiRequestBody = '''
{
  "eventName": "${escapeStringForJson(eventName)}",
  "eventDate": "${escapeStringForJson(eventDate)}",
  "auth_token": "${escapeStringForJson(authToken)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'addEvent',
      apiUrl: 'http://10.0.2.2:8080/api/plantify/calendar/add-event',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetTipsCall {
  static Future<ApiCallResponse> call({
    String? authToken = '',
    String? species = '',
    String? lang = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getTips',
      apiUrl: 'http://localhost:8080/api/plantify/ai/tips',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': '${lang}',
      },
      params: {
        'species': species,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: true,
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
  if (item is DocumentReference) {
    return item.path;
  }
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

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
