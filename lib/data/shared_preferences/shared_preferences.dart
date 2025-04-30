import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static SharedPreferences? _preferences;

  static const _languageNepali = 'LANGUAGE';
  static const _token = 'TOKEN';
  static const _username = 'USERNAME';
  static const _clientId ='CLIENTID';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

//save data
  static Future setLanguage(bool languageNepali) async {
    await _preferences?.setBool(_languageNepali, languageNepali);
  }

  static Future setToken(String token) async {
    await _preferences?.setString(_token, token);
  }

  static Future setUsername(String username) async {
    await _preferences?.setString(_username, username);
  }
  static Future setClientId(String clientId)async{
    await _preferences?.setString(_clientId, clientId);
  }

//get saved data
  static bool? getLanguage() => _preferences?.getBool(_languageNepali);
  static String? getToken() => _preferences?.getString(_token);
  static String? getUsername() => _preferences?.getString(_username);
  static Future cleanL() async {
    await _preferences?.remove(_languageNepali);
  }
  static String? getClientId()=> _preferences?.getString(_clientId);

  static Future cleanToken() async {
    await _preferences?.remove(_token);
  }

  static userLoggedIn() {
    return _preferences?.containsKey(_token);
  }

  static Future userLoggedOut() async {
    await _preferences?.remove(_token);
    await _preferences?.remove(_username);
  }
}
