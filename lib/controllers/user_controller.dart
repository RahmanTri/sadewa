import 'package:get/get.dart';
import '../models/user_model.dart';

class UserController extends GetxController {
  var user = Rxn<User>();
  var userToken = ''.obs;
  var isLoading = false.obs;


  void assignUserData(Map<String, dynamic> userData) {
    isLoading.value = true;
    user.value = User.fromJson(userData);

    // Get.snackbar('Berhasil Cok', user.value?.dataWajah.toString() ?? '');

    isLoading.value = false;
  }

  void setUserToken(String token) {
    userToken.value = token;
  }
}