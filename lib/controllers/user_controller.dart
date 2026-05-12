import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/models/admin_model.dart';
import 'package:sadewa_fe/pages/Profile/changepw_succes.dart';
import '../models/user_model.dart';
import 'package:sadewa_fe/services/api_service.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:sadewa_fe/constants/urls.dart';

class UserController extends GetxController {
  final ApiService _apiService = ApiService();
  final ImagePicker _picker = ImagePicker();
  final String baseApiUrl = AppUrls.baseApiUrl;
  final String imgProfileUrl = AppUrls.imgProfileUrl;

  var user = Rxn<User>();
  var admin = Rxn<Admin>();

  var isAdmin = false.obs;

  var userToken = ''.obs;
  var isLoading = false.obs;
  var isEditing = false.obs;
  var selectedImagePath = ''.obs;

  var obscureOld = true.obs;
  var obscureNew = true.obs;
  var obscureConfirm = true.obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController divisionController = TextEditingController();

  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();
  final confirmPassController = TextEditingController();

  void assignUserData(Map<String, dynamic> userData) {
    isLoading.value = true;
     if (userData['role'] == 'admin') {
      admin.value = Admin.fromJson(userData);
      isAdmin.value = true;
    } else {
      user.value = User.fromJson(userData);
    }
    // Get.snackbar('Berhasil Cok', user.value?.dataWajah.toString() ?? '');

    isLoading.value = false;
  }

  void setUserToken(String token) {
    userToken.value = token;
  }

  void toogleEdit() {
    isEditing.value = !isEditing.value;
    if (isEditing.value) {
      setValue();
    }
  }

  void setValue() {
    nameController.text = user.value!.namaLengkap;
    emailController.text = user.value!.email;
    phoneController.text = user.value!.noTelp;
    divisionController.text = user.value!.namaDivisi;
  }

  Future<void> updateUser() async {
    isLoading.value = true;

    final endpoint = 'employee/profile';
    Map<String, dynamic> userData = {};
    
    if (nameController.text != user.value?.namaLengkap) {
      userData.assign('name', nameController.text);
    }

    if (emailController.text != user.value?.email) {
      userData.assign('email', emailController.text);
    }

    if (phoneController.text != user.value?.noTelp) {
      userData.assign('phone_number', phoneController.text.trim());
    } 

    if (divisionController.text != user.value?.namaDivisi) {
      userData.assign('namaDivisi(X)', divisionController.text);
    }

    try {
      isLoading.value = true; 
        await _apiService.postRequest<Map<String, dynamic>>(
        endpoint: endpoint,
        data: userData,
        parser: (body) => jsonDecode(body),
        onError: (resp) => 'Gagal memperbarui data: ${resp.statusCode}',
        headers: {'Authorization': 'Bearer $userToken'},
      );

      if (user.value != null) {
        user.value = User(
        userId: user.value!.userId,
        username: user.value!.username,
        namaLengkap: nameController.text,
        email: emailController.text,
        noTelp: phoneController.text,
        role: user.value!.role,
        idPerusahaan: user.value!.idPerusahaan,
        idDivisi: user.value!.idDivisi,
        namaDivisi: user.value!.namaDivisi,
        dataWajah: user.value!.dataWajah,
        fotoProfil: user.value!.fotoProfil,
        poin: user.value!.poin,
        loggedIn: user.value!.loggedIn,
        loggedOut: user.value!.loggedOut,
        );

        user.refresh();
      }

      Get.snackbar('Berhasil', 'Data profil telah diperbarui');
    } catch (e) {
      Get.snackbar('error', 'Terjadi kesalahan: $e');
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  } 

 Future<void> pickImage(ImageSource source) async {
  try{
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 50,
    );

    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;

    if (Get.isBottomSheetOpen ?? false) Get.back();
    
    await uploadProfilePic(File(pickedFile.path));
    }
  } catch (e) {
    Get.snackbar('error', 'Gagal mengambil gambar: $e');
  }
 }

