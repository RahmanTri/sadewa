import 'package:flutter/material.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/constants/sdw_sizes.dart';
import 'package:sadewa_fe/pages/Effect/box_shadow.dart';

class ActivityLog extends StatelessWidget {
  final double width;
  final double height;
  ActivityLog({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        physics: BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            height: height * 0.1,
            width: width,
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  width: width * 0.67,
                  height: height,
                  decoration: BoxDecoration(
                    color: SDWcolors.bgL,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [SDWboxShadow.shadow],
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: height,
                        width: width * 0.13,
                        margin: EdgeInsets.only(right: 30),
                        decoration: BoxDecoration(
                          color: SDWcolors.bgL,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.exit_to_app,
                          color: SDWcolors.primary,
                          size: 70,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Absen Keluar",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: SDWcolors.textD,
                              decoration: TextDecoration.underline,
                              decorationColor: SDWcolors.textD,
                              fontSize: SDWsizes.lg * 0.65,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.ring_volume_outlined,
                                color: SDWcolors.textD,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Tepat Waktu",
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: SDWcolors.textD,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.date_range_outlined,
                                color: SDWcolors.textD,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "data",
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: SDWcolors.textD,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: width * 0.175,
                  height: height,
                  decoration: BoxDecoration(
                    color: SDWcolors.bgL,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [SDWboxShadow.shadow],
                  ),
                  child: Icon(
                    Icons.check_circle,
                    color: SDWcolors.success,
                    size: 70,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
