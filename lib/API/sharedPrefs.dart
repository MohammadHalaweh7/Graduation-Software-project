import 'package:shared_preferences/shared_preferences.dart';

class sharedPrefs {
  static saveToken(String token, String? type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
    if (type != null) {
      prefs.setString("type", type);
    }
  }
}
