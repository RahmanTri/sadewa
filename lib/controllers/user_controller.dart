import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/controllers/auth_controller.dart';
import 'dart:async';
import 'package:sadewa_fe/models/admin_model.dart';
import 'package:sadewa_fe/pages/User/Profile/changepw_succes.dart';
import 'package:sadewa_fe/routes/app_routes.dart';
import 'package:sadewa_fe/services/storage_service.dart';
import '../models/user_model.dart';
import 'package:sadewa_fe/services/api_service.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:sadewa_fe/constants/urls.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/controllers/home_controller.dart';

class UserController extends GetxController {
  final ApiService _apiService = ApiService();
  final ImagePicker _picker = ImagePicker();
  final StorageService _storageService = StorageService();
  final String baseApiUrl = AppUrls.baseApiUrl;
  final String imgProfileUrl = AppUrls.imgProfileUrl;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController divisionController = TextEditingController();

  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();
  final confirmPassController = TextEditingController();

  final forgotEmailController = TextEditingController();
  var visibleEmail = ''.obs;
  final otpController = TextEditingController();
  final resetNewPassController = TextEditingController();
  final resetConfirmPassController = TextEditingController();

  final otp1Controller = TextEditingController();
  final otp2Controller = TextEditingController();
  final otp3Controller = TextEditingController();
  final otp4Controller = TextEditingController();

  final fn1 = FocusNode();
  final fn2 = FocusNode();
  final fn3 = FocusNode();
  final fn4 = FocusNode();

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

  var isEditMode = false.obs;

  Timer? _timer;
  var remainingTime = 120.obs;
  var isButtonDisabled = true.obs;

  // To fusion 4 number into 1 string OTP
  String get combinedOtp =>
      otp1Controller.text +
      otp2Controller.text +
      otp3Controller.text +
      otp4Controller.text;

