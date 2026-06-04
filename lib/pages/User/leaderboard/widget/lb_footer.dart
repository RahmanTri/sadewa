import 'package:flutter_arc_text/flutter_arc_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/constants/urls.dart';
import 'package:sadewa_fe/controllers/leaderboard_controller.dart';
import '../../../Effect/box_shadow.dart';

class FooterPage extends StatelessWidget {
  final double width;
  final double height;

  FooterPage({required this.width, required this.height});
  final lbController = Get.put(LeaderboardController(), permanent: false);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SizedBox(
        height: height * 0.15,
        width: width,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: height * 0.1,
                width: width,
                decoration: BoxDecoration(
                  color: SDWcolors.primary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  boxShadow: [SDWboxShadow.shadow],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: height * 0.11,
                width: width * 0.9,
                padding: EdgeInsets.only(
                  top: 12,
                  bottom: 12,
                  left: 20,
                  right: 10,
                ),
                decoration: BoxDecoration(
                  color: SDWcolors.bgL,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  boxShadow: [
                    BoxShadow(
                      color: SDWcolors.primary,
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, -1),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Peringkat Anda",
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  color: SDWcolors.textD,
                                  fontSize: width * 0.04,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  lbController.userLeaderboard.first.rank < 10
                                      ? "0${lbController.userLeaderboard.first.rank}"
                                      : "${lbController.userLeaderboard.first.rank}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        color: SDWcolors.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: width * 0.06,
                                      ),
                                ),
                              ),
                              SizedBox(width: width * 0.02),
                              Stack(
                                children: [
                                  Container(
                                    height: height,
                                    width: width * 0.14,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          '${AppUrls.imgAssets}default-profile.png',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: SDWcolors.essentialD,
                                        width: 8,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: SDWcolors.bgL.withAlpha(100),
                                          spreadRadius: 2,
                                          blurRadius: 20,
                                          offset: const Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                    child:
                                        lbController
                                                .userLeaderboard
                                                .first
                                                .profilePict !=
                                            ''
                                        ? Container(
                                            height: width,
                                            width: width,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.amberAccent,
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  '${AppUrls.imgProfileUrl}${lbController.userLeaderboard.first.profilePict}',
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )
                                        : null,
                                  ),
                                  Container(
                                    height: height,
                                    width: width * 0.14,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          'assets/images/leaderboard-profile.png',
                                        ),
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: width * 0.01),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      lbController
                                          .userLeaderboard
                                          .first
                                          .namaLengkap,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            color: SDWcolors.textD,
                                            fontSize: height * 0.022,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    SizedBox(height: width * 0.01),
                                    Text(
                                      "Tepat Waktu:"
                                      " ${lbController.userLeaderboard.first.onTimePercent}"
                                      " | "
                                      "Telat: "
                                      "${lbController.userLeaderboard.first.totalTelat} Hari",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: SDWcolors.textD,
                                            fontSize: height * 0.01,
                                            fontWeight: FontWeight.w300,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        height: height * 0.075,
                        width: width * 0.2,
                        decoration: BoxDecoration(
                          color: SDWcolors.primary,
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        child: Center(
                          child: Text(
                            lbController.userLeaderboard.first.totalPoin
                                .toString(),
                            style: Theme.of(context).textTheme.headlineLarge
                                ?.copyWith(
                                  color: SDWcolors.textL,
                                  shadows: [
                                    BoxShadow(
                                      color: SDWcolors.bgL.withAlpha(150),
                                      spreadRadius: 0,
                                      blurRadius: 50,
                                      offset: const Offset(0, 0),
                                    ),
                                  ],
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
