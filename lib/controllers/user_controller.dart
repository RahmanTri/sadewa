import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import 'package:sadewa_fe/services/api_service.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController {
  final ApiService _apiService = ApiService();
  final ImagePicker _picker = ImagePicker();
  var user = Rxn<User>();
  var userToken = ''.obs;
  var isLoading = false.obs;
  var isEditing = false.obs;
  var selectedImagePath = ''.obs;

  var isAdmin = false.obs;


  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController divisionController = TextEditingController();

  void assignUserData(Map<String, dynamic> userData) {
    isLoading.value = true;
    user.value = User.fromJson(userData);

    // Get.snackbar('Berhasil Cok', user.value?.dataWajah.toString() ?? '');

    isLoading.value = false;
  }

  // void updateUserData(Map<String, dynamic> rawjson) {
  //   Map<String, dynamic> userData = {
  //     //User
  //     'user_id' : rawjson['user']['new']['id'],
  //     'username' : rawjson['user']['new']['username'],
  //     'email' : rawjson['user']['new']['email'],
  //     'role' : rawjson['user']['new']['role'],
  //     //employee
  //     'id_perusahaan' : rawjson['employee']['new']['company_id'],
  //     'id_divisi' : rawjson['employee']['new']['division_id'],
  //     'nama_divisi' : rawjson['employee']['new']['division_name'],
  //     'nama_lengkap' : rawjson['employee']['new']['name'],
  //     'no_telp' : rawjson['employee']['new']['phone_number'],
  //     'data_wajah' : rawjson['employee']['new']['face_data'],
  //     'foto_profil' :rawjson['employee']['new']['profile_pic'],
  //     'poin' :rawjson['employee']['new']['points'],
  //     'logged_in' :rawjson['employee']['new']['logged_in'],
  //     'logged_out' :rawjson['employee']['new']['logged_out'],
  //   }; 

  //   user.value = User.fromJson(userData);
  // }

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

//Upload into Database
 Future<void> uploadProfilePic(File imageFile) async {
  try {
  isLoading.value = true;

  var uri = Uri.parse('employee/profile/picture');
  var request = http.MultipartRequest('POST', uri);
  
  request.headers.addAll({
    'Authorization': 'Bearer ${userToken.value}',
    'Accept': 'application/json',
  });

  request.files.add(await http.MultipartFile.fromPath(
    'photo', 
    imageFile.path,
  ));

  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);

  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);

    if (user.value != null) {
      String newPhotoUrl = result['data']['photo_url'] ?? user.value!.fotoProfil;

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
        fotoProfil: newPhotoUrl,
        poin: user.value!.poin,
        loggedIn: user.value!.loggedIn,
        loggedOut: user.value!.loggedOut,
      );

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
}