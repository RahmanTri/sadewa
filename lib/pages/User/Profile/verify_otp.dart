import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/controllers/user_controller.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/pages/User/Profile/widget/otp_box.dart';

class VerifyOtp extends StatelessWidget {
  const VerifyOtp({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 70),
            Center(
              child: Image.asset(
                'assets/icons/verify_otp.png',
                width: 180,
                height: 180,
              ),
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Check your email',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: SDWcolors.primary,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    height: 2.3,
                    color: SDWcolors.grey,
                  ),
                  children: [
                    const TextSpan(text: 'We sent a verification code to '),
                    TextSpan(
                      text: userController.visibleEmail.value,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(
                      text:
                          '. \nPlease enter 4 digit code that mentioned in your email.',
                      style: TextStyle(height: 1.6),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                otpBox(
                  context,
                  userController.otp1Controller,
                  userController.fn1,
                  userController.fn2,
                  null,
                ),
                otpBox(
                  context,
                  userController.otp2Controller,
                  userController.fn2,
                  userController.fn3,
                  userController.fn1,
                ),
                otpBox(
                  context,
                  userController.otp3Controller,
                  userController.fn3,
                  userController.fn4,
                  userController.fn2,
                ),
                otpBox(
                  context,
                  userController.otp4Controller,
                  userController.fn4,
                  null,
                  userController.fn3,
                ),
              ],
            ),
            const SizedBox(height: 40),

            Obx(
              () => SizedBox(
                width: 220,
                height: 50,
                child: ElevatedButton(
                  onPressed: userController.isLoading.value
                      ? null
                      : () =>userController.verifyOtp(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: SDWcolors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 0,
                  ),
                  child: userController.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'VERIFY',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Obx(() => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Not received the code? ',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: SDWcolors.grey,
                      ),
                    ),
                    if (userController.isButtonDisabled.value)
                  Text(
                      'Resend code in ${userController.formattedTime}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: SDWcolors.primary,
                      ),
                    )
                    else
                    TextButton(
                      onPressed: (userController.isButtonDisabled.value || userController.isLoading.value)
                      ? null
                      : () => userController.resendOtp(),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0,0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap
                      ),
                      child: const Text(
                        'Resend',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: SDWcolors.primary
                        ),
                      ),
                    )
                  ],
                ),
                
              ],
            ))
          ],
        ),
      ),
    );
  }
}
