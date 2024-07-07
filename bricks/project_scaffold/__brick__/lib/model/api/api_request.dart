enum HttpMethod {
  get,
  post,
  put,
  delete,
}

class ApiRequest {

  final String route;
  final String? name;
  final HttpMethod method;
  final bool requiresAuth;
  final Map<String, dynamic>? data;

  ApiRequest({ required this.route, required this.method, this.requiresAuth = false, this.data, this.name });

  String describe() {
    var dataString = '';
    
    if (data != null && data!.isNotEmpty) {
      for (var key in data!.keys) {
        dataString += '\t$key: ${data![key].runtimeType}\n';
      }
    }

    var responseString = '''
Request: $name, Route: $route, Method: $method, Requires Auth: $requiresAuth''';

    if (dataString.isNotEmpty) {
      responseString += '\nParameters:\n $dataString';
    }

    return responseString;
  }



}

class Request {
  String route;
  String name;
  HttpMethod method;
  bool requiresAuth;
  Map<String, dynamic>? data;

  Request(this.route, this.method, this.requiresAuth, { this.name = 'Untitled', this.data = const {} });

  String describe() {
    var dataString = '';
    
    if (data != null && data!.isNotEmpty) {
      for (var key in data!.keys) {
        dataString += '\t$key: ${data![key].runtimeType}\n';
      }
    }

    var responseString = '''
Request: $name, Route: $route, Method: $method, Requires Auth: $requiresAuth''';

    if (dataString.isNotEmpty) {
      responseString += '\nParameters:\n $dataString';
    }

    return responseString;
  }
}