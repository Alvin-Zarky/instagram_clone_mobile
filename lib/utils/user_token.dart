import 'package:shared_preferences/shared_preferences.dart';

class UserTokenService {
  Future<String?> getUserToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString('token');
    return token;
  }
}
