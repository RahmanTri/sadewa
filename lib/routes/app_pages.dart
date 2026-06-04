// import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:sadewa_fe/pages/Admin/Admin_Divisi/add_divisi_page.dart';
import 'package:sadewa_fe/pages/Admin/Admin_Divisi/detail_divisi_page.dart';
import 'package:sadewa_fe/pages/Admin/Admin_Divisi/divisi_page.dart';
import 'package:sadewa_fe/pages/Admin/Admin_ManajerAkun/manajer_akun_page.dart';
import 'package:sadewa_fe/pages/Admin/Admin_ViewKaryawan/tambah_karyawan_page.dart';
import 'package:sadewa_fe/pages/Admin/Admin_ViewKaryawan/view_karyawan_page.dart';
import 'package:sadewa_fe/pages/User/Notice/read_notice_page.dart';
import 'package:sadewa_fe/pages/User/Poin/my_point_page.dart';
import 'package:sadewa_fe/pages/User/Profile/forgot_password.dart';
import 'package:sadewa_fe/pages/User/Profile/help_center.dart';
import 'package:sadewa_fe/pages/User/Profile/reset_password.dart';
import 'package:sadewa_fe/pages/User/Profile/verify_otp.dart';
import 'package:sadewa_fe/pages/User/Profile/change_password_page.dart';

import 'package:sadewa_fe/routes/app_routes.dart';
import 'package:sadewa_fe/pages/Auth/login_page.dart';
import 'package:sadewa_fe/binding/app_binding.dart';
import 'package:sadewa_fe/pages/Splash/splash_page.dart';
import 'package:sadewa_fe/pages/User/Riwayat/riwayat_page.dart';
import 'package:sadewa_fe/pages/User/Home/home_page.dart';
import 'package:sadewa_fe/pages/User/Notice/notice_page.dart';
import 'package:sadewa_fe/pages/User/Absen/face_scan.dart';
import 'package:sadewa_fe/pages/User/Absen/scan_confirm.dart';
import 'package:sadewa_fe/pages/User/Profile/profile_page.dart';
import 'package:sadewa_fe/pages/User/Profile/edit_profile.dart';
import 'package:sadewa_fe/pages/User/leaderboard/leaderboard_page.dart';
import 'package:sadewa_fe/pages//Admin/Admin_ViewKaryawan/edit_karyawan_page.dart';
import 'package:sadewa_fe/pages//Admin/Admin_ViewKaryawan/karyawan_page.dart';

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
    GetPage(name: Routes.profile, page: () => ProfilePage()),
    GetPage(name: Routes.editProfile, page: () => EditProfile()),
    GetPage(name: Routes.karyawanDetail, page: () => ViewKaryawanDetails()),
    GetPage(name: Routes.editKaryawan, page: () => EditKaryawan()),
    GetPage(name: Routes.akunManajer, page: () => ManajerAkun()),
    GetPage(name: Routes.leaderboard, page: () => LeaderboardPage()),
    GetPage(name: Routes.changePassword, page: () => ChangePassword()),
    GetPage(name: Routes.forgotPassword, page: () => ForgotPassword()),
    GetPage(name: Routes.resetPassword, page: () => ResetPassword()),
    GetPage(name: Routes.verifyOtp, page: () => VerifyOtp()),
    GetPage(name: Routes.tambahKaryawan, page: () => AddKaryawanPage()),
    GetPage(name: Routes.divisi, page: () => DivisiPage()),
    GetPage(name: Routes.detailDivisi, page : () => DetailDivisiPage()),
    GetPage(name: Routes.helpCenter, page: () => HelpCenter()),
    GetPage(name: Routes.addDivisi, page : () => AddDivisiPage()),
  ];
}
