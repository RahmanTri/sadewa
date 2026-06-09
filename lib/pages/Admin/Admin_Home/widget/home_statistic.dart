import 'package:flutter/material.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/constants/sdw_sizes.dart';
import 'package:sadewa_fe/controllers/home_controller.dart';
import 'package:sadewa_fe/controllers/karyawan_controller.dart';
import 'package:sadewa_fe/controllers/point_controller.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/pages/Effect/box_shadow.dart';
import 'package:sadewa_fe/routes/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeStatistic extends StatelessWidget {
  final double width;
  final double height;
  HomeStatistic({required this.width, required this.height});
  final homeController = Get.put(HomeController(), permanent: false);
  final karyawanController = Get.put(KaryawanController(), permanent: false);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          homeController.jumlahKaryawan.value.isEmpty
              ? Center(child: CircularProgressIndicator())
              : GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.karyawan);
                  },
                  child: Container(
                    height: width * 0.29,
                    width: width * 0.29,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: SDWcolors.bgL,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [SDWboxShadow.shadow],
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "Jumlah Karyawan",
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 1.5
                                    ..color = SDWcolors.textD,
                                  fontWeight: FontWeight.w900,
                                  fontSize: height * 0.0135,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: width,
                                height: height * 0.07,
                                child: Center(
                                  child: Text(
                                    homeController.jumlahKaryawan.toString(),
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(
                                          color: SDWcolors.primary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: height * 0.06,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Text("lihat detail"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

          homeController.jumlahDivisi.value.isEmpty
              ? Center(child: CircularProgressIndicator())
              : GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.divisi);
                  },
                  child: Container(
                    height: width * 0.29,
                    width: width * 0.29,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: SDWcolors.bgL,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [SDWboxShadow.shadow],
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "Jumlah Divisi",
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 1.5
                                    ..color = SDWcolors.textD,
                                  fontWeight: FontWeight.w900,
                                  fontSize: height * 0.0135,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(height: height * 0.015, width: width),
                              SizedBox(
                                width: width,
                                height: height * 0.07,
                                child: Center(
                                  child: Text(
                                    homeController.jumlahDivisi.toString(),
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(
                                          color: SDWcolors.primary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: height * 0.06,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Text("lihat detail"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

          homeController.underPoint.value.isEmpty
              ? Center(child: CircularProgressIndicator())
              : GestureDetector(
                  onTap: () {
                    karyawanController.getUnderPoint();
                    Get.toNamed(Routes.underPoint);
                  },
                  child: Container(
                    height: width * 0.29,
                    width: width * 0.29,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: SDWcolors.bgL,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [SDWboxShadow.shadow],
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "Under Point",
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 1.5
                                    ..color = SDWcolors.textD,
                                  fontWeight: FontWeight.w900,
                                  fontSize: height * 0.0135,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        Align(
                          alignment: AlignmentGeometry.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(height: height * 0.015, width: width),
                              SizedBox(
                                width: width,
                                height: height * 0.07,
                                child: Center(
                                  child: Text(
                                    homeController.underPoint.toString(),
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: height * 0.06,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Text("lihat detail"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      );
    });
  }
}
