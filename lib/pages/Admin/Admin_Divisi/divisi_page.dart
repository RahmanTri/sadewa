import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/constants/urls.dart';
import 'package:sadewa_fe/controllers/division_controller.dart';
import 'package:sadewa_fe/controllers/home_controller.dart';
import 'package:sadewa_fe/pages/Admin/Admin_Divisi/widgets/divisions_card.dart';
import 'package:sadewa_fe/routes/app_routes.dart';
import '../../effect/box_shadow.dart';

class DivisiPage extends StatefulWidget {
  const DivisiPage({super.key});

  @override
  State<DivisiPage> createState() => _DivisiPageState();
}

class _DivisiPageState extends State<DivisiPage> {
  late DivisionController divisionController;
  @override
  void initState() {
    divisionController = Get.find<DivisionController>();
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   karyawanController.fetchKaryawan();
  // }

  @override
  Widget build(BuildContext context) {
    final DivisionController divisionController =
        Get.find<DivisionController>();
    final homeController = Get.find<HomeController>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // Future.microtask(() => karyawanController.fetchKaryawan());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: SDWcolors.primary,
        toolbarHeight: height * 0.05,
        surfaceTintColor: SDWcolors.transparent,
        title: Text(
          'Divisi',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: SDWcolors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            homeController.loadAdminDashboard();
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
          color: SDWcolors.white,
        ),
      ),
      backgroundColor: SDWcolors.bgD,
      floatingActionButton: FloatingActionButton(
        backgroundColor: SDWcolors.primary,
        child: const Icon(Icons.add),
        onPressed: () {
          divisionController.goToAddNewDivision();
          Get.toNamed(Routes.addDivisi);
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
                                value: divisionController.selectedFilter.value,
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
                                items: divisionController.filterOptions.map((
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
                                    divisionController.selectedFilter.value =
                                        newValue;
                                    divisionController.applyFilter(newValue);
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
              SizedBox(height: height * 0.012),
              Obx(
                () => divisionController.isLoading.value == true
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
                    : divisionController.filteredDivisions.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.only(
                            left: width * 0.04,
                            right: width * 0.04,
                          ),
                          physics: BouncingScrollPhysics(),
                          itemCount:
                              divisionController.filteredDivisions.length,
                          itemBuilder: (context, index) => DivisionsCard(
                            division:
                                divisionController.filteredDivisions[index],
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
