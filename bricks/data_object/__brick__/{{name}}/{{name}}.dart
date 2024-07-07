import '../../api/api_response.dart';

class {{name.pascalCase()}} extends ApiResponse<{{name.pascalCase()}}> {
  
  final String id;

  {{name.pascalCase()}}({ required this.id });

  @override
  {{name.pascalCase()}} parseFunction(Map<String, dynamic> json) => {{name.pascalCase()}}(
    id: json['id']! 
  );

  {{name.pascalCase()}}.fromJson(Map<String, dynamic> json) 
  : id = json['id']!;

}