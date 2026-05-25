import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/controllers/user_controller.dart';
import 'package:sadewa_fe/models/akun_model.dart';
import 'package:sadewa_fe/pages/Admin_ManajerAkun/widgets/akun_alert_dialog.dart';
import 'package:sadewa_fe/services/api_service.dart';

class AkunController extends GetxController {
  final ApiService _apiService = ApiService();

  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  final TextEditingController usernameAdd = TextEditingController();
  final TextEditingController emailAdd = TextEditingController();
  final TextEditingController passwordAdd = TextEditingController();

  var selectedRoleAdd = ''.obs;

  var usernameError = ''.obs;
  var emailError = ''.obs;
  var passwordError = ''.obs;

  var availableRoles = <String>['admin', 'employee'].obs;
  var selectedRole = ''.obs;

  var accounts = <Akun>[].obs;

  var selectedFilter = 'Semua'.obs;
  var filterOptions = ['Semua', 'Admin', 'Karyawan'];
  var filteredAccounts = <Akun>[].obs;

  var editedAccount = Rxn<Akun>();

  var dialogMessage = ''.obs;

  var isLoading = false.obs;
  var deleting = false.obs;
  var updating = false.obs;
  var adding = false.obs;
  var successAdding = false.obs;

  Future<void> fetchAccounts() async {
    isLoading.value = true;
    accounts.clear();

    try {
      final endpoint = "user/get-data";
      final userToken = Get.find<UserController>().userToken.value;

      final result = await _apiService.getRequest<Map<String, dynamic>>(
        endpoint: endpoint,
        parser: (body) => jsonDecode(body),
        onError: (resp) => 'Terjadi kesalahan: ${resp.statusCode}',
        headers: {"Authorization": "Bearer $userToken"},
      );

      final jsonData = result['data'];
      final accountsFromBE = jsonData
          .map((item) => Akun.fromJson(item))
          .toList();
      for (int i = 0; i < accountsFromBE.length; i++) {
        accounts.add(accountsFromBE[i]);
      }
    } catch (e) {
      Get.snackbar('Terjadi kesalahan', e.toString());
    } finally {
      Get.snackbar('Sukses', 'Berhasil mengambil Akun');
      applyFilter(selectedFilter.value);
      isLoading.value = false;
    }
  }

  void applyFilter(String filter) {
    isLoading.value = true;

    filteredAccounts.clear();

    selectedFilter.value = filter;
    if (filter == 'Semua') {
      filteredAccounts.assignAll(accounts);
      isLoading.value = false;
    } else if (filter == 'Admin') {
      filteredAccounts.assignAll(
        accounts.where((account) => account.role == 'admin'),
      );
      isLoading.value = false;
    } else if (filter == 'Karyawan') {
      filteredAccounts.assignAll(
        accounts.where((account) => account.role == 'employee'),
      );
      isLoading.value = false;
    }
  }

  void editAccount(Akun account) {
    editedAccount.value = account;

    username.text = editedAccount.value!.username;
    email.text = editedAccount.value!.email;
    selectedRole.value = editedAccount.value!.role;
    password.text = '';

    Get.snackbar('Mengedit', 'Akun : ${account.username}');
  }

  Future<void> updateAccount() async {
    updating.value = true;
    final endpoint = "user/edit-data";
    final userToken = Get.find<UserController>().userToken.value;
    Map<String, dynamic> data = {'user_id': editedAccount.value!.id};

    if (username.text.isNotEmpty &&
        username.text != editedAccount.value!.username) {
      data.addAll({'username': username.text});
    }
    if (email.text.isNotEmpty && email.text != editedAccount.value!.email) {
      data.addAll({'email': email.text});
    }
    if (selectedRole.value.isNotEmpty &&
        selectedRole.value != editedAccount.value!.role) {
      data.addAll({'role': selectedRole.value});
    }
    if (password.text.isNotEmpty) {
      data.addAll({'password': password.text});
    }

    try {
      await _apiService.postRequest<Map<String, dynamic>>(
        endpoint: endpoint,
        data: data,
        parser: (body) => jsonDecode(body),
        onError: (resp) => 'Terjadi kesalahan: ${resp.statusCode}',
        headers: {'Authorization': 'Bearer $userToken'},
      );

      showDialog(true, 'Berhasil mengubah akun');
    } catch (e) {
      updating.value = false;
      showDialog(false, 'Gagal mengubah akun');
    } finally {
      updating.value = false;
      refreshEditedAccount();
      editAccount(editedAccount.value!);
    }
  }

  Future<void> makeNewAccount() async {
    adding.value = true;
    final endpoint = "user/create";
    final userToken = Get.find<UserController>().userToken.value;
    Map<String, dynamic> data = {};

    data = checkForm();

    if (data.isEmpty) {
      refreshForm();
      adding.value = false;
      return;
    }

    try {
      await _apiService.postRequest<Map<String, dynamic>>(
        endpoint: endpoint,
        data: data,
        parser: (body) => jsonDecode(body),
        onError: (resp) => 'Terjadi kesalahan: ${resp.statusCode}',
        headers: {'Authorization': 'Bearer $userToken'},
      );

      showDialog(true, 'Berhasil membuat akun');
      successAdding.value = true;
    } catch (e) {
      showDialog(false, 'Gagal membuat akun');
      adding.value = false;
      successAdding.value = false;
    } finally {
      adding.value = false;
      fetchAccounts();
    }
  }

