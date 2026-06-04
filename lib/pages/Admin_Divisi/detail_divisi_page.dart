import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/controllers/division_controller.dart';
import 'package:sadewa_fe/controllers/karyawan_controller.dart';
import 'package:sadewa_fe/pages/Admin_Divisi/widgets/divisi_dialog.dart';
import 'package:sadewa_fe/pages/Admin_Divisi/widgets/division_address_edit_dialog.dart';
import 'package:sadewa_fe/pages/Admin_Divisi/widgets/division_area_tolerance_edit_dialog.dart';
import 'package:sadewa_fe/pages/Admin_Divisi/widgets/division_name_edit_dialog.dart';
import 'package:sadewa_fe/pages/Admin_Divisi/widgets/division_office_edit_dialog.dart';
import 'package:sadewa_fe/pages/Admin_Divisi/widgets/division_time_picker_dialog.dart';
import 'package:sadewa_fe/pages/Admin_Divisi/widgets/division_time_tolerance_edit_dialog.dart';
import 'package:sadewa_fe/routes/app_routes.dart';
import '../effect/box_shadow.dart';

class DetailDivisiPage extends StatelessWidget {
  const DetailDivisiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final KaryawanController karyawanController =
        Get.find<KaryawanController>();
    final DivisionController divisionController =
        Get.find<DivisionController>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // Future.microtask(() => karyawanController.fetchKaryawan());

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(height: height, width: width, color: SDWcolors.bgD),
        Container(
          height: height * 0.2,
          decoration: const BoxDecoration(
            color: SDWcolors.primary,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: SDWcolors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: width,
                height: height * 0.08,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                        divisionController.editingLocation.value = false;
                      },
                      icon: Icon(Icons.arrow_back),
                      color: SDWcolors.white,
                    ),

