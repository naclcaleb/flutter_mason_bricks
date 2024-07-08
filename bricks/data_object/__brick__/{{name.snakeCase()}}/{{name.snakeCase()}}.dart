import 'package:rctv/rctv.dart';
import '../../api/json_tools.dart';

class {{name.pascalCase()}} implements Manageable<{{name.pascalCase()}}>, JsonObject {
  
  @override
  final String id;

  {{name.pascalCase()}}({ required this.id });

  static {{name.pascalCase()}} parseFunction(Map<String, dynamic> json) => {{name.pascalCase()}}(
    id: json['id']! 
  );

  @override
  void update({{name.pascalCase()}} newVersion) {
    
  }

}