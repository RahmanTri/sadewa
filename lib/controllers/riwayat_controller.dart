import 'package:get/get.dart';
import 'dart:convert';
import 'package:sadewa_fe/constants/urls.dart';
import 'package:sadewa_fe/models/riwayat_model.dart';
import 'package:sadewa_fe/services/api_service.dart';
import 'package:sadewa_fe/services/storage_service.dart';

class RiwayatController extends GetxController {
  final StorageService _storageService = StorageService();
  final ApiService _apiService = ApiService();

  final filteroptions = [
    'Semua',
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

  var selectedFilter = 'Semua'.obs; // filteroptions

  var histories = <Riwayat>[].obs;
  var filteredhistories = <Riwayat>[].obs;

  var jumlahOnTime = 0.obs;
  var jumlahLate = 0.obs;
  var jumlahAbsen = 0.obs;

  var token = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    token.value = await _storageService.getToken() ?? '';
  }

  Future<void> fetchRiwayat() async {
    isLoading.value = true;
    final String authtoken = token.value;
    try {
      final result = await _apiService.getRequest<Map<String, dynamic>>(
        endpoint: AppUrls.riwayat,
        parser: (body) => jsonDecode(body),
        onError: (resp) => 'Gagal memuat riwayat: ${resp.statusCode}',
        headers: {'Authorization': 'Bearer $authtoken'},
      );
      final jsonData = result['data'];
      final List<Riwayat> data = jsonData.map((item) => Riwayat.fromJson(item)).toList();
      for (int i = 0; i < data.length; i++) {
        histories.add(data[i]);
      }

      //Test
      print(histories);

      isLoading.value = false;
      return;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString());
      return;
    }
  }

  void applyFilter(String filter) {
    selectedFilter.value = filter;
    if (filter == 'Semua') {
      filteredhistories.assignAll(histories);
    } else {
      filteredhistories.assignAll(
        histories.where((riwayat) => riwayat.bulan == filter),
      );
    }
  }
}
