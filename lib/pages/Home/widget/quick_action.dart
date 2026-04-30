import 'package:flutter/material.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/constants/sdw_sizes.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/routes/app_routes.dart';
import 'package:sadewa_fe/controllers/notice_controller.dart';
import 'package:sadewa_fe/pages/Effect/SDWOverlay.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class QuickAction extends StatelessWidget {
  final double width;
  final double height;
  QuickAction({required this.width, required this.height});
  final noticeController = Get.put(NoticeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.22,
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: SDWcolors.bgL,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: SDWcolors.essentialDR.withAlpha(50),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Quick Action",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: SDWcolors.textD,
                        fontWeight: FontWeight.bold,
                        fontSize: height * 0.024,
                      ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () {
                      Get.toNamed(Routes.riwayat);
                    },
                    child: Container(
                      width: width * 0.2,
                      height: height * 0.09,
                      decoration: BoxDecoration(
                        color: SDWcolors.bgD,
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/icons/riwayat_kehadiran.png',
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: width * 0.2,
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      "Riwayat Kehadiran",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: SDWcolors.textD,
                        fontWeight: FontWeight.bold,
                        fontSize: height * 0.016,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(width: width * 0.1),

              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () {
                      // Get.offAllNamed(Routes.riwayat);
                    },
                    child: Container(
                      width: width * 0.2,
                      height: height * 0.09,
                      decoration: BoxDecoration(
                        color: SDWcolors.bgD,
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/icons/peringkat_karyawan.png',
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: width * 0.2,
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      "Peringkat Karyawan",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: SDWcolors.textD,
                        fontWeight: FontWeight.bold,
                        fontSize: height * 0.016,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(width: width * 0.1),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () {
                      Get.toNamed(Routes.notice);
                    },
                    child: Container(
                      width: width * 0.2,
                      height: height * 0.09,
                      decoration: BoxDecoration(
                        color: SDWcolors.bgD,
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage('assets/icons/peringatan.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),

                  Container(
                    width: width * 0.2,
                    margin: EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        SizedBox(height: height * 0.008,),
                        Text(
                          "Peringatan",
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: SDWcolors.textD,
                                fontWeight: FontWeight.bold,
                                fontSize: height * 0.016,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
