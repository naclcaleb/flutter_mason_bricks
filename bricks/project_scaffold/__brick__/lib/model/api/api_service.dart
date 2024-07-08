import 'dart:convert';
import 'dart:developer';
import '../../root_app_config.dart';
import '../../service_locator.dart';
import '../error_handlers/info_exception.dart';
import '../error_handlers/network_error_handler.dart';
import '../services/error_service.dart';
import 'api_request.dart';
import 'json_tools.dart';
import 'package:http/http.dart' as http;

abstract class ApiService {

  final String baseUrl = '';
  final String? devBaseUrl = null;

  final ErrorService _errorService = sl();

  ApiService() {
    _registerAllApiResponses();
  }

  String get _baseUrl {
    if (devBaseUrl == null) return baseUrl;
    if (RootAppConfig.environment == ProjectEnvironment.dev) return devBaseUrl!;
    return baseUrl;
  }

  Map<String, String> baseHeaders = {
    'X-App-Version': RootAppConfig.appVersion,
    'Content-Type': 'application/json'
  };

  Map<String, String> _getBaseHeaders() {
    Map<String, String> headers = {};
    headers.addAll(baseHeaders);
    return headers;
  }
  
  Map<String, dynamic> onJsonReceived(http.Response response, Map<String, dynamic> jsonBody, Map<String, String> headers) {
    //Handle error codes
    if (response.statusCode != 200) {

      if (jsonBody['success'] != null && jsonBody['success'] == false) {

        final String errorMessage = jsonBody['errorMessage'] ?? 'No error message provided';
        throw NetworkException(message: errorMessage, statusCode: response.statusCode);

      }

      if (jsonBody['message'] != null && jsonBody['message'] == 'Invalid token') {
        
        //_authService.signOut();
        
        
        throw NetworkException(message: 'Invalid token', statusCode: response.statusCode);
      }
      log(response.body);
      throw NetworkException(message: 'Unknown Error', statusCode: response.statusCode);

    }

    //Format response as JSON
    return jsonBody;
  } 

  Future<void> authenticate(Map<String, String> headers, Map<String, dynamic>? data) async {
    //var token = await authService.getSessionToken();
    //headers['Authorization'] = 'Bearer $token';
  }

  //Base request code
  Future<Map<String, dynamic>> _makeRequest(String route, HttpMethod method, Map<String, String> headers, Map<String, dynamic>? data) async {
    //Parse the URL
    var httpUrl = Uri.parse('$_baseUrl/$route');
    
    //For get requests, data is given as query parameters
    if (method == HttpMethod.get) {
      Map<String, dynamic> newData = Map.from(data ?? {});
      newData.updateAll((key, value) {
        if (value is! Iterable) {
          return value.toString();
        }
        return value;
      });
      httpUrl = httpUrl.replace(queryParameters: newData);
    }

    //Use baseline headers
    headers.addAll(baseHeaders);

    //Make the proper request
    http.Response response;
    if (method == HttpMethod.get) { response = await http.get(httpUrl, headers: headers); }
    else if (method == HttpMethod.post) { response = await http.post(httpUrl, headers: headers, body: json.encode(data)); }
    else if (method == HttpMethod.put) { response = await http.put(httpUrl, headers: headers, body: json.encode(data)); }
    else if (method == HttpMethod.delete) { response = await http.delete(httpUrl, headers: headers); }
    else { throw Exception('Invalid HTTP method'); }

    Map<String, dynamic> jsonBody;
    try {
      jsonBody = jsonDecode(response.body);
    } on FormatException catch(error) {
      final newError = FormatException(response.body, error);
      _errorService.receiveError(newError);
      return {};
    }

    return onJsonReceived(response, jsonBody, headers);
  }

  //For requests that require authentication
  Future<Map<String, dynamic>> _makeAuthenticatedRequest(String route, HttpMethod method, Map<String, dynamic>? data) async {

    var headers = _getBaseHeaders();

    //First, ensure authentication
    authenticate(headers, data);
    
    //Make the request
    return await _makeRequest(route, method, headers, data);
  }

  Future<ResponseType> _performAndParse<ResponseType extends JsonObject>(ApiRequest request) async {
    Map<String, dynamic> responseJson;
    
    if (request.requiresAuth) {
      responseJson = await _makeAuthenticatedRequest(request.route, request.method, request.data).catchError((error) {
        _errorService.receiveError(error);
        throw error;
      });
    }
    else {
      responseJson = await _makeRequest(request.route, request.method, {}, request.data).catchError((error) {
        _errorService.receiveError(error);
        throw error;
      });
    }

    return JsonObjectParser.parseResponse(responseJson) as ResponseType;
  }

  //Convenience mirror of ApiRequest
  Future<ResponseType> apiRequest<ResponseType>(
    String route,
    {
      required HttpMethod method,
      bool requiresAuth = false,
      Map<String, dynamic>? data,
      String? name
    }
  ) {

    return _performAndParse(ApiRequest(route: route, method: method, requiresAuth: requiresAuth, data: data, name: name));

  }

  //To be overridden
  final List<RegisteredJsonObjectParser> responseParsers = [];
  
  void _registerAllApiResponses() {
    for (final parser in responseParsers) {
      if (parser.type == JsonObject) throw const InfoException('JsonObjectParser: Attempted to register parser for object of base type "JsonObject". This is a mistake - did you forget to use explicit type definitions in instances of `RegisteredJsonObjectParser()`?');
      log('Registering object of type ${parser.type}');
    }
  }

}


