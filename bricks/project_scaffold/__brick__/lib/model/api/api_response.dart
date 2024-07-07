import '../error_handlers/info_exception.dart';

//Use to implement your own base response class as needed
abstract class ApiResponse<ResponseType extends ApiResponse<ResponseType>> {
  ResponseType parseFunction(Map<String, dynamic> json);

  //A little hacky, but the best place to put it at the moment
  late final _registration = ApiResponseParser.registerParseFunc(parseFunction);
}

typedef ApiResponseParseFunc<ResponseType> = ResponseType Function(Map<String, dynamic> json);

class ApiResponseParser {

  static final List<ApiResponseParseFunc> _parseFuncs = [];

  static bool registerParseFunc<ResponseType>(ApiResponseParseFunc<ResponseType> parseFunc) {
    _parseFuncs.add(parseFunc);
    return true;
  }

  static ApiResponseParseFunc<ResponseType> _searchParseFuncsForType<ResponseType>() {
    for (final parseFunc in _parseFuncs) {
      if (parseFunc is ApiResponseParseFunc<ResponseType>) {
        return parseFunc;
      }
    }

    throw InfoException(
      'No parser function found for ApiResponse type "${ResponseType.runtimeType}"'
      'Did you forget to call `registerParseFunc()` for this type?'
      );
  }

  static ResponseType parseResponse<ResponseType>(Map<String, dynamic> json) {
    final parseFunc = _searchParseFuncsForType<ResponseType>();
    try {
      return parseFunc(json);
    } on TypeError catch(e) {
      throw ResponseParseException(responseJson: json, errorMessage: e.toString(), targetType: ResponseType.runtimeType.toString());
    }
  }

}


class ResponseParseException implements Exception {
  final Map<String, dynamic> responseJson;
  final String errorMessage;
  final String targetType;

  ResponseParseException({required this.responseJson, required this.errorMessage, required this.targetType});

  @override
  String toString() {
    return '''
ResponseParseException:
  Target Type: $targetType
  Response JSON: ${responseJson.toString()}
Error Message: 
$errorMessage
''';
  }
}