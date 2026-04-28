import 'dart:convert';
import 'package:get/get.dart';
import 'package:sadewa_fe/controllers/user_controller.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sadewa_fe/constants/sdw_sizes.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
// import 'package:sadewa_fe/constants/urls.dart';
import 'package:sadewa_fe/services/api_service.dart';
// import 'package:sadewa_fe/services/storage_service.dart';
import 'package:sadewa_fe/pages/Effect/SDWOverlay.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeController extends GetxController {
  final userData = Get.find<UserController>();
  final ApiService _apiService = ApiService();
  // final StorageService _storageService = StorageService();

  var greetingText = ''.obs;
  var isLoading = false.obs;
  var absentText = ''.obs;
  var absenMessage = ''.obs;
  var absenIcons = Rxn<Widget>();
  var pointText = Rxn<Widget>();
  var pointMessage = ''.obs;
  var token = ''.obs;
  RxList<Map<String, dynamic>> latestLoginData = <Map<String, dynamic>>[].obs;
  // List<Map<String, dynamic>> latestLoginData = [].obs;

  @override
  void onInit() async {
    super.onInit();
    token.value = userData.userToken.value;
    _loadGreeting();
    _loadAbsenText();
    _loadPointText();
    _loadLatestLogin();
  }

  Future<void> _loadGreeting() async {
    final now = DateTime.now();

    if (now.hour < 12) {
      greetingText.value = 'Selamat Pagi';
    } else if (now.hour < 15) {
      greetingText.value = 'Selamat Siang';
    } else if (now.hour < 19) {
      greetingText.value = 'Selamat Sore';
    } else {
      greetingText.value = 'Selamat Malam';
    }
  }

  Future<void> _loadAbsenText() async {
    final List<String> messageData = [
      'Laksanakan tugas anda dengan sepenuh hati!',
      'Semangat untuk hari ini!',
      'Kerjalah dengan penuh semangat!',
    ];
    final randomIndex = Random().nextInt(messageData.length);

    void changeAbsentIcons(bool isValid) {
      absenIcons.value = isValid
          ? Icon(Icons.check_circle_outline, color: Colors.green, size: 60)
          : Icon(Icons.cancel_outlined, color: Colors.red, size: 60);
    }

    if (userData.user.value?.loggedIn == true) {
      absentText.value = 'Anda Sudah Absen Hari Ini!';
      absenMessage.value = messageData[randomIndex];
      changeAbsentIcons(true);
    } else {
      absentText.value = 'Anda Belum Absen Hari Ini!';
      absenMessage.value =
          'Anda belum melakukan absen! segera lakukan absensi!';
      changeAbsentIcons(false);
    }
  }

  Future<void> _loadPointText() async {
    final point = userData.user.value?.poin;

    if (point! <= 50) {
      pointText.value = Text(
        point.toString(),
        style: TextStyle(
          fontSize: SDWsizes.lg * 2,
          fontWeight: FontWeight.w800,
          color: SDWcolors.error,
        ),
        textAlign: TextAlign.center,
      );
      pointMessage.value = 'RESIGN O MAREN!!';
    } else if (point < 75) {
      pointText.value = Text(
        point.toString(),
        style: TextStyle(
          fontSize: SDWsizes.lg * 2,
          fontWeight: FontWeight.w800,
          color: SDWcolors.warning,
        ),
        textAlign: TextAlign.center,
      );
      pointMessage.value = 'Tingkatkan Pointmu Terus!';
    } else if (point == 75) {
      pointText.value = Text(
        point.toString(),
        style: TextStyle(
          fontSize: SDWsizes.lg * 2,
          fontWeight: FontWeight.w800,
          color: SDWcolors.essentialL,
        ),
        textAlign: TextAlign.center,
      );
    } else if (point < 90) {
      pointText.value = Text(
        point.toString(),
        style: TextStyle(
          fontSize: SDWsizes.lg * 2,
          fontWeight: FontWeight.w800,
          color: SDWcolors.primary,
        ),
        textAlign: TextAlign.center,
      );
      pointMessage.value = 'Lebih semangat lagi!!!';
    } else {
      pointText.value = Text(
        point.toString(),
        style: TextStyle(
          fontSize: SDWsizes.lg * 2,
          fontWeight: FontWeight.w800,
          color: SDWcolors.success,
        ),
        textAlign: TextAlign.center,
      );
      pointMessage.value = 'Point anda sangat baik! PERTAHANKAN!';
    }
  }

  Future<void> _loadLatestLogin() async {
    final String authToken = token.value;

    const dayMap = {
      DateTime.sunday: 'min',
      DateTime.monday: 'sen',
      DateTime.tuesday: 'sel',
      DateTime.wednesday: 'rab',
      DateTime.thursday: 'kam',
      DateTime.friday: 'jum',
      DateTime.saturday: 'sab',
    };

    List<Map<String, dynamic>> loginDay = [
      {'hari': 'min', 'status': 'day_off'},
      {'hari': 'sen', 'status': 'unabsent'},
      {'hari': 'sel', 'status': 'unabsent'},
      {'hari': 'rab', 'status': 'unabsent'},
      {'hari': 'kam', 'status': 'unabsent'},
      {'hari': 'jum', 'status': 'unabsent'},
      {'hari': 'sab', 'status': 'unabsent'},
    ];

    try {
      final result = await _apiService.getRequest<Map<String, dynamic>>(
        endpoint: 'get-latest',
        parser: (body) => jsonDecode(body),
        onError: (resp) => 'Gagal memuat riwayat: ${resp.statusCode}',
        headers: {'Authorization': 'Bearer $authToken'},
      );
      final List<dynamic> jsonData = result['latest_login'];

      for (var apiItem in jsonData) {
        final dt = DateTime.parse(apiItem['hari']);
        final dayAbbr = dayMap[dt.weekday == 7 ? DateTime.sunday : dt.weekday]!;
        final status = apiItem['status'];

        final index = loginDay.indexWhere((e) => e['hari'] == dayAbbr);
        if (index != -1) {
          loginDay[index]['status'] = status;
        }
      }
      print("Berhasil mendapatkan Data Latest Login");
      latestLoginData.value = loginDay;
      print(latestLoginData);
    } catch (e) {
      print('Gagal Mendapatkan Latest Logi : $e');
    }
  }
}
