import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static SharedPreferences? _prefs;

  // Initialize SharedPreferences instance
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Set value in SharedPreferences
  static Future<bool> setValue(String key, dynamic value) async {
    if (_prefs == null) return false;

    if (value is String) {
      return await _prefs!.setString(key, value);
    } else if (value is int) {
      return await _prefs!.setInt(key, value);
    } else if (value is bool) {
      return await _prefs!.setBool(key, value);
    } else if (value is double) {
      return await _prefs!.setDouble(key, value);
    } else {
      throw Exception("Invalid value type");
    }
  }

  // Get value from SharedPreferences
  static dynamic getValue(String key, {dynamic defaultValue}) {
    if (_prefs == null) return defaultValue;

    return _prefs!.get(key) ?? defaultValue;
  }

  // Clear a specific key
  static Future<bool> clearKey(String key) async {
    if (_prefs == null) return false;

    return await _prefs!.remove(key);
  }

  // Clear all SharedPreferences
  static Future<bool> clearAll() async {
    if (_prefs == null) return false;

    return await _prefs!.clear();
  }
}
