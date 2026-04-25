class AppUrls {
  AppUrls._();

  // Base URL
  static const String usedUrl = emulator;

  static const String baseApiUrl = '${usedUrl}api';
  static const String imgProfileUrl = '${usedUrl}storage/profile_pics/';

  //Platform URL
  static const String emulator = "http://10.0.2.2:8000/";
  static const String local = "http://localhost:8000/";
  static const String physical = "http://127.0.0.1:8000/";
  static const String ngrok = "https://shaunda-unpolitic-maeve.ngrok-free.dev/";

  // ENDPOINTS
  static const String loginByE = "email-login";
  static const String loginByU = "username-login";
  static const String register = "register";
  static const String riwayat = "fetch-history";
}
