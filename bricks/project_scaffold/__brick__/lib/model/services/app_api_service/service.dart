import 'package:http/http.dart';
import '../../api/api_request.dart';
import '../../api/api_service.dart';
import 'responses.dart';

class AppApiService extends ApiService {

  @override
  String get baseUrl => 'http://example.com';

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

  Future<TestApiResponse> getWhatINeed(String id) => apiRequest(
    '/test',
    method: HttpMethod.get,
    data: {
      'id': id
    }
  );

}