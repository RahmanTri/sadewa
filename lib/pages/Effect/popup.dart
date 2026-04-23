import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/constants/sdw_sizes.dart';

class BaseDialog {
  static void show({
    required String title,
    required String message,
    required height,
    required width,
    String cancelText = "Batal",
    String confirmText = "Lanjut",
    IconData icon = Icons.notifications,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    Get.defaultDialog(
      content: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(color: const Color.fromRGBO(0, 0, 0, 0.5)),
        child: Stack(
          children: [
            Container(
              width: width * 0.5,
              height: height * 0.5,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: SDWcolors.primary,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(icon, color: SDWcolors.bgL),
            ),
            Container(
              width: width * 0.7,
              height: height * 0.3,
              decoration: BoxDecoration(
                color: SDWcolors.bgD,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(title),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: onCancel,
                        child: Container(
                          height: height * 0.02,
                          width: width * 0.4,
                          decoration: BoxDecoration(
                            color: SDWcolors.bgL,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            cancelText,
                            style: TextStyle(color: SDWcolors.primary),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: onConfirm,
                        child: Container(
                          height: height * 0.02,
                          width: width * 0.4,
                          decoration: BoxDecoration(
                            color: SDWcolors.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            confirmText,
                            style: TextStyle(color: SDWcolors.bgL),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
