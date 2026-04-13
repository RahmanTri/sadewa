import 'package:get/instance_manager.dart';
import 'package:sadewa_fe/controllers/auth_controller.dart';
import 'package:sadewa_fe/services/storage_service.dart'; 

class AppBinding extends Bindings {
  @override
  void dependencies() {
    //Get.put<blablabla>dst...
    Get.put<StorageService>(StorageService(), permanent: true);
    Get.put<AuthController>(AuthController(), permanent: true);
  }
}