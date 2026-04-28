import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/controllers/user_controller.dart';
import 'package:sadewa_fe/services/api_service.dart';
import '../models/riawayat_poin.dart';

class PointController extends GetxController {
  final _userController = Get.find<UserController>();
  final _apiService = ApiService();

  var profilePic = ''.obs;
  var point = 0.obs;
  var performanceCredit = 'Sangat Buruk'.obs;
  var performanceColor = SDWcolors.essentialDR.obs;
  var performanceIcon = Icons.cancel_outlined.obs;
  var performanceMsg = 'Nothing To See Here :)'.obs;

  var historyPoint = <RiwayatPoin>[].obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getPoint();
    getProfilePic();
    // point.value = 120;
    getUserPerformance();
    getPerformanceMsg();
    getPointHistoryLog();
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

  void getPointHistoryLog() async {
    isLoading.value = true;

    historyPoint.clear();

    String endpoint = 'point/get-history';

    try {
    final result = await _apiService.getRequest<Map<String, dynamic>>(
      endpoint: endpoint,
      parser: (body) => jsonDecode(body),
      onError: (resp) => 'Gagal Memuat Data: ${resp.statusCode}',
      headers: {
        'Authorization': 'Bearer ${_userController.userToken.value}'
      },
    );

    final jsonData = result['data'];
    final data = jsonData
        .map((item) => RiwayatPoin.fromJson(item))
        .toList();
    for (int i = 0; i < data.length; i++) {
      RiwayatPoin addedRiwayat = data[i];
      addedRiwayat.setStatusKehadiran();
      addedRiwayat.translateStatus();
      Get.snackbar('Menambahkan', addedRiwayat.hari.toString());
      historyPoint.add(addedRiwayat);
    }
    isLoading.value = false;


    } catch (e) {
      isLoading.value = false;
      throw Exception(e);
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