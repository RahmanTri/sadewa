import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:sadewa_fe/controllers/face_scan_controller.dart';
import 'package:sadewa_fe/services/api_service.dart';
import 'package:sadewa_fe/services/storage_service.dart';
import 'package:sadewa_fe/controllers/user_controller.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sadewa_fe/routes/app_routes.dart';
import 'package:sadewa_fe/controllers/home_controller.dart';

class AbsenConfirmController extends GetxController {
  final ApiService _apiService = ApiService();
  final StorageService _storageService = StorageService();
  final scanResult = Get.find<FaceScanController>();
  final userData = Get.find<UserController>();

  final bool _isLoading = false;
  final statusText = "".obs;
  final dateNow = "".obs;
  bool isRegist = false;
  bool isAbsen = false;
  final token = ''.obs;

  List<double>? _embeddingResult = [];
  List<double>? _userEmbeddings = [];

  @override
  void onInit() async {
    super.onInit();
    _loadDateNow();
    isAbsen = userData.user.value!.loggedIn;
    token.value = await _storageService.getToken() ?? '';
    isRegist = scanResult.isRegist;
    _embeddingResult = scanResult.embeddingResult;
  }

  Future<void> registFaceData() async {
    final embeddingsData = {'face_data': _embeddingResult};
    final authToken = token.value;

    try {
      final result = await _apiService.postRequest<Map<String, dynamic>>(
        endpoint: 'employee/regface',
        data: embeddingsData,
        parser: (body) => jsonDecode(body),
        onError: (resp) => 'Gagal memuat riwayat: ${resp.statusCode}',
        headers: {'Authorization': 'Bearer $authToken'},
      );

      Get.snackbar(
        "Registrasi Wajah Berhasil",
        "Registrasi data wajah berhasil",
      );
      Get.offAllNamed("login");
    } catch (e) {
      print(e);
    }
  }

  Future<void> absenLogin() async {
    final authToken = token.value;
    final now = DateTime.now();
    final formattedTime = DateFormat('HH:mm:ss').format(now);
    try {
      final result = await _apiService.postRequest<Map<String, dynamic>>(
        endpoint: 'em-log/chkin',
        data: {'time': formattedTime},
        parser: (body) => jsonDecode(body),
        onError: (resp) => 'Gagal memuat riwayat: ${resp.statusCode}',
        headers: {'Authorization': 'Bearer $authToken'},
      );
      userData.refreshUserData();
      Get.snackbar(
        "Berhasil Check-In",
        "Anda berhasil check-in untuk hari ini",
      );
      Get.offAllNamed(Routes.home);
    } catch (e) {
      Get.snackbar("Gagal Check-In", "$e");
    }
  }

  Future<void> absenLogout() async {
    final authToken = token.value;
    final now = DateTime.now();
    final formattedTime = DateFormat('HH:mm:ss').format(now);

    try {
      final result = await _apiService.postRequest<Map<String, dynamic>>(
        endpoint: 'em-log/chkout',
        data: {'time': formattedTime},
        parser: (body) => jsonDecode(body),
        onError: (resp) => 'Gagal checkout: ${resp.statusCode}',
        headers: {'Authorization': 'Bearer $authToken'},
      );
      Get.snackbar(
        "Berhasil Check-Out",
        "Anda berhasil check-out untuk hari ini",
      );
      userData.refreshUserData();
      print("berhasil chekout");
      Get.offAllNamed(Routes.home);
    } catch (e) {
      print("gagal checkout: $e");
      Get.snackbar("Gagal Check-Out", "$e");
    }
  }

  Future<void> _loadDateNow() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initializeDateFormatting('id_ID', null);
    DateTime now = DateTime.now();
    final hari = DateFormat.EEEE('id_ID').format(now);
    final tanggal = DateFormat('dd MMMM yyyy', 'id_ID').format(now);
    final jam = DateFormat('HH:mm').format(now);
    dateNow.value = '$hari, $tanggal | $jam';
  }

  void loginChecker() {
    if (isRegist) {
      registFaceData();
    } else if (userData.user.value!.loggedIn == false) {
      absenLogin();
    } else {
      absenLogout();
    }
  }
}
