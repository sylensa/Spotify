import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';



class UserPreferences {
  static late SharedPreferences _prefs;

  static set prefs(SharedPreferences prefs) => _prefs = prefs;

  static SharedPreferences get instance => _prefs;
  static String? get accessToken => _prefs.getString("token");
  static String? get refreshToken => _prefs.getString("refresh_token");



  Future<String?> getUserToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString("token");
    return value;
  }

  Future<String?> getUserRefreshToken() async {
    return getUserValue("refresh_token");
  }


  Future<String?> getUserValue(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString(args);
    return value;
  }

  setToken(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    log("setting new token token:$value");
    preferences.setString('token', value);
  }

  setRefreshToken(String value) async {
    log("setting new refresh_token:$value");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('refresh_token', value);
  }

}
