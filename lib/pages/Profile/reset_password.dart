import 'package:flutter/material.dart';
import 'package:sadewa_fe/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/pages/Profile/widget/change_password.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

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
                  const SizedBox(height: 87),
                  Image.asset(
                    'assets/icons/reset_password.png',
                    width: 130,
                    height: 130,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Create New Password',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: SDWcolors.primary,
                    ),
                  ),
                  const SizedBox(height: 25),

                  changePassword(
                    controller: userController.resetNewPassController,
                    label: 'New Password',
                    isObscure: userController.obscureNew,
                  ),
                  changePassword(
                    controller: userController.resetConfirmPassController,
                    label: 'Confirm Password',
                    isObscure: userController.obscureConfirm,
                  ),
                  const SizedBox(height: 30),

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
                            : () => userController.resetPassword(),
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
                                'RESET',
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
        ],
      ),
    );
  }
}
