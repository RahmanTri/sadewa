import 'dart:convert';
import 'package:get/get.dart';
import 'package:sadewa_fe/controllers/user_controller.dart';
import '../models/divisi_model.dart';
import '../services/api_service.dart';
import '../controllers/karyawan_controller.dart';

class DivisionController extends GetxController {
  final ApiService _apiService = ApiService();
  final UserController _userController = Get.find<UserController>();
  final KaryawanController _karyawanController = Get.find<KaryawanController>();


  var divisions = <Divisi>[].obs;
  var availableDivisions = [].obs;

  var isLoading = false.obs;

  void refreshIt() {
    fetchDivisions();
  }

  void fetchDivisions() async {
    isLoading.value = true;
    final endpoint = 'division/get-data';
    final apiToken = _userController.userToken.value;

    try {
      final result = await _apiService.getRequest(
        endpoint: endpoint,
        parser: (body) => jsonDecode(body),
        onError: (resp) => 'Terjadi kesalahan: ${resp.statusCode}',
        headers: {'Authorization': 'Bearer $apiToken'},
      );

      final jsonData = result['data'];
      final divisiFromBE = jsonData
          .map((item) => Divisi.fromJson(item))
          .toList();

      for (int i = 0; i < divisiFromBE.length; i++) {
        divisions.add(divisiFromBE[i]);
      }

      setDivisonsAvailable();

      for (int i = 0; i < availableDivisions.length; i++) {
        _karyawanController.filterOptions.add(availableDivisions[i]);
      }

      Get.snackbar('Berhasil', 'Data divisi berhasil dimuat');
      isLoading.value = false;
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
      isLoading.value = false;
    }
  }

  void setDivisonsAvailable() {
    for (int i = 0; i < divisions.length; i++) {
      availableDivisions.add(divisions[i].namaDivisi);
    }
  }
}
