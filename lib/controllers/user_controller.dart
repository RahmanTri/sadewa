import 'dart:convert';

import 'package:flutter/material.dart';
import 'auth_controller.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/services/api_service.dart';
import 'package:sadewa_fe/services/storage_service.dart';
import 'package:sadewa_fe/models/user_model.dart';
import 'package:sadewa_fe/models/absen_terkini.dart';

class UserController extends GetxController {
  final ApiService _apiService = ApiService();
  final StorageService _storageService = StorageService();
  final userData = <User>[].obs;

  final recentAbsent = <AbsenTerkini>[].obs;
  final token = ''.obs;
  final isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    token.value = await _storageService.getToken() ?? '';
  }

  Future<void> fetchUser() async {
    isLoading.value = true;
    final String authtoken = token.value;

    try {
      final result = await _apiService.getRequest<Map<String, dynamic>>(
        endpoint: 'get-user',
        parser: (body) => jsonDecode(body),
        onError: (resp) => "Gagal memuat user: ${resp.statusCode}",
        headers: {'Authorization': 'Bearer $authtoken'},
      );
      final jsonData = result['data'];
      final List<User> data = jsonData
          .map((item) => User.fromJson(item))
          .toList();
      for (int i = 0; i < data.length; i++) {
        userData.add(data[i]);
      }

      isLoading.value = false;
      return;
      
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString());
      return;
    }
  }
}
