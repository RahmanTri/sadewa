import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/controllers/notice_controller.dart';
import '../effect/box_shadow.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import '../../routes/app_routes.dart';

class ReadNoticePage extends StatelessWidget {
  const ReadNoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    final noticeController = Get.find<NoticeController>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: SDWcolors.primary,
        toolbarHeight: height * 0.05,
        title: Text(
          'Peringatan',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: SDWcolors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back),
          color: SDWcolors.white,
        ),
      ),
      backgroundColor: SDWcolors.bgD,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: height * 0.04,
            decoration: const BoxDecoration(
              color: SDWcolors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.06),
              Container(
                height: width * 0.92,
                width: width * 0.92,
                decoration: BoxDecoration(
                  color: SDWcolors.bgL,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [SDWboxShadow.shadow],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      size: width * 0.4,
                      color: SDWcolors.primary,
                    ),
                    Text(
                      noticeController.beingRead.value?.title ?? '',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: SDWcolors.textD,
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.04,
                      ),
                    ),
                    SizedBox(height: 4),
                    SizedBox(
                      width: width * 0.8,
                      child: Text(
                        noticeController.beingRead.value?.content ?? '',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: SDWcolors.textD,
                          fontWeight: FontWeight.normal,
                          fontSize: width * 0.03,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: SDWcolors.primary,
                ),
                onPressed: () => {noticeController.hasBeenRead(), Get.back()},
                child: SizedBox(
                  height: height * 0.04,
                  width: width * 0.5,
                  child: Center(
                    child: Text(
                      'Saya Mengerti',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: SDWcolors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.04,
                      ),
                    ),
                  ),
                ),
              ),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: SDWcolors.primary,
              //   ),
              //   onPressed: () => {Get.toNamed(Routes.myPoint)},
              //   child: SizedBox(
              //     height: height * 0.04,
              //     width: width * 0.5,
              //     child: Center(
              //       child: Text(
              //         'Poin Saya',
              //         style: Theme.of(context).textTheme.titleLarge?.copyWith(
              //           color: SDWcolors.white,
              //           fontWeight: FontWeight.bold,
              //           fontSize: width * 0.04,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
