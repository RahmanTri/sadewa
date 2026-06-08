import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/controllers/home_controller.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/constants/sdw_sizes.dart';
import 'package:sadewa_fe/controllers/notice_controller.dart';
import '../../Effect/box_shadow.dart';
import '../../Effect/SDWOverlay.dart';
import 'widget/header_page.dart';
import 'widget/activity_log.dart';
import 'widget/point_n_absent.dart';
import 'widget/quick_action.dart';
import 'widget/recent_absent.dart';
import 'widget/buttom_navbar.dart';
import 'package:sadewa_fe/routes/app_routes.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final homeController = Get.put(HomeController(), permanent: false);

    return Obx(() {
      if (homeController.isLoading.value) {
        return Scaffold(
          body: Center(
            child: Container(
              decoration: BoxDecoration(
                color: SDWcolors.bgD,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: CircularProgressIndicator(),
            ),
          ),
        );
      }

      if (homeController.userData.user.value?.dataWajah == null ||
          homeController.userData.user.value!.dataWajah.isEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Sdwoverlay.showOverlay(
            context: context,
            title: 'Data Wajah Kosong, Silahkan Registrasi Wajah Anda Dahulu!',
            iconData: FontAwesomeIcons.userXmark,
            height: height,
            width: width,
            onCancel: () {
              Get.offAllNamed(Routes.login);
            },
            onConfirm: () {
              Get.offAllNamed(Routes.faceScan);
            },
          );
        });
      }

      return Scaffold(
        backgroundColor: SDWcolors.bgD,
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            // Background Oren
            Container(
              height: height * 0.4,
              decoration: BoxDecoration(
                color: SDWcolors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),

            // Content
            SizedBox(
              height: height,
              width: width * 0.92,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.04),
                  HeaderPage(height: height, width: width),
                  PointAbsent(width: width, height: height),
                  QuickAction(width: width, height: height),
                  RecentAbsent(width: width, height: height),
                  // Log History
                  SizedBox(height: 20),
                  Text(
                    "Log Aktivitas",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: SDWsizes.lg,
                      color: SDWcolors.textD,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 10),
                  ActivityLog(width: width, height: height),
                ],
              ),
            ),

            // Navbar
            Align(
              alignment: Alignment.bottomCenter,
              child: ButtomNavbar(height: height, width: width),
            ),
          ],
        ),
      );
    });
  }
}
