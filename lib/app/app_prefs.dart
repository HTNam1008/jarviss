// lib/app/app_prefs.dart

import 'package:jarvis/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String PREFS_KEY_TOKEN = "PREFS_KEY_TOKEN";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  String getAppLanguage() {
    String? language = _sharedPreferences.getString(PREFS_KEY_LANG);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.ENGLISH.getValue();
    }
  }

  Future<void> setAppLanguage(String language) async {
    await _sharedPreferences.setString(PREFS_KEY_LANG, language);
  }

  String getToken() {
    return _sharedPreferences.getString(PREFS_KEY_TOKEN) ?? '';
  }

  Future<void> setToken(String token) async {
    await _sharedPreferences.setString(PREFS_KEY_TOKEN, token);
  }

  Future<void> clearToken() async {
    await _sharedPreferences.remove(PREFS_KEY_TOKEN);
  }

  bool hasToken() {
    return _sharedPreferences.containsKey(PREFS_KEY_TOKEN);
  }
}
