import 'dart:ffi';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const _emailUsernameKey = 'username_email';
  static const _passwordKey = 'user_password';
  static const _rememberKey = 'user_is_remember';
  static const _userTokenKey = 'user_token';
  static const _userRoleKey = 'user_role';
  static const _faceEmbeddings = 'face_embeddings';

  // Save data
  Future<void> saveEmailUsername(String emailUsername) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_emailUsernameKey, emailUsername);
  }

  Future<void> savePassword(String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_passwordKey, password);
  }

  Future<void> saveRemember(bool isRemember) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_rememberKey, isRemember);
  }

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userTokenKey, token);
  }

  Future<void> saveRole(String role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userRoleKey, role);
  }

  // Future<void> saveEmbeddings(List<double> embeddings) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String embeddingJson = jsonEncode(embeddings);
  //   await prefs.setString(_faceEmbeddings, embeddingJson);
  // }

  // Get data
  Future<String?> getEmailUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailUsernameKey);
  }

  Future<String?> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_passwordKey);
  }

  Future<bool?> getRemember() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_rememberKey);
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userTokenKey);
  }

  Future<String?> getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userRoleKey);
  }

  // Future<List<double>> getEmbeddings() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String? embeddingJson = pref.getString(_faceEmbeddings);
  //   if (embeddingJson != null) {
  //     return jsonDecode(embeddingJson);
  //   } else {
  //     return [];
  //   }
  // }

  // Delete data
  Future<void> deleteEmailUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_emailUsernameKey);
  }

  Future<void> deletePassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_passwordKey);
  }

  Future<void> deleteRemember() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_rememberKey);
  }

  Future<void> deleteToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userTokenKey);
  }

  Future<void> deleteRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userRoleKey);
  }

  // RememberMe
  Future<void> setRememberMe(
    bool rememberValue,
    String emailUsername,
    String password,
  ) async {
    saveRemember(rememberValue);

    if (rememberValue) {
      await saveEmailUsername(emailUsername);
      await savePassword(password);
    } else {
      await deleteEmailUsername();
      await deletePassword();
    }
  }

  // GetUserCredential
  Future<Map<String, String>> getUserCredential() async {
    String emailUsername = getEmailUsername().toString();
    String password = getPassword().toString();
    return {'emailUsername': emailUsername, 'password': password};
  }

  //LogOut
  Future<void> logOut() async {
    await deleteEmailUsername();
    await deletePassword();
    await deleteRemember();
    await deleteToken();
    await deleteRole();
  }
}
