import 'package:flutter/material.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/constants/sdw_sizes.dart';
import 'package:sadewa_fe/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/pages/Effect/box_shadow.dart';
import 'package:sadewa_fe/routes/app_routes.dart';

class PointAbsent extends StatelessWidget {
  final double width;
  final double height;
  PointAbsent({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController(), permanent: false);
    return Obx(() {
      return Row(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.faceScan);
            },
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              height: height * 0.15,
              width: width * 0.59,
              decoration: BoxDecoration(
                color: SDWcolors.bgL,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: SDWcolors.essentialDR.withAlpha(50),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  homeController.absenIcons.value!,
                  Text(
                    homeController.absentText.value,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 1
                        ..color = SDWcolors.textD,
                      fontWeight: FontWeight.w900,
                      fontSize: height * 0.018,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    homeController.absenMessage.value,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: SDWcolors.textD,
                      fontWeight: FontWeight.normal,
                      fontSize: height * 0.01,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.myPoint);
            },
            child: Container(
              margin: const EdgeInsets.only(top: 20, left: 10),
              height: height * 0.15,
              width: width * 0.3,
              decoration: BoxDecoration(
                color: SDWcolors.bgL,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [SDWboxShadow.shadow],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Poin Saya",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: SDWcolors.textD,
                      fontWeight: FontWeight.w900,
                      fontSize: height * 0.018,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    homeController.userController.user.value?.poin.toString() ?? '',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: homeController.pointTextColor.value,
                      fontWeight: FontWeight.w900,
                      fontSize: height * 0.06,
                    ),
                  ),
                  Text(
                    homeController.pointMessage.value,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: SDWcolors.textD,
                      fontWeight: FontWeight.normal,
                      fontSize: height * 0.012,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "lihat benefit",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: SDWcolors.textD,
                      fontWeight: FontWeight.normal,
                      fontSize: height * 0.01,
                      decoration: TextDecoration.underline,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
