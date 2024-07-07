import '../../api/api_response.dart';

class Example{{name.pascalCase()}}ApiResponse extends ApiResponse<Example{{name.pascalCase()}}ApiResponse> {

  final String message;

  @override
  Example{{name.pascalCase()}}ApiResponse parseFunction(Map<String, dynamic> json) => Example{{name.pascalCase()}}ApiResponse(json['message']);

  Example{{name.pascalCase()}}ApiResponse(this.message);

}