//Upload to Database
 Future<void> uploadProfilePic(File imageFile) async {

  try {
  isLoading.value = true;

  var url = Uri.parse('$baseApiUrl/employee/profile');
  var request = http.MultipartRequest('POST', url);
  
  request.headers.addAll({
    'Authorization': 'Bearer ${userToken.value}',
    'Accept': 'application/json',
  });

  request.files.add(await http.MultipartFile.fromPath(
    'profile_pic', 
    imageFile.path,
  ));

  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);

  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);

      String? newFileName = result['data']['employee']['new']['profile_pic'];

      if (newFileName != null && user.value != null) {

      user.value = User(
        userId: user.value!.userId,
        username: user.value!.username,
        namaLengkap: user.value!.namaLengkap,
        email: user.value!.email,
        noTelp: user.value!.noTelp,
        role: user.value!.role,
        idPerusahaan: user.value!.idPerusahaan,
        idDivisi: user.value!.idDivisi,
        namaDivisi: user.value!.namaDivisi,
        dataWajah: user.value!.dataWajah,
        fotoProfil: newFileName,
        poin: user.value!.poin,
        loggedIn: user.value!.loggedIn,
        loggedOut: user.value!.loggedOut,
      );

      selectedImagePath.value = '';
      user.refresh();
      
    }
    
    Get.snackbar('Berhasil', 'Foto profil telah diperbarui');
  } else {
    Get.snackbar('Gagal', 'Gagal mengunggah foto ke server');
  }
 } catch (e) {
    Get.snackbar('error', 'Terjadi kesalahan: $e');
  } finally {
    isLoading.value = false;
  }
 }

 Future<void> deleteProfilePic() async {
  try {
    isLoading.value = true;

    var url = Uri.parse('$baseApiUrl/employee/clear-profile');
    var response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer ${userToken.value}',
        'Accept': 'application/json',
      },
    );
    
    if (response.statusCode == 200) {
      if (user.value != null) {

        user.value = User(
        userId: user.value!.userId,
        username: user.value!.username,
        namaLengkap: user.value!.namaLengkap,
        email: user.value!.email,
        noTelp: user.value!.noTelp,
        role: user.value!.role,
        idPerusahaan: user.value!.idPerusahaan,
        idDivisi: user.value!.idDivisi,
        namaDivisi: user.value!.namaDivisi,
        dataWajah: user.value!.dataWajah,
        fotoProfil: '',
        poin: user.value!.poin,
        loggedIn: user.value!.loggedIn,
        loggedOut: user.value!.loggedOut,
      );

      selectedImagePath.value = '';
      user.refresh();
      }
      
      Get.snackbar('Berhasil', 'Foto profil telah dihapus');
    } else {
      Get.snackbar('Gagal', 'Gagal menghapus foto ke server');
    }
      } catch (e) {
      Get.snackbar('error', 'Terjadi kesalahan: $e');
      } finally {
      isLoading.value = false;
      }
    }

    Future<void> changePassword() async {
      if (oldPassController.text.isEmpty || newPassController.text.isEmpty || confirmPassController.text.isEmpty) {
        Get.snackbar('Peringatan!', 'Semua kolom wajib diisi!');
        return;
      }
      if (newPassController.text == oldPassController.text) {
        Get.snackbar('Error!', 'Password baru tidak boleh sama dengan password lama');
        return;
      }
      if (newPassController.text != confirmPassController.text) {
        Get.snackbar('Gagal', 'Password baru dan konfirmasi password tidak cocok');
        return;
      }

      try 
      {
        isLoading.value = true;

        // Send to Backend
        await _apiService.postRequest<Map<String, dynamic>>(
          endpoint: 'user/change-pw', 
          data: {
            'old_password': oldPassController.text,
            'password': newPassController.text,
          },
          parser: (body) => json.decode(body), 
          onError: (resp) => 'Gagal: ${resp.statusCode}',
          headers: {'Authorization': 'Bearer ${userToken.value}'},
        );
          
          Get.snackbar('Berhasil', 'Password berhasil diubah');
          oldPassController.clear();
          newPassController.clear();
          confirmPassController.clear();

          Get.off(() => const PasswordChangeSuccess());
          
      } catch (e) {
        Get.snackbar('Error', 'Gagal mengubah password: $e');
      } finally {
        isLoading.value = false;
      }
    }
  }
