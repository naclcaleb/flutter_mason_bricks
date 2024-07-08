import 'dart:developer';
import '../api/json_tools.dart';
import 'user/user.dart';

//Add your ORM objects here - be sure to use explicit types!
final List<RegisteredJsonObjectParser>  objectRegistry = [
  RegisteredJsonObjectParser<User>(parser: User.parseFunction),
];

void initObjectRegistry() {
  for (final object in objectRegistry) {
    log('Registering object of type ${object.type}');
  }
}