                    IconButton(
                      onPressed: () {
                        DivisiDialog.showDialog(
                          context: context,
                          symbol: '!',
                          title: 'Peringatan!',
                          message:
                              'Apakah anda yakin ingin menghapus divisi ini?',
                          onConfirm: () {
                            divisionController.deleteDivision();
                          },
                          height: height,
                          width: width,
                        );
                      },
                      icon: Icon(Icons.delete_forever_rounded),
                      color: SDWcolors.white,
                    ),
                  ],
                ),
              ),
              Obx(
                () => Text(
                  divisionController.showedDivisions.value?.namaDivisi ?? '',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: SDWcolors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: height * 0.024,
                  ),
                ),
              ),

              //5 Box
              SizedBox(
                height: height * 0.16,
                width: width * 0.92,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //Item 1
                      Container(
                        margin: EdgeInsets.only(right: width * 0.035),
                        height: width * 0.28,
                        width: width * 0.28,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(height * 0.01),
                        decoration: BoxDecoration(
                          color: SDWcolors.bgL,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [SDWboxShadow.shadow],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Jumlah Karyawan',
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: SDWcolors.textD,
                                    fontSize: height * 0.01,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            SizedBox(
                              height: height * 0.064,
                              child: Center(
                                child: Obx(
                                  () => Text(
                                    divisionController.showedDivisionsEms.value
                                        .toString(),
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(
                                          color: SDWcolors.primary,
                                          fontSize: height * 0.054,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                            // Text(
                            //   '75L | 75P',
                            //   style: Theme.of(context).textTheme.bodyLarge
                            //       ?.copyWith(
                            //         color: SDWcolors.textD,
                            //         fontSize: height * 0.012,
                            //         fontWeight: FontWeight.bold,
                            //       ),
                            // ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.karyawan);
                                karyawanController.fetchKaryawan();
                                karyawanController.applyFilter(
                                  divisionController
                                      .showedDivisions
                                      .value!
                                      .namaDivisi,
                                );
                                karyawanController.isLoading.value = true;
                              },
                              child: SizedBox(
                                height: height * 0.012,
                                child: Text(
                                  'lihat detail>>>',
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        color: SDWcolors.textD,
                                        fontSize: height * 0.008,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //Item 2
                      Container(
                        margin: EdgeInsets.only(right: width * 0.035),
                        height: width * 0.28,
                        width: width * 0.28,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(height * 0.01),
                        decoration: BoxDecoration(
                          color: SDWcolors.bgL,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [SDWboxShadow.shadow],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Jam Masuk',
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: SDWcolors.textD,
                                    fontSize: height * 0.01,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            SizedBox(
                              height: height * 0.064,
                              child: Center(
                                child: Obx(
                                  () => Text(
                                    divisionController
                                            .showedDivisions
                                            .value
                                            ?.waktuMasuk ??
                                        '00:00',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(
                                          color: SDWcolors.primary,
                                          fontSize: height * 0.032,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                //Edit Time
                                divisionController.editJamMasuk();
                                DivisionTimePicker.show(
                                  context: context,
                                  divisionController: divisionController,
                                  height: height,
                                  width: width,
                                );
                              },
                              child: Container(
                                height: height * 0.02,
                                width: width * 0.12,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: SDWcolors.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'Atur',
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        color: SDWcolors.white,
                                        fontSize: height * 0.012,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //Item 3
                      Container(
                        margin: EdgeInsets.only(right: width * 0.035),
                        height: width * 0.28,
                        width: width * 0.28,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(height * 0.01),
                        decoration: BoxDecoration(
                          color: SDWcolors.bgL,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [SDWboxShadow.shadow],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Jam Keluar',
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: SDWcolors.textD,
                                    fontSize: height * 0.01,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            SizedBox(
                              height: height * 0.064,
                              child: Center(
                                child: Obx(
                                  () => Text(
                                    divisionController
                                            .showedDivisions
                                            .value
                                            ?.waktuKeluar ??
                                        '00:00',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(
                                          color: SDWcolors.primary,
                                          fontSize: height * 0.032,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                //Edit Time
                                divisionController.editJamKeluar();
                                DivisionTimePicker.show(
                                  context: context,
                                  divisionController: divisionController,
                                  height: height,
                                  width: width,
                                );
                              },
                              child: Container(
                                height: height * 0.02,
                                width: width * 0.12,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: SDWcolors.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'Atur',
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        color: SDWcolors.white,
                                        fontSize: height * 0.012,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //Item 4
                      Container(
                        margin: EdgeInsets.only(right: width * 0.035),
                        height: width * 0.28,
                        width: width * 0.28,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(height * 0.01),
                        decoration: BoxDecoration(
                          color: SDWcolors.bgL,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [SDWboxShadow.shadow],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Toleransi Waktu',
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: SDWcolors.textD,
                                    fontSize: height * 0.01,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            SizedBox(
                              height: height * 0.064,
                              child: Obx(
                                () => Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      divisionController
                                              .showedDivisions
                                              .value
                                              ?.toleransiWaktu
                                              .toString() ??
                                          '0',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color: SDWcolors.primary,
                                            fontSize: height * 0.032,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Text(
                                      'Menit',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color: SDWcolors.primary,
                                            fontSize: height * 0.012,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                //Edit Toleransi Waktu
                                divisionController.editTimeTolerance();
                                DivisionEditTimeTolerance.show(
                                  context: context,
                                  divisionController: divisionController,
                                  height: height,
                                  width: width,
                                );
                              },
                              child: Container(
                                height: height * 0.02,
                                width: width * 0.12,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: SDWcolors.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'Atur',
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        color: SDWcolors.white,
                                        fontSize: height * 0.012,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //Item 5
                      Container(
                        height: width * 0.28,
                        width: width * 0.28,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(height * 0.01),
                        decoration: BoxDecoration(
                          color: SDWcolors.bgL,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [SDWboxShadow.shadow],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Toleransi Area',
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: SDWcolors.textD,
                                    fontSize: height * 0.01,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            SizedBox(
                              height: height * 0.064,
                              child: Obx(
                                () => Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      divisionController
                                              .showedDivisions
                                              .value
                                              ?.toleransiArea
                                              .toString() ??
                                          '0',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color: SDWcolors.primary,
                                            fontSize: height * 0.032,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Text(
                                      'Meter',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color: SDWcolors.primary,
                                            fontSize: height * 0.012,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                //Edit Toleransi Area
                                divisionController.editAreaTolerance();
                                DivisionEditAreaTolerance.show(
                                  context: context,
                                  divisionController: divisionController,
                                  height: height,
                                  width: width,
                                );
                              },
                              child: Container(
                                height: height * 0.02,
                                width: width * 0.12,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: SDWcolors.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'Atur',
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        color: SDWcolors.white,
                                        fontSize: height * 0.012,
                                        fontWeight: FontWeight.bold,
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

              //Detail Box
              Container(
                width: width * 0.92,
                height: height * 0.172,
                padding: EdgeInsets.all(width * 0.02),
                decoration: BoxDecoration(
                  color: SDWcolors.bgL,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [SDWboxShadow.shadow],
                ),
                child: Column(
                  children: [
                    //Title
                    Text(
                      'Detail',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: SDWcolors.textD,
                        fontSize: height * 0.02,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    //Items
                    SizedBox(
                      width: width * 0.92,
                      height: height * 0.12,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            //Item 1
                            SizedBox(
                              height: height * 0.06,
                              width: width * 0.8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nama Divisi:',
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(
                                          color: SDWcolors.textD,
                                          fontSize: height * 0.016,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: width * 0.68,
                                        height: height * 0.016,
                                        child: Obx(
                                          () => SingleChildScrollView(
                                            physics:
                                                const BouncingScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            child: Text(
                                              divisionController
                                                      .showedDivisions
                                                      .value
                                                      ?.namaDivisi ??
                                                  '-',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                    color: SDWcolors.textD,
                                                    fontSize: height * 0.016,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          divisionController.editName();
                                          DivisionEditName.show(
                                            context: context,
                                            divisionController:
                                                divisionController,
                                            height: height,
                                            width: width,
                                          );
                                        },
                                        child: Container(
                                          height: height * 0.016,
                                          width: width * 0.1,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: SDWcolors.primary,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Text(
                                            'Ubah',
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                  color: SDWcolors.white,
                                                  fontSize: height * 0.01,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(color: SDWcolors.textD),
                                ],
                              ),
                            ),

                            //Item 2
                            SizedBox(
                              height: height * 0.06,
                              width: width * 0.8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Kantor:',
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(
                                          color: SDWcolors.textD,
                                          fontSize: height * 0.016,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: width * 0.68,
                                        height: height * 0.016,
                                        child: Obx(
                                          () => SingleChildScrollView(
                                            physics:
                                                const BouncingScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            child: Text(
                                              divisionController
                                                          .showedDivisions
                                                          .value
                                                          ?.kantor ==
                                                      ''
                                                  ? 'belum di-set'
                                                  : divisionController
                                                        .showedDivisions
                                                        .value!
                                                        .kantor,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                    color: SDWcolors.textD,
                                                    fontSize: height * 0.016,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          divisionController.editOffice();
                                          DivisionEditOffice.show(
                                            context: context,
                                            divisionController:
                                                divisionController,
                                            height: height,
                                            width: width,
                                          );
                                        },
                                        child: Container(
                                          height: height * 0.016,
                                          width: width * 0.1,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: SDWcolors.primary,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Text(
                                            'Ubah',
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                  color: SDWcolors.white,
                                                  fontSize: height * 0.01,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(color: SDWcolors.textD),
                                ],
                              ),
                            ),

                            //Item 3
                            SizedBox(
                              height: height * 0.06,
                              width: width * 0.8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Alamat Kantor:',
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(
                                          color: SDWcolors.textD,
                                          fontSize: height * 0.016,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: width * 0.68,
                                        height: height * 0.016,
                                        child: Obx(
                                          () => SingleChildScrollView(
                                            physics:
                                                const BouncingScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            child: Text(
                                              divisionController
                                                          .showedDivisions
                                                          .value
                                                          ?.alamatKantor ==
                                                      ''
                                                  ? 'belum di-set'
                                                  : divisionController
                                                        .showedDivisions
                                                        .value!
                                                        .alamatKantor,

                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                    color: SDWcolors.textD,
                                                    fontSize: height * 0.016,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          divisionController.editAddress();
                                          DivisionEditAddress.show(
                                            context: context,
                                            divisionController:
                                                divisionController,
                                            height: height,
                                            width: width,
                                          );
                                        },
                                        child: Container(
                                          height: height * 0.016,
                                          width: width * 0.1,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: SDWcolors.primary,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Text(
                                            'Ubah',
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                  color: SDWcolors.white,
                                                  fontSize: height * 0.01,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(color: SDWcolors.textD),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: height * 0.02),

              //Map Box
              Container(
                width: width * 0.92,
                height: height * 0.5,
                padding: EdgeInsets.all(width * 0.02),
                decoration: BoxDecoration(
                  color: SDWcolors.bgL,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [SDWboxShadow.shadow],
                ),
                child: Column(
                  children: [
                    Text(
                      'Lokasi',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: SDWcolors.textD,
                        fontSize: height * 0.02,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: height * 0.02),

                    //Map
                    Obx(
                      () => Container(
                        width: width * 0.8,
                        height: width * 0.8,
                        decoration: BoxDecoration(
                          color: SDWcolors.grey.withAlpha(120),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                  divisionController
                                              .showedDivisions
                                              .value
                                              ?.latitude ==
                                          0
                                      ? divisionController.initialLat
                                      : divisionController
                                            .showedDivisions
                                            .value!
                                            .latitude,
                                  divisionController
                                              .showedDivisions
                                              .value
                                              ?.longitude ==
                                          0
                                      ? divisionController.initialLng.value
                                      : divisionController
                                            .showedDivisions
                                            .value!
                                            .longitude,
                                ),
                                zoom: 17,
                              ),
                              onMapCreated: (controller) {
                                divisionController.mapController = controller;
                              },
                              zoomControlsEnabled: false,
                              myLocationEnabled: true,
                              scrollGesturesEnabled:
                                  divisionController.editingLocation.value,
                              zoomGesturesEnabled:
                                  divisionController.editingLocation.value,
                              rotateGesturesEnabled:
                                  divisionController.editingLocation.value,
                              tiltGesturesEnabled:
                                  divisionController.editingLocation.value,
                              onCameraMove: (position) {
                                divisionController.currentLat.value =
                                    position.target.latitude;
                                divisionController.currentLng.value =
                                    position.target.longitude;
                              },
                            ),
                            Container(
                              width: width * 0.001,
                              height: width * 0.8,
                              decoration: BoxDecoration(color: SDWcolors.red),
                            ),
                            Container(
                              width: width * 0.8,
                              height: width * 0.001,
                              decoration: BoxDecoration(color: SDWcolors.green),
                            ),
                            Icon(
                              Icons.circle,
                              color: SDWcolors.essentialDR,
                              size: width * 0.01,
                            ),
                          ],
                        ),
                      ),
                    ),

                    //Coordinates
                    SizedBox(
                      width: width * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Latitude: ',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: SDWcolors.textD,
                                  fontSize: height * 0.016,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                          Obx(
                            () => Text(
                              divisionController.editingLocation.value
                                  ? divisionController.currentLat.value
                                        .toString()
                                  : divisionController
                                            .showedDivisions
                                            .value
                                            ?.latitude ==
                                        0.0
                                  ? 'belum di-set'
                                  : divisionController
                                        .showedDivisions
                                        .value!
                                        .latitude
                                        .toString(),

                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: SDWcolors.textD,
                                    fontSize: height * 0.016,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      width: width * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Longitude: ',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: SDWcolors.textD,
                                  fontSize: height * 0.016,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                          Obx(
                            () => Text(
                              divisionController.editingLocation.value
                                  ? divisionController.currentLng.value
                                        .toString()
                                  : divisionController
                                            .showedDivisions
                                            .value!
                                            .latitude ==
                                        0.0
                                  ? 'belum di-set'
                                  : divisionController
                                        .showedDivisions
                                        .value!
                                        .longitude
                                        .toString(),
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: SDWcolors.textD,
                                    fontSize: height * 0.016,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Obx(
                      () => divisionController.editingLocation.value
                          ? ElevatedButton(
                              onPressed: () {
                                DivisiDialog.showDialog(
                                  context: context,
                                  symbol: '!',
                                  title: 'Peringatan',
                                  message: 'Yakin ingin menyimpan lokasi ini?',
                                  onConfirm: () {
                                    divisionController.saveLocation();
                                  },
                                  onCancel: () {
                                    divisionController.resetEditing();
                                  },
                                  height: height,
                                  width: width,
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  SDWcolors.primary,
                                ),
                                visualDensity: VisualDensity.compact,
                              ),
                              child: Text(
                                'Simpan',
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      color: SDWcolors.white,
                                      fontSize: height * 0.02,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                divisionController.editLocation();
                              },
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  SDWcolors.primary,
                                ),
                                visualDensity: VisualDensity.compact,
                              ),
                              child: Text(
                                'Atur',
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      color: SDWcolors.white,
                                      fontSize: height * 0.012,
                                      fontWeight: FontWeight.bold,
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
      ],
    );
  }
}
