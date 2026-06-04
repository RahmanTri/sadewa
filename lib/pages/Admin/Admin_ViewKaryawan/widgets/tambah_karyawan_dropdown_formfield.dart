import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/controllers/karyawan_controller.dart';

class KaryawanDropdownFormField extends StatelessWidget {
  final String title;
  const KaryawanDropdownFormField({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final karyawanController = Get.find<KaryawanController>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Obx(
      () => SizedBox(
        width: width * 0.8,
        height: height * 0.108,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: SDWcolors.textD,
                fontSize: height * 0.020,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: height * 0.006),
            Container(
              height: height * 0.06,
              width: width * 0.8,
              padding: EdgeInsets.only(left: width * 0.04, right: width * 0.04),
              decoration: BoxDecoration(
                color: SDWcolors.bgL,
                borderRadius: BorderRadius.circular(40),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  isExpanded: true,
                  isDense: true,
                  dropdownColor: SDWcolors.bgL,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: SDWcolors.textD,
                    fontWeight: FontWeight.bold,
                    fontSize: height * 0.020,
                  ),
                  icon: Transform.rotate(
                    angle: 3.14 / -2,
                    child: Icon(
                      Icons.chevron_left_outlined,
                      color: SDWcolors.essentialD,
                      size: 24,
                    ),
                  ),
                  value: karyawanController.selectedDivisionNameAdd.value,
                  items: karyawanController.availableDivisionNames.map((
                    divisi,
                  ) {
                    return DropdownMenuItem<String>(
                      value: divisi,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(divisi),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    if (newValue != null) {
                      karyawanController.selectedDivisionNameAdd.value =
                          newValue;
                      if (newValue != 'Pilih Divisi') {
                        karyawanController.availableDivisionNames.remove(
                          'Pilih Divisi',
                        );
                      }
                    }
                  },
                ),
              ),
            ),
            Obx(
              () => Text(
                karyawanController.divisionError.value,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: SDWcolors.error,
                  fontSize: height * 0.012,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
