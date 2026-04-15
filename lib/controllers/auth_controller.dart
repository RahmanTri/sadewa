import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/routes/app_routes.dart';
import 'package:sadewa_fe/constants/urls.dart';
import 'package:sadewa_fe/services/api_service.dart';
import 'package:sadewa_fe/services/storage_service.dart';
import 'package:sadewa_fe/routes/app_routes.dart';

class AuthController extends GetxController {
  final StorageService _storageService = StorageService();
  final ApiService _apiService = ApiService();
  final formKey = GlobalKey<FormState>();

  final emailUsername = TextEditingController();
  final password = TextEditingController();

  final isFormValid = false.obs;
  final obscurePW = true.obs;
  final rememberMe = false.obs;

  var isLoading = false.obs;
  var userRole = ''.obs;
  var token = ''.obs;

  @override
  void onInit() {
    super.onInit();
    emailUsername.addListener(_validateForm);
    password.addListener(_validateForm);
    // loadRememberMe();
  }

  void _validateForm() {
    isFormValid.value =
        emailUsername.text.isNotEmpty && password.text.isNotEmpty;
  }

  Future<void> loadRememberMe() async {
    final remembered = await _storageService.getRemember() ?? false;
    if (remembered) {
      final userCreds = await _storageService.getUserCredential();
      try {
        isLoading.value = true;
        login(userCreds['emailUsername']!, userCreds['password']!);
        isLoading.value = false;
      } catch (e) {
        isLoading.value = false;
      }
    }
  }

  Future<bool> login(String emailUsername, String password) async {
    isLoading.value = true;
    var loginEndpoint = AppUrls.loginByU;
    var loginData = {'username': emailUsername, 'password': password};
    if (emailUsername.contains('@') && emailUsername.contains('.')) {
      loginEndpoint = AppUrls.loginByE;
      loginData = {'email': emailUsername, 'password': password};
    }
    try {
      // print(loginData);
      // print(loginEndpoint);

      final result = await _apiService.postRequest<Map<String, dynamic>>(
        endpoint: loginEndpoint,
        data: loginData,
        parser: (body) => jsonDecode(body),
        onError: (resp) => 'Login gagal: ${resp.statusCode}',
      );

      //Save token
      token.value = result['token'] ?? '';
      await _storageService.saveToken(token.value);

      //Save role
      final role = result['user']['role'] ?? '';
      await _storageService.saveRole(role);
      userRole.value = role;

      //If remember me is checked
      if (rememberMe.value) {
        await _storageService.setRememberMe(true, emailUsername, password);
      }

      isLoading.value = false;

      Get.snackbar(
        'Login Berhasil',
        'Selamat Datang ${result['user']['username']}',
      );

      if (userRole.value == 'employee') {
        // Get.offNamed(Routes.riwayat);
        Get.offAllNamed(Routes.home, arguments: result['userData']);
      } else if (userRole.value == 'admin') {
        // Get.offNamed(Routes.adminHome);
        Get.offAllNamed(Routes.adminHome, arguments: result['userData']);

        //Test Only
        Get.snackbar('Memasuki Halaman', 'Anda Dipindahkan ke halaman admin');
      } else {
        Get.snackbar('Error', 'Anda belum memiliki role');
      }

      // Test
      // print(result);

      return true;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Login gagal', e.toString());
      return false;
    }
  }

  void loginAttempt() async {
    isLoading.value = true;

    try {
      final success = await login(
        emailUsername.text.trim(),
        password.text.trim(),
      );
      if (!success) {
        Get.snackbar('Login gagal', 'Email atau password salah');
        isLoading.value = false;
      }
      return;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Login gagal', e.toString());
      return;
    }
    // print(emailUsername.text.trim()+password.text.trim());
  }

  void logOut() async {
    await _storageService.logOut();
  }

  void devAutoLogin() async {
    isLoading.value = true;
    try {
      final success = await login('BambangSutejo', 'bamsutejo1234');
      if (!success) {
        Get.snackbar('Login gagal', 'Ada yang Keliru');
        isLoading.value = false;
      }
      return;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Login gagal', e.toString());
      return;
    }
  }

  @override
  void onClose() {
    emailUsername.dispose();
    password.dispose();
    super.onClose();
  }
}
