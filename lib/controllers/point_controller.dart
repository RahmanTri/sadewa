import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/controllers/user_controller.dart';

class PointController extends GetxController {
  final _userController = Get.find<UserController>();

  var profilePic = ''.obs;
  var point = 0.obs;
  var performanceCredit = 'Sangat Buruk'.obs;
  var performanceColor = SDWcolors.essentialDR.obs;
  var performanceIcon = Icons.cancel_outlined.obs;
  var performanceMsg = 'Nothing To See Here :)'.obs;

  @override
  void onInit() {
    super.onInit();
    getPoint();
    getProfilePic();
    // point.value = 120;
    getUserPerformance();
    getPerformanceMsg();
  }


  void getPoint(){
    point.value = _userController.user.value?.poin ?? 0;
  }

  void getProfilePic(){
    profilePic.value = _userController.user.value?.fotoProfil ?? '';
  }

  void getUserPerformance(){
    switch(point.value){
      case >= 100:
        performanceCredit.value = 'Sempurna';
        performanceColor.value = SDWcolors.essentialGLD;
        performanceIcon.value = Icons.star_border_sharp;
        break;
      case > 75:
        performanceCredit.value = 'Sangat Baik';
        performanceColor.value = SDWcolors.success;
        performanceIcon.value = Icons.thumb_up_alt_outlined;
        break;
      case 75:
        performanceCredit.value = 'Baik';
        performanceColor.value = SDWcolors.lGrey;
        performanceIcon.value = Icons.check_circle_outlined;
        break;
      case > 50:
        performanceCredit.value = 'Kurang Baik';
        performanceColor.value = SDWcolors.warning;
        performanceIcon.value = Icons.warning_amber_rounded;
        break;
      case > 30:
        performanceCredit.value = 'Sangat Kurang';
        performanceColor.value = SDWcolors.red;
        performanceIcon.value = Icons.thumb_down_alt_outlined;
        break;
      default:
        performanceCredit.value = 'Sangat Buruk';
        performanceColor.value = SDWcolors.essentialDR;
        performanceIcon.value = Icons.cancel_outlined;
        break;
    }
  }

  void getPerformanceMsg() {
    switch(performanceCredit.value){
      case 'Sempurna' :
        performanceMsg.value = 'Perusahaan sangat menghargai Kejujuran dan Kedisiplinan karyawan. Semoga apa yang anda kerjakan selalu menjadi berkah bagi anda dan keluarga';

      case 'Sangat Baik' || 'Baik' :
        performanceMsg.value = 'Terus pertahankan kedisiplinan anda. Kedisiplinan dan Kejujuran saat berkerja membawa berkah bagi anda dan keluarga';

      case 'Kurang Baik' || 'Sangat Kurang' :
        performanceMsg.value = 'Lebih tingkatkan lagi Kedisiplinan anda. Kedisiplinan dan Kejujuran saat berkerja membawa berkah bagi anda dan keluarga';
      case 'Sangat Buruk' :
        performanceMsg.value = 'Anda harus jauh lebih Disiplin dalam bekerja. Kedisiplinan dan Kejujuran saat berkerja membawa berkah bagi anda dan keluarga';
      default:
        performanceMsg.value = 'Kedisiplinan dan kejujuran adalah cerminan dari insan yang baik';
    }
  }

  @override
  void onClose() {
    profilePic.close();
    point.close();
    performanceColor.close();
    super.onClose();
  }
}