import 'package:get/get.dart';
import '../models/user_model.dart';
import '../models/admin_model.dart';

class UserController extends GetxController {
  var user = Rxn<User>();
  var admin = Rxn<Admin>();

  var isAdmin = false.obs;

  var userToken = ''.obs;
  var isLoading = false.obs;

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
}
