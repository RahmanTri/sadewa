import 'dart:convert';
import 'package:get/get.dart';
import 'package:sadewa_fe/controllers/user_controller.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sadewa_fe/constants/sdw_sizes.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
// import 'package:sadewa_fe/constants/urls.dart';
import 'package:sadewa_fe/services/api_service.dart';
import 'package:sadewa_fe/services/storage_service.dart';

class HomeController extends GetxController {
  final userData = Get.find<UserController>();
  final ApiService _apiService = ApiService();
  final StorageService _storageService = StorageService();

  var greetingText = ''.obs;
  var isLoading = false.obs;
  var absentText = ''.obs;
  var absenMessage = ''.obs;
  var absenIcons = Rxn<Widget>();
  var pointText = Rxn<Widget>();
  var latestLoginWidget = Rxn<Widget>();
  var pointMessage = ''.obs;
  var token = ''.obs;

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

  Future<void> _loadLatestLogin(double height, double width) async {
    final String authToken = token.value;
    List<Map<String, dynamic>> latestLoginData = [];

    String getOnlyDay(DateTime date) {
      switch (date.weekday) {
        case DateTime.monday:
          return 'sen';
        case DateTime.tuesday:
          return 'sel';
        case DateTime.wednesday:
          return 'rab';
        case DateTime.thursday:
          return 'kam';
        case DateTime.friday:
          return 'jum';
        case DateTime.saturday:
          return 'sab';
        case DateTime.sunday:
          return 'min';
        default:
          return '';
      }
    }

    try {
      final result = await _apiService.getRequest<Map<String, dynamic>>(
        endpoint: 'get-latest',
        parser: (body) => jsonDecode(body),
        onError: (resp) => 'Gagal memuat riwayat: ${resp.statusCode}',
        headers: {'Authorization': 'Bearer $authToken'},
      );
      final List<dynamic> jsonData = result['latest_login'];
      final List<Map<String, dynamic>> data = jsonData.map((item) {
        final date = DateTime.parse(item['hari']);
        final dayAbbr = getOnlyDay(date);

        return {'hari': dayAbbr, 'status': item['status']};
      }).toList();
      print("Berhasil mendapatkan Data Latest Login");
      latestLoginData = data;

      latestLoginWidget.value = ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: latestLoginData.length,
        itemBuilder: (context, index) {
          final item = latestLoginData[index];
          final status = item['status'];
          final hari = item['hari'];

          switch (status) {
            case 'on_time':
              final bgColor = SDWcolors.success;
              final iconData = Icons.check_circle_outline;
            case 'late':
              final bgColor = SDWcolors.warning;
              final iconData = Icons.warning_amber_outlined;
            case 'absent':
              final bgColor = SDWcolors.error;
              final iconData = Icons.cancel_outlined;
          }

          return Row(
            children: [
              Expanded(
                child: Container(
                  height: height * 0.4,
                  width: width * 0.9,
                  decoration: BoxDecoration(color: bgColor),
                ),
              ),
            ],
          );
        },
      );
      print(latestLoginData);
    } catch (e) {
      print('Gagal Mendapatkan Latest Logi : $e');
    }
  }
}
