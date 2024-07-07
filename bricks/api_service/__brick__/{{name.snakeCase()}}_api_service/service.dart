import 'package:http/http.dart';
import '../../api/api_request.dart';
import '../../api/api_service.dart';
import 'responses.dart';

class {{name.pascalCase()}}ApiService extends ApiService {

  @override
  String get baseUrl => '{{baseUrl}}';

  @override
  Future<void> authenticate(Map<String, String> headers, Map<String, dynamic>? data) async {
    //Authenticate
  }

  @override
  Map<String, dynamic> onJsonParsed(Response response, Map<String, dynamic> jsonBody, Map<String, String> headers) {
    //Code to execute on all requests after JSON has been received but before the response is parsed
    //For example, this could be used to filter HTTP status codes...
    return jsonBody;
  }

  Future<Example{{name.pascalCase()}}ApiResponse> example(String id) => apiRequest(
    '/example',
    method: HttpMethod.get,
    data: {
      'id': id
    }
  );

}