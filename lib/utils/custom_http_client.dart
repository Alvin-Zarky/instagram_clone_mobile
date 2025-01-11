import "package:http/http.dart" as http;
import 'package:instagram/utils/user_token.dart';

class CustomHttpClient extends http.BaseClient {
  final UserTokenService userTokenService = UserTokenService();
  final http.Client _httpClient = http.Client();

  final Map<String, String> headers = {
    "Content-Type": "application/json; charset=utf-8"
  };

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final String? token = await userTokenService.getUserToken();
    if (token!.isNotEmpty) {
      headers['Authorization'] = "Bearer $token";
    }

    request.headers.addAll(headers);
    return _httpClient.send(request);
  }
}
