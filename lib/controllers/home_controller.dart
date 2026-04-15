import 'package:get/get.dart';

class HomeController extends GetxController {
  late Map<String, dynamic> userData;

  @override
  void onInit() {
    super.onInit();
    userData = Get.arguments;
  }
}
