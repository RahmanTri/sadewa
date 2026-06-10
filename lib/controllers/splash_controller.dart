import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/pages/Splash/widget/splash_dialog.dart';

class SplashController extends GetxController {
  static const platform = MethodChannel('mock_location_channel');
  static late bool isMockLocationEnabled;

  Future<void> checkMockLocation() async {
    try {
      final bool result = await platform.invokeMethod('isMockLocation');
      isMockLocationEnabled = result;
    } on PlatformException catch (e) {
      Get.snackbar('Error', e.toString());
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
}
