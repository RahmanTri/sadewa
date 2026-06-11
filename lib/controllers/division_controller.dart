import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
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
  var alamatKantorError = ''.obs;

  final TextEditingController namaDivisi = TextEditingController();
  var namaDivisiError = ''.obs;

  GoogleMapController? mapController;
  var initialLat = -6.193479517229143.obs;
  var initialLng = 106.82442862540483.obs;
  var editingLocation = false.obs;

  var currentLat = 0.0.obs;
  var currentLng = 0.0.obs;

  var divisions = <Divisi>[].obs;
  var availableDivisions = [].obs;

  var showedDivisions = Rxn<Divisi>();

  var selectedFilter = 'Semua'.obs;
  var filterOptions = ['Semua', 'Kantor Utama', 'Kantor Cabang'].obs;
  var filteredDivisions = <Divisi>[].obs;

  List<String> jam = <String>[].obs;
  List<String> menit = <String>[].obs;
  var selectedHour = ''.obs;
  var selectedMinute = ''.obs;
  var editingCheckinTime = false.obs;
  DateTime jamMasuk = DateTime.now();
  DateTime jamKeluar = DateTime.now();

  var availableOffice = ['Kantor Utama', 'Kantor Cabang'].obs;
  var selectedOffice = ''.obs;
  var office = ''.obs;

  var availableTime = ['15', '30', '45', '60'].obs;
  var selectedAddTime = ''.obs;
  var selectedTime = ''.obs;
  var addTime = 0.obs;

  var availableRange = ['100', '200', '300', '400', '500'].obs;
  var selectedAddRange = ''.obs;
  var selectedRange = ''.obs;
  var addRange = 0.obs;

  final TextEditingController divisionNameAdd = TextEditingController();
  var divisionNameAddError = ''.obs;

  final TextEditingController divisionAddressAdd = TextEditingController();
  var divisionAddressAddError = ''.obs;

  var availableOfficeAdd = ['Kantor Utama', 'Kantor Cabang'].obs;
  var divisionOfficeSelectedAdd = ''.obs;
  var officeAdd = ''.obs;

  var jamAddAvailableH = <String>[].obs;
  var jamAddAvailableM = <String>[].obs;

  var selectedHourAdd = ''.obs;
  var selectedMinuteAdd = ''.obs;

  var selectJamMasuk = true.obs;

  var jamMasukSelectedH = ''.obs;
  var jamMasukSelectedM = ''.obs;

  var jamKeluarSelectedH = ''.obs;
  var jamKeluarSelectedM = ''.obs;

  var selectingLocation = false.obs;

  var addDivisionLat = 0.0.obs;
  var addDivisionLng = 0.0.obs;

  var showedDivisionsEms = 0.obs;

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

      if (result['success'] == true) {
        divisions.clear();
      }

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

      isLoading.value = false;
    } catch (e) {

      isLoading.value = false;
    } finally {
      applyFilter(selectedFilter.value);
    }
  }

  void setKaryawanFilter() {
    _karyawanController.filterOptions.clear();
    _karyawanController.filterOptions.add('Semua');
    for (int i = 0; i < availableDivisions.length; i++) {
      _karyawanController.filterOptions.add(availableDivisions[i]);
    }
  }

  void setDivisonsAvailable() {
    availableDivisions.clear();
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
              (divisions) => divisions.kantor == filterOptions[i],
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

    showedDivisionsEms.value = _karyawanController.countKaryawan(division.id);

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
    alamatKantorError.value = '';
    namaDivisiError.value = '';
    selectedHour.value = '';
    selectedMinute.value = '';
    editingCheckinTime.value = false;
    jamMasuk = DateTime.now();
    jamKeluar = DateTime.now();
    alamatKantor.text = '';
    namaDivisi.text = '';
    office.value = '';
    selectedOffice.value = '';
    selectedTime.value = '';
    selectedRange.value = '';
  }

  Future<bool> editDivision() async {
    isLoading.value = true;
    final endpoint = 'division/edit';
    final apiToken = _userController.userToken.value;
    Map<String, dynamic> data = {};

    data['id'] = showedDivisions.value?.id;

    if (office.value.isNotEmpty && office.value == 'head' ||
        office.value == 'branch') {
      data['office'] = office.value;
    }

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

    if (jamMasuk.year != DateTime.now().year) {
      if (jamMasuk.hour !=
              DateFormat(
                'HH:mm',
              ).parse(showedDivisions.value!.waktuMasuk).hour ||
          jamMasuk.minute !=
              DateFormat(
                'HH:mm',
              ).parse(showedDivisions.value!.waktuMasuk).minute) {
        data['checkin_time'] =
            '${jamMasuk.hour.toString().padLeft(2, '0')}:${jamMasuk.minute.toString().padLeft(2, '0')}';
      }
    }

    if (jamKeluar.year != DateTime.now().year) {
      if (jamKeluar.hour !=
              DateFormat(
                'HH:mm',
              ).parse(showedDivisions.value!.waktuKeluar).hour ||
          jamKeluar.minute !=
              DateFormat(
                'HH:mm',
              ).parse(showedDivisions.value!.waktuKeluar).minute) {
        data['checkout_time'] =
            '${jamKeluar.hour.toString().padLeft(2, '0')}:${jamKeluar.minute.toString().padLeft(2, '0')}';
      }
    }

    if (selectedTime.value !=
        showedDivisions.value?.toleransiWaktu.toString()) {
      final int? tolerance = int.tryParse(selectedTime.value);
      if (tolerance != null) {
        data['tolerance'] = int.parse(selectedTime.value);
      }
    }

    if (selectedRange.value !=
        showedDivisions.value?.toleransiArea.toString()) {
      final int? rTolerance = int.tryParse(selectedRange.value);
      if (rTolerance != null) {
        data['r_tolerance'] = int.parse(selectedRange.value);
      }
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
      showDialog(false, 'Eror: $e');
      return false;
    } finally {
      resetEditing();
    }
  }

  void showDialog(
    bool success,
    String message, {
    String goTo = '',
    VoidCallback? runFunction,
  }) {
    Get.dialog(
      DivisiAlertDialog(
        isSuccess: success,
        message: message,
        onConfirm: hideDialog,
        run: runFunction,
        height: Get.height,
        width: Get.width,
        goTo: goTo,
      ),
    );
  }

  void hideDialog() {
    dialogMessage.value = '';
  }

  Future<void> replaceDivision(int id) async {
    isLoading.value = true;
    final endpoint = 'division/get-id';
    final apiToken = _userController.userToken.value;
    final oldName = showedDivisions.value!.namaDivisi;

    try {
      final result = await _apiService.postRequest<Map<String, dynamic>>(
        endpoint: endpoint,
        parser: (body) => jsonDecode(body),
        onError: (resp) => 'Terjadi kesalahan: ${resp.statusCode}',
        headers: {'Authorization': 'Bearer $apiToken'},
        data: {'id': id},
      );

      final rawJson = result['data'];

      Divisi newDivisi = Divisi.fromJson(rawJson);
      divisions.remove(divisions.firstWhere((element) => element.id == id));
      divisions.add(newDivisi);

      if (newDivisi.namaDivisi != oldName) {
        setDivisonsAvailable();
        setKaryawanFilter();
        _karyawanController.reNewKaryawan(newDivisi.id);
      }
      applyFilter(selectedFilter.value);
      showedDivisions.value = newDivisi;

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  void refreshViewed() {
    isLoading.value = true;
    final divId = showedDivisions.value!.id;
    replaceDivision(divId);
    isLoading.value = false;
  }

  Future<void> saveLocation() async {
    isLoading.value = true;
    try {
      final success = await editDivision();
      if (success) {
        showDialog(true, 'Lokasi berhasil disimpan');
        isLoading.value = false;
        refreshViewed();
      } else {
        showDialog(false, 'Lokasi gagal disimpan');
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
    }
  }

  void editJamKeluar() {
    DateTime jamKeluar = DateFormat(
      'HH:mm',
    ).parse(showedDivisions.value!.waktuKeluar);
    editingCheckinTime.value = false;

    selectedHour.value = jamKeluar.hour.toString().padLeft(2, '0');
    selectedMinute.value = jamKeluar.minute.toString().padLeft(2, '0');
  }

  void editJamMasuk() {
    DateTime jamMasuk = DateFormat(
      'HH:mm',
    ).parse(showedDivisions.value!.waktuMasuk);
    editingCheckinTime.value = true;

    selectedHour.value = jamMasuk.hour.toString().padLeft(2, '0');
    selectedMinute.value = jamMasuk.minute.toString().padLeft(2, '0');
  }

  Future<void> saveTime() async {
    if (editingCheckinTime.value) {
      DateTime inputTime = DateFormat(
        'HH:mm',
      ).parse('$selectedHour:$selectedMinute');
      jamMasuk = inputTime;
      jamKeluar = DateTime.now();
    } else if (!editingCheckinTime.value) {
      DateTime inputTime = DateFormat(
        'HH:mm',
      ).parse('$selectedHour:$selectedMinute');
      jamKeluar = inputTime;
      jamMasuk = DateTime.now();
    } else {
      jamMasuk = DateTime.now();
      jamKeluar = DateTime.now();
    }

    final result = await editDivision();

    if (result) {
      showDialog(true, 'Informasi berhasil diperbarui');
      refreshViewed();
    } else {
      showDialog(false, 'Gagal memperbarui informasi');
    }
  }

  void generateAvailableTime() {
    jam = List.generate(24, (i) => i.toString().padLeft(2, '0'));
    menit = List.generate(60, (i) => i.toString().padLeft(2, '0'));
  }

  //NextGoal : Make editing Division Name and Office Address
  void editName() {
    namaDivisi.text = showedDivisions.value!.namaDivisi;
    namaDivisiError.value = '';
  }

  void editAddress() {
    alamatKantor.text = showedDivisions.value!.alamatKantor;
    alamatKantorError.value = '';
  }

  void checkNameColumn() {
    if (namaDivisi.text.isEmpty) {
      namaDivisiError.value = 'Nama Divisi tidak boleh kosong!';
      namaDivisi.text = '';
    } else if (namaDivisi.text.length > 100) {
      namaDivisiError.value = 'Nama Divisi maksimal 100 karakter!';
      namaDivisi.text = '';
    } else {
      return;
    }
  }

  void checkAddressColumn() {
    if (alamatKantor.text.isEmpty) {
      alamatKantorError.value = 'Alamat Kantor tidak boleh kosong!';
      alamatKantor.text = '';
    } else {
      return;
    }
  }

  Future<void> updateName() async {
    if (namaDivisiError.value.isNotEmpty) {
      return;
    }

    final result = await editDivision();

    if (result) {
      showDialog(true, 'Informasi berhasil diperbarui');
      refreshViewed();
    } else {
      showDialog(false, 'Gagal memperbarui informasi');
    }
  }

  Future<void> updateAddress() async {
    if (alamatKantorError.value.isNotEmpty) {
      return;
    }

    final result = await editDivision();

    if (result) {
      showDialog(true, 'Informasi berhasil diperbarui');
      refreshViewed();
    } else {
      showDialog(false, 'Gagal memperbarui informasi');
    }
  }

  void editOffice() {
    selectedOffice.value = showedDivisions.value!.kantor;
  }

  Future<void> updateOffice() async {
    if (selectedOffice.value.isEmpty) {
      return;
    }

    if (selectedOffice.value == 'Kantor Utama') {
      office.value = 'head';
    } else if (selectedOffice.value == 'Kantor Cabang') {
      office.value = 'branch';
    }

    final result = await editDivision();

    if (result) {
      showDialog(true, 'Informasi berhasil diperbarui');
      refreshViewed();
    } else {
      showDialog(false, 'Gagal memperbarui informasi');
    }
  }

  void goToAddNewDivision() {
    final listJam = List.generate(24, (i) => i.toString().padLeft(2, '0'));
    final listMenit = List.generate(60, (i) => i.toString().padLeft(2, '0'));

    availableOfficeAdd.clear();
    availableOfficeAdd.addAll([
      'Pilih Kantor',
      'Kantor Utama',
      'Kantor Cabang',
    ]);
    divisionOfficeSelectedAdd.value = 'Pilih Kantor';

    divisionNameAdd.text = '';
    divisionAddressAdd.text = '';

    divisionNameAddError.value = '';
    divisionAddressAddError.value = '';

    jamAddAvailableH.value = listJam;
    jamAddAvailableM.value = listMenit;

    selectedHourAdd.value = '00';
    selectedMinuteAdd.value = '00';

    jamMasukSelectedH.value = '00';
    jamMasukSelectedM.value = '00';

    jamKeluarSelectedH.value = '00';
    jamKeluarSelectedM.value = '00';

    selectedAddTime.value = '30';
    selectedAddRange.value = '100';
    addTime.value = 30;
    addRange.value = 100;

    selectingLocation.value = false;
  }

  void resetAddDivision() {
    divisionNameAdd.text = '';
    divisionAddressAdd.text = '';
    divisionNameAddError.value = '';
    divisionAddressAddError.value = '';
    divisionOfficeSelectedAdd.value = 'Pilih Kantor';
    selectedHourAdd.value = '00';
    selectedMinuteAdd.value = '00';
    jamMasukSelectedH.value = '00';
    jamMasukSelectedM.value = '00';
    jamKeluarSelectedH.value = '00';
    jamKeluarSelectedM.value = '00';
    selectingLocation.value = false;
    currentLat.value = 0.0;
    currentLng.value = 0.0;
    addDivisionLng.value = 0.0;
    addDivisionLat.value = 0.0;
    selectedAddTime.value = '';
    selectedAddRange.value = '';
  }

  void checkNameAddColumn() {
    if (divisionNameAdd.text.isEmpty) {
      divisionNameAddError.value = 'Nama Divisi tidak boleh kosong!';
      divisionNameAdd.text = '';
    } else if (divisionNameAdd.text.length > 100) {
      divisionNameAddError.value = 'Nama Divisi maksimal 100 karakter!';
      divisionNameAdd.text = '';
    } else {
      return;
    }
  }

  void checkAddressAddColumn() {
    if (divisionAddressAdd.text.isEmpty) {
      divisionAddressAddError.value = 'Alamat Kantor tidak boleh kosong!';
      divisionAddressAdd.text = '';
    } else {
      return;
    }
  }

  void addDivisionSelectTime() {
    selectedHourAdd.value = '00';
    selectedMinuteAdd.value = '00';
  }

  void applyTime() {
    if (selectJamMasuk.value) {
      jamMasukSelectedH.value = selectedHourAdd.value;
      jamMasukSelectedM.value = selectedMinuteAdd.value;
    } else if (!selectJamMasuk.value) {
      jamKeluarSelectedH.value = selectedHourAdd.value;
      jamKeluarSelectedM.value = selectedMinuteAdd.value;
    }
  }

  void selectLocation() {
    currentLat.value = initialLat;
    currentLng.value = initialLng.value;
    selectingLocation.value = true;
  }

  void applyLocation() {
    addDivisionLng.value = currentLng.value;
    addDivisionLat.value = currentLat.value;
    selectingLocation.value = false;
  }

  void editTimeTolerance() {
    selectedTime.value =
        showedDivisions.value?.toleransiWaktu.toString() ?? '15';
  }

  void editAreaTolerance() {
    selectedRange.value =
        showedDivisions.value?.toleransiArea.toString() ?? '100';
  }

  Future<void> updateTimeTolerance() async {
    if (selectedTime.value ==
        showedDivisions.value!.toleransiWaktu.toString()) {
      return;
    }

    final result = await editDivision();

    if (result) {
      showDialog(true, 'Informasi berhasil diperbarui');
      refreshViewed();
    } else {
      showDialog(false, 'Gagal memperbarui informasi');
    }
  }

  Future<void> updateAreaTolerance() async {
    if (selectedRange.value ==
        showedDivisions.value?.toleransiArea.toString()) {
      return;
    }

    final result = await editDivision();

    if (result) {
      showDialog(true, 'Informasi berhasil diperbarui');
      refreshViewed();
    } else {
      showDialog(false, 'Gagal memperbarui informasi');
    }
  }

  bool checkParameter() {
    if (divisionNameAdd.text.isEmpty) {
      return false;
    } else if (divisionAddressAdd.text.isEmpty) {
      return false;
    } else if (divisionOfficeSelectedAdd.value == 'Pilih Kantor') {
      return false;
    } else {
      return true;
    }
  }

  void applyOfficeAdd() {
    if (divisionOfficeSelectedAdd.value == 'Kantor Cabang') {
      officeAdd.value = 'branch';
    } else {
      officeAdd.value = 'head';
    }
  }

  void applySelectedTimeAdd() {
    final int? time = int.tryParse(selectedAddTime.value);
    if (time != null) {
      addTime.value = int.parse(selectedAddTime.value);
    }
  }

  void applySelectedRangeAdd() {
    final int? range = int.tryParse(selectedAddRange.value);
    if (range != null) {
      addRange.value = int.parse(selectedAddRange.value);
    }
  }

  Future<void> createDivision() async {
    const String endpoint = 'division/create';
    final token = _userController.userToken.value;

    final Map<String, dynamic> data = {
      'division_name': divisionNameAdd.text,
      'address': divisionAddressAdd.text,
      'latitude': addDivisionLat.value,
      'longitude': addDivisionLng.value,
      'office': officeAdd.value,
      'checkin_time': '${jamMasukSelectedH.value}:${jamMasukSelectedM.value}',
      'checkout_time':
          '${jamKeluarSelectedH.value}:${jamKeluarSelectedM.value}',
      'tolerance': addTime.value,
      'r_tolerance': addRange.value,
    };

    if (!checkParameter()) {
      return;
    }

    final result = await _apiService.postRequest<Map<String, dynamic>>(
      endpoint: endpoint,
      parser: (body) => jsonDecode(body),
      onError: (resp) => 'Terjadi kesalahan: ${resp.statusCode}',
      headers: {'Authorization': 'Bearer $token'},
      data: data,
    );

    if (result['success']) {
      final rawJson = result['data'];
      Divisi newDivisi = Divisi.fromJson(rawJson);
      divisions.add(newDivisi);
      setDivisonsAvailable();
      setKaryawanFilter();
      applyFilter(selectedFilter.value);

      showDialog(
        true,
        'Berhasil membuat divisi',
        runFunction: () {
          Get.back();
          resetAddDivision();
        },
      );
    } else {
      showDialog(false, 'Gagal membuat divisi');
    }
  }

  Future<void> deleteDivision() async {
    const String endpoint = 'division/delete';
    final token = _userController.userToken.value;

    final result = await _apiService.postRequest<Map<String, dynamic>>(
      endpoint: endpoint,
      parser: (body) => jsonDecode(body),
      onError: (resp) => 'Terjadi kesalahan: ${resp.statusCode}',
      headers: {'Authorization': 'Bearer $token'},
      data: {'id': showedDivisions.value!.id},
    );

    if (result['success']) {
      showDialog(
        true,
        'Berhasil menghapus divisi',
        runFunction: () {
          divisions.remove(showedDivisions.value!);
          setDivisonsAvailable();
          setKaryawanFilter();
          applyFilter(selectedFilter.value);
          Get.back();
        },
      );
    } else if (result['has_employee'] == true) {
      showDialog(
        false,
        'tidak dapat menghapus divisi yang masih memiliki karyawan',
      );
    } else {
      showDialog(false, 'Gagal menghapus divisi');
    }
  }

  @override
  void onInit() {
    generateAvailableTime();
    super.onInit();
  }
}
