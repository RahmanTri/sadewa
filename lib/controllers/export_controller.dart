import 'dart:convert';

import 'package:get/get.dart';
import 'package:sadewa_fe/controllers/division_controller.dart';
import 'package:sadewa_fe/controllers/home_controller.dart';
import 'package:sadewa_fe/models/absenMasuk_model.dart';
import 'package:sadewa_fe/services/api_service.dart';
import 'dart:io';
import 'package:sadewa_fe/pages/Effect/SDWOverlay.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sadewa_fe/controllers/user_controller.dart';
import 'package:sadewa_fe/constants/urls.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class ExportController extends GetxController {
  final initialData = 'test'.obs;
  final divisionData = Get.find<DivisionController>();
  final userData = Get.find<UserController>();
  final homeController = Get.put(HomeController());
  final ApiService _apiService = ApiService();

  final monthFilter = [
    'Periode',
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  final divisionFilter = ['Divisi'].obs;

  var divisionSelectedFilter = 'Divisi'.obs;
  var monthSelectedFIlter = 'Periode'.obs;

  var rawData = <AbsenMasuk>[].obs;
  var filteredData = <AbsenMasuk>[].obs;
  var filteredLate = ''.obs;
  var filteredAbsent = ''.obs;

  var downloadDirectory = ''.obs;

  var isLoading = false.obs;
  var isDownloading = false.obs;
  var token = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    token.value = userData.userToken.value;
    await _loadRawData();
    _loadDivisionFilter();
  }

  Future<void> _loadRawData() async {
    isLoading.value = true;
    try {
      rawData.assignAll(homeController.absenMasuk);
      filteredData.assignAll(rawData);
      filteredLate.value = filteredData
          .where((items) => items.status == "Telat")
          .length
          .toString();
      filteredAbsent.value = filteredData
          .where((items) => items.status == 'Tidak Hadir')
          .length
          .toString();
      print("Berhasil assign data dari home controller");
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print("Gagal assign data dari home controller");
    }
  }

  Future<void> _loadDivisionFilter() async {
    isLoading.value = true;
    final divisi = divisionData.availableDivisions;
    try {
      for (var item in divisi) {
        divisionFilter.add(item);
      }
      isLoading.value = false;
      print("Berhasil menambahkan divisi ke filter");
    } catch (e) {
      isLoading.value = false;
      print("Gagal menambahkan divisi ke list filter : $e");
    }
  }

  void applyFilter(String division, String month) {
    isLoading.value = true;
    int selectedMonth = 1;
    switch (month) {
      case "Januari":
        selectedMonth = 1;
      case "Februari":
        selectedMonth = 2;
      case "Maret":
        selectedMonth = 3;
      case "April":
        selectedMonth = 4;
      case "Mei":
        selectedMonth = 5;
      case "Juni":
        selectedMonth = 6;
      case "Juli":
        selectedMonth = 7;
      case "Agustus":
        selectedMonth = 8;
      case "September":
        selectedMonth = 9;
      case "Oktober":
        selectedMonth = 10;
      case "November":
        selectedMonth = 11;
      case "Desember":
        selectedMonth = 12;
    }
    try {
      if (division == 'Divisi' && month == 'Periode') {
        filteredData.clear();
        filteredData.assignAll(rawData);
        filteredLate.value = filteredData
            .where((items) => items.status == 'Telat')
            .length
            .toString();
        filteredAbsent.value = filteredData
            .where((items) => items.status == 'Tidak Hadir')
            .length
            .toString();
        isLoading.value = false;
      } else if (division != 'Divisi' && month == 'Periode') {
        filteredData.clear();
        filteredData.assignAll(
          rawData.where((items) => items.divisi == division),
        );
        filteredLate.value = filteredData
            .where((items) => items.status == 'Telat')
            .length
            .toString();
        filteredAbsent.value = filteredData
            .where((items) => items.status == 'Tidak Hadir')
            .length
            .toString();
        isLoading.value = false;
      } else if (month != 'Periode' && division == 'Divisi') {
        filteredData.clear();
        filteredData.assignAll(
          rawData.where((items) => items.rawDate.month == selectedMonth),
        );
        filteredLate.value = filteredData
            .where((items) => items.status == 'Telat')
            .length
            .toString();
        filteredAbsent.value = filteredData
            .where((items) => items.status == 'Tidak Hadir')
            .length
            .toString();
        isLoading.value = false;
      } else {
        filteredData.clear();
        filteredData.assignAll(
          rawData
              .where((items) => items.rawDate.month == selectedMonth)
              .where((items) => items.divisi == division),
        );
        filteredLate.value = filteredData
            .where((items) => items.status == 'Telat')
            .length
            .toString();
        filteredAbsent.value = filteredData
            .where((items) => items.status == 'Tidak Hadir')
            .length
            .toString();
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      print("Gagal apply filter : $e");
    }
  }

  Future<void> exportAll() async {
    isDownloading.value = true;
    final authToken = token.value;
    final baseUrl = AppUrls.baseApiUrl;
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/export/all'),
        headers: {'Authorization': 'Bearer $authToken'},
      );
      if (response.statusCode == 200) {
        if (await Permission.manageExternalStorage.request().isGranted) {
          final dir = Directory('/storage/emulated/0/SADEWA/Export/All');
          if (!await dir.exists()) {
            await dir.create(recursive: true);
          }
          final file = File('${dir.path}/Recap Semua Divisi.pdf');
          await file.writeAsBytes(response.bodyBytes);
          print("Berhasil exprort all");
          downloadDirectory.value = dir.path.toString();
          isDownloading.value = false;
        } else {
          print("Akses penyimpanan ditolak");
          isDownloading.value = false;
        }
      }
    } catch (e) {
      print("Gagal cetak semua kehadiran: $e");
    }
  }

  Future<void> customExport() async {
    isDownloading.value = true;
    final authToken = token.value;
    final baseUrl = AppUrls.baseApiUrl;
    final month = monthSelectedFIlter.value;
    final division = divisionSelectedFilter.value;
    
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/export/custom'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"month": month, "division": division}),
      );
      if (response.statusCode == 200) {
        if (await Permission.manageExternalStorage.request().isGranted) {
          final dir = Directory('/storage/emulated/0/SADEWA/Export/$division');
          if (!await dir.exists()) {
            await dir.create(recursive: true);
          }
          final file = File('${dir.path}/$division-$month.pdf');
          await file.writeAsBytes(response.bodyBytes);
          print("Berhasil exprort all");
          downloadDirectory.value = dir.path.toString();
          isDownloading.value = false;
        } else {
          print("Akses penyimpanan ditolak");
          isDownloading.value = false;
        }
      }
    } catch (e) {
      print("Gagal cetak semua kehadiran: $e");
    }
  }
}
