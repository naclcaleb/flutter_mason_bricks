import '../../api/api_response.dart';
import '../../utils/json_list_converter.dart';

class User extends ApiResponse<User> {
  
  final String id;

  List<User> friends;

  User({ required this.id, required this.friends });

  @override
  User parseFunction(Map<String, dynamic> json) => User(
    id: json['id']!, 
    friends: friends
  );

  User.fromJson(Map<String, dynamic> json) 
  : id = json['id']!,
    friends = jsonListConverter(json['friends'], User.fromJson);

}