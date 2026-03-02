import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'logger_service.dart';

class SharedPreferencesService {
  static const String _keyUserData = 'user_data';
  static const String _deviceToken = 'deviceToken';
  static const String _apiToken = 'apiToken';

  Future<void> saveDeviceToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_deviceToken, token);
    LoggerService.i('Saved device token');
  }

  Future<String?> readDeviceToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_deviceToken);
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_apiToken, token);
    LoggerService.i('Saved API token');
  }

  Future<String?> readToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_apiToken);
  }

  Future<void> saveUserData(dynamic userData) async {
    final prefs = await SharedPreferences.getInstance();
    final data = json.encode(userData.toJson());
    await prefs.setString(_keyUserData, data);
    LoggerService.i('Saved user data');
  }

  Future<dynamic> readUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_keyUserData);
    if (data == null) return null;
    return json.decode(data);
  }

  Future<void> clearAllPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
