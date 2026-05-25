import 'package:flutter_arc_text/flutter_arc_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/constants/urls.dart';
import 'package:sadewa_fe/controllers/leaderboard_controller.dart';
import '../../Effect/box_shadow.dart';

class Top20Page extends StatelessWidget {
  final double width;
  final double height;
  final dataLenght = 20;

  Top20Page({required this.width, required this.height});
  final lbController = Get.put(LeaderboardController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        padding: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          color: SDWcolors.bgD,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(70),
            topRight: Radius.circular(70),
          ),
        ),
        child: Column(
          children: [
            Center(
              child: Text(
                "Peringkat 20 Karyawan Terbaik",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
            SizedBox(height: height * 0.015),
            Center(
              child: Text(
                "Bulan"
                " ${lbController.month}",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: width * 0.035,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1,
                ),
              ),
            ),
            SizedBox(height: height * 0.015),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.all(Radius.circular(75)),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: BouncingScrollPhysics(),
                  itemCount: 22,
                  itemBuilder: (context, index) {
                    final item = lbController.leaderboard[index];

                    if (index >= dataLenght) {
                      return SizedBox(height: height * 0.075, width: width);
                    }

                    return Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 15),
                        padding: EdgeInsets.only(top: 1, bottom: 1),
                        width: width * 0.9,
                        height: height * 0.075,
                        decoration: BoxDecoration(
                          color: SDWcolors.primary,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          boxShadow: [
                            BoxShadow(
                              color: SDWcolors.primary.withAlpha(100),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: height,
                                  width: width * 0.14,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      item.rank < 10
                                          ? "0${item.rank}"
                                          : "${item.rank}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.copyWith(
                                            color: SDWcolors.textL,
                                            fontSize: width * 0.06,
                                          ),
                                    ),
                                  ),
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      height: height,
                                      width: width * 0.13,
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
                                      child: item.profilePict != ''
                                          ? Container(
                                              height: width,
                                              width: width,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.amberAccent,
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    '${AppUrls.imgProfileUrl}${item.profilePict}',
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            )
                                          : null,
                                    ),
                                    Container(
                                      height: height,
                                      width: width * 0.13,
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
                                SizedBox(
                                  height: height,
                                  width: width * 0.45,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.namaLengkap
                                            .split(" ")
                                            .take(2)
                                            .join(" "),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              color: SDWcolors.textL,
                                              fontSize: height * 0.022,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      SizedBox(height: width * 0.01),
                                      Text(
                                        "Tepat Waktu :"
                                        " ${item.onTimePercent}"
                                        " | "
                                        "Telat :"
                                        " ${item.totalTelat} Hari",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: SDWcolors.textL,
                                              fontSize: height * 0.01,
                                              fontWeight: FontWeight.w300,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: AlignmentGeometry.centerRight,
                              child: Container(
                                height: height,
                                width: width * 0.23,
                                decoration: BoxDecoration(
                                  color: SDWcolors.bgL,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    item.totalPoin.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(color: SDWcolors.primary),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
