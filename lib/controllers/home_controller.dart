import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sadewa_fe/controllers/karyawan_controller.dart';
import 'package:sadewa_fe/controllers/division_controller.dart';
import 'package:sadewa_fe/controllers/notice_controller.dart';
import 'package:sadewa_fe/controllers/user_controller.dart';
import 'package:sadewa_fe/models/user_refresh.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
// import 'package:sadewa_fe/constants/urls.dart';
import 'package:sadewa_fe/services/api_service.dart';
// import 'package:sadewa_fe/services/storage_service.dart';

import 'package:sadewa_fe/models/absenMasuk_model.dart';
import 'package:sadewa_fe/models/absenKeluar_model.dart';

class HomeController extends GetxController {
  final userData = Get.put(UserController());
  final karyawanController = Get.find<KaryawanController>();
  final divisiController = Get.find<DivisionController>();
  final ApiService _apiService = ApiService();
  final NoticeController _noticeController = Get.find<NoticeController>();
  // final dataRefresh = Rxn<UserRefresh>();

  var absenMasuk = <AbsenMasuk>[].obs;
  var absenKeluar = <AbsenKeluar>[].obs;

  var greetingText = ''.obs;
  var isLoading = false.obs;
  var absentText = ''.obs;
  var absenMessage = ''.obs;
  var absenIcons = Rxn<Widget>();
  var pointTextColor = SDWcolors.error.obs;
  var pointMessage = ''.obs;
  var token = ''.obs;

  var jumlahKaryawan = ''.obs;
  var jumlahDivisi = ''.obs;
  var underPoint = ''.obs;

  RxList<Map<String, dynamic>> latestLoginData = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> activityLog = <Map<String, dynamic>>[].obs;

