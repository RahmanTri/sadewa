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

    histories.clear();

    try {
      final result = await _apiService.getRequest<Map<String, dynamic>>(
        endpoint: AppUrls.riwayat,
        parser: (body) => jsonDecode(body),
        onError: (resp) => 'Gagal memuat riwayat: ${resp.statusCode}',
        headers: {'Authorization': 'Bearer $authtoken'},
      );
      final jsonData = result['data'];
      final data = jsonData
          .map((item) => Riwayat.fromJson(item))
          .toList();
      for (int i = 0; i < data.length; i++) {
        Riwayat addedRiwayat = data[i];
        addedRiwayat.translateStatuses();
        histories.add(addedRiwayat);
      }
      
      applyFilter(selectedFilter.value);

      // Test
      // print(histories);

      isLoading.value = false;
      return;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString());
      return;
    }
  }

  void applyFilter(String filter) {
    isLoading.value = true;
    selectedFilter.value = filter;
    if (filter == 'Semua') {
      filteredhistories.assignAll(histories);
      jumlahOnTime.value = filteredhistories
          .where((riwayat) => riwayat.statusMasuk == 'Tepat Waktu')
          .length;
      jumlahLate.value = filteredhistories
          .where((riwayat) => riwayat.statusMasuk == 'Terlambat')
          .length;
      jumlahAbsen.value = filteredhistories
          .where((riwayat) => riwayat.statusMasuk == 'Absen')
          .length;
      isLoading.value = false;
    } else {
      filteredhistories.assignAll(
        histories.where((riwayat) => riwayat.bulan == filter),
      );
      jumlahOnTime.value = filteredhistories
          .where((riwayat) => riwayat.statusMasuk == 'Tepat Waktu')
          .length;
      jumlahLate.value = filteredhistories
          .where((riwayat) => riwayat.statusMasuk == 'Terlambat')
          .length;
      jumlahAbsen.value = filteredhistories
          .where((riwayat) => riwayat.statusMasuk == 'Absen')
          .length;
      isLoading.value = false;
    }
  }

  void dummyHistory() {
    histories.clear();
    Riwayat histori1 = Riwayat(
      hari: 'Kamis',
      tanggal: '6',
      bulan: 'April',
      tahun: '2026',
      statusMasuk: 'Tepat Waktu',
      waktuMasuk: '09:01',
      statusKeluar: 'Tepat Waktu',
      waktuKeluar: '17:04',
    );
    Riwayat histori2 = Riwayat(
      hari: 'Jumat',
      tanggal: '7',
      bulan: 'April',
      tahun: '2026',
      statusMasuk: 'Tepat Waktu',
      waktuMasuk: '09:12',
      statusKeluar: 'Lebih Awal',
      waktuKeluar: '16:22',
    );
    Riwayat histori3 = Riwayat(
      hari: 'Sabtu',
      tanggal: '8',
      bulan: 'April',
      tahun: '2026',
      statusMasuk: 'Tepat Waktu',
      waktuMasuk: '09:11',
      statusKeluar: 'Tepat Waktu',
      waktuKeluar: '17:06',
    );
    Riwayat histori4 = Riwayat(
      hari: 'Senin',
      tanggal: '10',
      bulan: 'April',
      tahun: '2026',
      statusMasuk: 'Terlambat',
      waktuMasuk: '09:26',
      statusKeluar: 'Tepat Waktu',
      waktuKeluar: '17:11',
    );
    Riwayat histori5 = Riwayat(
      hari: 'Selasa',
      tanggal: '11',
      bulan: 'April',
      tahun: '2026',
      statusMasuk: 'Tepat Waktu',
      waktuMasuk: '09:07',
      statusKeluar: 'Tepat Waktu',
      waktuKeluar: '17:02',
    );
    Riwayat histori6 = Riwayat(
      hari: 'Rabu',
      tanggal: '12',
      bulan: 'April',
      tahun: '2026',
      statusMasuk: 'Tepat Waktu',
      waktuMasuk: '09:04',
      statusKeluar: 'Tepat Waktu',
      waktuKeluar: '17:28',
    );
    histories.add(histori1);
    histories.add(histori2);
    histories.add(histori3);
    histories.add(histori4);
    histories.add(histori5);
    histories.add(histori6);
    applyFilter(selectedFilter.value);
  }
}
