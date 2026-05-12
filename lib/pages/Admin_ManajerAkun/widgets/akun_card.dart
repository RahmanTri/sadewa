import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/controllers/akun_controller.dart';
import 'package:sadewa_fe/models/akun_model.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/constants/urls.dart';
import 'package:sadewa_fe/pages/Admin_ManajerAkun/widgets/popup_edit.dart';
import 'package:sadewa_fe/pages/Effect/SDWOverlay.dart';
import 'package:sadewa_fe/pages/Effect/box_shadow.dart';

class AkunCard extends StatelessWidget {
  final Akun akun;
  final double width;
  final double height;
  final double gap;

  const AkunCard({
    super.key,
    required this.akun,
    required this.width,
    required this.height,
    required this.gap,
  });

  @override
  Widget build(BuildContext context) {
    final AkunController akunController = Get.find<AkunController>();

    return GestureDetector(
      onTap: () => {
        // Functions
        akunController.editAccount(akun),
        PopUpEdit.show(
          context: context,
          akunController: akunController,
          height: height,
          width: width,
        ),
        // Sdwoverlay.showOverlay(
        //   context: context,
        //   title: 'Mbledos',
        //   iconData: Icons.check_circle,
        //   height: height,
        //   width: width,
        // ),
      },
      child: Container(
        margin: EdgeInsets.only(bottom: gap),
        height: height * 0.1,
        width: width * 0.92,
        decoration: BoxDecoration(
          color: SDWcolors.bgL,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [SDWboxShadow.shadow],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: width * 0.04, right: width * 0.04),
              height: height * 0.08,
              width: height * 0.08,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('${AppUrls.imgAssets}default-profile.png'),
                ),
                border: Border.all(color: SDWcolors.primary, width: 4),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  akun.username,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: SDWcolors.textD,
                    fontWeight: FontWeight.bold,
                    fontSize: height * 0.022,
                  ),
                ),
                Text(
                  akun.email,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: SDWcolors.textD,
                    fontWeight: FontWeight.normal,
                    fontSize: height * 0.016,
                  ),
                ),
                Text(
                  akun.role,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: SDWcolors.textD,
                    fontWeight: FontWeight.normal,
                    fontSize: height * 0.016,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
