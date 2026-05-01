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

  RecentAbsent({required this.width, required this.height});

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
              style: TextStyle(
                fontSize: SDWsizes.lg,
                fontWeight: FontWeight.bold,
                color: SDWcolors.textD,
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
                      Icon? iconData;

                      switch (status) {
                        case 'unabsent':
                          bgColor = SDWcolors.grey;
                          iconData = Icon(
                            FontAwesomeIcons.circleQuestion,
                            color: SDWcolors.white,
                            size: 25,
                          );
                        case 'on_time':
                          bgColor = SDWcolors.success;
                          iconData = Icon(
                            Icons.check_circle_outline,
                            color: SDWcolors.white,
                            size: 30,
                          );
                          break;
                        case 'late':
                          bgColor = SDWcolors.warning;
                          iconData = Icon(
                            Icons.warning_amber_outlined,
                            color: SDWcolors.white,
                            size: 30,
                          );
                          break;
                        case 'absent':
                          bgColor = SDWcolors.error;
                          iconData = Icon(
                            Icons.cancel_outlined,
                            color: SDWcolors.white,
                            size: 30,
                          );
                          break;
                        case 'day_off':
                          bgColor = SDWcolors.grey;
                          iconData = Icon(
                            FontAwesomeIcons.bed,
                            color: SDWcolors.white,
                            size: 17,
                          );
                          break;
                      }
                      return Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Column(
                          children: [
                            Container(
                              height: height * 0.04,
                              width: width * 0.09,
                              decoration: BoxDecoration(
                                color: bgColor,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: SDWcolors.bgL,
                                  width: 5,
                                ),
                              ),
                              child: iconData,
                            ),
                            Text(
                              hari,
                              style: TextStyle(
                                color: SDWcolors.textD,
                                fontWeight: FontWeight.bold,
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
