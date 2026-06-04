import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/controllers/karyawan_controller.dart';

// Unused Class

class KaryawanAlertDialog extends StatelessWidget {
  final bool isSuccess;
  final String message;
  final VoidCallback onConfirm;
  final double height;
  final double width;
  final String goTo;

  const KaryawanAlertDialog({
    super.key,
    required this.isSuccess,
    required this.message,
    required this.onConfirm,
    required this.height,
    required this.width,
    required this.goTo,
  });

  @override
  Widget build(BuildContext context) {
    final KaryawanController karyawanController = Get.find<KaryawanController>();

    return Material(
          color: SDWcolors.transparent,
          child: Stack(
            alignment: AlignmentGeometry.center,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    color: SDWcolors.essentialDR.withAlpha(80),
                  ),
                ),
              ),
              Stack(
                alignment: AlignmentGeometry.topCenter,
                children: [
                  SizedBox(
                    height: height * 0.32,
                    width: width * 0.9,
                    child: Container(
                      margin: EdgeInsets.only(top: height * 0.06),
                      height: height * 0.26,
                      width: width * 0.9,
                      decoration: BoxDecoration(
                        color: SDWcolors.bgL,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: height * 0.08),
                          SizedBox(
                            height: height * 0.04,
                            width: width * 0.8,
                            child: Text(
                              isSuccess ? 'Berhasil!' : 'Gagal!',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: SDWcolors.textD,
                                    fontSize: height * 0.032,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          SizedBox(height: height * 0.012),
                          SizedBox(
                            height: height * 0.04,
                            width: width * 0.8,
                            child: Text(
                              message,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: SDWcolors.textD,
                                    fontSize: height * 0.02,
                                  ),
                            ),
                          ),
                          SizedBox(height: height * 0.024),
                          SizedBox(
                            height: height * 0.04,
                            width: width * 0.8,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    onConfirm();
                                    Get.back();
                                    if (goTo != '') {
                                      Get.offAllNamed(goTo);
                                      karyawanController.fetchKaryawan();
                                    }
                                  },
                                  style: ButtonStyle(
                                    fixedSize: WidgetStatePropertyAll(
                                      Size(width * 0.36, height * 0.04),
                                    ),
                                    backgroundColor: WidgetStatePropertyAll(
                                      SDWcolors.primary,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Oke',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color: SDWcolors.white,
                                            fontSize: height * 0.018,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: height * 0.12,
                    width: height * 0.12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: SDWcolors.primary,
                    ),
                    child: Container(
                      margin: EdgeInsets.all(height * 0.012),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: SDWcolors.transparent,
                        border: Border.all(
                          color: SDWcolors.white,
                          width: 4,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          isSuccess ? Icons.check : Icons.close,
                          color: SDWcolors.white,
                          size: height * 0.06,
                        )
                      )
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
  }
}
