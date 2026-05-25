import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/controllers/karyawan_controller.dart';
import 'package:sadewa_fe/constants/urls.dart';
import 'package:sadewa_fe/pages/Admin_ViewKaryawan/widgets/karyawan_attribute.dart';
import 'package:sadewa_fe/pages/Admin_ViewKaryawan/widgets/karyawan_attribute_wbutton.dart';
import 'package:sadewa_fe/pages/Admin_ViewKaryawan/widgets/karyawan_dialog.dart';
import 'package:sadewa_fe/routes/app_routes.dart';

class ViewKaryawanDetails extends StatelessWidget {
  const ViewKaryawanDetails({super.key});

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
                        onPressed: () => {
                          karyawanController.refreshData(),
                          Get.back(),
                        },
                        icon: Icon(Icons.arrow_back, color: SDWcolors.white),
                      ),

                      IconButton(
                        onPressed: () => {
                          karyawanController.goToedit(),
                          Get.toNamed(Routes.editKaryawan),
                        },
                        icon: Icon(Icons.edit, color: SDWcolors.white),
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
                  Text(
                    karyawanController.karyawanView.value!.namaLengkap,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: SDWcolors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: height * 0.032,
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
          Obx(
            () => Column(
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
                        Obx(
                          () => KaryawanAttribute(
                            label: 'Nama',
                            value: karyawanController
                                .karyawanView
                                .value!
                                .namaLengkap,
                            icon: Icons.person,
                            height: height,
                            width: width,
                          ),
                        ),
                        Obx(
                          () => KaryawanAttribute(
                            label: 'Email',
                            value: karyawanController.karyawanView.value!.email,
                            icon: Icons.email,
                            height: height,
                            width: width,
                          ),
                        ),
                        Obx(
                          () => KaryawanAttribute(
                            label: 'Nomor Telepon',
                            value: karyawanController.karyawanView.value!.noTlp,
                            icon: Icons.phone,
                            height: height,
                            width: width,
                          ),
                        ),
                        Obx(
                          () => KaryawanAttribute(
                            label: 'Divisi',
                            value: karyawanController
                                .karyawanView
                                .value!
                                .namaDivisi,
                            icon: Icons.settings,
                            height: height,
                            width: width,
                          ),
                        ),
                        Obx(() {
                          return KaryawanAttributeWButton(
                            label: 'Data Wajah',
                            value: karyawanController
                                .karyawanView
                                .value!
                                .dataWajah,
                            icon: Icons.tag_faces_rounded,
                            buttonText: 'Reset',
                            onPress: () => {
                              KaryawanDialog.showDialog(
                                context: context,
                                symbol: '!',
                                title: 'Peringatan!',
                                message: 'Yakin reset data wajah karyawan ini?',
                                onConfirm: () => {
                                  karyawanController.resetEmployeeFD(),
                                },
                                height: height,
                                width: width,
                              ),
                            },
                            height: height,
                            width: width,
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => {
                    KaryawanDialog.showDialog(
                      context: context,
                      symbol: '!',
                      title: 'Peringatan!',
                      message: 'Yakin reset password karyawan ini?',
                      onConfirm: () => {karyawanController.resetEmployeePW()},
                      height: height,
                      width: width,
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
                            child: SizedBox(
                              height: height * 0.024,
                              width: height * 0.024,
                              child: CircularProgressIndicator(
                                color: SDWcolors.white,
                              ),
                            ),
                          )
                        : Center(
                            child: Text(
                              'Reset Password',
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: SDWcolors.white,
                                    fontSize: height * 0.018,
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
  }
}
