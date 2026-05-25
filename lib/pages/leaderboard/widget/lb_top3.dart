import 'package:flutter_arc_text/flutter_arc_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/constants/urls.dart';
import 'package:sadewa_fe/controllers/leaderboard_controller.dart';
import '../../Effect/box_shadow.dart';

class Top3Page extends StatelessWidget {
  final double width;
  final double height;

  Top3Page({required this.width, required this.height});
  final lbController = Get.put(LeaderboardController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SizedBox(
        width: width,
        height: height * 0.27,
        child: Stack(
          children: [
            Row(
              children: [
                SizedBox(height: height, width: width * 0.05),
                SizedBox(
                  height: height,
                  width: width * 0.24,
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.135),
                      Container(
                        width: width * 0.25,
                        height: width * 0.25,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                              '${AppUrls.imgAssets}default-profile.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: lbController.leaderboard[1].profilePict != ''
                            ? Container(
                                height: width,
                                width: width,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.amberAccent,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      '${AppUrls.imgProfileUrl}${lbController.leaderboard[1].profilePict}',
                                    ),
                                  ),
                                ),
                              )
                            : null,
                      ),
                      Expanded(child: SizedBox()),
                    ],
                  ),
                ),
                SizedBox(height: height, width: width * 0.06),
                SizedBox(
                  height: height,
                  width: width * 0.3,
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.062),
                      Container(
                        width: width * 0.3,
                        height: width * 0.3,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                              '${AppUrls.imgAssets}default-profile.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: lbController.leaderboard[0].profilePict != ''
                            ? Container(
                                height: width,
                                width: width,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.amberAccent,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      '${AppUrls.imgProfileUrl}${lbController.leaderboard[0].profilePict}',
                                    ),
                                  ),
                                ),
                              )
                            : null,
                      ),
                      Expanded(child: SizedBox()),
                    ],
                  ),
                ),

                SizedBox(height: height, width: width * 0.06),
                SizedBox(
                  height: height,
                  width: width * 0.24,
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.152),

                      Container(
                        width: width * 0.25,
                        height: width * 0.25,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                              '${AppUrls.imgAssets}default-profile.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: lbController.leaderboard[2].profilePict != ''
                            ? Container(
                                height: width,
                                width: width,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.amberAccent,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      '${AppUrls.imgProfileUrl}${lbController.leaderboard[2].profilePict}',
                                    ),
                                  ),
                                ),
                              )
                            : null,
                      ),
                      Expanded(child: SizedBox()),
                    ],
                  ),
                ),
                SizedBox(height: height, width: width * 0.05),
              ],
            ),
            Center(
              child: Container(
                width: width * 0.9,
                height: height * 0.3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/leaderboard-border.png"),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(height: height, width: width * 0.05),
                SizedBox(
                  height: height,
                  width: width * 0.24,
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.1355),
                      Container(
                        width: width * 0.25,
                        height: width * 0.25,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: ArcText(
                          radius: 70,
                          startAngle: -3.1,
                          startAngleAlignment: StartAngleAlignment.center,
                          text: lbController.leaderboard[1].namaLengkap
                              .split(" ")
                              .take(2)
                              .join(" "),
                          textStyle: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.03,
                              ),
                          direction: Direction.counterClockwise,
                          placement: Placement.outside,
                        ),
                      ),
                      Expanded(child: SizedBox()),
                    ],
                  ),
                ),
                SizedBox(height: height, width: width * 0.06),
                SizedBox(
                  height: height,
                  width: width * 0.3,
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.065),
                      Container(
                        width: width * 0.3,
                        height: width * 0.3,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: ArcText(
                          radius: 90,
                          startAngle: -3.1,
                          startAngleAlignment: StartAngleAlignment.center,
                          text: lbController.leaderboard[0].namaLengkap
                              .split(" ")
                              .take(2)
                              .join(" "),
                          textStyle: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.03,
                              ),
                          direction: Direction.counterClockwise,
                          placement: Placement.outside,
                        ),
                      ),
                      Expanded(child: SizedBox()),
                    ],
                  ),
                ),

                SizedBox(height: height, width: width * 0.06),
                SizedBox(
                  height: height,
                  width: width * 0.24,
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.1525),

                      Container(
                        width: width * 0.25,
                        height: width * 0.25,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: ArcText(
                          radius: 70,
                          startAngle: -3.3,
                          startAngleAlignment: StartAngleAlignment.center,
                          text: lbController.leaderboard[2].namaLengkap
                              .split(" ")
                              .take(2)
                              .join(" "),
                          textStyle: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.03,
                              ),
                          direction: Direction.counterClockwise,
                          placement: Placement.outside,
                        ),
                      ),
                      Expanded(child: SizedBox()),
                    ],
                  ),
                ),
                SizedBox(height: height, width: width * 0.05),
              ],
            ),
          ],
        ),
      );
    });
  }
}
