import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;

class SharedPrefs {
  static Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setStringValue(String key, String value) async {
    await prefs!.setString(key, value);
  }

  static String? getStringValue(String key) {
    return prefs!.getString(key);
  }

  static Future<void> setBooleanValue(String key, bool value) async {
    await prefs!.setBool(key, value);
  }

  static bool? getBooleanValue(String key) {
    return prefs!.getBool(key);
  }

  static Future<void> removeValue(String key) async {
    await prefs!.remove(key);
  }

  static Future<void> clearValues() async {
    await prefs!.clear();
  }
}