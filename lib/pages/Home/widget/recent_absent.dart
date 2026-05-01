import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/constants/sdw_sizes.dart';
import 'package:sadewa_fe/controllers/home_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final homeController = Get.put(HomeController());

class RecentAbsent extends StatelessWidget {
  final double width;
  final double height;

  const RecentAbsent({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final List<Map<String, dynamic>> latestLoginData =
          homeController.latestLoginData;
      return Container(
        height: height * 0.12,
        width: width,
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.all(10),
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Kehadiran Terkini",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: SDWcolors.textD,
                fontWeight: FontWeight.bold,
                fontSize: height * 0.024,
              ),
            ),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: height * 0.003,
                  width: width * 0.8,
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: SDWcolors.textD,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                SizedBox(
                  height: height * 0.06,
                  width: width * 0.8,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: latestLoginData.length,
                    itemBuilder: (context, index) {
                      final item = latestLoginData[index];
                      final status = item['status'];
                      final hari = item['hari'];
                      Color? bgColor;
                      IconData? iconData;

                      switch (status) {
                        case 'unabsent':
                          bgColor = SDWcolors.grey;
                          iconData = FontAwesomeIcons.circleQuestion;
                        case 'on_time':
                          bgColor = SDWcolors.success;
                          iconData = FontAwesomeIcons.circleCheck;
                          break;
                        case 'late':
                          bgColor = SDWcolors.warning;
                          iconData = FontAwesomeIcons.circleExclamation;
                          break;
                        case 'absent':
                          bgColor = SDWcolors.error;
                          iconData = FontAwesomeIcons.circleXmark;
                          break;
                        case 'day_off':
                          bgColor = SDWcolors.grey;
                          iconData = FontAwesomeIcons.calendarXmark;
                          break;
                      }
                      return Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Column(
                          children: [
                            Container(
                              height: height * 0.04,
                              width: height * 0.04,
                              decoration: BoxDecoration(
                                color: bgColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: SDWcolors.bgL,
                                  width: 5,
                                ),
                              ),
                              child: Icon(
                                iconData,
                                color: SDWcolors.white,
                                size: height * 0.022,
                              ),
                            ),
                            Text(
                              hari,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: SDWcolors.textD,
                                    fontWeight: FontWeight.bold,
                                    fontSize: height * 0.015,
                                  ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
