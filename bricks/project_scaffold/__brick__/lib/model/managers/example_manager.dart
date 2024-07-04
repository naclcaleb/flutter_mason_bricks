import 'package:rctv/rctv.dart';

class Example extends Manageable<Example> {
  @override
  final String id;
  String exampleText = 'Hey there!';

  Example(this.id);

  @override
  void update(Example newVersion) {
    exampleText = newVersion.exampleText;
  }
}



class ExampleManager extends Manager<Example> {
  @override
  Future<Example> fetchItem(String id) {
    return Future.delayed(const Duration(seconds: 2), () {
      return Example(id);
    });
  }
}
