import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/controllers/karyawan_controller.dart';
import 'package:sadewa_fe/constants/urls.dart';
import 'package:sadewa_fe/pages/Admin/Admin_ViewKaryawan/widgets/karyawan_attribute_edit_dropdown.dart';
import 'package:sadewa_fe/pages/Admin/Admin_ViewKaryawan/widgets/karyawan_attribute_edit_form.dart';
import 'package:sadewa_fe/pages/Admin/Admin_ViewKaryawan/widgets/karyawan_attribute.dart';
import 'package:sadewa_fe/pages/Admin/Admin_ViewKaryawan/widgets/karyawan_dialog.dart';
import 'package:sadewa_fe/routes/app_routes.dart';

class EditKaryawan extends StatelessWidget {
  const EditKaryawan({super.key});

  @override
  Widget build(BuildContext context) {
    final KaryawanController karyawanController =
        Get.find<KaryawanController>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: SDWcolors.bgD,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: height * 0.36,
            width: width,
            decoration: BoxDecoration(
              color: SDWcolors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.028),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => {Get.back()},
                        icon: Icon(Icons.arrow_back, color: SDWcolors.white),
                      ),

                      IconButton(
                        onPressed: () {
                          KaryawanDialog.showDialog(
                            context: context,
                            symbol: '!',
                            title: 'Peringatan!',
                            message: 'Anda yakin ingin menghapus karyawan ini?',
                            onConfirm: () {
                              karyawanController.deleteKaryawan();
                            },
                            height: height,
                            width: width,
                          );
                        },
                        icon: Icon(
                          Icons.delete_forever_rounded,
                          color: SDWcolors.white,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: height * 0.02),
                    height: height * 0.12,
                    width: height * 0.12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                          '${AppUrls.imgAssets}default-profile.png',
                        ),
                      ),
                      border: Border.all(color: SDWcolors.white, width: 4),
                    ),
                    child:
                        karyawanController.karyawanView.value!.fotoProfil !=
                                'null' &&
                            karyawanController.karyawanView.value!.fotoProfil !=
                                ''
                        ? Container(
                            width: height * 0.12,
                            height: height * 0.12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  '${AppUrls.imgProfileUrl}${karyawanController.karyawanView.value!.fotoProfil}',
                                ),
                              ),
                            ),
                          )
                        : null,
                  ),
                  SizedBox(
                    width: width * 0.92,
                    child: Text(
                      karyawanController.karyawanView.value!.namaLengkap,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: SDWcolors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: height * 0.032,
                      ),
                    ),
                  ),
                  Text(
                    karyawanController.karyawanView.value!.namaDivisi,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: SDWcolors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: height * 0.022,
                    ),
                  ),
                  Container(
                    height: height * 0.024,
                    margin: EdgeInsets.only(top: height * 0.004),
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: SDWcolors.white,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          karyawanController.karyawanView.value!.idPerusahaan,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: SDWcolors.primary,
                                fontWeight: FontWeight.normal,
                                fontSize: height * 0.018,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: height * 0.4),
              SizedBox(
                width: width * 0.92,
                height: height * 0.512,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      KaryawanAttributeForm(
                        label: 'Nama',
                        controller: karyawanController.namaLengkap,
                        value: 'Masukkan Nama Lengkap',
                        icon: Icons.person,
                        height: height,
                        width: width,
                      ),

                      KaryawanAttributeForm(
                        label: 'Email',
                        controller: karyawanController.email,
                        value: 'Masukkan Email',
                        icon: Icons.email,
                        height: height,
                        width: width,
                      ),

                      KaryawanAttributeForm(
                        label: 'Nomor Telepon',
                        controller: karyawanController.noTlp,
                        value: 'Masukkan Nomor Telepon',
                        icon: Icons.phone,
                        height: height,
                        width: width,
                      ),

                      KaryawanAttributeDropdown(
                        label: 'Divisi',
                        icon: Icons.settings,
                        height: height,
                        width: width,
                      ),

                      Obx(
                        () => KaryawanAttribute(
                          label: 'Data Wajah',
                          value:
                              karyawanController.karyawanView.value!.dataWajah,
                          icon: Icons.tag_faces_rounded,
                          height: height,
                          width: width,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => {
                  KaryawanDialog.showDialog(
                    context: context,
                    symbol: '!',
                    title: 'Peringatan',
                    message: 'Yakin ingin menyimpan perubahan?',
                    onConfirm: () {
                      karyawanController.editEmployee();
                      Get.back();
                    },
                    height: height,
                    width: width,

                    // symbol: '?',
                    // title: 'ID',
                    // message: 'Id Divisi: ${karyawanController.selectedDivisionId.value}',
                  ),
                },
                child: Container(
                  height: height * 0.036,
                  width: width * 0.4,
                  padding: EdgeInsets.only(top: 4, bottom: 4),
                  margin: EdgeInsets.only(top: height * 0.02),
                  decoration: BoxDecoration(
                    color: SDWcolors.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: karyawanController.processing.value
                      ? Center(
                          child: CircularProgressIndicator(
                            color: SDWcolors.white,
                          ),
                        )
                      : Center(
                          child: Text(
                            'Simpan',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: SDWcolors.white,
                                  fontSize: height * 0.018,
                                ),
                          ),
                        ),
                ),
              ),
              // Obx(() =>
              //   karyawanController.showSuccessDialog.value ?
              // )
            ],
          ),
        ],
      ),
    );
  }
}
