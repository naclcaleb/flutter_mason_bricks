import '../../api/api_response.dart';

class TestApiResponse extends ApiResponse<TestApiResponse> {

  final String message;

  @override
  TestApiResponse parseFunction(Map<String, dynamic> json) => TestApiResponse(json['message']);

  TestApiResponse(this.message);

}