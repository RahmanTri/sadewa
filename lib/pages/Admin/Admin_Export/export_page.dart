import 'package:flutter/material.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/pages/Effect/box_shadow.dart';

import 'package:sadewa_fe/controllers/export_controller.dart';

class AdminExportPage extends StatelessWidget {
  AdminExportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final exportController = Get.put(ExportController(), permanent: false);

    return Obx(() {
      return Scaffold(
        backgroundColor: SDWcolors.bgD,
        body: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: width,
                height: height * 0.18,
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  color: SDWcolors.primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: height * 0.025, width: width),
                    SizedBox(
                      height: height * 0.07,
                      width: width,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(
                                FontAwesomeIcons.arrowLeft,
                                color: SDWcolors.bgL,
                                fontWeight: FontWeight.bold,
                                size: width * 0.08,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Cetak Rekap Kehadiran",
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    fontSize: width * 0.06,
                                    color: SDWcolors.bgL,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: height,
                            width: width * 0.25,
                            child: Center(
                              child: Container(
                                height: height * 0.035,
                                width: width,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: SDWcolors.bgL,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    isDense: true,
                                    dropdownColor: SDWcolors.bgL,
                                    menuWidth: width * 0.256,
                                    value: exportController
                                        .monthSelectedFIlter
                                        .value,
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(
                                          color: SDWcolors.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                    icon: Transform.rotate(
                                      angle: 3.14 / -2,
                                      child: Icon(
                                        Icons.chevron_left_outlined,
                                        color: SDWcolors.primary,
                                        size: 24,
                                      ),
                                    ),
                                    items: exportController.monthFilter.map((
                                      filter,
                                    ) {
                                      return DropdownMenuItem<String>(
                                        value: filter,
                                        child: Text(filter),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      if (newValue != null) {
                                        exportController
                                            .monthSelectedFIlter
                                            .value = newValue
                                            .toString();
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height,
                            width: width * 0.3,
                            child: Center(
                              child: Container(
                                height: height * 0.035,
                                width: width,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: SDWcolors.bgL,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      isDense: true,
                                      dropdownColor: SDWcolors.bgL,
                                      menuWidth: width * 0.36,
                                      value: exportController
                                          .divisionSelectedFilter
                                          .value,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color: SDWcolors.primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                      icon: Transform.rotate(
                                        angle: 3.14 / -2,
                                        child: Icon(
                                          Icons.chevron_left_outlined,
                                          color: SDWcolors.primary,
                                          size: 24,
                                        ),
                                      ),
                                      items: exportController.divisionFilter
                                          .map((filter) {
                                            return DropdownMenuItem(
                                              value: filter,
                                              child: Text(filter),
                                            );
                                          })
                                          .toList(),
                                      selectedItemBuilder: (context) {
                                        return exportController.divisionFilter.map((
                                          filter,
                                        ) {
                                          return SizedBox(
                                            height: height,
                                            width: width * 0.22,
                                            child: SingleChildScrollView(
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              child: Text(filter),
                                            ),
                                          );
                                        }).toList();
                                      },
                                      onChanged: (newValue) {
                                        if (newValue != null) {
                                          exportController
                                              .divisionSelectedFilter
                                              .value = newValue
                                              .toString();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: height,
                            width: width * 0.26,
                            child: GestureDetector(
                              onTap: () {},
                              child: Center(
                                child: Container(
                                  height: height * 0.035,
                                  width: width,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: SDWcolors.bgL,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Cetak Semua",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              color: SDWcolors.primary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          FontAwesomeIcons.angleRight,
                                          size: 20,
                                          color: SDWcolors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
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
            SizedBox(height: width * 0.02),
            Expanded(
              child: Container(
                height: height,
                width: width * 0.95,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: SDWcolors.bgL,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  boxShadow: [SDWboxShadow.shadow],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: width,
                      height: height * 0.1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Stack(
                            children: [
                              Align(
                                alignment: AlignmentGeometry.centerLeft,
                                child: Text(
                                  "Nama Divisi",
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        color: SDWcolors.textD,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentGeometry.centerRight,
                                child: Text(
                                  "Nama Divisi",
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        color: SDWcolors.textD,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ],
                          ),

                          Stack(
                            children: [
                              Align(
                                alignment: AlignmentGeometry.centerLeft,
                                child: Text(
                                  "Periode",
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        color: SDWcolors.textD,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentGeometry.centerRight,
                                child: Text(
                                  "Periode",
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        color: SDWcolors.textD,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            children: [
                              Align(
                                alignment: AlignmentGeometry.centerLeft,
                                child: Text(
                                  "Jumlah Staff",
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        color: SDWcolors.textD,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentGeometry.centerRight,
                                child: Text(
                                  "Jumlah Staff",
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        color: SDWcolors.textD,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            children: [
                              Align(
                                alignment: AlignmentGeometry.centerLeft,
                                child: Text(
                                  "Jumlah Telat",
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        color: SDWcolors.textD,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentGeometry.centerRight,
                                child: Text(
                                  "Jumlah Telat",
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        color: SDWcolors.textD,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(color: SDWcolors.black, thickness: 2.5, height: 20),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        itemCount: 50,
                        itemBuilder: (context, index) {
                          // final item = homeController.absenMasuk[index];
                          return Column(
                            children: [
                              Container(
                                height: height * 0.055,
                                width: width,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: SDWcolors.bgD,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: height,
                                      width: width * 0.5,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "item.namaLengkap",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: width * 0.035,
                                                ),
                                          ),
                                          Text(
                                            "item.namaDivisi",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                  fontSize: width * 0.03,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "item.absentDate",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: width * 0.035,
                                                ),
                                          ),
                                          Text(
                                            "item.absentStatus",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                  fontSize: width * 0.03,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: height * 0.005),
                            ],
                          );
                        },
                      ),
                    ),
                    Divider(color: SDWcolors.black, thickness: 2.5, height: 20),
                    SizedBox(
                      width: width,
                      height: height * 0.07,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: height * 0.04,
                            width: width * 0.25,
                            decoration: BoxDecoration(
                              color: SDWcolors.primary,
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Cetak",
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      color: SDWcolors.bgL,
                                      fontWeight: FontWeight.bold,
                                      fontSize: width * 0.05,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: width * 0.1),
          ],
        ),
      );
    });
  }
}
