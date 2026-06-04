import 'package:flutter_arc_text/flutter_arc_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/constants/urls.dart';
import 'package:sadewa_fe/controllers/leaderboard_controller.dart';
import '../../Effect/box_shadow.dart';
import 'widget/lb_header.dart';
import 'widget/lb_top3.dart';
import 'widget/lb_top20.dart';
import 'widget/lb_footer.dart';

class LeaderboardPage extends StatelessWidget {
  LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final lbController = Get.put(LeaderboardController(), permanent: false);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Obx(() {
      if (lbController.isLoading.value || lbController.leaderboard.isEmpty) {
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      return Scaffold(
        body: Stack(
          children: [
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
                HeaderPage(width: width, height: height),
                Top3Page(width: width, height: height),
                SizedBox(height: height * 0.04, width: width),
                Expanded(
                  child: Top20Page(width: width, height: height),
                ),
              ],
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: FooterPage(width: width, height: height),
            ),
          ],
        ),
      );
    });
  }
}
