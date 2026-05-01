// import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:sadewa_fe/routes/app_routes.dart';
import 'package:sadewa_fe/pages/Auth/login_page.dart';
import 'package:sadewa_fe/binding/app_binding.dart';
import 'package:sadewa_fe/pages/splash_page.dart';
import 'package:sadewa_fe/pages/Riwayat/riwayat_page.dart';
import 'package:sadewa_fe/pages/Home/home_page.dart';
import 'package:sadewa_fe/pages/Profile/profile_page.dart';
import 'package:sadewa_fe/pages/Profile/edit_profile.dart';
// import 'package:sadewa_fe/pages/Notice/notice_page.dart';

class AppPages {
  // static const initial = Routes.splash;
  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => SplashPage(),
      binding: AppBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => LoginPage(),
    ),
    GetPage(
      name: Routes.profile,
      page: () => ProfilePage(),
    ),
    GetPage(
      name: Routes.editProfile,
      page: () => EditProfile(),
    ),
    GetPage(
    name: Routes.riwayat,
    page: () => RiwayatPage(), 
    ),
    GetPage(
      name: Routes.home,
      page: () => HomePage(),
    ),

  ];
}
