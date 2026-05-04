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
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: SDWcolors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: height * 0.022,
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
                    homeController.userData.user.value?.namaLengkap ?? 'User',
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
          GestureDetector(
            onTap: () => Get.toNamed(Routes.profile),
            child: Container(
              width: width * 0.22,
              height: width * 0.22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [SDWboxShadow.shadow],
                image: DecorationImage(
                  image: const AssetImage(
                    '${AppUrls.imgAssets}default-profile.png',
                  ),
                ),
                border: Border.all(color: SDWcolors.bgL, width: 3, strokeAlign: BorderSide.strokeAlignInside),
              ),
              child:
                  homeController.userData.user.value?.fotoProfil != '' &&
                      homeController.userData.user.value?.fotoProfil != null &&
                      homeController.userData.user.value?.fotoProfil != 'null'
                  ? Container(
                    height: width * 0.22,
                    width: width * 0.22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          '${AppUrls.imgProfileUrl}${homeController.userData.user.value?.fotoProfil}',
                        ),
                      ),
                    ),
                  )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
