// import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:sadewa_fe/pages/Admin_Divisi/detail_divisi_page.dart';
import 'package:sadewa_fe/pages/Admin_Divisi/divisi_page.dart';
import 'package:sadewa_fe/pages/Admin_ManajerAkun/manajer_akun_page.dart';
import 'package:sadewa_fe/pages/Admin_ViewKaryawan/tambah_karyawan_page.dart';
import 'package:sadewa_fe/pages/Admin_ViewKaryawan/view_karyawan_page.dart';
import 'package:sadewa_fe/pages/Notice/read_notice_page.dart';
import 'package:sadewa_fe/pages/Poin/my_point_page.dart';
import 'package:sadewa_fe/routes/app_routes.dart';
import 'package:sadewa_fe/pages/Auth/login_page.dart';
import 'package:sadewa_fe/binding/app_binding.dart';
import 'package:sadewa_fe/pages/splash_page.dart';
import 'package:sadewa_fe/pages/Riwayat/riwayat_page.dart';
import 'package:sadewa_fe/pages/Home/home_page.dart';
import 'package:sadewa_fe/pages/Notice/notice_page.dart';
import 'package:sadewa_fe/pages/Absen/face_scan.dart';
import 'package:sadewa_fe/pages/Absen/scan_confirm.dart';
import 'package:sadewa_fe/pages/Admin_ViewKaryawan/karyawan_page.dart';
import 'package:sadewa_fe/pages/Profile/edit_profile.dart';
import 'package:sadewa_fe/pages/Admin_ViewKaryawan/edit_karyawan_page.dart';
import 'package:sadewa_fe/pages/leaderboard/leaderboard_page.dart';

class AppPages {
  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => SplashPage(),
      binding: AppBinding(),
    ),
    GetPage(name: Routes.login, page: () => LoginPage()),
    GetPage(name: Routes.riwayat, page: () => RiwayatPage()),
    GetPage(name: Routes.home, page: () => HomePage()),
    GetPage(name: Routes.notice, page: () => NoticePage()),
    GetPage(name: Routes.readNotice, page: () => ReadNoticePage()),
    GetPage(name: Routes.myPoint, page: () => MyPointPage()),
    GetPage(name: Routes.faceScan, page: () => RegistWajah()),
    GetPage(name: Routes.absenConfirm, page: () => AbsenConfirm()),
    GetPage(name: Routes.karyawan, page: () => KaryawanPage()),
    GetPage(name: Routes.editProfile, page: () => EditProfile()),
    GetPage(name: Routes.karyawanDetail, page: () => ViewKaryawanDetails(),),
    GetPage(name: Routes.editKaryawan, page: () => EditKaryawan(),),
    GetPage(name: Routes.akunManajer, page: () => ManajerAkun()),
    GetPage(name: Routes.leaderboard, page: () => LeaderboardPage()),
    GetPage(name: Routes.tambahKaryawan, page: () => AddKaryawanPage()),
    GetPage(name: Routes.divisi, page: () => DivisiPage()),
    GetPage(name: Routes.detailDivisi, page : () => DetailDivisiPage()),
  ];
}
