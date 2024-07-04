import 'package:rctv/rctv.dart';

abstract class BaseViewModel extends ReactiveAggregate {

  void init() {

  }

  @override
  void dispose() {
    disposeReactives([]);
  }

}