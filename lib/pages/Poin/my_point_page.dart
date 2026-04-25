import 'package:flutter/material.dart';
import 'package:sadewa_fe/controllers/point_controller.dart';
import 'package:get/get.dart';
import '../../constants/sdw_colors.dart';
import '../../constants/urls.dart';
import '../Effect/box_shadow.dart';

class MyPointPage extends StatelessWidget {
  const MyPointPage({super.key});

  @override
  Widget build(BuildContext context) {
    final poinController = Get.put<PointController>(PointController());
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [SDWcolors.primary, SDWcolors.bgL],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: SDWcolors.transparent,
          toolbarHeight: height * 0.05,
          title: Text(
            'Poin Saya',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: SDWcolors.white),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back),
            color: SDWcolors.white,
          ),
        ),
        backgroundColor: SDWcolors.transparent,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                SizedBox(height: height * 0.2),
                Expanded(
                  child: Container(
                    width: width,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      color: SDWcolors.bgD,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(height: height * 0.06),
                Container(
                  height: height * 0.24,
                  width: width * 0.48,
                  decoration: BoxDecoration(
                    color: SDWcolors.transparent,
                    image: DecorationImage(
                      image: AssetImage('${AppUrls.imgAssets}point-box.png'),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [SDWboxShadow.shadow],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(height: height * 0.008),
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    border: Border.all(color: SDWcolors.essentialD, width: 8),
                    shape: BoxShape.circle,
                    color: SDWcolors.essentialL,
                    image: DecorationImage(
                      // image: AssetImage('${AppUrls.imgAssets}default-profile.png'),
                      image: poinController.profilePic.value == ''
                          ? AssetImage(
                              '${AppUrls.imgAssets}default-profile.png',
                            )
                          : NetworkImage(
                              '${AppUrls.imgProfileUrl}${poinController.profilePic.value}',
                            ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02),
                IntrinsicWidth(
                  child: Container(
                    height: height * 0.106,
                    padding: EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                      color: SDWcolors.primary.withAlpha(50),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        poinController.point.value.toString(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineLarge
                            ?.copyWith(
                              color: SDWcolors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02),
                Text(
                  'POIN',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: SDWcolors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: height * 0.032),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: height * 0.15,
                        width: width * 0.92,
                        decoration: BoxDecoration(
                          color: SDWcolors.bgL,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [SDWboxShadow.shadow],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: height * 0.012),
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: poinController.performanceColor.value,
                              ),
                              child: Icon(
                                poinController.performanceIcon.value,
                                size: 36,
                                color: SDWcolors.white,
                              ),
                            ),
                            SizedBox(height: height * 0.008),
                            Text(
                              'Peforma Anda Bulan Ini ${poinController.performanceCredit.value}!',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    color: SDWcolors.textD,
                                    fontSize: width * 0.032,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            SizedBox(height: height * 0.004),
                            SizedBox(
                              width: width * 0.84,
                              child: Text(
                                poinController.performanceMsg.value,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(
                                      color: SDWcolors.textD,
                                      fontSize: width * 0.028,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.012),
                      Container(
                        height: height * 0.16,
                        width: width * 0.92,
                        padding: EdgeInsets.only(
                          left: 12,
                          right: 12,
                          bottom: 12,
                        ),
                        decoration: BoxDecoration(
                          color: SDWcolors.primaryL,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [SDWboxShadow.shadow],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: height * 0.008),
                            Text(
                              'Benefit',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    color: SDWcolors.textD,
                                    fontSize: width * 0.040,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: height * 0.008),
                                            Text(
                                              'Bonus Bulanan',
                                              textAlign: TextAlign.left,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge
                                                  ?.copyWith(
                                                    color:
                                                        poinController
                                                                .point
                                                                .value >=
                                                            85
                                                        ? SDWcolors.textD
                                                        : SDWcolors.textD
                                                              .withAlpha(150),
                                                    fontSize: width * 0.028,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            Text(
                                              'Bonus Rp.200.000 pada setiap bulanya',
                                              textAlign: TextAlign.left,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge
                                                  ?.copyWith(
                                                    color:
                                                        poinController
                                                                .point
                                                                .value >=
                                                            85
                                                        ? SDWcolors.textD
                                                        : SDWcolors.textD
                                                              .withAlpha(150),
                                                    fontSize: width * 0.024,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              SizedBox(height: height * 0.0072),
                                              SizedBox(
                                                width: width * 0.16,
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                      poinController
                                                                  .point
                                                                  .value >=
                                                              85
                                                          ? Icons.check_circle
                                                          : Icons.cancel,
                                                      size: width * 0.04,
                                                      color:
                                                          poinController
                                                                  .point
                                                                  .value >=
                                                              85
                                                          ? SDWcolors.essentialD
                                                          : SDWcolors.essentialD
                                                                .withAlpha(150),
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.004,
                                                    ),
                                                    Text(
                                                      'min 85 Poin',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge
                                                          ?.copyWith(
                                                            color:
                                                                poinController
                                                                        .point
                                                                        .value >=
                                                                    85
                                                                ? SDWcolors
                                                                      .textD
                                                                : SDWcolors
                                                                      .textD
                                                                      .withAlpha(
                                                                        150,
                                                                      ),
                                                            fontSize:
                                                                width * 0.020,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      color: poinController.point.value >= 85
                                          ? SDWcolors.essentialD
                                          : SDWcolors.essentialD.withAlpha(150),
                                      thickness: 1,
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: height * 0.008),
                                            Text(
                                              'Bonus Mingguan',
                                              textAlign: TextAlign.left,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge
                                                  ?.copyWith(
                                                    color:
                                                        poinController
                                                                .point
                                                                .value >=
                                                            95
                                                        ? SDWcolors.textD
                                                        : SDWcolors.textD
                                                              .withAlpha(150),
                                                    fontSize: width * 0.028,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            Text(
                                              'Bonus Rp.50.000 pada setiap minggunya',
                                              textAlign: TextAlign.left,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge
                                                  ?.copyWith(
                                                    color:
                                                        poinController
                                                                .point
                                                                .value >=
                                                            95
                                                        ? SDWcolors.textD
                                                        : SDWcolors.textD
                                                              .withAlpha(150),
                                                    fontSize: width * 0.024,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              SizedBox(height: height * 0.0072),
                                              SizedBox(
                                                width: width * 0.16,
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                      poinController
                                                                  .point
                                                                  .value >=
                                                              95
                                                          ? Icons.check_circle
                                                          : Icons.cancel,
                                                      size: width * 0.04,
                                                      color:
                                                          poinController
                                                                  .point
                                                                  .value >=
                                                              95
                                                          ? SDWcolors.essentialD
                                                          : SDWcolors.essentialD
                                                                .withAlpha(150),
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.004,
                                                    ),
                                                    Text(
                                                      'min 95 Poin',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge
                                                          ?.copyWith(
                                                            color:
                                                                poinController
                                                                        .point
                                                                        .value >=
                                                                    95
                                                                ? SDWcolors
                                                                      .textD
                                                                : SDWcolors
                                                                      .textD
                                                                      .withAlpha(
                                                                        150,
                                                                      ),
                                                            fontSize:
                                                                width * 0.020,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      color: poinController.point.value >= 95
                                          ? SDWcolors.essentialD
                                          : SDWcolors.essentialD.withAlpha(150),
                                      thickness: 1,
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: height * 0.008),
                                            Text(
                                              'Bonus Uang Lembur',
                                              textAlign: TextAlign.left,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge
                                                  ?.copyWith(
                                                    color:
                                                        poinController
                                                                .point
                                                                .value >=
                                                            110
                                                        ? SDWcolors.textD
                                                        : SDWcolors.textD
                                                              .withAlpha(150),
                                                    fontSize: width * 0.028,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            Text(
                                              'Bonus Rp.20.000 untuk setiap jam lembur',
                                              textAlign: TextAlign.left,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge
                                                  ?.copyWith(
                                                    color:
                                                        poinController
                                                                .point
                                                                .value >=
                                                            110
                                                        ? SDWcolors.textD
                                                        : SDWcolors.textD
                                                              .withAlpha(150),
                                                    fontSize: width * 0.024,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              SizedBox(height: height * 0.0072),
                                              SizedBox(
                                                width: width * 0.16,
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                      poinController
                                                                  .point
                                                                  .value >=
                                                              110
                                                          ? Icons.check_circle
                                                          : Icons.cancel,
                                                      size: width * 0.04,
                                                      color:
                                                          poinController
                                                                  .point
                                                                  .value >=
                                                              110
                                                          ? SDWcolors.essentialD
                                                          : SDWcolors.essentialD
                                                                .withAlpha(150),
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.004,
                                                    ),
                                                    Text(
                                                      'min 110 Poin',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge
                                                          ?.copyWith(
                                                            color:
                                                                poinController
                                                                        .point
                                                                        .value >=
                                                                    110
                                                                ? SDWcolors
                                                                      .textD
                                                                : SDWcolors
                                                                      .textD
                                                                      .withAlpha(
                                                                        150,
                                                                      ),
                                                            fontSize:
                                                                width * 0.020,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      color: poinController.point.value >= 110
                                          ? SDWcolors.essentialD
                                          : SDWcolors.essentialD.withAlpha(150),
                                      thickness: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.012),
                      SizedBox(
                        width: width * 0.92,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Riwayat Perolehan Poin',
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    color: SDWcolors.textD,
                                    fontSize: width * 0.04,
                                  ),
                            ),
                            SizedBox(height: height * 0.012),
                            SizedBox(
                              width: width * 0.92,
                              child: Container(
                                height: height * 0.2,
                                decoration: BoxDecoration(
                                  color: SDWcolors.primary
                                ),
                              )
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
