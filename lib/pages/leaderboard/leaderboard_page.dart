import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/icons/heroicons.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/controllers/leaderboard_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LeaderboardPage extends StatelessWidget {
  LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final lbController = Get.put(LeaderboardController());
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Obx(() {
      return Scaffold(
        body: Stack(
          children: [
            Text(lbController.initial.value),
            Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [SDWcolors.primary, SDWcolors.bgL],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(height: height * 0.04, width: width),
                Container(
                  width: width,
                  height: height * 0.05,
                  padding: EdgeInsets.only(
                    left: width * 0.05,
                    right: width * 0.05,
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          FontAwesomeIcons.arrowLeft,
                          size: height * 0.03,
                          color: SDWcolors.textL,
                        ),
                      ),
                      Center(
                        child: Text(
                          "Peringkat Teratas",
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: SDWcolors.textL,
                                fontSize: width * 0.05,
                                letterSpacing: 5,
                              ),
                        ),
                      ),
                    ],
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
