import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/controllers/home_controller.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/constants/sdw_sizes.dart';
import '../../Effect/box_shadow.dart';
import '../../Effect/SDWOverlay.dart';
import 'widget/header_page.dart';
import 'widget/activity_log.dart';
import 'widget/home_statistic.dart';
import 'widget/quick_action.dart';
import 'widget/recent_absent.dart';
import 'package:sadewa_fe/routes/app_routes.dart';

class AdminHomePage extends StatelessWidget {
  AdminHomePage({super.key});

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
              width: width * 0.94,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.04),
                  HeaderPage(height: height, width: width),
                  HomeStatistic(width: width, height: height),
                  QuickAction(width: width, height: height),
                  SizedBox(height: 20),
                  RecentAbsent(width: width, height: height),
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
            Align(alignment: Alignment.bottomCenter),
          ],
        ),
      );
    });
  }
}
