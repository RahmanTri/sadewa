import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/constants/urls.dart';
import 'package:sadewa_fe/services/api_service.dart';
import 'package:sadewa_fe/services/storage_service.dart';

class AuthController extends GetxController {
  final StorageService _storageService = StorageService();
  final ApiService _apiService = ApiService();
  final formKey = GlobalKey<FormState>();

  final emailUsername = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final isFormValid = false.obs;
  final obscurePW = true.obs;
  final rememberMe = false.obs;
  
  var isLoading = false.obs;
  var token = ''.obs;

  @override
  void onInit() {
    super.onInit();
    emailUsername.addListener(_validateForm);
    password.addListener(_validateForm);
    confirmPassword.addListener(_validateForm);
    _loadRememberMe();
  }

  void _validateForm() {
    isFormValid.value = 
    emailUsername.text.isNotEmpty && password.text.isNotEmpty;
  }

  void _loadRememberMe() async {
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
      final result = await _apiService.postRequest<Map<String,dynamic>>(
      endpoint: loginEndpoint,
      data: loginData,
      parser: (body) => jsonDecode(body),  
      onError: (resp) => 'Login gagal: ${resp.statusCode}'
      );

      //Save token
      token.value = result['token'] ?? '';
      await _storageService.saveToken(token.value);

      //Save role
      final role = result['role'] ?? '';
      await _storageService.saveRole(role);

      //If remember me is checked
      if (rememberMe.value) {
        await _storageService.setRememberMe(true, emailUsername, password);
      }
      isLoading.value = false;
      return true;
    } catch (e) {
      isLoading.value = false;
      return false;
    }
  }

  void loginAttempt() async {
    isLoading.value = true;
    final success = await login(emailUsername.text.trim(), password.text.trim());

    isLoading.value = false;
    if (!success) {
      Get.snackbar('Login gagal', 'Email atau password salah');
    }
    return;
  }

  void logOut() async {
    await _storageService.logOut();
  }

  @override
  void onClose() {
    emailUsername.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.onClose();
  }
}