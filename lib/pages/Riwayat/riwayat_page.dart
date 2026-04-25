import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/controllers/riwayat_controller.dart';
import 'package:sadewa_fe/pages/Riwayat/widgets/history_card.dart';
import '../effect/box_shadow.dart';
// import 'package:sadewa_fe/controllers/notice_controller.dart';
// import 'package:sadewa_fe/models/notice_model.dart';
import 'package:sadewa_fe/routes/app_routes.dart';

class RiwayatPage extends StatelessWidget {
  const RiwayatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final riwayatController = Get.find<RiwayatController>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    Future.microtask(() => riwayatController.fetchRiwayat());

    // Dummy
    // Future.microtask(() => riwayatController.dummyHistory());

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
          onPressed: () => Get.toNamed(Routes.notice),
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
                  boxShadow: [SDWboxShadow.shadow],
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
                            riwayatController.jumlahLate.value.toString(),
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
                            riwayatController.jumlahAbsen.value.toString(),
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
                    height: 32,
                    width: width * 0.36,
                    decoration: BoxDecoration(
                      color: SDWcolors.bgL,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [SDWboxShadow.shadow],
                    ),
                    child: Center(
                      child: Obx(
                        () => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isDense: true,
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Obx(
                () => riwayatController.isLoading.value
                    ? Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(color: SDWcolors.primary),
                            SizedBox(height: 10),
                            Text(
                              'Memuat Data...',
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: SDWcolors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      )
                    : Obx(
                        () => riwayatController.isLoading.value
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: SDWcolors.primary,
                                ),
                              )
                            : riwayatController.filteredhistories.isEmpty
                            ? Center(
                                child: Column(
                                  children: [
                                    Image(
                                      image: AssetImage(
                                        'assets/images/blank-page-img.png',
                                      ),
                                      height: height * 0.5,
                                      width: width * 0.4,
                                    ),
                                    Text(
                                      'Belum ada riwayat',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: SDWcolors.textD,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  padding: EdgeInsets.only(left: 12, right: 12),
                                  physics: BouncingScrollPhysics(),
                                  itemCount: riwayatController
                                      .filteredhistories
                                      .length,
                                  itemBuilder: (context, index) => HistoryCard(
                                    height: height,
                                    width: width,
                                    gap: 12,
                                    riwayat: riwayatController
                                        .filteredhistories[index],
                                  ),
                                ),
                              ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