  void assignUserData(Map<String, dynamic> userData) {
    isLoading.value = true;
    if (userData['role'] == 'admin') {
      admin.value = Admin.fromJson(userData);
      isAdmin.value = true;
    } else {
      user.value = User.fromJson(userData);
    }
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

  @override
  void dispose() {
    isEditMode.value = false;
    super.dispose();
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

    if (userData.isEmpty) {
      isLoading.value = false;
      return;
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
      isEditing.value = false;
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 50,
      );

      if (pickedFile != null) {
        selectedImagePath.value = pickedFile.path;

        if (Get.isBottomSheetOpen ?? false) {
          Get.back();
        }
        await Future.delayed(const Duration(milliseconds: 200));

        await cropImage(pickedFile.path);
      }
    } catch (e) {
      print(e);
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

      request.files.add(
        await http.MultipartFile.fromPath('profile_pic', imageFile.path),
      );

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
      }
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> cropImage(String filePath) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: filePath,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 90,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Photo',
          toolbarColor: SDWcolors.primary,
          toolbarWidgetColor: SDWcolors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
          aspectRatioPresets: [CropAspectRatioPreset.square],
        ),
        IOSUiSettings(
          title: 'Crop Photo',
          aspectRatioLockEnabled: true,
          aspectRatioPresets: [CropAspectRatioPreset.square],
        ),
      ],
    );

    if (croppedFile != null) {
      selectedImagePath.value = croppedFile.path;

      uploadProfilePic(File(croppedFile.path));
    }
  }

  Future<void> deleteProfilePic() async {
    try {
      isLoading.value = true;

      var url = Uri.parse('$baseApiUrl/employee/clear-profile');
      var response = await http.post(
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
      }
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changePassword() async {
    if (oldPassController.text.isEmpty ||
        newPassController.text.isEmpty ||
        confirmPassController.text.isEmpty) {
      Get.snackbar('Peringatan!', 'Semua kolom wajib diisi!');
      return;
    }
    if (newPassController.text == oldPassController.text) {
      Get.snackbar(
        'Error!',
        'Password baru tidak boleh sama dengan password lama',
      );
      return;
    }
    if (newPassController.text != confirmPassController.text) {
      Get.snackbar(
        'Gagal',
        'Password baru dan konfirmasi password tidak cocok',
      );
      return;
    }

    try {
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
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  void emailVisible() {
    if (GetUtils.isEmail(forgotEmailController.text)) {
      final email = forgotEmailController.text;

      final trimEmail = email.substring(0, (email.length - 10));
      final visible = trimEmail.substring(0, 4);
      final replacement = ('*' * (trimEmail.length - 4));

      final combined = '$visible$replacement@gmail.com';

      visibleEmail.value = combined;
    }
  }

  Future<void> sendOtp(String email) async {
    if (forgotEmailController.text.trim().isEmpty) {
      Get.snackbar('Peringatan!', 'Email harus diisi!');
      return;
    }
    if (!GetUtils.isEmail(forgotEmailController.text)) {
      Get.snackbar('Peringatan!', 'Email tidak valid!');
      return;
    }
    try {
      isLoading.value = true;

      await _apiService.postRequest<Map<String, dynamic>>(
        endpoint: 'employee/send-otp',
        data: {'email': forgotEmailController.text},
        parser: (body) => json.decode(body),
        onError: (resp) => 'Gagal: ${resp.statusCode}',
      );

      Get.snackbar('Berhasil', 'Kode OTP berhasil dikirim');

      startTimer();

      Get.offAllNamed('/verifyOtp');
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtp() async {
    String otp = combinedOtp.trim();

    otpController.text = otp;

    if (otpController.text.isEmpty) {
      Get.snackbar('Error', 'Kode OTP harus diisi');
      return;
    }
    if (otpController.text.length != 4) {
      Get.snackbar('Peringatan!', 'Kode OTP harus terdiri dari 4 angka');
      return;
    }
    try {
      isLoading.value = true;

      await _apiService.postRequest<Map<String, dynamic>>(
        endpoint: 'employee/verify-otp',
        data: {'email': forgotEmailController.text, 'otp': otpController.text},
        parser: (body) => json.decode(body),
        onError: (resp) => 'Gagal: ${resp.statusCode}',
      );

      Get.snackbar('Berhasil', 'Kode OTP berhasil diverifikasi');

      otp1Controller.clear();
      otp2Controller.clear();
      otp3Controller.clear();
      otp4Controller.clear();

      otpController.clear();

      Get.offAllNamed('/resetPassword');
    } catch (e) {
      Get.snackbar('Error', 'Kode OTP salah atau kadaluarsa');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetPassword() async {
    if (resetNewPassController.text.isEmpty ||
        resetConfirmPassController.text.isEmpty) {
      Get.snackbar('Peringatan!', 'Semua kolom wajib diisi');
      return;
    }
    if (resetNewPassController.text != resetConfirmPassController.text) {
      Get.snackbar('Error', 'Konfirmasi password tidak cocok');
      return;
    }
    try {
      isLoading.value = true;

      await _apiService.postRequest<Map<String, dynamic>>(
        endpoint: 'employee/verify-pw',
        data: {
          'email': forgotEmailController.text,
          'password': resetNewPassController.text,
        },
        parser: (body) => json.decode(body),
        onError: (resp) => 'Gagal: ${resp.statusCode}',
      );

      Get.snackbar(
        'Berhasil',
        'Password Anda telah diperbarui, silahkan login kembali',
      );

      forgotEmailController.clear();
      otpController.clear();
      resetNewPassController.clear();
      resetConfirmPassController.clear();

      Get.offAllNamed('/login');
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  void startTimer() {
    remainingTime.value = 120;
    isButtonDisabled.value = true;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        isButtonDisabled.value = false;
        _timer?.cancel();
      }
    });
  }

  /// Convert into minuttes:seconds format
  String get formattedTime {
    int minutes = remainingTime.value ~/ 60;
    int seconds = remainingTime.value % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  Future<void> resendOtp() async {
    try {
      isLoading.value = true;

      await _apiService.postRequest<Map<String, dynamic>>(
        endpoint: 'employee/send-otp',
        data: {'email': forgotEmailController.text},
        parser: (body) => json.decode(body),
        onError: (resp) => 'Gagal: ${resp.statusCode}',
      );

      Get.snackbar('Berhasil', 'Kode OTP berhasil dikirim ulang');

      startTimer();
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  void logOutCurrentUser() {
    print("logout dimulai");
    final AuthController authController = Get.find<AuthController>();
    Get.delete<HomeController>();
    user.value = null;
    admin.value = null;
    isAdmin.value = false;
    userToken.value = '';
    _storageService.logOut();
    Get.offAllNamed(Routes.login);
    authController.rememberMe.value = false;
    print("logout berhasil dijalankan");
  }

  Future<void> refreshUserData() async {
    print("fungsi refresh user di panggil");
    try {
      final result = await _apiService.getRequest<Map<String, dynamic>>(
        endpoint: 'user/fetch',
        parser: (body) => jsonDecode(body),
        onError: (resp) => 'Gagal memuat riwayat: ${resp.statusCode}',
        headers: {'Authorization': 'Bearer ${userToken.value}'},
      );
      final Map<String, dynamic> jsonData =
          result['refreshed_userData'] as Map<String, dynamic>;
      user.value = User.fromJson(jsonData);
      print("Berhasil Refresh data user");
    } catch (e) {
      print("Gagal Mendapatkan User Data: $e");
    }
  }
}
