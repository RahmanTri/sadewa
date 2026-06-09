import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/constants/urls.dart';
import 'package:sadewa_fe/controllers/karyawan_controller.dart';
import 'package:sadewa_fe/routes/app_routes.dart';
import 'package:sadewa_fe/controllers/home_controller.dart';
import '../../effect/box_shadow.dart';
import 'widgets/karyawan_card.dart';

class UnderPoint extends StatefulWidget {
  const UnderPoint({super.key});

  @override
  State<UnderPoint> createState() => _KaryawanPageState();
}

class _KaryawanPageState extends State<UnderPoint> {
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
    final homeController = Get.find<HomeController>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // Future.microtask(() => karyawanController.fetchKaryawan());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: SDWcolors.primary,
        toolbarHeight: height * 0.05,
        title: Text(
          'KARYAWAN POINT TERENDAH',
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
              SizedBox(height: 12),
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
                    : karyawanController.underPoint.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.only(
                            left: width * 0.04,
                            right: width * 0.04,
                          ),
                          physics: BouncingScrollPhysics(),
                          itemCount: karyawanController.underPoint.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                KaryawanCard(
                                  karyawan:
                                      karyawanController.underPoint[index],
                                  height: height,
                                  width: width * 0.85,
                                  gap: 10,
                                ),
                                Align(
                                  alignment: AlignmentGeometry.centerRight,
                                  child: Container(
                                    height: height * 0.1,
                                    width: width * 0.13,
                                    decoration: BoxDecoration(
                                      color: Colors.red.withAlpha(50),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        karyawanController
                                            .underPoint[index]
                                            .pointValue
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              color: Colors.red,
                                              fontSize: width * 0.08,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
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
