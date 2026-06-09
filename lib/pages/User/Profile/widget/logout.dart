import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/controllers/user_controller.dart';
import 'package:sadewa_fe/pages/Effect/box_shadow.dart';

void logoutDialog(BuildContext context) {
  final UserController userController = Get.find<UserController>();
  Get.dialog(
    Dialog(
      backgroundColor: SDWcolors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40),
      child: Stack(
        alignment: Alignment.topRight,
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 50, 24, 20),
            decoration: BoxDecoration(
              color: SDWcolors.bgD,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [SDWboxShadow.shadow],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Konfirmasi Logout?',
                  style: TextStyle(
                    color: SDWcolors.textD,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),

                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 30,
                        child: TextButton(
                          onPressed: () => Get.back(),
                          style: TextButton.styleFrom(
                            backgroundColor: SDWcolors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            side: const BorderSide(
                              color: SDWcolors.primary,
                              width: 1,
                            ),
                          ),
                          child: const Text(
                            'Batal',
                            style: TextStyle(
                              color: SDWcolors.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    Expanded(
                      child: SizedBox(
                        height: 30,
                        child: ElevatedButton(
                          onPressed: () {
                            userController.logOutCurrentUser();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: SDWcolors.primary,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            'Lanjut',
                            style: TextStyle(
                              color: SDWcolors.textL,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: -25,
            left: 120,
            child: Container(
              width: 70,
              decoration: BoxDecoration(
                color: SDWcolors.primary,
                shape: BoxShape.circle,
                border: Border.all(color: SDWcolors.white),
                boxShadow: [SDWboxShadow.shadow],
              ),
              child: const Icon(
                Icons.help_outline,
                color: SDWcolors.white,
                size: 52,
              ),
            ),
          ),
        ],
      ),
    ),
    barrierDismissible: true,
  );
}
