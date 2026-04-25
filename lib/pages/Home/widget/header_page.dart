import 'package:flutter/material.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/constants/sdw_sizes.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/controllers/home_controller.dart';
import 'package:sadewa_fe/constants/urls.dart';

class HeaderPage extends StatelessWidget {
  final double width;
  final double height;
  HeaderPage({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    return Obx(
      () => Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            width: width * 0.65,
            height: height * 0.1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  homeController.greetingText.value,
                  style: TextStyle(
                    fontSize: SDWsizes.lg,
                    fontWeight: FontWeight.normal,
                    color: SDWcolors.white,
                  ),
                ),

                // SizedBox(
                //   height: 50,
                //   child: Marquee(
                //     text: "Suwito",
                //     style: TextStyle(
                //       fontSize: SDWsizes.xl,
                //       fontWeight: FontWeight.bold,
                //       color: SDWcolors.white,
                //     ),
                //     scrollAxis: Axis.horizontal,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     blankSpace: 20.0,
                //     velocity: 30.0,
                //     pauseAfterRound: Duration(seconds: 2),
                //   ),
                // ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    homeController.userData.user.value?.namaLengkap ?? '',
                    style: TextStyle(
                      fontSize: SDWsizes.xl,
                      fontWeight: FontWeight.bold,
                      color: SDWcolors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: width * 0.22,
            height: height * 0.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: SDWcolors.essentialDR.withAlpha(50),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                ),
              ],
              image: DecorationImage(
                image: NetworkImage(
                  '${AppUrls.imgProfileUrl}${homeController.userData.user.value?.fotoProfil ?? ''}',
                ),
              ),
              border: Border.all(color: SDWcolors.bgL, width: 3),
            ),
          ),
        ],
      ),
    );
  }
}
