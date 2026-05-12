import 'package:get/instance_manager.dart';
import 'package:sadewa_fe/controllers/akun_controller.dart';
import 'package:sadewa_fe/controllers/auth_controller.dart';
import 'package:sadewa_fe/controllers/karyawan_controller.dart';
import 'package:sadewa_fe/controllers/notice_controller.dart';
import 'package:sadewa_fe/services/api_service.dart';
import 'package:sadewa_fe/services/storage_service.dart';
import 'package:sadewa_fe/controllers/riwayat_controller.dart';
import 'package:sadewa_fe/controllers/user_controller.dart';
import 'package:sadewa_fe/controllers/division_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    //Get.put<blablabla>dst...
    Get.put<UserController>(UserController(), permanent: true);
    Get.put<KaryawanController>(KaryawanController(), permanent: true);
    Get.put<DivisionController>(DivisionController(), permanent: true);
    Get.put<StorageService>(StorageService(), permanent: true);
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<ApiService>(ApiService(), permanent: true);
    Get.put<RiwayatController>(RiwayatController(), permanent: true);
    Get.put<NoticeController>(NoticeController(), permanent: true);
    Get.put<AkunController>(AkunController(), permanent: true);
  }
}
