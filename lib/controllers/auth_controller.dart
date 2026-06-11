import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/controllers/division_controller.dart';
import 'package:sadewa_fe/routes/app_routes.dart';
import 'package:sadewa_fe/constants/urls.dart';
import 'package:sadewa_fe/services/api_service.dart';
import 'package:sadewa_fe/services/storage_service.dart';
import 'package:sadewa_fe/controllers/user_controller.dart';

class AuthController extends GetxController {
  final StorageService _storageService = StorageService();
  final ApiService _apiService = ApiService();
  final formKey = GlobalKey<FormState>();
  final userController = Get.find<UserController>();
  final DivisionController divisionController = Get.find<DivisionController>();

  final emailUsername = TextEditingController();
  final password = TextEditingController();

  final isFormValid = false.obs;
  final obscurePW = true.obs;
  final rememberMe = false.obs;

  var isLoading = false.obs;
  var userRole = ''.obs;
  var token = ''.obs;

  var embeddings = <List<double>>[].obs;

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

  Future<bool> loadRememberMe() async {
    final remembered = await _storageService.getRemember() ?? false;
    if (remembered) {
      final userCreds = await _storageService.getUserCredential();

      final loginRemember = await login(userCreds['emailUsername']!, userCreds['password']!);
      if (loginRemember) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
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
      final role = result['user_data']['role'] ?? '';
      await _storageService.saveRole(role);
      userRole.value = role;

      // //Save Embeddings
      // final embeddingsData = result['user']['embeddings'] ?? <List<double>>[];
      // await _storageService.saveEmbeddings(embeddingsData);
      // embeddings.value = embeddingsData;
      final savedRememberMe = await _storageService.getRemember() ?? false;
      if (savedRememberMe) {
        rememberMe.value = savedRememberMe;
      }

      //If remember me is checked
      if (rememberMe.value) {
        await _storageService.setRememberMe(true, emailUsername, password);
      } else {
        await _storageService.saveRemember(rememberMe.value);
      }

      isLoading.value = false;

      //Assign user data to userController
      if (result['user_data']['role'] == 'admin') {
        userController.isAdmin.value = true;
        userController.assignUserData(result['user_data']);
        userController.setUserToken(token.value);
      } else {
        userController.assignUserData(result['user_data']);
        userController.setUserToken(token.value);
      }

      //Assign division data to divisionController
      divisionController.fetchDivisions();

      Get.snackbar(
        'Login Berhasil',
        'Selamat Datang ${result['user_data']['username']}',
      );

      //employee page can be changed during development
      if (userRole.value == 'employee') {
        Get.offAllNamed(Routes.profile);
        // Get.offNamed(Routes.riwayat);
        Get.offAllNamed(Routes.home);
      } else if (userRole.value == 'admin') {
        // Get.offNamed(Routes.adminHome);
        Get.offAllNamed(Routes.adminHome);
        //Test Only
      }
      // Test
      // print(result);

      return true;
    } catch (e) {
      isLoading.value = false;
      // print("Error Login: $e");
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
      return;
    }
    // print(emailUsername.text.trim()+password.text.trim());
  }

  // void logOut() async {
  //   try {
  //     await _storageService.logOut();
  //     Get.offAllNamed(Routes.login);
  //   } catch (e) {
  //     print("Gagal logout: $e");
  //   }
  // }

  // Future<void> devAutoLogin() async {
  //   isLoading.value = true;
  //   final username = 'employee01';
  //   final password = 'employee123';

  //   try {
  //     final success = await login(username, password);
  //     if (!success) {
  //       Get.snackbar('Login gagal', 'Ada yang Keliru');
  //       isLoading.value = false;
  //     }
  //     return;
  //   } catch (e) {
  //     isLoading.value = false;
  //     Get.snackbar('Login gagal', e.toString());
  //     return;
  //   }
  // }

  @override
  void onClose() {
    emailUsername.dispose();
    password.dispose();
    super.onClose();
  }
}
