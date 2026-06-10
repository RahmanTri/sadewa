import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/controllers/auth_controller.dart';
import 'package:sadewa_fe/pages/Splash/widget/splash_dialog.dart';
import 'package:sadewa_fe/routes/app_routes.dart';
import 'package:sadewa_fe/services/storage_service.dart';

class SplashController extends GetxController {
  static const platform = MethodChannel('mock_location_channel');
  static late bool isMockLocationEnabled;
  final AuthController authController = Get.find<AuthController>();
  final StorageService _storageService = Get.find<StorageService>();

  Future<bool> checkMockLocation() async {
    try {
      final bool result = await platform.invokeMethod('isMockLocation');
      return result;
    } on Error {
      return false;
    }
  }

  Future<bool> checkMockLocation2() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      } else if (permission == LocationPermission.deniedForever) {
        return false;
      }
    }

    final location = await Geolocator.getCurrentPosition();

    if (location.isMocked) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> checkIsLoacationMocked() async {
    final test1 = await checkMockLocation();
    // Get.snackbar('Hasil Test 1', test1.toString());
    final test2 = await checkMockLocation2();
    // Get.snackbar('Hasil Test 2', test2.toString());

    if (test1 || test2) {
      showDialog(message: 'Penggunaan lokasi palsu terdeteksi');
    } else {
      // await Future.delayed(const Duration(seconds: 3));
      final rememberMeSaved = await _storageService.getRemember() ?? false;
      // Get.snackbar('Remember Me Tersimpan', 'Remember Me: $rememberMeSaved');
      if (rememberMeSaved) {
        final tryAutoLog = await authController.loadRememberMe();
        if (!tryAutoLog) {
          Get.offAllNamed(Routes.login);
        }
      } else {
        Get.offAllNamed(Routes.login);
      }
    }
  }

  void showDialog({
    String message = '',
    VoidCallback? runFunction,
    String goTo = '',
  }) {
    final height = Get.height;
    final width = Get.width;
    Get.dialog(
      SplashDialog(message: message, height: height, width: width, goTo: goTo),
    );
  }

  Future<void> checkLocationPermission() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        SystemNavigator.pop();
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
    checkLocationPermission();
    checkIsLoacationMocked();
  }
}
