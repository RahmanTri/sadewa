import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sadewa_fe/models/leaderboard_model.dart';
import 'package:sadewa_fe/services/api_service.dart';
import 'package:sadewa_fe/controllers/user_controller.dart';
import 'package:sadewa_fe/services/storage_service.dart';

class LeaderboardController extends GetxController {
  final UserController _userController = Get.find<UserController>();
  final StorageService _storageService = StorageService();
  final ApiService _apiService = ApiService();

  var leaderboard = <Leaderboard>[].obs;
  var userLeaderboard = <Leaderboard>[].obs;

  var token = ''.obs;
  var isLoading = false.obs;
  var month = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    token.value = await _storageService.getToken() ?? '';
    await _loadMonth();
    await _fetchLeaderboard();
  }

  Future<void> _fetchLeaderboard() async {
    isLoading.value = true;
    final String authToken = token.value;

    leaderboard.clear();

    try {
      final result = await _apiService.getRequest<Map<String, dynamic>>(
        endpoint: 'employee/leaderboard',
        parser: (body) => jsonDecode(body),
        onError: (resp) => 'Gagal memuat riwayat: ${resp.statusCode}',
        headers: {'Authorization': 'Bearer $authToken'},
      );
      final jsonData = result['leaderboardData'];
      print("Berhasil mendapatkan data");
      final data = jsonData.map((item) => Leaderboard.fromJson(item)).toList();
      print("Berhasil koversi data dari json");
      for (int i = 0; i < data.length; i++) {
        Leaderboard addedLeaderboard = data[i];
        leaderboard.add(addedLeaderboard);
        isLoading.value = false;
      }
      print("Berhasil mendapatkan data leaderboard");
      userLeaderboard.assignAll(
        leaderboard.where(
          (lb) => lb.namaLengkap == _userController.user.value?.namaLengkap,
        ),
      );
      print("Berhasil assign data user leaderboard");
      return;
    } catch (e) {
      print("gagal fetch leaderboard: $e");
      isLoading.value = false;
      return;
    }
  }

  Future<void> _loadMonth() async {
    isLoading.value = true;
    await initializeDateFormatting('id_ID', null);
    final now = DateTime.now();
    month.value = DateFormat('MMMM', 'id_ID').format(now);
    isLoading.value = false;
  }
}
