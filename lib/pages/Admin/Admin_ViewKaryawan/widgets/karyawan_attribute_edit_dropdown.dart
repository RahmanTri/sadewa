import 'package:flutter/material.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/controllers/karyawan_controller.dart';
import 'package:get/get.dart';

class KaryawanAttributeDropdown extends StatelessWidget {
  final String label;
  final IconData icon;
  final double height;
  final double width;
  const KaryawanAttributeDropdown({
    super.key,
    required this.label,
    required this.icon,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final KaryawanController karyawanController =
        Get.find<KaryawanController>();

    return Container(
      margin: EdgeInsets.only(bottom: height * 0.02),
      height: height * 0.1,
      width: width * 0.92,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, color: SDWcolors.primary, size: height * 0.032),
              SizedBox(width: width * 0.02),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: SDWcolors.textD,
                  fontSize: height * 0.018,
                ),
              ),
            ],
          ),
          Expanded(
            child: Row(
              children: [
                SizedBox(width: width * 0.088),
                Expanded(
                  child: SizedBox(
                    height: height * 0.04,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            () => DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: true,
                                isDense: true,
                                dropdownColor: SDWcolors.bgL,
                                menuWidth: width,
                                value: karyawanController
                                    .selectedDivisionName
                                    .value,
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      color: SDWcolors.textD,
                                      fontSize: height * 0.024,
                                    ),
                                icon: Transform.rotate(
                                  angle: 3.14 / -2,
                                  child: Icon(
                                    Icons.chevron_left_outlined,
                                    color: SDWcolors.essentialD,
                                    size: 24,
                                  ),
                                ),
                                items: karyawanController.availableDivisionNames
                                    .map((divisi) {
                                      return DropdownMenuItem<String>(
                                        value: divisi,
                                        child: SingleChildScrollView(
                                          physics: BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          child: Text(divisi.toString()),
                                        ),
                                      );
                                    })
                                    .toList(),
                                onChanged: (newValue) {
                                  if (newValue != null) {
                                    karyawanController
                                            .selectedDivisionName
                                            .value =
                                        newValue;
                                    karyawanController.assignDivisionSelected(
                                      newValue,
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: SDWcolors.essentialD.withAlpha(120),
            thickness: 1,
            radius: BorderRadius.circular(20),
          ),
        ],
      ),
    );
  }
}
