import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/controllers/riwayat_controller.dart';

class RiwayatPage extends StatelessWidget {
  const RiwayatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final riwayatController = Get.find<RiwayatController>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // Future.microtask(() => riwayatController.fetchRiwayat());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: SDWcolors.primary,
        toolbarHeight: height * 0.05,
        title: Text(
          'Riwayat',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: SDWcolors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: Get.back,
          icon: Icon(Icons.arrow_back),
          color: SDWcolors.white,
        ),
      ),
      backgroundColor: SDWcolors.bgD,
      body: Stack(
        children: [
          Container(
            height: height * 0.12,
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
              Container(
                margin: EdgeInsets.all(12),
                height: height * 0.13,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: SDWcolors.bgL,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: SDWcolors.essentialDR.withAlpha(50),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(
                      () => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Tepat Waktu',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: SDWcolors.textD,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            riwayatController.jumlahOnTime.value.toString(),
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: SDWcolors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                ),
                          ),
                          Text(
                            'Hari',
                            style: Theme.of(context).textTheme.labelMedium
                                ?.copyWith(color: SDWcolors.textD),
                          ),
                        ],
                      ),
                    ),
                    VerticalDivider(color: SDWcolors.bgD),
                    Obx(
                      () => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Terlambat',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: SDWcolors.textD,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            riwayatController.jumlahOnTime.value.toString(),
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: SDWcolors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                ),
                          ),
                          Text(
                            'Hari',
                            style: Theme.of(context).textTheme.labelMedium
                                ?.copyWith(color: SDWcolors.textD),
                          ),
                        ],
                      ),
                    ),
                    VerticalDivider(color: SDWcolors.bgD),
                    Obx(
                      () => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Tidak Hadir',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: SDWcolors.textD,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            riwayatController.jumlahOnTime.value.toString(),
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: SDWcolors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                ),
                          ),
                          Text(
                            'Hari',
                            style: Theme.of(context).textTheme.labelMedium
                                ?.copyWith(color: SDWcolors.textD),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 12),
                    height: double.infinity,
                    width: width * 0.4,
                    decoration: BoxDecoration(
                      color: SDWcolors.bgL,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: SDWcolors.essentialDR.withAlpha(50),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Obx(
                        () => Column(
                          children: [
                            DropdownButton(
                              dropdownColor: SDWcolors.bgL,
                              menuWidth: width * 0.36,
                              value: riwayatController.selectedFilter.value,
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
                              items: riwayatController.filteroptions.map((
                                filter,
                              ) {
                                return DropdownMenuItem<String>(
                                  value: filter,
                                  child: Text(filter),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                if (newValue != null) {
                                  riwayatController.selectedFilter.value =
                                      newValue;
                                  riwayatController.applyFilter(newValue);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
