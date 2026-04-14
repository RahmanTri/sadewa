class AppUrls {
  AppUrls._();

  // Base URL
  static const String baseApiUrl = emulator;

  //Platform URL
  static const String emulator = "http://10.0.2.2:8000/api/";
  static const String local = "http://localhost:8000/api/";
  // static const String ngrok = "https://4f3f-200-0-0-1.ngrok-free.app/api/";

  // ENDPOINTS
  static const String loginByE = "email-login";
  static const String loginByU = "username-login";
  static const String register = "register";
}
