import 'package:rctv/rctv.dart';
import 'user.dart';

class ReactiveUser extends SupervisedReactive<User> {

  ReactiveUser(User user) : super('ReactiveUser ${user.id}', initialValue: user);

}