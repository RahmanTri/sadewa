import 'package:flutter/material.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/constants/sdw_sizes.dart';
import 'package:sadewa_fe/pages/Effect/box_shadow.dart';

class ActivityLog extends StatelessWidget {
  final double width;
  final double height;
  const ActivityLog({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        physics: BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 10),
            height: height * 0.1,
            width: width,
            child: Row(
              children: [
                Container(
                  width: width * 0.68,
                  height: height * 0.1,
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
                          size: width * 0.16,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Absen Keluar",
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  color: SDWcolors.textD,
                                  fontWeight: FontWeight.w900,
                                  fontSize: height * 0.02,
                                  decoration: TextDecoration.underline,
                                ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.ring_volume_outlined,
                                color: SDWcolors.textD,
                                size: height * 0.024,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Tepat Waktu",
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      color: SDWcolors.textD,
                                      fontWeight: FontWeight.normal,
                                      fontSize: height * 0.016,
                                    ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.date_range_outlined,
                                color: SDWcolors.textD,
                                size: height * 0.024,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "data",
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      color: SDWcolors.textD,
                                      fontWeight: FontWeight.normal,
                                      fontSize: height * 0.016,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: height * 0.1,
                        height: height * 0.1,
                        decoration: BoxDecoration(
                          color: SDWcolors.bgL,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [SDWboxShadow.shadow],
                        ),
                        child: Icon(
                          Icons.check_circle,
                          color: SDWcolors.success,
                          size: width * 0.16,
                        ),
                      ),
                    ],
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
