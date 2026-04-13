class AppUrls {
  AppUrls._();

  // Base URL
  static const String baseApiUrl = "https://localhost:8000/api/";

  // Auth URL
  static const String loginByE = "$baseApiUrl/email-login";
  static const String loginByU = "$baseApiUrl/username-login";
  static const String register = "$baseApiUrl/register";
}
