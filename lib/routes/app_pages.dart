// import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:sadewa_fe/pages/Notice/read_notice_page.dart';
import 'package:sadewa_fe/pages/Poin/my_point_page.dart';
import 'package:sadewa_fe/routes/app_routes.dart';
import 'package:sadewa_fe/pages/Auth/login_page.dart';
import 'package:sadewa_fe/binding/app_binding.dart';
import 'package:sadewa_fe/pages/splash_page.dart';
import 'package:sadewa_fe/pages/Riwayat/riwayat_page.dart';
import 'package:sadewa_fe/pages/Home/home_page.dart';
import 'package:sadewa_fe/pages/Notice/notice_page.dart';

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
      name: Routes.riwayat,
      page: () => RiwayatPage(), 
    ),
    GetPage(
      name: Routes.home,
      page: () => HomePage(),
    ),
    GetPage(
      name: Routes.notice,
      page: () => NoticePage(),
    ),
    GetPage(
      name: Routes.readNotice,
      page: () => ReadNoticePage(),
    ),
    GetPage(
      name: Routes.myPoint,
      page: () => MyPointPage(), 
    ),
  ];
}
