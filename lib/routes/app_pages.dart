// import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:sadewa_fe/routes/app_routes.dart';
import 'package:sadewa_fe/pages/Auth/login_page.dart';
import 'package:sadewa_fe/binding/app_binding.dart';

class AppPages {
<<<<<<< HEAD
  static const initial = Routes.splash;
  static const splash = Routes.splash;
=======
  // static const initial = Routes.splash;
  static const initial = Routes.login;
>>>>>>> 99a72ac1979de7b0fdfeda3773415e11d3788dca

  static final routes = [
    // GetPage(
    //   name: Routes.splash,
    //   page: () => SplashPage(),
    //   binding: AppBindings(),
    // ),
    GetPage(
      name: Routes.login,
      page: () => LoginPage(),
      binding: AppBinding(),
    )
  ];
}
