import 'package:shared_preferences/shared_preferences.dart';

class sharedPrefs {
 static saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
  }

  // static getToken() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var token = prefs.getString("token");

  //   return token.toString();
  // }

}
