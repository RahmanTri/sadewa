import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const _emailKey = 'user_enmail';
  static const _passwordKey = 'user_password';
  static const _rememberKey = 'user_is_remember';

  // Save data
  Future<void> saveEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_emailKey, email);
  }

  Future<void> savePassword(String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_passwordKey, password);
  }

  Future<void> saveRemember(bool isRemember) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_rememberKey, isRemember);
  }

  // Get data
  Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailKey);
  }

  Future<String?> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_passwordKey);
  }

  Future<bool?> getRemember() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_rememberKey);
  }

  // Delete data
  Future<void> deleteEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_emailKey);
  }

  Future<void> deletePassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_passwordKey);
  }

  Future<void> deleteRemember() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_rememberKey);
  }

  // RememberMe
  Future<void> setRememberMe(
    bool rememberValue,
    String? email,
    String? password,
  ) async {
    saveRemember(rememberValue);

    if (rememberValue) {
      await saveEmail(email ?? '');
      await savePassword(password ?? '');
    } else {
      await deleteEmail();
      await deletePassword();
    }
  }

  // GetUserCredential
  Future<Map<String, String>> getUserCredential() async {
    String? email = await getEmail();
    String? password = await getPassword();
    return {'email': email ?? '', 'password': password ?? ''};
  }
}
