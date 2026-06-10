import 'package:flutter/material.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/constants/sdw_sizes.dart';
import 'package:sadewa_fe/pages/Effect/box_shadow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sadewa_fe/routes/app_routes.dart';
import 'package:sadewa_fe/pages/Effect/SDWOverlay.dart';
import 'package:sadewa_fe/controllers/home_controller.dart';
import 'package:get/get.dart';

class ButtomNavbar extends StatelessWidget {
  final double width;
  final double height;
  const ButtomNavbar({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    return SizedBox(
      width: width,
      height: height * 0.14,
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(width: width, height: height * 0.04),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    boxShadow: [SDWboxShadow.shadow],
                    color: SDWcolors.bgL,
                    border: Border(
                      top: BorderSide(width: 5, color: SDWcolors.textD),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.reload();
                        },
                        child: SizedBox(
                          width: width * 0.2,
                          height: height,
                          child: Column(
                            children: [
                              Container(
                                width: width * 0.12,
                                height: width * 0.12,
                                decoration: BoxDecoration(
                                  color: SDWcolors.primary.withAlpha(12),
                                ),
                                child: Icon(
                                  FontAwesomeIcons.houseChimney,
                                  color: SDWcolors.primary,
                                  size: width * 0.09,
                                ),
                              ),
                              Text(
                                "beranda",
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: SDWcolors.textD,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.myPoint);
                        },
                        child: SizedBox(
                          width: width * 0.2,
                          height: height,
                          child: Column(
                            children: [
                              Container(
                                width: width * 0.12,
                                height: width * 0.12,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: SDWcolors.primary.withAlpha(12),
                                ),
                                child: Image(
                                  image: AssetImage(
                                    'assets/icons/point_navbar.png',
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Text(
                                "point",
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: SDWcolors.textD,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(width: width * 0.15, height: height),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.notice);
                        },
                        child: SizedBox(
                          width: width * 0.2,
                          height: height,
                          child: Column(
                            children: [
                              Container(
                                width: width * 0.12,
                                height: width * 0.12,
                                decoration: BoxDecoration(
                                  color: SDWcolors.primary.withAlpha(12),
                                ),
                                child: Icon(
                                  FontAwesomeIcons.envelope,
                                  color: SDWcolors.primary,
                                  size: width * 0.09,
                                ),
                              ),
                              Text(
                                "pesan",
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: SDWcolors.textD,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.profile);
                        },
                        child: SizedBox(
                          width: width * 0.2,
                          height: height,
                          child: Column(
                            children: [
                              Container(
                                width: width * 0.12,
                                height: width * 0.12,
                                decoration: BoxDecoration(
                                  color: SDWcolors.primary.withAlpha(12),
                                ),
                                child: Icon(
                                  FontAwesomeIcons.userTie,
                                  color: SDWcolors.primary,
                                  size: width * 0.09,
                                ),
                              ),
                              Text(
                                "profil",
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: SDWcolors.textD,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: GestureDetector(
              onTap: () {
                if (homeController.userData.user.value?.loggedIn == true &&
                    homeController.userData.user.value?.loggedOut == true) {
                  SDWoverlay.showOverlay(
                    context: context,
                    title: "Anda Sudah Melakukan Absensi",
                    subtitle:
                        "Anda tidak dapat melakukan absensi 2x pada hari yang sama",
                    iconData: FontAwesomeIcons.check,
                    height: height,
                    width: width,
                    onConfirm: () {},
                  );
                } else {
                  Get.toNamed(Routes.faceScan);
                }
              },
              child: Column(
                children: [
                  Container(
                    width: width * 0.2,
                    height: width * 0.2,
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      color: SDWcolors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: SDWcolors.textD, width: 5),
                      boxShadow: [SDWboxShadow.shadow],
                    ),
                    child: Image(
                      image: AssetImage('assets/icons/face_scan.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Text(
                    "SCAN WAJAH",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: SDWcolors.textD,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