  Future<void> deleteAccount() async {
    deleting.value = true;
    final endpoint = "user/delete";
    final userToken = Get.find<UserController>().userToken.value;

    try {
      await _apiService.postRequest<Map<String, dynamic>>(
        endpoint: endpoint,
        data: {'user_id': editedAccount.value!.id},
        parser: (body) => jsonDecode(body),
        onError: (resp) => 'Terjadi kesalahan: ${resp.statusCode}',
        headers: {'Authorization': 'Bearer $userToken'},
      );

      editedAccount.value = null;
      showDialog(true, 'Berhasil menghapus akun');
  } catch (e) {
      showDialog(false, 'Gagal menghapus akun');
    } finally {
      fetchAccounts();
      deleting.value = false;
    }
  }

  Map<String, dynamic> checkForm() {
    Map<String, dynamic> data = {};

    if (usernameAdd.text.isEmpty) {
      usernameError.value = 'Username tidak boleh kosong';
    } else if (usernameAdd.text.length < 8) {
      usernameError.value = 'Username minimal 8 karakter';
    } else if (usernameAdd.text.length > 24) {
      usernameError.value = 'Username maksimal 24 karakter';
    } else if (usernameAdd.text.contains(' ')) {
      usernameError.value = 'Username tidak boleh mengandung spasi';
    } else {
      data.addAll({'username': usernameAdd.text});
    }

    if (emailAdd.text.isEmpty) {
      emailError.value = 'Email tidak boleh kosong';
    } else if (!GetUtils.isEmail(emailAdd.text)) {
      emailError.value = 'Email tidak valid';
    } else {
      data.addAll({'email': emailAdd.text});
    }

    if (passwordAdd.text.isEmpty) {
      passwordError.value = 'Password tidak boleh kosong';
    } else if (passwordAdd.text.length < 8) {
      passwordError.value = 'Password minimal 8 karakter';
    } else {
      data.addAll({'password': passwordAdd.text});
    }

    data.addAll({'role': selectedRoleAdd.value});

    if (usernameError.value.isNotEmpty ||
        emailError.value.isNotEmpty ||
        passwordError.value.isNotEmpty) {
      return {};
    }

    return data;
  }

  void checkUsernameField() {
    if (usernameAdd.text.isEmpty) {
      usernameError.value = 'Username tidak boleh kosong';
    } else if (usernameAdd.text.length < 8) {
      usernameError.value = 'Username minimal 8 karakter';
    } else if (usernameAdd.text.length > 24) {
      usernameError.value = 'Username maksimal 24 karakter';
    } else if (usernameAdd.text.contains(' ')) {
      usernameError.value = 'Username tidak boleh mengandung spasi';
    }
  }

  void checkEmailField() {
    if (emailAdd.text.isEmpty) {
      emailError.value = 'Email tidak boleh kosong';
    } else if (!GetUtils.isEmail(emailAdd.text)) {
      emailError.value = 'Email tidak valid';
    }
  }

  void checkPasswordField() {
    if (passwordAdd.text.isEmpty) {
      passwordError.value = 'Password tidak boleh kosong';
    } else if (passwordAdd.text.length < 8) {
      passwordError.value = 'Password minimal 8 karakter';
    }
  }

  void refreshEditedAccount() {
    final userId = editedAccount.value!.id;

    fetchAccounts();
    editedAccount.value = accounts.firstWhere(
      (account) => account.id == userId,
    );
    editedAccount.refresh();
  }

  void clearError() {
    usernameError.value = '';
    emailError.value = '';
    passwordError.value = '';
  }

  void clearForm() {
    usernameAdd.text = '';
    emailAdd.text = '';
    passwordAdd.text = '';
  }

  void addNewAccount() {
    usernameAdd.text = '';
    emailAdd.text = '';
    passwordAdd.text = '';
    selectedRoleAdd.value = 'employee';
  }

  void refreshForm() {
    if (usernameError.value.isNotEmpty) {
      usernameAdd.text = '';
    }
    if (emailError.value.isNotEmpty) {
      emailAdd.text = '';
    }
    if (passwordError.value.isNotEmpty) {
      passwordAdd.text = '';
    }
  }

  //Test Only
  void clearList() {
    accounts.clear();
    filteredAccounts.clear();
  }

  void showDialog(bool success, String message) {
    dialogMessage.value = message;
    Get.dialog(
      AkunAlertDialog(
        isSuccess: success,
        message: message,
        onConfirm: hideDialog,
        height: Get.height,
        width: Get.width,
      ),
    );
  }

  void hideDialog() {
    dialogMessage.value = '';
  }
}
