import 'package:flutter/material.dart';
import 'package:sadewa_fe/models/notice_model.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import '../../../Effect/box_shadow.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/controllers/notice_controller.dart';
import 'package:sadewa_fe/routes/app_routes.dart';

class NoticeCard extends StatelessWidget {
  final Notice notice;
  final double width;
  final double height;
  final double gap;

  const NoticeCard({
    super.key,
    required this.notice,
    required this.width,
    required this.height,
    required this.gap,
  });

  @override
  Widget build(BuildContext context) {
    final noticeController = Get.find<NoticeController>();

    return GestureDetector(
      onTap: () => {
        noticeController.readNotice(notice),
        Get.toNamed(Routes.readNotice),
      },
      child: Container(
        margin: EdgeInsets.only(bottom: gap),
        height: height * 0.128,
        width: width * 0.9,
        decoration: BoxDecoration(
          color: notice.isRead ? SDWcolors.bgL.withAlpha(150) : SDWcolors.bgL,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [SDWboxShadow.shadow],
        ),
        child: Stack(
          alignment: AlignmentGeometry.topEnd,
          children: [
            Column(
              children: [
                Container(
                  height: 24,
                  width: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: notice.isRead
                        ? SDWcolors.primary.withAlpha(150)
                        : SDWcolors.primary,
                  ),
                  child: notice.isRead
                      ? Icon(
                          Icons.check_circle,
                          color: SDWcolors.white.withAlpha(150),
                          size: 16,
                        )
                      : Icon(
                          Icons.circle_notifications_rounded,
                          color: SDWcolors.white,
                          size: 16,
                        ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 16),
                Center(
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: SDWcolors.primary.withAlpha(50),
                    ),
                    child: Icon(
                      Icons.mail_outline_rounded,
                      color: notice.isRead
                          ? SDWcolors.primary.withAlpha(150)
                          : SDWcolors.primary,
                      size: 64,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notice.title,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(
                        fontSize: height * 0.02,
                        color: notice.isRead
                            ? SDWcolors.textD.withAlpha(150)
                            : SDWcolors.textD,
                        fontWeight: FontWeight.bold,
                        ),
                    ),
                    SizedBox(height: 4),
                    SizedBox(
                      height: 32,
                      width: width * 0.53,
                      child: Text(
                        notice.description,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(
                          fontSize: height * 0.012,
                          color: notice.isRead
                              ? SDWcolors.textD.withAlpha(150)
                              : SDWcolors.textD,
                          fontWeight: FontWeight.normal,
                          ),
                        maxLines: 2,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    SizedBox(height: 2),
                    SizedBox(
                      height: 14,
                      width: width * 0.6,
                      child: Text(
                        textAlign: TextAlign.right,
                        notice.date,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(
                          fontSize: height * 0.012,
                          color: notice.isRead
                              ? SDWcolors.textD.withAlpha(150)
                              : SDWcolors.textD,
                          fontWeight: FontWeight.normal,
                          ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
