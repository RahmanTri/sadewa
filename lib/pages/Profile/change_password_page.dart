import 'package:flutter/material.dart';
import 'package:sadewa_fe/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/pages/Profile/widget/change_password.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();

    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 95),
                  Image.asset(
                    'assets/icons/change_password.png',
                    width: 130,
                    height: 150,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Change Password',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: SDWcolors.primary,
                    ),
                  ),
                  const SizedBox(height: 43),

                  changePassword(
                    controller: userController.oldPassController,
                    label: 'Old Password',
                    isObscure: userController.obscureOld,
                  ),
                  changePassword(
                    controller: userController.newPassController,
                    label: 'New Password',
                    isObscure: userController.obscureNew,
                  ),
                  changePassword(
                    controller: userController.confirmPassController,
                    label: 'Confirm Password',
                    isObscure: userController.obscureConfirm,
                  ),
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: TextButton(
                  //     onPressed: () => Get.toNamed('/forgotPassword'), 
                  //     child: const Text(
                  //       'Forgot Password?',
                  //       style: TextStyle(
                  //         color: SDWcolors.primary,
                  //         fontSize: 13,
                  //         fontWeight: FontWeight.w600
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 20),

                  Obx(
                    () => SizedBox(
                      width: 220,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: SDWcolors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onPressed: userController.isLoading.value
                            ? null
                            : () => userController.changePassword(),
                        child: userController.isLoading.value
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: SDWcolors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'SIMPAN',
                                style: TextStyle(
                                  color: SDWcolors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 15,
            child: IconButton(
              onPressed: Get.back,
              icon: const Icon(Icons.arrow_back, color: SDWcolors.primary),
              iconSize: 25,
            ),
          ),
        ],
      ),
    );
  }
}
