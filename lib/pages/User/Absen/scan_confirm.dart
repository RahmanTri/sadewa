import 'package:flutter/material.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sadewa_fe/controllers/absen_confirm_controller.dart';
import 'package:sadewa_fe/controllers/user_controller.dart';
import 'package:sadewa_fe/pages/Effect/box_shadow.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/constants/urls.dart';
import 'package:sadewa_fe/constants/sdw_sizes.dart';
import 'package:sadewa_fe/routes/app_routes.dart';
import 'package:sadewa_fe/controllers/home_controller.dart';

class AbsenConfirm extends StatelessWidget {
  const AbsenConfirm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final absenConfirm = Get.put(AbsenConfirmController());
    // final userController = Get.put(UserController());

    return Obx(() {
      return Scaffold(
        backgroundColor: SDWcolors.bgD,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height * 0.035),
            SizedBox(
              height: height * 0.075,
              width: width,
              child: Stack(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () {
                      Get.offAllNamed(Routes.faceScan);
                    },
                    child: SizedBox(
                      width: width * 0.18,
                      height: height,
                      child: Icon(
                        FontAwesomeIcons.arrowLeft,
                        size: 30,
                        color: SDWcolors.textD,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      absenConfirm.isRegist
                          ? 'Konfirmasi Registrasi'
                          : absenConfirm.userData.user.value!.loggedIn == false
                          ? 'Konfirmasi Absen Masuk'
                          : 'Konfirmasi Absen Keluar',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: SDWcolors.textD,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.25,
              width: width,
              child: Center(
                child: Stack(
                  children: [
                    Container(
                      height: height * 0.15,
                      width: height * 0.15,
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: SDWcolors.essentialD,
                          width: 5,
                        ),
                        image: DecorationImage(
                          image: AssetImage(
                            '${AppUrls.imgAssets}default-profile.png',
                          ),
                        ),
                      ),
                      child:
                          absenConfirm.userData.user.value?.fotoProfil !=
                                  null &&
                              absenConfirm.userData.user.value?.fotoProfil != ''
                          ? Container(
                              height: height * 0.15,
                              width: height * 0.15,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(
                                    '${AppUrls.imgProfileUrl}${absenConfirm.userData.user.value?.fotoProfil}',
                                  ),
                                ),
                                border: Border.all(
                                  color: SDWcolors.white,
                                  width: 4,
                                ),
                              ),
                            )
                          : null,
                    ),
                    Container(
                      height: height * 0.055,
                      width: height * 0.055,
                      margin: EdgeInsets.only(left: width * 0.21),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: SDWcolors.success,
                        border: Border.all(
                          color: SDWcolors.essentialD,
                          width: 4,
                        ),
                      ),
                      child: Icon(
                        FontAwesomeIcons.check,
                        color: SDWcolors.essentialD,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * 0.05,
              width: width,
              child: Center(
                child: Text(
                  'Verifikasi Berhasil',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.05,
              width: width * 0.8,
              child: Text(
                'Pastikan data anda sesuai dengan data yang ada di bawah ini',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
              ),
            ),
            SizedBox(
              width: width * 0.85,
              height: height * 0.4,
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(height: height * 0.05),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 25,
                            bottom: 10,
                            right: 25,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [SDWboxShadow.shadow],
                            color: SDWcolors.bgL,
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: height * 0.02),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: height * 0.05,
                                          width: height * 0.06,
                                          child: Image(
                                            image: AssetImage(
                                              'assets/icons/employee_id.png',
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'ID Karyawan',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      foreground: Paint()
                                                        ..style =
                                                            PaintingStyle.stroke
                                                        ..strokeWidth = 1
                                                        ..color =
                                                            SDWcolors.textD,
                                                    ),
                                              ),
                                              Text(
                                                '${absenConfirm.userData.user.value?.idPerusahaan}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w100,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        SizedBox(
                                          height: height * 0.06,
                                          width: height * 0.06,
                                          child: Image(
                                            image: AssetImage(
                                              'assets/icons/user.png',
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Nama',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      foreground: Paint()
                                                        ..style =
                                                            PaintingStyle.stroke
                                                        ..strokeWidth = 1
                                                        ..color =
                                                            SDWcolors.textD,
                                                    ),
                                              ),
                                              Text(
                                                '${absenConfirm.userData.user.value?.namaLengkap}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w100,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: height * 0.06,
                                          width: height * 0.06,
                                          child: Image(
                                            image: AssetImage(
                                              'assets/icons/divisi.png',
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Divisi',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      foreground: Paint()
                                                        ..style =
                                                            PaintingStyle.stroke
                                                        ..strokeWidth = 1
                                                        ..color =
                                                            SDWcolors.textD,
                                                    ),
                                              ),
                                              Text(
                                                '${absenConfirm.userData.user.value?.namaDivisi}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w100,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        SizedBox(
                                          height: height * 0.06,
                                          width: height * 0.06,
                                          child: Image(
                                            image: AssetImage(
                                              'assets/icons/calendar.png',
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Tanggal',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      foreground: Paint()
                                                        ..style =
                                                            PaintingStyle.stroke
                                                        ..strokeWidth = 1
                                                        ..color =
                                                            SDWcolors.textD,
                                                    ),
                                              ),
                                              Text(
                                                absenConfirm.dateNow.value,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w100,
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(height: height * 0.03),
                      Center(
                        child: Container(
                          height: height * 0.035,
                          width: width * 0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: SDWcolors.primary,
                            boxShadow: [SDWboxShadow.shadow],
                          ),
                          child: Center(
                            child: Text(
                              'Data Karyawan',
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: SDWcolors.textL,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: height * 0.03,
              width: width,
              margin: EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () {
                      Get.offAllNamed(Routes.faceScan);
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        color: SDWcolors.bgL,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [SDWboxShadow.shadow],
                      ),
                      child: Center(
                        child: Text(
                          'Batal',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                // color: SDWcolors.primary,
                                fontWeight: FontWeight.bold,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 1
                                  ..color = SDWcolors.primary,
                              ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () {
                      absenConfirm.loginChecker();
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        color: SDWcolors.primary,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [SDWboxShadow.shadow],
                      ),
                      child: Center(
                        child: Text(
                          'Lanjut',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                // color: SDWcolors.primary,
                                fontWeight: FontWeight.bold,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 1
                                  ..color = SDWcolors.textL,
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
      );
    });
  }
}
