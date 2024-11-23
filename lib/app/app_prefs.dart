// lib/app/app_prefs.dart

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jarvis/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String KEY_ACCESS_TOKEN = "KEY_ACCESS_TOKEN";
const String KEY_REFRESH_TOKEN = "KEY_REFRESH_TOKEN";

class AppPreferences {
  final SharedPreferences _sharedPreferences;
  final FlutterSecureStorage _secureStorage;

  AppPreferences(this._sharedPreferences, this._secureStorage);

  String getAppLanguage() {
    String? language = _sharedPreferences.getString(PREFS_KEY_LANG);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.ENGLISH.getValue();
    }
  }

  // Access Token
  Future<String> getAccessToken() async {
    return await _secureStorage.read(key: KEY_ACCESS_TOKEN) ?? '';
  }

  Future<void> setAccessToken(String token) async {
    await _secureStorage.write(key: KEY_ACCESS_TOKEN, value: token);
  }

  Future<void> deleteAccessToken() async {
    await _secureStorage.delete(key: KEY_ACCESS_TOKEN);
  }

  // Refresh Token
  Future<String> getRefreshToken() async {
    return await _secureStorage.read(key: KEY_REFRESH_TOKEN) ?? '';
  }

  Future<void> setRefreshToken(String token) async {
    await _secureStorage.write(key: KEY_REFRESH_TOKEN, value: token);
  }

  Future<void> deleteRefreshToken() async {
    await _secureStorage.delete(key: KEY_REFRESH_TOKEN);
  }

  // Xóa tất cả token
  Future<void> clearTokens() async {
    await _secureStorage.delete(key: KEY_ACCESS_TOKEN);
    await _secureStorage.delete(key: KEY_REFRESH_TOKEN);
  }

  // bool hasToken() {
  //   return _sharedPreferences.containsKey(PREFS_KEY_TOKEN);
  // }
}
