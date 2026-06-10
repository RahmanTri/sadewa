import 'package:flutter/material.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/constants/sdw_sizes.dart';
import 'package:sadewa_fe/pages/Effect/box_shadow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../../controllers/home_controller.dart';

class ActivityLog extends StatelessWidget {
  final double width;
  final double height;
  const ActivityLog({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    final homeCOntroller = Get.put(HomeController(), permanent: false);

    return Obx(() {
      return Expanded(
        child: ListView.builder(
          padding: EdgeInsets.zero,
          physics: BouncingScrollPhysics(),
          itemCount: homeCOntroller.activityLog.length,
          itemBuilder: (context, index) {
            final item = homeCOntroller.activityLog[index];
            return Container(
              margin: EdgeInsets.only(bottom: 10),
              height: height * 0.085,
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
                          width: width * 0.15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Icon(
                              FontAwesomeIcons.bell,
                              color: SDWcolors.primary,
                              size: width * 0.11,
                            ),
                          ),
                        ),
                        SizedBox(width: width * 0.02),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item["activity_type"],
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    color: SDWcolors.textD,
                                    fontWeight: FontWeight.w900,
                                    fontSize: height * 0.017,
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
                                  size: height * 0.02,
                                ),
                                SizedBox(width: 10),
                                SizedBox(
                                  width: width * 0.4,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      item["description"],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color: SDWcolors.textD,
                                            fontWeight: FontWeight.normal,
                                            fontSize: height * 0.012,
                                          ),
                                    ),
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
                                  size: height * 0.02,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  item['created_at'],
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        color: SDWcolors.textD,
                                        fontWeight: FontWeight.normal,
                                        fontSize: height * 0.012,
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
    });
  }
}
