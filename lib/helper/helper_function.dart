import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction {
  HelperFunction() {}

  static Future<void> saveUserName(String userName) async {
    print("saving while registering " + userName);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userNameKey", userName);
  }

  static Future<void> saveUserLoginStatus(String loginKey) async {
    //if login key is empty then user is logging out
    if (loginKey.isEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("userLoggedInKey", "");
      saveUserEmail("");
      saveUserName("");
      return;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userLoggedInKey", loginKey);
  }

  static Future<void> saveUserEmail(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userEmailKey", userEmail);
  }

  static Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("userNameKey");
  }

  static Future<bool?> getUserLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("userLoggedInKey");
  }

  static Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("userEmailKey");
  }
}
