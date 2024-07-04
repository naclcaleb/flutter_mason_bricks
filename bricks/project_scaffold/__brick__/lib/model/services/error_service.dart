import 'package:rctv/rctv.dart';

typedef ErrorServicePlugin = bool Function(ErrorService service, Exception error);

class ErrorService extends ReactiveStream<String> {

  final List<ErrorServicePlugin> _plugins = [];

  ErrorService();

  void receiveError(Exception error) {

    var shouldContinue = true;

    for (final plugin in _plugins) {
      shouldContinue = plugin(this, error);
      if (!shouldContinue) break;
    }

    if (shouldContinue) _defaultPlugin(error);

  }

  bool _defaultPlugin(Exception error) {
    //If all else fails, just throw
    throw error;
  }

  void registerPlugin(ErrorServicePlugin plugin) {
    _plugins.add(plugin);
  }

  void registerPlugins(List<ErrorServicePlugin> plugins) {
    _plugins.addAll(plugins);
  }

  void showSnack(String message) {
    add(message);
  }

}