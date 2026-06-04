import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';

class PasswordChangeSuccess extends StatelessWidget {
  const PasswordChangeSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 230),
                Image.asset(
                  'assets/icons/success.png',
                  width: 180,
                  height: 180,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Password Changed!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: SDWcolors.primary,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Your password has been\nchanged successfully.',
                  style: TextStyle(fontSize: 12, color: SDWcolors.grey),
                ),
                const SizedBox(height: 35),
                SizedBox(
                  width: 200,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SDWcolors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'DONE',
                      style: TextStyle(
                        color: SDWcolors.textL,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () => Get.toNamed('/home'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
