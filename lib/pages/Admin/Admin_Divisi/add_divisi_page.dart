import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/controllers/division_controller.dart';
import 'package:sadewa_fe/pages/Admin/Admin_Divisi/widgets/add_division_time_picker_dialog.dart';
import 'package:sadewa_fe/pages/Admin/Admin_Divisi/widgets/divisi_dialog.dart';
import 'package:sadewa_fe/pages/Admin/Admin_Divisi/widgets/division_area_tolerance_add_dialog.dart';
import 'package:sadewa_fe/pages/Admin/Admin_Divisi/widgets/division_time_tolerance_add_dialog.dart';
import '../../effect/box_shadow.dart';

class AddDivisiPage extends StatelessWidget {
  const AddDivisiPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          width: width,
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
          body: SizedBox(
            width: width,
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.024),
                SizedBox(
                  width: width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                          divisionController.resetAddDivision();
                        },
                        icon: Icon(Icons.arrow_back),
                        color: SDWcolors.white,
                      ),
                      IconButton(
                        onPressed: () {
                          DivisiDialog.showDialog(
                            context: context,
                            symbol: '!',
                            title: 'Buat Divisi Baru',
                            message:
                                'Apakah anda yakin ingin menambahkan divisi baru?',
                            onConfirm: () => DivisiDialog.showDialog(
                              context: context,
                              symbol: '!',
                              title: 'Peringatan',
                              message:
                                  'Pastikan semua informasi sudah terisi dengan benar',
                              onConfirm: () =>
                                  divisionController.createDivision(),
                              height: height,
                              width: width,
                            ),
                            height: height,
                            width: width,
                          );
                        },
                        icon: Icon(Icons.check),
                        color: SDWcolors.white,
                      ),
                    ],
                  ),
                ),
                Text(
                  'Tambah Divisi',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: SDWcolors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: height * 0.024,
                  ),
                ),

                //Informasi Box
                Container(
                  margin: EdgeInsets.only(top: height * 0.02),
                  width: width * 0.92,
                  height: height * 0.4,
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
                        'Informasi',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: SDWcolors.textD,
                          fontSize: height * 0.02,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: height * 0.01),

                      //Items

                      //Name
                      SizedBox(
                        height: height * 0.082,
                        width: width * 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: width * 0.02),
                                Text(
                                  'Nama Divisi',
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        color: SDWcolors.textD,
                                        fontSize: height * 0.015,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                            Container(
                              height: height * 0.05,
                              width: width * 0.8,
                              padding: EdgeInsets.only(
                                left: width * 0.02,
                                right: width * 0.02,
                              ),
                              decoration: BoxDecoration(
                                color: SDWcolors.bgD,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextField(
                                controller: divisionController.divisionNameAdd,
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      color: SDWcolors.textD,
                                      fontSize: height * 0.02,
                                      fontWeight: FontWeight.bold,
                                    ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: const EdgeInsets.only(
                                    left: 0,
                                    right: 0,
                                  ),
                                  hintText: 'Masukkan Nama Divisi',
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: SDWcolors.essential,
                                        fontSize: height * 0.018,
                                      ),
                                ),
                                onEditingComplete: () {
                                  divisionController.checkNameAddColumn();
                                },
                                onChanged: (value) {
                                  divisionController
                                          .divisionNameAddError
                                          .value =
                                      '';
                                },
                              ),
                            ),

                            //Error text
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width: width * 0.02),
                                Obx(
                                  () => Text(
                                    divisionController
                                        .divisionNameAddError
                                        .value,
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(
                                          color: SDWcolors.error,
                                          fontSize: height * 0.012,
                                          height: 1,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      //Office
                      SizedBox(
                        height: height * 0.082,
                        width: width * 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: width * 0.02),
                                Text(
                                  'Kantor',
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        color: SDWcolors.textD,
                                        fontSize: height * 0.015,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                            Container(
                              height: height * 0.04,
                              width: width * 0.8,
                              padding: EdgeInsets.only(
                                left: width * 0.02,
                                right: width * 0.02,
                              ),
                              decoration: BoxDecoration(
                                color: SDWcolors.bgD,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Obx(
                                () => DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    isExpanded: true,
                                    dropdownColor: SDWcolors.bgL,
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(
                                          color: SDWcolors.textD,
                                          fontSize: height * 0.02,
                                          fontWeight: FontWeight.bold,
                                        ),
                                    value: divisionController
                                        .divisionOfficeSelectedAdd
                                        .value,
                                    items: divisionController.availableOfficeAdd
                                        .map((office) {
                                          return DropdownMenuItem<String>(
                                            value: office,
                                            child: Text(
                                              office,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                    color: SDWcolors.textD,
                                                    fontSize: height * 0.02,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          );
                                        })
                                        .toList(),
                                    icon: Transform.rotate(
                                      angle: 3.14 / -2,
                                      child: Icon(
                                        Icons.chevron_left_outlined,
                                        color: SDWcolors.essentialD,
                                        size: 24,
                                      ),
                                    ),
                                    onChanged: (value) {
                                      if (value != null &&
                                          value !=
                                              divisionController
                                                  .divisionOfficeSelectedAdd
                                                  .value) {
                                        divisionController
                                                .divisionOfficeSelectedAdd
                                                .value =
                                            value;
                                        divisionController.applyOfficeAdd();
                                        divisionController.availableOfficeAdd
                                            .remove('Pilih Kantor');
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //Address
                      SizedBox(
                        height: height * 0.082,
                        width: width * 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: width * 0.02),
                                Text(
                                  'Alamat Kantor',
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        color: SDWcolors.textD,
                                        fontSize: height * 0.015,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                            Container(
                              height: height * 0.05,
                              width: width * 0.8,
                              padding: EdgeInsets.only(
                                left: width * 0.02,
                                right: width * 0.02,
                              ),
                              decoration: BoxDecoration(
                                color: SDWcolors.bgD,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextField(
                                controller:
                                    divisionController.divisionAddressAdd,
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      color: SDWcolors.textD,
                                      fontSize: height * 0.02,
                                      fontWeight: FontWeight.bold,
                                    ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: const EdgeInsets.only(
                                    left: 0,
                                    right: 0,
                                  ),
                                  hintText: 'Masukkan Alamat Kantor',
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: SDWcolors.essential,
                                        fontSize: height * 0.018,
                                      ),
                                ),
                                onEditingComplete: () {
                                  divisionController.checkAddressAddColumn();
                                },
                                onChanged: (value) {
                                  divisionController
                                          .divisionAddressAddError
                                          .value =
                                      '';
                                },
                              ),
                            ),

                            //Error text
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width: width * 0.02),
                                Obx(
                                  () => Text(
                                    divisionController
                                        .divisionAddressAddError
                                        .value,
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(
                                          color: SDWcolors.error,
                                          fontSize: height * 0.012,
                                          height: 1
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      //Jam dan Toleransi
                      SizedBox(
                        height: height * 0.1,
                        width: width * 0.8,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //Jam Masuk
                              Container(
                                width: width * 0.3,
                                height: height * 0.08,
                                margin: EdgeInsets.only(right: width * 0.02),
                                decoration: BoxDecoration(
                                  color: SDWcolors.bgD,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: SDWcolors.primary,
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Jam Masuk',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color: SDWcolors.textD,
                                            fontSize: height * 0.015,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Obx(
                                      () => Text(
                                        '${divisionController.jamMasukSelectedH}:${divisionController.jamMasukSelectedM}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              color: SDWcolors.textD,
                                              fontSize: height * 0.032,
                                              fontWeight: FontWeight.bold,
                                              height: 1
                                            ),
                                      ),
                                    ),

                                    GestureDetector(
                                      onTap: () {
                                        divisionController
                                                .selectJamMasuk
                                                .value =
                                            true;
                                        divisionController
                                            .addDivisionSelectTime();
                                        AddDivisionTimePicker.show(
                                          context: context,
                                          divisionController:
                                              divisionController,
                                          height: height,
                                          width: width,
                                        );
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: height * 0.02,
                                        width: width * 0.16,
                                        decoration: BoxDecoration(
                                          color: SDWcolors.primary,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Text(
                                          'Atur',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                color: SDWcolors.textL,
                                                fontSize: height * 0.012,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              //Jam Keluar
                              Container(
                                width: width * 0.3,
                                height: height * 0.08,
                                margin: EdgeInsets.only(right: width * 0.02),
                                decoration: BoxDecoration(
                                  color: SDWcolors.bgD,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: SDWcolors.primary,
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Jam Keluar',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color: SDWcolors.textD,
                                            fontSize: height * 0.015,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Obx(
                                      () => Text(
                                        '${divisionController.jamKeluarSelectedH}:${divisionController.jamKeluarSelectedM}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              color: SDWcolors.textD,
                                              fontSize: height * 0.032,
                                              fontWeight: FontWeight.bold,
                                              height: 1
                                            ),
                                      ),
                                    ),

                                    GestureDetector(
                                      onTap: () {
                                        divisionController
                                                .selectJamMasuk
                                                .value =
                                            false;
                                        divisionController
                                            .addDivisionSelectTime();
                                        AddDivisionTimePicker.show(
                                          context: context,
                                          divisionController:
                                              divisionController,
                                          height: height,
                                          width: width,
                                        );
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: height * 0.02,
                                        width: width * 0.16,
                                        decoration: BoxDecoration(
                                          color: SDWcolors.primary,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Text(
                                          'Atur',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                color: SDWcolors.textL,
                                                fontSize: height * 0.012,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              //Toleransi Waktu
                              Container(
                                width: width * 0.3,
                                height: height * 0.08,
                                margin: EdgeInsets.only(right: width * 0.02),
                                decoration: BoxDecoration(
                                  color: SDWcolors.bgD,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: SDWcolors.primary,
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Toleransi Waktu',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color: SDWcolors.textD,
                                            fontSize: height * 0.015,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    SizedBox(
                                      height: height * 0.032,
                                      width: width * 0.3,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Obx(
                                            () => Text(
                                              divisionController
                                                  .selectedAddTime
                                                  .value,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                    color: SDWcolors.textD,
                                                    fontSize: height * 0.032,
                                                    fontWeight: FontWeight.bold,
                                                    height: 1
                                                  ),
                                            ),
                                          ),
                                          Text(
                                            'Menit',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                  color: SDWcolors.textD,
                                                  fontSize: height * 0.012,
                                                  fontWeight: FontWeight.bold,
                                                  height: 1.5,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    GestureDetector(
                                      onTap: () {
                                        //Choose Time
                                        DivisionAddTimeTolerance.show(
                                          context: context,
                                          divisionController:
                                              divisionController,
                                          height: height,
                                          width: width,
                                        );
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: height * 0.02,
                                        width: width * 0.16,
                                        decoration: BoxDecoration(
                                          color: SDWcolors.primary,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Text(
                                          'Atur',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                color: SDWcolors.textL,
                                                fontSize: height * 0.012,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              //Toleransi Area
                              Container(
                                width: width * 0.3,
                                height: height * 0.08,
                                margin: EdgeInsets.only(right: width * 0.02),
                                decoration: BoxDecoration(
                                  color: SDWcolors.bgD,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: SDWcolors.primary,
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Toleransi Area',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color: SDWcolors.textD,
                                            fontSize: height * 0.015,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    SizedBox(
                                      height: height * 0.032,
                                      width: width * 0.3,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Obx(
                                            () => Text(
                                              divisionController
                                                  .selectedAddRange
                                                  .value,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                    color: SDWcolors.textD,
                                                    fontSize: height * 0.032,
                                                    fontWeight: FontWeight.bold,
                                                    height: 1
                                                  ),
                                            ),
                                          ),
                                          Text(
                                            'Meter',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                  color: SDWcolors.textD,
                                                  fontSize: height * 0.012,
                                                  fontWeight: FontWeight.bold,
                                                  height: 1.5,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    GestureDetector(
                                      onTap: () {
                                        //Choose Range
                                        DivisionAddAreaTolerance.show(
                                          context: context,
                                          divisionController:
                                              divisionController,
                                          height: height,
                                          width: width,
                                        );
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: height * 0.02,
                                        width: width * 0.16,
                                        decoration: BoxDecoration(
                                          color: SDWcolors.primary,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Text(
                                          'Atur',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                color: SDWcolors.textL,
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
                    ],
                  ),
                ),

                SizedBox(height: height * 0.02),

                //Map Box
                Container(
                  width: width * 0.92,
                  height: height * 0.45,
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
                      SizedBox(height: height * 0.005),

                      //Map
                      Obx(
                        () => Container(
                          width: width * 0.69,
                          height: width * 0.69,
                          decoration: BoxDecoration(
                            color: SDWcolors.grey.withAlpha(120),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              GoogleMap(
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(
                                    divisionController.initialLat,
                                    divisionController.initialLng.value,
                                  ),
                                  zoom: 8,
                                ),
                                onMapCreated: (controller) {
                                  divisionController.mapController = controller;
                                },
                                zoomControlsEnabled: false,
                                myLocationEnabled: true,
                                scrollGesturesEnabled:
                                    divisionController.selectingLocation.value,
                                zoomGesturesEnabled:
                                    divisionController.selectingLocation.value,
                                rotateGesturesEnabled:
                                    divisionController.selectingLocation.value,
                                tiltGesturesEnabled:
                                    divisionController.selectingLocation.value,
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
                                decoration: BoxDecoration(
                                  color: SDWcolors.green,
                                ),
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
                        width: width * 0.7,
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
                                divisionController.selectingLocation.value
                                    ? divisionController.currentLat.value
                                          .toString()
                                    : divisionController.addDivisionLat.value ==
                                          0.0
                                    ? 'Belum di-set'
                                    : divisionController.addDivisionLat.value
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
                        width: width * 0.7,
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
                                divisionController.selectingLocation.value
                                    ? divisionController.currentLng.value
                                          .toString()
                                    : divisionController.addDivisionLng.value ==
                                          0.0
                                    ? 'Belum di-set'
                                    : divisionController.addDivisionLng.value
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
                        () => divisionController.selectingLocation.value
                            ? ElevatedButton(
                                onPressed: () {
                                  divisionController.applyLocation();
                                },
                                style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                    SDWcolors.primary,
                                  ),
                                  visualDensity: VisualDensity.compact,
                                ),
                                child: Text(
                                  'Tempatkan',
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
                                  divisionController.selectLocation();
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
        ),
      ],
    );
  }
}
