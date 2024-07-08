import '../../api/json_tools.dart';

class Example{{name.pascalCase()}}Response extends JsonObject {

  final String message;

  static Example{{name.pascalCase()}}Response parseFunction(Map<String, dynamic> json) => Example{{name.pascalCase()}}Response(json['message']);

  Example{{name.pascalCase()}}Response(this.message);

}

final List<RegisteredJsonObjectParser> allResponseTypes = [
  RegisteredJsonObjectParser<Example{{name.pascalCase()}}Response>(parser: Example{{name.pascalCase()}}Response.parseFunction)
];