import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/controllers/user_controller.dart';
import 'package:sadewa_fe/models/karyawan_model.dart';
import 'package:sadewa_fe/pages/Admin_ViewKaryawan/widgets/karyawan_alert_dialog.dart';
import 'package:sadewa_fe/routes/app_routes.dart';
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

  TextEditingController usernameNew = TextEditingController();
  TextEditingController emailNew = TextEditingController();
  TextEditingController passwordNew = TextEditingController();
  TextEditingController namaLengkapNew = TextEditingController();
  TextEditingController noTelpNew = TextEditingController();

  var usernameAdd = ''.obs;
  var usernameError = ''.obs;

  var emailAdd = ''.obs;
  var emailError = ''.obs;

  var passwordAdd = ''.obs;
  var passwordError = ''.obs;

  var namaLengkapAdd = ''.obs;
  var namaLengkapError = ''.obs;

  var noTelpAdd = ''.obs;
  var noTelpError = ''.obs;

  var selectedDivisionIDAdd = 0.obs;
  var selectedDivisionNameAdd = ''.obs;
  var divisionError = ''.obs;

  var dialogMessage = ''.obs;

  var isLoading = false.obs;
  var processing = false.obs;

  void applyFilter(String filter) {
    selectedFilter.value = filter;
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
      showDialog(true, 'Password berhasil direset');
      processing.value = false;
    } catch (e) {
      showDialog(false, 'Gagal mereset password');
      processing.value = false;
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
      showDialog(true, 'Data wajah berhasil direset');
      processing.value = false;
    } catch (e) {
      showDialog(false, 'Gagal mereset data wajah');
      processing.value = false;
    } finally {
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
    selectedDivisionId.value = karyawanView.value!.idDivisi;
  }

  Future<void> editEmployee() async {
    processing.value = true;
    final endpoint = 'employee/edit';
    final apiToken = Get.find<UserController>().userToken.value;

    Map<String, dynamic> data = {};

    data.addAll({'em_id': karyawanView.value!.idKaryawan});

    if (namaLengkap.text.isNotEmpty &&
        namaLengkap.text != karyawanView.value!.namaLengkap) {
      data.addAll({'name': namaLengkap.text});
    }
    if (email.text.isNotEmpty && email.text != karyawanView.value!.email) {
      data.addAll({'email': email.text});
    }
    if (noTlp.text.isNotEmpty && noTlp.text != karyawanView.value!.noTlp) {
      data.addAll({'phone_number': noTlp.text});
    }
    if (selectedDivisionId.value != karyawanView.value!.idDivisi &&
        selectedDivisionId.value != 0) {
      data.addAll({'division_id': selectedDivisionId.value});
    }

    try {
      await _apiService.postRequest<Map<String, dynamic>>(
        endpoint: endpoint,
        parser: (body) => jsonDecode(body),
        onError: (resp) => 'Terjadi kesalahan: ${resp.body}',
        headers: {'Authorization': 'Bearer $apiToken'},
        data: data,
      );
      showDialog(true, 'Berhasil mengupdate data karyawan');
      processing.value = false;
    } catch (e) {
      Get.snackbar('Terjadi kesalahan', e.toString());
      showDialog(false, 'Gagal mengupdate data karyawan');
      processing.value = false;
    } finally {
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

  void hideDialog() {
    dialogMessage.value = '';
  }

  void showDialog(bool success, String message, {String newRoutes = ''}) {
    dialogMessage.value = message;
    Get.dialog(
      KaryawanAlertDialog(
        isSuccess: success,
        message: message,
        onConfirm: hideDialog,
        goTo: newRoutes,
        height: Get.height,
        width: Get.width,
      ),
    );
  }

  Future<void> registerEmployee() async {
    final endpoint = 'employee/register';
    final apiToken = Get.find<UserController>().userToken.value;

    Map<String, dynamic> data = {};

    final validation = validateForm();

    if (!validation) {
      return;
    }

    data.addAll({'username': usernameNew.text});
    data.addAll({'email': emailNew.text});
    data.addAll({'password': passwordNew.text});
    data.addAll({'name': namaLengkapNew.text});
    data.addAll({'phone_number': noTelpNew.text});
    data.addAll({'division_id': selectedDivisionIDAdd.value});

    try {
      await _apiService.postRequest<Map<String, dynamic>>(
        endpoint: endpoint,
        parser: (body) => jsonDecode(body),
        onError: (resp) => 'Terjadi kesalahan: ${resp.body}',
        headers: {'Authorization': 'Bearer $apiToken'},
        data: data,
      );
      showDialog(true, 'Berhasil mendaftarkan karyawan');
      clearForm();
      refreshView();
      goToAddEmployee();
    } catch (e) {
      Get.snackbar('Terjadi kesalahan', e.toString());
      showDialog(false, 'Gagal mendaftarkan karyawan');
    }
  }

  void checkUsernameField() {
    if (usernameNew.text.isEmpty) {
      usernameError.value = 'Username harus diisi';
    } else if (usernameNew.text.length < 8) {
      usernameError.value = 'Username minimal 8 karakter';
    } else if (usernameNew.text.length > 24) {
      usernameError.value = 'Username maksimal 24 karakter';
    } else if (usernameNew.text.contains(' ')) {
      usernameError.value = 'Username tidak boleh mengandung spasi';
    } else {
      return;
    }
  }

  void checkPasswordField() {
    if (passwordNew.text.isEmpty) {
      passwordError.value = 'Password harus diisi';
    } else if (passwordNew.text.length < 8) {
      passwordError.value = 'Password minimal 8 karakter';
    } else if (passwordNew.text == usernameNew.text) {
      passwordError.value = 'Password dan username tidak boleh sama';
    } else if (passwordNew.text.contains(' ')) {
      passwordError.value = 'Password tidak boleh mengandung spasi';
    } else {
      return;
    }
  }

  void checkEmailField() {
    if (emailNew.text.isEmpty) {
      emailError.value = 'Email harus diisi';
    } else if (!GetUtils.isEmail(emailNew.text)) {
      emailError.value = 'Email tidak valid';
    } else {
      return;
    }
  }

  void checkNameField() {
    if (namaLengkapNew.text.isEmpty) {
      namaLengkapError.value = 'Nama lengkap harus diisi';
    } else {
      return;
    }
  }

  void checkPhoneField() {
    if (noTelpNew.text.isEmpty) {
      noTelpError.value = 'Nomor telepon harus diisi';
    } else if (noTelpNew.text.length < 12) {
      noTelpError.value = 'Nomor telepon Tidak Valid';
    } else if (noTelpNew.text.length > 13) {
      noTelpError.value = 'Nomor telepon Tidak Valid';
    } else if (!noTelpNew.text.startsWith('08') &&
        !noTelpNew.text.startsWith('62')) {
      noTelpError.value = 'Nomor telepon Tidak Valid';
    } else {
      return;
    }
  }

  void checkDivisionField() {
    assignDivNameAdd(selectedDivisionNameAdd.value);

    if (selectedDivisionNameAdd.value == 'Pilih Divisi') {
      divisionError.value = 'Divisi harus diisi';
    } else if (selectedDivisionIDAdd.value == 0) {
      divisionError.value = 'Divisi harus diisi';
    } else {
      return;
    }
  }

  void clearForm() {
    usernameNew.text = '';
    passwordNew.text = '';
    emailNew.text = '';
    namaLengkapNew.text = '';
    noTelpNew.text = '';
    selectedDivisionNameAdd.value = 'Pilih Divisi';

    clearError();
  }

  void clearError() {
    usernameError.value = '';
    passwordError.value = '';
    emailError.value = '';
    namaLengkapError.value = '';
    noTelpError.value = '';
    divisionError.value = '';
  }

  void goToAddEmployee() {
    clearForm();
    availableDivisionNames.clear();
    availableDivisionNames.add('Pilih Divisi');

    final divAvailable = Get.find<DivisionController>().availableDivisions
        .toList();

    for (int i = 0; i < divAvailable.length; i++) {
      availableDivisionNames.add(divAvailable[i]);
    }

    selectedDivisionNameAdd.value = 'Pilih Divisi';
  }

  void assignDivNameAdd(String divisionName) {
    final availableDiv = Get.find<DivisionController>().divisions
        .toList();

    for (int i = 0; i < availableDiv.length; i++) {
      if (availableDiv[i].namaDivisi == divisionName &&
          divisionName != 'Pilih Divisi') {
        selectedDivisionIDAdd.value = availableDiv[i].id;
      }
    }
  }

  bool validateForm() {
    checkUsernameField();
    checkPasswordField();
    checkEmailField();
    checkNameField();
    checkPhoneField();
    checkDivisionField();

    if (usernameError.value.isNotEmpty ||
        passwordError.value.isNotEmpty ||
        emailError.value.isNotEmpty ||
        namaLengkapError.value.isNotEmpty ||
        noTelpError.value.isNotEmpty ||
        divisionError.value.isNotEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> deleteKaryawan() async {
    processing.value = true;
    final endpoint = 'employee/delete';
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
      showDialog(true, 'Data karyawan berhasil dihapus', newRoutes: Routes.karyawan);
      processing.value = false;
    } catch (e) {
      showDialog(false, 'Gagal menghapus data karyawan');
      processing.value = false;
    } finally {
      refreshView();
      fetchKaryawan();
    }
  }

  Future<void> reNewKaryawan(int divisionID) async {
    processing.value = true;
    final endpoint = 'employee/get-div';
    final apiToken = Get.find<UserController>().userToken.value;
    final data = {'division_id': divisionID};
    try {
      final result = await _apiService.postRequest<Map<String, dynamic>>(
        endpoint: endpoint,
        parser: (body) => jsonDecode(body),
        onError: (resp) => 'Terjadi kesalahan: ${resp.statusCode}',
        headers: {'Authorization': 'Bearer $apiToken'},
        data: data,
      );

      final jsonData = result['data'];
      final reNewKaryawanFromBE = jsonData
          .map((item) => Karyawan.fromJson(item))
          .toList();
      
      karyawan.removeWhere((item) => item.idDivisi == divisionID);

      for (int i = 0; i < reNewKaryawanFromBE.length; i++) {
        karyawan.add(reNewKaryawanFromBE[i]);
      }

      applyFilter(selectedFilter.value);

      processing.value = false;
    } catch (e) {
      processing.value = false;
    }
  }

  int countKaryawan(int divId) {
    int count = 0;
    for (int i = 0; i < karyawan.length; i++) {
      if (karyawan[i].idDivisi == divId) {
        count += 1;
      }
    }
    return count;
  }
}
