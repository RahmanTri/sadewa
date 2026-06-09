import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/constants/sdw_sizes.dart';
// import '../Effect/box_shadow.dart';
import '../../Effect/SDWOverlay.dart';
import 'package:sadewa_fe/controllers/face_scan_controller.dart';
import 'package:sadewa_fe/routes/app_routes.dart';

class RegistWajah extends StatelessWidget {
  RegistWajah({Key? key});
  final absenController = Get.put(FaceScanController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final height = MediaQuery.of(context).size.height;
      final width = MediaQuery.of(context).size.width;
      final cam = absenController.cameraController.value;

      if (cam == null ||
          !cam.value.isInitialized &&
              !absenController.distanceUpdated.value &&
              absenController.isLoading) {
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      if (!absenController.isInRadius.value && !absenController.isRegist) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final ctx = Get.context;
          if (ctx != null) {
            SDWoverlay.showOverlay(
              context: (context),
              title: "Anda Berada Diluar Jangkauan Area Divisi",
              iconData: Icons.warning,
              height: Get.height,
              width: Get.width,
              onConfirm: () => (Get.offAllNamed(Routes.home)),
            );
          }
        });
      }
      return Scaffold(
        backgroundColor: SDWcolors.bgD,
        body: Stack(
          children: [
            // Header
            Container(
              height: height * 0.13,
              width: width,
              child: Stack(
                children: [
                  Container(
                    height: height * 0.13,
                    child: IconButton(
                      onPressed: () {
                        Get.offAllNamed(Routes.home);
                      },
                      icon: Icon(Icons.arrow_back),
                      color: SDWcolors.textD,
                      iconSize: 40,
                    ),
                  ),

                  Container(
                    height: height * 0.13,
                    width: width,
                    alignment: Alignment.center,
                    child: Text(
                      absenController.isRegist
                          ? 'Registrasi Wajah'
                          : absenController.isAbsen
                          ? 'Absen Keluar'
                          : 'Absen Masuk',
                      style: TextStyle(
                        fontSize: SDWsizes.xl,
                        fontWeight: FontWeight.bold,
                        color: SDWcolors.textD,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Camera Box
            Container(
              margin: EdgeInsets.only(left: 40, right: 40, top: height * 0.1),
              height: height * 0.5,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: CameraPreview(cam),
            ),

            // Text Wrapper
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: height * 0.62),
              height: height * 0.3,
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Status Check",
                    style: TextStyle(
                      color: SDWcolors.textD,
                      fontSize: SDWsizes.xl,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    absenController.statusText.value,
                    style: TextStyle(
                      color: SDWcolors.error,
                      fontSize: SDWsizes.lg * 0.7,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Arahan",
                    style: TextStyle(
                      color: SDWcolors.textD,
                      fontSize: SDWsizes.lg * 0.7,
                      fontWeight: FontWeight.w300,
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