  @override
  void onInit() async {
    super.onInit();
    try {
      token.value = userData.userToken.value;
      _loadGreeting();
      await _loadActivityLog();

      if (userData.user.value?.role == 'employee') {
        _noticeController.fetchNotices();
        await _loadLatestLogin();
        _loadAbsenText();
        _loadPointText();
      } else {
        await loadAdminDashboard();
        await _loadMasuk();
        await _loadKeluar();
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = true;
      print("Ada kegagalan memulai sistem $e");
    }
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

    try {
      print(
        "data refresh untuk point n absen : ${userData.user.value?.loggedIn}",
      );
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
      print("Berhasil set Absen Text");
    } catch (e) {
      print("Gagal set Absen Text: $e");
    }
  }

  Future<void> _loadPointText() async {
    final point = userData.user.value?.poin;

    if (point! <= 50) {
      pointTextColor.value = SDWcolors.error;
      pointMessage.value = 'RESIGN O MAREN!!';
    } else if (point < 75) {
      pointTextColor.value = SDWcolors.warning;

      pointMessage.value = 'Tingkatkan Pointmu Terus!';
    } else if (point == 75) {
      pointTextColor.value = SDWcolors.essentialL;
      pointMessage.value = 'Masih bisa ditingkatkan!';
    } else if (point < 90) {
      pointTextColor.value = SDWcolors.primary;
      pointMessage.value = 'Lebih semangat lagi!!!';
    } else {
      pointTextColor.value = SDWcolors.success;
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
      isLoading.value = true;
      final result = await _apiService.getRequest<Map<String, dynamic>>(
        endpoint: 'user/get-latest',
        parser: (body) => jsonDecode(body),
        onError: (resp) => 'Gagal memuat riwayat: ${resp.statusCode}',
        headers: {'Authorization': 'Bearer $authToken'},
      );
      final List<dynamic> jsonData = result['latest_login'];
      print("berhasil mendapat json latest login");
      print(jsonData);

      for (var apiItem in jsonData) {
        final dt = DateTime.parse(apiItem['hari']);
        final dayAbbr = dayMap[dt.weekday == 7 ? DateTime.sunday : dt.weekday]!;
        final status = apiItem['status'];

        final index = loginDay.indexWhere((e) => e['hari'] == dayAbbr);
        if (index != -1) {
          loginDay[index]['status'] = status;
        }
      }
      latestLoginData.value = loginDay;
      print("Berhasil mendapatkan Data Latest Login");
      print(latestLoginData);
      isLoading.value = false;
    } catch (e) {
      print('Gagal Mendapatkan Latest Login : $e');
      isLoading.value = false;
    }
  }

  Future<void> _loadActivityLog() async {
    isLoading.value = true;
    await initializeDateFormatting('id_ID', null);
    String authToken = token.value;
    try {
      final result = await _apiService.getRequest<Map<String, dynamic>>(
        endpoint: 'activity-log',
        parser: (body) => jsonDecode(body),
        onError: (resp) =>
            'Gagal memuat riwayat activity log: ${resp.statusCode}',
        headers: {'Authorization': 'Bearer $authToken'},
      );

      final List<dynamic> jsonData = result['data'];

      for (var apiItem in jsonData) {
        String rawDate = apiItem['created_at'];
        DateTime dateTime = DateTime.parse(rawDate).toLocal();

        String formattedDate = DateFormat(
          "EEE, dd MMM | HH:mm",
          "id_ID",
        ).format(dateTime);
        apiItem['created_at'] = formattedDate;
        activityLog.add(apiItem);
      }

      isLoading.value = false;
      print("Berhasil Mendapatkan Activity Log");
    } catch (e) {
      isLoading.value = false;
      print('Gagal Mendapatkan Activity Log: $e');
    }
  }

  Future<void> loadAdminDashboard() async {
    try {
      isLoading.value = true;
      final karyawanResult = await _apiService.getRequest<Map<String, dynamic>>(
        endpoint: 'employee/get-data',
        parser: (body) => jsonDecode(body),
        onError: (resp) => "${resp.statusCode}",
        headers: {'Authorization': 'Bearer ${token.value}'},
      );
      final List<dynamic> karyawanJson = karyawanResult['data'];
      final underPointResult = await _apiService
          .getRequest<Map<String, dynamic>>(
            endpoint: 'point/under-point',
            parser: (body) => jsonDecode(body),
            onError: (resp) => "${resp.statusCode}",
            headers: {'Authorization': 'Bearer ${token.value}'},
          );
      final List<dynamic> underPointJson = underPointResult['data'];

      final divisionResult = await _apiService.getRequest<Map<String, dynamic>>(
        endpoint: 'division/get-data',
        parser: (body) => jsonDecode(body),
        onError: (resp) => '${resp.statusCode}',
        headers: {'Authorization': 'Bearer ${token.value}'},
      );
      final List<dynamic> divisionJson = divisionResult['data'];

      underPoint.value = underPointJson.length.toString();
      jumlahKaryawan.value = karyawanJson.length.toString();
      jumlahDivisi.value = divisionJson.length.toString();
      isLoading.value = false;
      print('Berhasil mendapatkan data statistik untuk menu admin');
    } catch (e) {
      isLoading.value = false;
      print("Gagal mendapatkan data statistik : $e");
    }
  }

  Future<void> _loadMasuk() async {
    try {
      isLoading.value = true;
      await initializeDateFormatting("id_ID", null);
      final result = await _apiService.getRequest<Map<String, dynamic>>(
        endpoint: 'em-log-in',
        parser: (body) => jsonDecode(body),
        onError: (resp) => 'Gagal memuat riwayat masuk: ${resp.statusCode}',
        headers: {'Authorization': 'Bearer ${token.value}'},
      );
      final jsonData = result['data'];
      final data = jsonData.map((item) => AbsenMasuk.fromJson(item)).toList();
      for (int i = 0; i < data.length; i++) {
        AbsenMasuk addedAbsenMasuk = data[i];

        DateTime rawDate = addedAbsenMasuk.rawDate.toLocal();
        String formattedDate = DateFormat(
          "d MMM | HH:mm",
          "id_ID",
        ).format(rawDate);
        addedAbsenMasuk.stringDate = formattedDate;
        absenMasuk.add(addedAbsenMasuk);
        isLoading.value = false;
      }

      print("Berhasil mendapatkan data absen masuk");
    } catch (e) {
      isLoading.value = false;
      print('Gagal Mendapatkan data absen masuk: $e');
    }
  }

  Future<void> _loadKeluar() async {
    try {
      isLoading.value = true;
      await initializeDateFormatting("id_ID", null);
      final result = await _apiService.getRequest<Map<String, dynamic>>(
        endpoint: 'em-log-out',
        parser: (body) => jsonDecode(body),
        onError: (resp) => 'Gagal memuat riwayat keluar: ${resp.statusCode}',
        headers: {'Authorization': 'Bearer ${token.value}'},
      );
      final jsonData = result['data'];
      final data = jsonData.map((item) => AbsenKeluar.fromJson(item)).toList();
      for (int i = 0; i < data.length; i++) {
        AbsenKeluar addedAbsenKeluar = data[i];

        DateTime rawDate = DateTime.parse(
          addedAbsenKeluar.waktuKeluar,
        ).toLocal();
        String formattedDate = DateFormat(
          "d MMM | HH:mm",
          "id_ID",
        ).format(rawDate);
        addedAbsenKeluar.waktuKeluar = formattedDate;
        absenKeluar.add(addedAbsenKeluar);
        isLoading.value = false;
      }

      print("Berhasil mendapatkan data absen keluar");
    } catch (e) {
      isLoading.value = false;
      print('Gagal Mendapatkan data absen keluar: $e');
    }
  }

  // Future<void> refreshUserData() async {
  //   isLoading.value = true;
  //   try {
  //     final result = await _apiService.getRequest<Map<String, dynamic>>(
  //       endpoint: 'user/fetch',
  //       parser: (body) => jsonDecode(body),
  //       onError: (resp) => 'Gagal memuat riwayat: ${resp.statusCode}',
  //       headers: {'Authorization': 'Bearer ${token.value}'},
  //     );
  //     final List<dynamic> jsonData = result['refreshed_userData'];
  //     dataRefresh.value = UserRefresh.fromJson(jsonData[0]);
  //     print("hasil data refresh login :  ${dataRefresh.value}");
  //     print("Berhasil Refresh data user");
  //     isLoading.value = false;
  //   } catch (e) {
  //     print("Gagal Mendapatkan User Data: $e");
  //     isLoading.value = false;
  //   }
  // }
}
