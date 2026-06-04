class AppUrls {
  AppUrls._();

  // Base URL
  static const String usedUrl = physical2; 

  static const String baseApiUrl = '${usedUrl}api';
  static const String imgProfileUrl = '${usedUrl}storage/profile_pics/';

  //Platform URL
  static const String emulator = "http://10.0.2.2/";
  static const String local = "http://192.168.0.102:8000/";
  static const String physical = "http://192.168.0.30/";
  static const String physical2 = "http://192.168.0.31/";
  static const String ngrok = "https://shaunda-unpolitic-maeve.ngrok-free.dev/";

  //ImageAssets
  static const String imgAssets = "assets/images/";

  // ENDPOINTS
  static const String loginByE = "email-login";
  static const String loginByU = "username-login";
  static const String register = "register";
  static const String riwayat = "fetch-history";
}
