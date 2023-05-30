import 'package:shared_preferences/shared_preferences.dart';



class SessionManager {
  static const String ACCESS_TOKEN = "ACCESS_TOKEN";
  static const String USER_ID = "USER_ID";
  static const String FCM_TOKEN = "FCM_TOKEN";


  static Future<void> saveAccessToken(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(ACCESS_TOKEN, value);
  }

  static Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(ACCESS_TOKEN);
  }

  static Future<void> saveFCMToken(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(FCM_TOKEN, value);
  }

  static Future<String?> getFCMToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(FCM_TOKEN);
  }

  static Future<void> saveUserId(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_ID, value);
  }

  static Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(USER_ID);
  }

}
