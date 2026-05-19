import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPreferences {
  static SharedPreferences? _prefs;

  static const String _userKey = "user_data";
  static const String _isLoggedInKey = "is_logged_in";

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// SAVE FULL USER DATA (LOGIN / REGISTER)
  static Future<void> saveUser(Map<String, dynamic> userData) async {
    await _prefs?.setString(_userKey, jsonEncode(userData));
    await _prefs?.setBool(_isLoggedInKey, true);
  }

  /// GET USER DATA
  static Map<String, dynamic>? getUser() {
    final data = _prefs?.getString(_userKey);
    if (data == null) return null;
    return jsonDecode(data);
  }

  /// CHECK LOGIN STATUS
  static bool isLoggedIn() {
    return _prefs?.getBool(_isLoggedInKey) ?? false;
  }

  /// GET USER ID
  static int? getUserId() {
    final user = getUser();
    return user?['id'];
  }

  /// LOGOUT
  static Future<void> logout() async {
    await _prefs?.remove(_userKey);
    await _prefs?.remove(_isLoggedInKey);
  }
}