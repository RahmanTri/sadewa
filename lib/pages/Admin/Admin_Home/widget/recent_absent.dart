import 'package:flutter/material.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/pages/Effect/box_shadow.dart';

class RecentAbsent extends StatelessWidget {
  final double width;
  final double height;
  RecentAbsent({required this.width, required this.height});
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SizedBox(
        width: width,
        height: height * 0.3,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Monitor Absensi",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Row(
                children: [
                  SizedBox(
                    height: height,
                    width: width * 0.467,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "Absen Masuk",
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w300),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: BouncingScrollPhysics(),
                            itemCount: homeController.absenMasuk.length,
                            itemBuilder: (context, index) {
                              final item = homeController.absenMasuk[index];
                              return Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: SizedBox(
                                      width: width * 0.46,
                                      height: height * 0.05,
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              height: height,
                                              width: width,
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: SDWcolors.bgL,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                boxShadow: [
                                                  SDWboxShadow.shadow,
                                                ],
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: height * 0.027,
                                                    width: width * 0.25,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        item.namaLengkap,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium
                                                            ?.copyWith(
                                                              fontSize:
                                                                  height *
                                                                  0.013,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      item.divisi,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall
                                                          ?.copyWith(
                                                            fontSize:
                                                                height * 0.01,
                                                            color: SDWcolors
                                                                .primary,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              height: height,
                                              width: width * 0.23,
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: SDWcolors.primary,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    item.waktuMasuk,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall
                                                        ?.copyWith(
                                                          color:
                                                              SDWcolors.white,
                                                          fontSize:
                                                              height * 0.013,
                                                        ),
                                                  ),

                                                  Text(
                                                    item.status,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium
                                                        ?.copyWith(
                                                          color:
                                                              SDWcolors.success,
                                                          fontSize:
                                                              height * 0.015,
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
                                  SizedBox(height: height * 0.005),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: height,
                      width: width * 0.01,
                      color: SDWcolors.essentialD,
                    ),
                  ),
                  SizedBox(
                    height: height,
                    width: width * 0.467,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "Absen Keluar",
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w300),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: BouncingScrollPhysics(),
                            itemCount: homeController.absenKeluar.length,
                            itemBuilder: (context, index) {
                              final item = homeController.absenKeluar[index];
                              return Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: SizedBox(
                                      width: width * 0.46,
                                      height: height * 0.05,
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              height: height,
                                              width: width,
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: SDWcolors.bgL,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                boxShadow: [
                                                  SDWboxShadow.shadow,
                                                ],
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: height * 0.027,
                                                    width: width * 0.25,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        item.namaLengkap,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium
                                                            ?.copyWith(
                                                              fontSize:
                                                                  height *
                                                                  0.013,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      item.divisi,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall
                                                          ?.copyWith(
                                                            fontSize:
                                                                height * 0.01,
                                                            color: SDWcolors
                                                                .primary,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              height: height,
                                              width: width * 0.23,
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: SDWcolors.primary,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    item.waktuKeluar,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall
                                                        ?.copyWith(
                                                          color:
                                                              SDWcolors.white,
                                                          fontSize:
                                                              height * 0.013,
                                                        ),
                                                  ),

                                                  Text(
                                                    item.status,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium
                                                        ?.copyWith(
                                                          color:
                                                              SDWcolors.success,
                                                          fontSize:
                                                              height * 0.015,
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
                                  SizedBox(height: height * 0.005),
                                ],
                              );
                            },
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
      );
    });
  }
}
