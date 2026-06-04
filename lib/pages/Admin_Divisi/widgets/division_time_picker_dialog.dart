import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/controllers/division_controller.dart';

class DivisionTimePicker {
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
              Stack(
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
                              'Atur Waktu',
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

                          // Time Picker
                          SizedBox(
                            height: height * 0.1,
                            width: width * 0.8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                //Jam
                                Container(
                                  height: height * 0.072,
                                  width: width * 0.2,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: SDWcolors.bgD,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                    () => DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        isExpanded: true,
                                        isDense: true,
                                        dropdownColor: SDWcolors.bgL,
                                        menuMaxHeight: height * 0.5,
                                        menuWidth: width * 0.2,
                                        selectedItemBuilder: (context) {
                                          return divisionController.jam.map((
                                            waktu,
                                          ) {
                                            return Text(
                                              waktu,
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                    color: SDWcolors.textD,
                                                    fontSize: height * 0.048,
                                                    fontWeight: FontWeight.bold,
                                                    height: 1,
                                                  ),
                                            );
                                          }).toList();
                                        },
                                        value: divisionController
                                            .selectedHour
                                            .value,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              color: SDWcolors.textD,
                                              fontSize: height * 0.048,
                                              fontWeight: FontWeight.bold,
                                            ),
                                        items: divisionController.jam.map((
                                          waktu,
                                        ) {
                                          return DropdownMenuItem<String>(
                                            value: waktu,
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                top: height * 0.004,
                                                bottom: height * 0.004,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: SDWcolors.essentialD,
                                                  width: 2,
                                                ),
                                              ),
                                              alignment: Alignment.topCenter,
                                              child: Center(
                                                child: Text(
                                                  waktu,
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(
                                                        color: SDWcolors.textD,
                                                        fontSize:
                                                            height * 0.032,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        height: 1,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        icon: Transform.rotate(
                                          angle: 3.14 / -2,
                                          child: Icon(
                                            Icons.chevron_left_outlined,
                                            color: SDWcolors.essentialD,
                                            size: 24,
                                          ),
                                        ),
                                        onChanged: (value) {
                                          if (value != null) {
                                            divisionController
                                                    .selectedHour
                                                    .value =
                                                value;
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),

                                // :
                                SizedBox(
                                  width: width * 0.1,
                                  height: height * 0.072,
                                  child: Text(
                                    ':',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(
                                          color: SDWcolors.textD,
                                          fontSize: height * 0.08,
                                          fontWeight: FontWeight.bold,
                                          height: 0.72,
                                        ),
                                  ),
                                ),

                                //Menit
                                Container(
                                  height: height * 0.072,
                                  width: width * 0.2,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: SDWcolors.bgD,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                    () => DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        isExpanded: true,
                                        isDense: true,
                                        dropdownColor: SDWcolors.bgL,
                                        menuMaxHeight: height * 0.5,
                                        menuWidth: width * 0.2,
                                        selectedItemBuilder: (context) {
                                          return divisionController.menit.map((
                                            waktu,
                                          ) {
                                            return Text(
                                              waktu,
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                    color: SDWcolors.textD,
                                                    fontSize: height * 0.048,
                                                    fontWeight: FontWeight.bold,
                                                    height: 1,
                                                  ),
                                            );
                                          }).toList();
                                        },
                                        value: divisionController
                                            .selectedMinute
                                            .value,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              color: SDWcolors.textD,
                                              fontSize: height * 0.048,
                                              fontWeight: FontWeight.bold,
                                            ),
                                        items: divisionController.menit.map((
                                          waktu,
                                        ) {
                                          return DropdownMenuItem<String>(
                                            value: waktu,
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                top: height * 0.004,
                                                bottom: height * 0.004,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: SDWcolors.essentialD,
                                                  width: 2,
                                                ),
                                              ),
                                              alignment: Alignment.topCenter,
                                              child: Center(
                                                child: Text(
                                                  waktu,
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(
                                                        color: SDWcolors.textD,
                                                        fontSize:
                                                            height * 0.032,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        height: 1,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        icon: Transform.rotate(
                                          angle: 3.14 / -2,
                                          child: Icon(
                                            Icons.chevron_left_outlined,
                                            color: SDWcolors.essentialD,
                                            size: 24,
                                          ),
                                        ),
                                        onChanged: (value) {
                                          if (value != null) {
                                            divisionController
                                                    .selectedMinute
                                                    .value =
                                                value;
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: height * 0.012),

                          SizedBox(
                            height: height * 0.04,
                            width: width * 0.8,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                    if (divisionController
                                            .editingCheckinTime
                                            .value ==
                                        true) {
                                      if (divisionController
                                                  .selectedHour
                                                  .value !=
                                              divisionController
                                                  .showedDivisions
                                                  .value!
                                                  .waktuMasuk
                                                  .substring(0, 2) ||
                                          divisionController
                                                  .selectedMinute
                                                  .value !=
                                              divisionController
                                                  .showedDivisions
                                                  .value!
                                                  .waktuMasuk
                                                  .substring(3, 5)) {
                                        Navigator.pop(context);
                                        divisionController.saveTime();
                                      }
                                    } else if (divisionController
                                            .editingCheckinTime
                                            .value ==
                                        false) {
                                      if (divisionController
                                                  .selectedHour
                                                  .value !=
                                              divisionController
                                                  .showedDivisions
                                                  .value!
                                                  .waktuKeluar
                                                  .substring(0, 2) ||
                                          divisionController
                                                  .selectedMinute
                                                  .value !=
                                              divisionController
                                                  .showedDivisions
                                                  .value!
                                                  .waktuKeluar
                                                  .substring(3, 5)) {
                                        Navigator.pop(context);
                                        divisionController.saveTime();
                                      }
                                    }
                                    // onConfirm();
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
                          Icons.more_time,
                          color: SDWcolors.white,
                          size: height * 0.06,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
