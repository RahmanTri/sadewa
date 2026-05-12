import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/controllers/user_controller.dart';
import 'package:sadewa_fe/models/karyawan_model.dart';
import 'package:sadewa_fe/services/api_service.dart';
import 'package:sadewa_fe/controllers/division_controller.dart';
import 'dart:convert';

class KaryawanController extends GetxController {
  final ApiService _apiService = ApiService();

  final TextEditingController namaLengkap = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController noTlp = TextEditingController();

  var filterOptions = ['Semua'].obs;
  var selectedFilter = 'Semua'.obs;

  var selectedDivisionId = 0.obs;
  var selectedDivisionName = ''.obs;
  var availableDivisionNames = <String>[].obs;

  var karyawan = <Karyawan>[].obs;
  var filteredKaryawan = <Karyawan>[].obs;
  var karyawanView = Rxn<Karyawan>();

  var isLoading = false.obs;
  var processing = false.obs;

  void applyFilter(String filter) {
    isLoading.value = true;
    for (int i = 0; i < filterOptions.length; i++) {
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

  void assignView(Karyawan karyawan) {
    karyawanView.value = karyawan;
  }

  void clearView() {
    karyawanView.value = null;
  }

  Future<void> fetchKaryawan() async {
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
      Get.snackbar('Sukses', 'Berhasil mengambil Karyawan');

      applyFilter(selectedFilter.value);
      isLoading.value = false;
    } catch (e) {
      Get.snackbar('Terjadi kesalahan', e.toString());
      isLoading.value = false;
    }
  }

  Future<void> resetEmployeePW() async {
    processing.value = true;
    final endpoint = 'employee/reset-pw';
    final apiToken = Get.find<UserController>().userToken.value;
    final data = {'id': karyawanView.value!.idUser};
    try {
      await _apiService.postRequest<Map<String, dynamic>>(
        endpoint: endpoint,
        parser: (body) => jsonDecode(body),
        onError: (resp) => 'Terjadi kesalahan: ${resp.statusCode}',
        headers: {'Authorization': 'Bearer $apiToken'},
        data: data,
      );
      processing.value = false;
    } catch (e) {
      Get.snackbar('Terjadi kesalahan', e.toString());
      processing.value = false;
    } finally {
      Get.snackbar('Berhasil', 'Password berhasil direset');
    }
  }

  Future<void> resetEmployeeFD() async {
    processing.value = true;
    final endpoint = 'employee/reset-faces';
    final apiToken = Get.find<UserController>().userToken.value;
    final data = {'id': karyawanView.value!.idKaryawan};
    try {
      await _apiService.postRequest<Map<String, dynamic>>(
        endpoint: endpoint,
        parser: (body) => jsonDecode(body),
        onError: (resp) => 'Terjadi kesalahan: ${resp.statusCode}',
        headers: {'Authorization': 'Bearer $apiToken'},
        data: data,
      );
      processing.value = false;
    } catch (e) {
      Get.snackbar('Terjadi kesalahan', e.toString());
      processing.value = false;
    } finally {
      Get.snackbar('Berhasil', 'Data wajah berhasil direset');
      refreshView();
    }
  }

  Future<void> refreshData() async {
    await fetchKaryawan();
  }

  Future<void> refreshView() async {
    final viewedId = karyawanView.value!.idUser;

    await fetchKaryawan();

    final updated = karyawan.firstWhere(
      (karyawan) => karyawan.idUser == viewedId,
    );

    assignView(updated);
    karyawanView.refresh();
  }

  void goToedit() {

    availableDivisionNames.clear();

    final availDivisions = Get.find<DivisionController>().availableDivisions
        .toList();

    selectedDivisionName.value = karyawanView.value!.namaDivisi;

    for (int i = 0; i < availDivisions.length; i++) {
      availableDivisionNames.add(availDivisions[i]);
    }
    namaLengkap.text = karyawanView.value!.namaLengkap;
    email.text = karyawanView.value!.email;
    noTlp.text = karyawanView.value!.noTlp;
  }

  Future<void> editEmployee() async {
    processing.value = true;
    final endpoint = 'employee/edit';
    final apiToken = Get.find<UserController>().userToken.value;
    Map<String, dynamic> defaultData = {'id': karyawanView.value!.idKaryawan};

    final data = defaultData;

    if (namaLengkap.text.isNotEmpty &&
        namaLengkap.text != karyawanView.value!.namaLengkap) {
      data.addAll({'name': namaLengkap.text});
    }
    if (email.text.isNotEmpty && email.text != karyawanView.value!.email) {
      data.addAll({'email': email.text});
    }
    if (noTlp.text.isNotEmpty) {
      data.addAll({'phone_number': noTlp.text});
    }
    if (selectedDivisionId.value != karyawanView.value!.idDivisi) {
      data.addAll({'division_id': selectedDivisionId.value});
    }

    try {
      await _apiService.postRequest<Map<String, dynamic>>(
        endpoint: endpoint,
        parser: (body) => jsonDecode(body),
        onError: (resp) => 'Terjadi kesalahan: ${resp.statusCode}',
        headers: {'Authorization': 'Bearer $apiToken'},
        data: data,
      );
      processing.value = false;
    } catch (e) {
      Get.snackbar('Terjadi kesalahan', e.toString());
      processing.value = false;
    } finally {
      Get.snackbar('Berhasil', 'Data karyawan berhasil diubah');
      refreshView();
      processing.value = false;
    }
  }

  void assignDivisionSelected(String divisionName) {
    final availDivisions = Get.find<DivisionController>().divisions.toList();

    for (int i = 0; i < availDivisions.length; i++) {
      if (availDivisions[i].namaDivisi == divisionName) {
        selectedDivisionId.value = availDivisions[i].id;
      }
    }
  }
}
