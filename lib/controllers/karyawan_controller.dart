import 'package:get/get.dart';
import 'package:sadewa_fe/controllers/user_controller.dart';
import 'package:sadewa_fe/models/karyawan_model.dart';
import 'package:sadewa_fe/services/api_service.dart';
import 'dart:convert';

class KaryawanController extends GetxController {
  final ApiService _apiService = ApiService();

  var filterOptions = ['Semua'].obs;
  var selectedFilter = 'Semua'.obs;

  var karyawan = <Karyawan>[].obs;
  var filteredKaryawan = <Karyawan>[].obs;

  var isLoading = false.obs;

  var debugFilter = ''.obs;

  void applyFilter(String filter) {
    isLoading.value = true;
    for (int i = 0; i < filterOptions.length; i++) {
      debugFilter.value = karyawan[i].namaDivisi;
      if (filter == filterOptions[i]) {
        if (filter == 'Semua') {
          filteredKaryawan.assignAll(karyawan);
        } else {
          filteredKaryawan.assignAll(
            karyawan.where(
              (karyawan) => karyawan.namaDivisi == filterOptions[i],
            ),
          );
          break;
        }
      }
    }
    isLoading.value = false;
  }

  void fetchKaryawan() async {
    karyawan.clear();
    filteredKaryawan.clear();

    isLoading.value = true;
    final endpoint = 'employee/get-data';
    final apiToken = Get.find<UserController>().userToken.value;
    try {
      final result = await _apiService.getRequest<Map<String, dynamic>>(
        endpoint: endpoint,
        parser: (body) => jsonDecode(body),
        onError: (resp) => 'Terjadi kesalahan: ${resp.statusCode}',
        headers: {'Authorization': 'Bearer $apiToken'},
      );
      final jsonData = result['data'];
      final karyawanFromBE = jsonData
          .map((item) => Karyawan.fromJson(item))
          .toList();

      for (int i = 0; i < karyawanFromBE.length; i++) {
        karyawan.add(karyawanFromBE[i]);
      }
      Get.snackbar('Sukses', 'Berhasil mengambil data');

      applyFilter(selectedFilter.value);
      isLoading.value = false;
    } catch (e) {
      Get.snackbar('Terjadi kesalahan', e.toString());
      isLoading.value = false;
    }
  }
}
