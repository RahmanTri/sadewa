import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/constants/urls.dart';
import 'package:sadewa_fe/controllers/karyawan_controller.dart';
import 'package:sadewa_fe/routes/app_routes.dart';
import '../../effect/box_shadow.dart';
import 'widgets/karyawan_card.dart';

class KaryawanPage extends StatefulWidget {
  const KaryawanPage({super.key});

  @override
  State<KaryawanPage> createState() => _KaryawanPageState();
}

class _KaryawanPageState extends State<KaryawanPage> {
  late KaryawanController karyawanController;
  @override
  void initState() {
    karyawanController = Get.find<KaryawanController>();
    karyawanController.fetchKaryawan();
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   karyawanController.fetchKaryawan();
  // }

  @override
  Widget build(BuildContext context) {
    final karyawanController = Get.find<KaryawanController>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // Future.microtask(() => karyawanController.fetchKaryawan());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: SDWcolors.primary,
        toolbarHeight: height * 0.05,
        title: Text(
          'Karyawan',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: SDWcolors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.toNamed(Routes.akunManajer),
          icon: Icon(Icons.arrow_back),
          color: SDWcolors.white,
        ),
      ),
      backgroundColor: SDWcolors.bgD,
      floatingActionButton: FloatingActionButton(
        backgroundColor: SDWcolors.primary,
        child: const Icon(Icons.add),
        onPressed: () {
          karyawanController.clearForm();
          karyawanController.goToAddEmployee();
          Get.toNamed(Routes.tambahKaryawan);
        },
      ),
      body: Stack(
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
              SizedBox(height: height * 0.054),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: width * 0.04),
                    padding: EdgeInsets.only(left: 8, right: 8),
                    height: 32,
                    width: width * 0.42,
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
                                isExpanded: true,
                                isDense: true,
                                dropdownColor: SDWcolors.bgL,
                                menuWidth: width * 0.42,
                                value: karyawanController.selectedFilter.value,
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
                                items: karyawanController.filterOptions.map((
                                  filter,
                                ) {
                                  return DropdownMenuItem<String>(
                                    value: filter,
                                    child: SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      child: Text(filter),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  if (newValue != null) {
                                    karyawanController.selectedFilter.value =
                                        newValue;
                                    karyawanController.applyFilter(newValue);
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

              //Dev Only
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.divisi);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: SDWcolors.primary,
                ),
                child: Text(
                  'Divisi',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: SDWcolors.white,
                    fontSize: height * 0.02,
                  ),
                ),
              ),

              SizedBox(height: 12),
              // Obx(
              //   () => Text(
              //     karyawanController.filteredKaryawan.length.toString(),
              //     style: Theme.of(
              //       context,
              //     ).textTheme.titleLarge?.copyWith(color: SDWcolors.primary),
              //   ),
              // ),
              Obx(
                () => karyawanController.isLoading.value == true
                    ? Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: SDWcolors.primary,
                              ),
                              SizedBox(height: height * 0.02),
                              Text(
                                'Memuat Data...',
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(
                                      color: SDWcolors.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: height * 0.022,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : karyawanController.filteredKaryawan.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.only(
                            left: width * 0.04,
                            right: width * 0.04,
                          ),
                          physics: BouncingScrollPhysics(),
                          itemCount: karyawanController.filteredKaryawan.length,
                          itemBuilder: (context, index) => KaryawanCard(
                            karyawan:
                                karyawanController.filteredKaryawan[index],
                            height: height,
                            width: width,
                            gap: 10,
                          ),
                        ),
                      )
                    : Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * 0.5,
                              width: width * 0.42,
                              child: Image.asset(
                                '${AppUrls.imgAssets}blank-page-img.png',
                              ),
                            ),
                            Text(
                              'Tidak ada data',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    color: SDWcolors.textD,
                                    fontWeight: FontWeight.bold,
                                    fontSize: height * 0.022,
                                  ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: height * 0.02),
                              height: height * 0.05,
                              width: width * 0.5,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: karyawanController.karyawan.isEmpty
                                    ? SDWcolors.primary
                                    : SDWcolors.transparent,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: karyawanController.karyawan.isEmpty
                                  ? GestureDetector(
                                      onTap: () {
                                        if (karyawanController
                                            .karyawan
                                            .isEmpty) {
                                          karyawanController.fetchKaryawan();
                                        }
                                      },
                                      child: Container(
                                        height: height * 0.05,
                                        width: width * 0.5,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: SDWcolors.primary,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Text(
                                          'Refresh',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                color: SDWcolors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: height * 0.022,
                                                fontStyle: FontStyle.italic,
                                              ),
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink(),
                            ),
                          ],
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
