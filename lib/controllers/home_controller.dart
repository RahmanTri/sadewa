import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sadewa_fe/models/user_model.dart';
import 'package:sadewa_fe/services/api_service.dart';
import 'package:sadewa_fe/services/storage_service.dart';

class HomeController extends GetxController {
  final StorageService _storageService = StorageService();
  final ApiService _apiService = ApiService();
  var token = ''.obs;
  var userData = <User>[].obs;
  var isLoading = false.obs;
  var namaKaryawan = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    token.value = await _storageService.getToken() ?? '';
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    isLoading.value = true;
    final authToken = token.value;

    try {
      final result = await _apiService.getRequest<Map<String, dynamic>>(
        endpoint: 'get-user',
        parser: (body) => jsonDecode(body),
        onError: (resp) => 'Gagal memuat riwayat: ${resp.statusCode}',
        headers: {'Authorization': 'Bearer $authToken'},
      );

      final jsonData = result['data'];
      final data = jsonData.map((item) => User.fromJson(item)).toList();

      for (int i = 0; i < data.length; i++) {
        User addedUser = data[i];
        userData.add(addedUser);
      }
      
      namaKaryawan.value = userData[0].namaLengkap;
      isLoading.value = false;

      return;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString());
      return;
    }
  }
}
