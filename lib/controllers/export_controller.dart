import 'package:get/get.dart';
import 'package:sadewa_fe/controllers/division_controller.dart';

class ExportController extends GetxController {
  final initialData = 'test'.obs;
  final divisionData = Get.find<DivisionController>();

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

  var isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    _loadDivisionFilter();
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
}
