import 'package:flutter/material.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/controllers/home_controller.dart';
import 'package:sadewa_fe/constants/urls.dart';
import 'package:sadewa_fe/pages/Effect/box_shadow.dart';
import 'package:sadewa_fe/routes/app_routes.dart';

class HeaderPage extends StatelessWidget {
  final double width;
  final double height;
  const HeaderPage({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController(), permanent: false);
    return Obx(
      () => Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            width: width * 0.892,
            height: height * 0.1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  homeController.greetingText.value,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: SDWcolors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: height * 0.022,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    homeController.userData.admin.value?.name ?? '',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: SDWcolors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: height * 0.04,
                    ),
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
