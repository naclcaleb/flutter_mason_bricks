import '../error_handlers/info_exception.dart';

//Use to implement your own base response class as needed
abstract class JsonObject {
}

typedef JsonObjectParseFunc<ResponseType> = ResponseType Function(Map<String, dynamic> json);

class RegisteredJsonObjectParser<T extends JsonObject> {
  final JsonObjectParseFunc<T> parser;

  Type get type => T;

  RegisteredJsonObjectParser({ required this.parser }) {
    JsonObjectParser.registerParseFunc(parser);
  }
}

class JsonObjectParser {

  static final Map<Type, JsonObjectParseFunc> _responseParsers = {};

  static bool registerParseFunc<ResponseType extends JsonObject>(JsonObjectParseFunc<ResponseType> parseFunc) {
    if (parseFunc.runtimeType == JsonObjectParseFunc<JsonObject>) throw const InfoException('JsonObjectParser: Attempted to register parser for object of base type "JsonObject". This is a mistake - did you forget to use explicit type definitions in instances of `RegisteredJsonObjectParser()`?');
    _responseParsers[ResponseType] = parseFunc;
    return true;
  } 

  static JsonObjectParseFunc<ResponseType> _searchParseFuncsForType<ResponseType>() {
    if (_responseParsers.containsKey(ResponseType)) return _responseParsers[ResponseType] as JsonObjectParseFunc<ResponseType>;

    throw InfoException(
      'No parser function found for JsonObject type "$ResponseType"\n'
      'Did you forget to call `registerParseFunc()` for this type?'
      );
  }

  static ResponseType parseResponse<ResponseType>(Map<String, dynamic> json) {
    final parseFunc = _searchParseFuncsForType<ResponseType>();
    try {
      return parseFunc(json);
    } on TypeError catch(e) {
      throw JsonParseException(responseJson: json, errorMessage: e.toString(), targetType: ResponseType.toString());
    }
  }

  static List<Type> jsonListConverter<Type extends JsonObject>(Object? jsonList) {
    return (jsonList as List<dynamic>?)?.map((item) => JsonObjectParser.parseResponse<Type>(item)).toList() ?? [];
  }

}


class JsonParseException implements Exception {
  final Map<String, dynamic> responseJson;
  final String errorMessage;
  final String targetType;

  JsonParseException({required this.responseJson, required this.errorMessage, required this.targetType});

  @override
  String toString() {
    return '''
JsonParseException:
  Target Type: $targetType
  Original JSON: ${responseJson.toString()}
Error Message: 
$errorMessage
''';
  }
}