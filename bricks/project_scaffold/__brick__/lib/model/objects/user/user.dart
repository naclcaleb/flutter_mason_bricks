import 'package:rctv/rctv.dart';
import '../../api/json_tools.dart';

class User implements Manageable<User>, JsonObject {
  
  @override
  final String id;

  User({ required this.id });

  static User parseFunction(Map<String, dynamic> json) => User(
    id: json['id']!
  );

  @override
  void update(User newVersion) {
    
  }

}
