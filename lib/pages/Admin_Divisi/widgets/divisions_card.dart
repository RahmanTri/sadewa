import 'package:flutter/material.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/controllers/division_controller.dart';
import 'package:sadewa_fe/models/divisi_model.dart';
import 'package:sadewa_fe/pages/effect/box_shadow.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/routes/app_routes.dart';

class DivisionsCard extends StatelessWidget {
  final Divisi division;
  final double width;
  final double height;
  final double gap;

  const DivisionsCard({
    super.key,
    required this.division,
    required this.width,
    required this.height,
    required this.gap,
  });

  @override
  Widget build(BuildContext context) {
    final DivisionController divisionController = Get.find<DivisionController>();

    return Container(
      margin: EdgeInsets.only(
        bottom: gap,
        left: width * 0.02,
        right: width * 0.02,
      ),
      height: height * 0.14,
      width: width * 0.92,
      decoration: BoxDecoration(
        color: SDWcolors.bgL,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [SDWboxShadow.shadow],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: width * 0.75,
            height: height * 0.12,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.08,
                  width: width * 0.75,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        division.namaDivisi,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: SDWcolors.textD,
                          fontSize: height * 0.028,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Kantor Utama | Jl. Jendral Sudirman No. 1, Jakarta Pusat, Indonesia',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: SDWcolors.textD,
                          fontSize: height * 0.016,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.04,
                  width: width * 0.75,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Masuk ${division.waktuMasuk} | Keluar ${division.waktuKeluar}',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: SDWcolors.textD,
                          fontSize: height * 0.016,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: width * 0.075,
            height: height * 0.12,
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    divisionController.goToDetails(division);
                    Get.toNamed(Routes.detailDivisi);
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: SDWcolors.textD,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
