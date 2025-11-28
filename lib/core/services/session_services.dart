import 'package:shared_preferences/shared_preferences.dart';

class SessionServices {
  static const String _accessTokenKey = 'access_token';

  final SharedPreferences _prefs;
  SessionServices(this._prefs);

  // save token method
  Future<void> saveToken({required String accessToken}) async {
    await _prefs.setString(_accessTokenKey, accessToken);
  }

  // get token method
  String? getAccessToken() {
    return _prefs.getString(_accessTokenKey);
  }

  // check session method
  bool isLoggedIn() {
    final token = getAccessToken();
    if (token == null || token.isEmpty) return false;

    return true;
  }

  // clear session method
  Future<void> clearSession() async {
    await _prefs.remove(_accessTokenKey);
  }
}
