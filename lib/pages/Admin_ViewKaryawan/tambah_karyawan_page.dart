import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/constants/urls.dart';
import 'package:sadewa_fe/controllers/karyawan_controller.dart';
import 'package:sadewa_fe/pages/Admin_ViewKaryawan/widgets/tambah_karyawan_dropdown_formfield.dart';
import 'package:sadewa_fe/pages/Admin_ViewKaryawan/widgets/tambah_karyawan_formfield.dart';
import '../effect/box_shadow.dart';

class AddKaryawanPage extends StatefulWidget {
  const AddKaryawanPage({super.key});

  @override
  State<AddKaryawanPage> createState() => _AddKaryawanPageState();
}

class _AddKaryawanPageState extends State<AddKaryawanPage> {
  late KaryawanController karyawanController;
  @override
  void initState() {
    karyawanController = Get.find<KaryawanController>();
    super.initState();
  }

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
          'Tambahkan Karyawan',
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
      backgroundColor: SDWcolors.bgD,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.06),
                Container(
                  width: width * 0.92,
                  height: height * 0.82,
                  decoration: BoxDecoration(
                    color: SDWcolors.bgD,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [SDWboxShadow.shadow],
                  ),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: height * 0.08,
                            width: height * 0.08,
                            margin: EdgeInsets.only(top: height * 0.02),
                            decoration: BoxDecoration(
                              color: SDWcolors.primary,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                  '${AppUrls.imgAssets}default-profile.png',
                                ),
                              ),
                              border: Border.all(
                                color: SDWcolors.primary,
                                width: 4,
                              ),
                            ),
                          ),
                          KaryawanFormField(
                            title: 'Username',
                            hint: 'Masukkan Username',
                          ),
                          KaryawanFormField(
                            title: 'Email',
                            hint: 'Masukkan Email',
                          ),
                          KaryawanFormField(
                            title: 'Password',
                            hint: 'Masukkan Password',
                          ),
                          KaryawanFormField(
                            title: 'Nama Lengkap',
                            hint: 'Masukkan Nama Lengkap',
                          ),
                          KaryawanFormField(
                            title: 'No. Telepon',
                            hint: 'Masukkan No. Telepon',
                          ),
                          KaryawanDropdownFormField(title: 'Divisi'),
                          SizedBox(height: height * 0.004),
                          ElevatedButton(
                            onPressed: () {
                              karyawanController.registerEmployee();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: SDWcolors.primary,
                            ),
                            child: Text(
                              'Simpan',
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: SDWcolors.white,
                                    fontSize: height * 0.02,
                                  ),
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
        ],
      ),
    );
  }
}
