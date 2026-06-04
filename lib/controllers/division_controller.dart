import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sadewa_fe/controllers/user_controller.dart';
import 'package:sadewa_fe/pages/Admin/Admin_Divisi/widgets/divisi_alert_dialog.dart';
import '../models/divisi_model.dart';
import '../services/api_service.dart';
import '../controllers/karyawan_controller.dart';

class DivisionController extends GetxController {
  final ApiService _apiService = ApiService();
  final UserController _userController = Get.find<UserController>();
  final KaryawanController _karyawanController = Get.find<KaryawanController>();

  final TextEditingController alamatKantor = TextEditingController();
  final TextEditingController namaDivisi = TextEditingController();
  final TextEditingController jamMasuk = TextEditingController();
  final TextEditingController jamKeluar = TextEditingController();

  GoogleMapController? mapController;
  var initialLat = -6.2012432312346.obs;
  var initialLng = 106.8123412345.obs;
  var editingLocation = false.obs;

  var currentLat = 0.0.obs;
  var currentLng = 0.0.obs;

  var divisions = <Divisi>[].obs;
  var availableDivisions = [].obs;

  var showedDivisions = Rxn<Divisi>();

  var selectedFilter = 'Semua'.obs;
  var filterOptions = ['Semua'].obs;
  var filteredDivisions = <Divisi>[].obs;

  var dialogMessage = ''.obs;

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
    } finally {
      applyFilter(selectedFilter.value);
    }
  }

  void setDivisonsAvailable() {
    for (int i = 0; i < divisions.length; i++) {
      availableDivisions.add(divisions[i].namaDivisi);
    }
  }

  void applyFilter(String filter) {
    isLoading.value = true;
    for (int i = 0; i < filterOptions.length; i++) {
      if (filter == filterOptions[i]) {
        if (filter == 'Semua') {
          filteredDivisions.assignAll(divisions);
        } else {
          filteredDivisions.assignAll(
            divisions.where(
              (divisions) => divisions.namaDivisi == filterOptions[i],
            ),
          );
          break;
        }
      }
    }
    isLoading.value = false;
  }

  void goToDetails(Divisi division) {
    showedDivisions.value = division;

    currentLat.value = division.latitude == 0.0
        ? initialLat
        : division.latitude;
    currentLng.value = division.longitude == 0.0
        ? initialLng.value
        : division.longitude;
  }

  void editLocation() {
    editingLocation.value = true;
    currentLat.value = showedDivisions.value?.latitude == 0.0
        ? initialLat
        : showedDivisions.value?.latitude ?? 0.0;
    currentLng.value = showedDivisions.value?.longitude == 0.0
        ? initialLng.value
        : showedDivisions.value?.longitude ?? 0.0;
  }

  void resetEditing() {
    editingLocation.value = false;
    currentLat.value = showedDivisions.value?.latitude == 0.0
        ? 0.0
        : showedDivisions.value!.latitude;
    currentLng.value = showedDivisions.value?.longitude == 0.0
        ? 0.0
        : showedDivisions.value!.longitude;
  }

  Future<bool> editDivision() async {
    isLoading.value = true;
    final endpoint = 'division/edit';
    final apiToken = _userController.userToken.value;
    Map<String, dynamic> data = {};

    data['id'] = showedDivisions.value?.id;

    if (alamatKantor.text.isNotEmpty &&
        alamatKantor.text != showedDivisions.value?.alamatKantor) {
      data['address'] = alamatKantor.text;
    }

    if (namaDivisi.text.isNotEmpty &&
        namaDivisi.text != showedDivisions.value?.namaDivisi) {
      data['division_name'] = namaDivisi.text;
    }

    if (currentLat.value != 0.0 &&
        currentLat.value != showedDivisions.value?.latitude) {
      data['latitude'] = currentLat.value;
    }

    if (currentLng.value != 0.0 &&
        currentLng.value != showedDivisions.value?.longitude) {
      data['longitude'] = currentLng.value;
    }

    if (jamMasuk.text.isNotEmpty &&
        jamMasuk.text != showedDivisions.value?.waktuMasuk) {
      data['checkin_time'] = jamMasuk.text;
    }

    if (jamKeluar.text.isNotEmpty &&
        jamKeluar.text != showedDivisions.value?.waktuKeluar) {
      data['checkout_time'] = jamKeluar.text;
    }

    try {
      await _apiService.postRequest<Map<String, dynamic>>(
        endpoint: endpoint,
        parser: (body) => jsonDecode(body),
        onError: (resp) => 'Terjadi kesalahan: ${resp.statusCode}',
        headers: {'Authorization': 'Bearer $apiToken'},
        data: data,
      );
      isLoading.value = false;
      return true;
    } catch (e) {
      isLoading.value = false;
      return false;
    }
  }

  void showDialog(bool success, String message, {String goTo = ''}) {
    Get.dialog(
      DivisiAlertDialog(
        isSuccess: success,
        message: message,
        onConfirm: hideDialog,
        height: Get.height,
        width: Get.width,
        goTo: goTo,
      ),
    );
  }

  void hideDialog() {
    dialogMessage.value = '';
  }

  Future<void> getDivision(int id) async {
    isLoading.value = true;
    final endpoint = 'division/get-id';
    final apiToken = _userController.userToken.value;

    try {
      final result = await _apiService.postRequest<Map<String, dynamic>>(
        endpoint: endpoint,
        parser: (body) => jsonDecode(body),
        onError: (resp) => 'Terjadi kesalahan: ${resp.statusCode}',
        headers: {'Authorization': 'Bearer $apiToken'},
        data: {'id': id},
      );

      final rawJson = result['data'];

      showDialog(false, rawJson.toString());

      Divisi newDivisi = Divisi.fromJson(rawJson);

      divisions.add(newDivisi);

      isLoading.value = false;
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
      isLoading.value = false;
    }
  }

  void refreshViewed() {
    isLoading.value = true;
    final divId = showedDivisions.value!.id;

    divisions.remove(divisions.firstWhere((element) => element.id == divId));
    getDivision(divId);

    divisions.sort((a, b) => a.namaDivisi.compareTo(b.namaDivisi));
    applyFilter(selectedFilter.value);

    showedDivisions.value = divisions.firstWhere((element) => element.id == divId);

    isLoading.value = false;
  }

  Future<void> saveLocation() async {
    isLoading.value = true;
    try {
      final success = await editDivision();
      if (success) {
        showDialog(true, 'Lokasi berhasil disimpan');
      } else {
        showDialog(false, 'Lokasi gagal disimpan');
      }
    } catch (e) {
      Get.snackbar('Terjadi kesalahan', e.toString());
    } finally {
      isLoading.value = false;
      refreshViewed();
      resetEditing();
    }

    //Bugs Found UNFINISHED
  }
}
