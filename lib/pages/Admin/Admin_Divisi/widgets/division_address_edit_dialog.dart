import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/controllers/division_controller.dart';

class DivisionEditAddress {
  static void show({
    required BuildContext context,
    required DivisionController divisionController,
    required double height,
    required double width,
  }) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
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
              AnimatedPadding(
                curve: Curves.easeOut,
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                duration: const Duration(milliseconds: 300),
                child: Stack(
                  alignment: AlignmentGeometry.topCenter,
                  children: [
                    SizedBox(
                      height: height * 0.36,
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
                                'Ubah Alamat Kantor',
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

                            // TextField
                            Container(
                              width: width * 0.8,
                              height: height * 0.05,
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(
                                left: width * 0.04,
                                right: width * 0.04,
                              ),
                              decoration: BoxDecoration(
                                color: SDWcolors.bgD,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextField(
                                controller: divisionController.alamatKantor,
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      color: SDWcolors.textD,
                                      fontSize: height * 0.024,
                                      fontWeight: FontWeight.bold,
                                    ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: const EdgeInsets.only(
                                    left: 0,
                                    right: 0,
                                  ),
                                  hintText: 'Masukkan Alamat Kantor',
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: SDWcolors.essential,
                                        fontSize: height * 0.018,
                                      ),
                                ),
                                onChanged: (value) =>
                                    divisionController.alamatKantorError.value =
                                        '',
                                onEditingComplete: () {
                                  divisionController.checkAddressColumn();
                                },
                              ),
                            ),
                            SizedBox(
                              width: width * 0.8,
                              child: Obx(
                                () => Text(
                                  divisionController.alamatKantorError.value,
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        color: SDWcolors.error,
                                        fontSize: height * 0.016,
                                        fontStyle: FontStyle.italic,
                                      ),
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.032),

                            SizedBox(
                              height: height * 0.04,
                              width: width * 0.8,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      // if (onCancel != null) {
                                      //   onCancel();
                                      // }
                                      Navigator.pop(context);
                                    },
                                    style: ButtonStyle(
                                      fixedSize: WidgetStatePropertyAll(
                                        Size(width * 0.36, height * 0.04),
                                      ),
                                      backgroundColor: WidgetStatePropertyAll(
                                        SDWcolors.white,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Batal',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              color: SDWcolors.primary,
                                              fontSize: height * 0.018,
                                            ),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      // onConfirm();
                                      if (divisionController.alamatKantor.text !=
                                          divisionController
                                              .showedDivisions
                                              .value!
                                              .alamatKantor) {
                                        //Execute Here
                                        divisionController.checkNameColumn();
                                        if (divisionController.alamatKantorError.value.isEmpty) {
                                          divisionController.updateAddress();
                                        }
                                        Navigator.pop(context);
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
                                        'Konfirmasi',
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
                          border: Border.all(color: SDWcolors.white, width: 4),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.edit_outlined,
                            color: SDWcolors.white,
                            size: height * 0.06,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
