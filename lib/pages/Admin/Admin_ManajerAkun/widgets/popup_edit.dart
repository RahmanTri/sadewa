import 'package:flutter/material.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/constants/urls.dart';
import 'package:sadewa_fe/controllers/akun_controller.dart';
import 'package:sadewa_fe/pages/Admin/Admin_ManajerAkun/widgets/akun_dialog.dart';
import 'package:sadewa_fe/pages/Effect/box_shadow.dart';
import 'package:get/get.dart';

class PopUpEdit {
  static void show({
    required BuildContext context,
    required AkunController akunController,
    required double height,
    required double width,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Edit Akun',
      barrierColor: SDWcolors.essentialDR.withAlpha(80),
      pageBuilder: (contex, animation, secondaryAnimation) {
        return Material(
          color: SDWcolors.transparent,
          child: Stack(
            alignment: AlignmentGeometry.topCenter,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    color: SDWcolors.essentialDR.withAlpha(80),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      padding: EdgeInsets.only(top: height * 0.02),
                      height: height * 0.64,
                      width: width * 0.92,
                      decoration: BoxDecoration(
                        color: SDWcolors.bgD,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [SDWboxShadow.shadow],
                      ),
                      child: Stack(
                        alignment: AlignmentGeometry.topCenter,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Edit Akun',
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      color: SDWcolors.primary,
                                      fontSize: height * 0.024,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              SizedBox(height: height * 0.02),
                              Container(
                                height: height * 0.1,
                                width: height * 0.1,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: SDWcolors.primary,
                                    width: 4,
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      '${AppUrls.imgAssets}default-profile.png',
                                    ),
                                  ),
                                ),
                              ),

                              //Username
                              SizedBox(
                                width: width * 0.8,
                                height: height * 0.1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Username',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color: SDWcolors.textD,
                                            fontSize: height * 0.020,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    SizedBox(height: height * 0.006),
                                    Container(
                                      height: height * 0.06,
                                      width: width * 0.8,
                                      alignment: AlignmentGeometry.center,
                                      decoration: BoxDecoration(
                                        color: SDWcolors.bgL,
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: TextField(
                                        controller: akunController.username,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              color: SDWcolors.textD,
                                              fontSize: height * 0.024,
                                            ),
                                        decoration: InputDecoration(
                                          hintText: 'Masukkan Username',
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                            left: width * 0.04,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              //Email
                              SizedBox(
                                width: width * 0.8,
                                height: height * 0.1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Email',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color: SDWcolors.textD,
                                            fontSize: height * 0.020,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    SizedBox(height: height * 0.006),
                                    Container(
                                      height: height * 0.06,
                                      width: width * 0.8,
                                      alignment: AlignmentGeometry.center,
                                      decoration: BoxDecoration(
                                        color: SDWcolors.bgL,
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: TextField(
                                        controller: akunController.email,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              color: SDWcolors.textD,
                                              fontSize: height * 0.024,
                                            ),
                                        decoration: InputDecoration(
                                          hintText: 'Masukkan Email',
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                            left: width * 0.04,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              //Password
                              SizedBox(
                                width: width * 0.8,
                                height: height * 0.1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Ganti Password',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color: SDWcolors.textD,
                                            fontSize: height * 0.020,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    SizedBox(height: height * 0.006),
                                    Container(
                                      height: height * 0.06,
                                      width: width * 0.8,
                                      alignment: AlignmentGeometry.center,
                                      decoration: BoxDecoration(
                                        color: SDWcolors.bgL,
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: TextField(
                                        controller: akunController.password,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              color: SDWcolors.textD,
                                              fontSize: height * 0.024,
                                            ),
                                        decoration: InputDecoration(
                                          hintText: 'Masukkan Password Baru',
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                            left: width * 0.04,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              //Role
                              Obx(
                                () => SizedBox(
                                  width: width * 0.8,
                                  height: height * 0.1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Role',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              color: SDWcolors.textD,
                                              fontSize: height * 0.020,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      SizedBox(height: height * 0.006),
                                      Container(
                                        height: height * 0.06,
                                        width: width * 0.8,
                                        padding: EdgeInsets.only(
                                          left: width * 0.04,
                                          right: width * 0.04,
                                        ),
                                        decoration: BoxDecoration(
                                          color: SDWcolors.bgL,
                                          borderRadius: BorderRadius.circular(
                                            40,
                                          ),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            isExpanded: true,
                                            isDense: true,
                                            dropdownColor: SDWcolors.bgL,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                  color: SDWcolors.textD,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: height * 0.020,
                                                ),
                                            icon: Transform.rotate(
                                              angle: 3.14 / -2,
                                              child: Icon(
                                                Icons.chevron_left_outlined,
                                                color: SDWcolors.essentialD,
                                                size: 24,
                                              ),
                                            ),
                                            value: akunController
                                                .selectedRole
                                                .value,
                                            items: akunController.availableRoles
                                                .map((role) {
                                                  return DropdownMenuItem<
                                                    String
                                                  >(
                                                    value: role,
                                                    child:
                                                        SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Text(role),
                                                        ),
                                                  );
                                                })
                                                .toList(),
                                            onChanged: (newValue) {
                                              if (newValue != null) {
                                                akunController
                                                        .selectedRole
                                                        .value =
                                                    newValue;
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Obx(
                                  () => Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () => {
                                          AkunDialog.showDialog(
                                            context: context,
                                            symbol: '!',
                                            title: 'Peringatan!',
                                            message:
                                                'Yakin ingin menyimpan perubahan?',
                                            onConfirm: () => {
                                              akunController.updateAccount(),
                                              Navigator.pop(context),
                                            },
                                            height: height,
                                            width: width,
                                          ),
                                        },
                                        child: Container(
                                          height: height * 0.04,
                                          width: width * 0.32,
                                          decoration: BoxDecoration(
                                            color: SDWcolors.primary,
                                            borderRadius: BorderRadius.circular(
                                              32,
                                            ),
                                          ),
                                          child: akunController.updating.value
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                        color: SDWcolors.white,
                                                      ),
                                                )
                                              : Center(
                                                  child: Text(
                                                    'Simpan',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge
                                                        ?.copyWith(
                                                          color:
                                                              SDWcolors.white,
                                                        ),
                                                  ),
                                                ),
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
                              SizedBox(
                                height: height * 0.08,
                                width: width * 0.92,
                                child: Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          AkunDialog.showDialog(
                                            context: context,
                                            symbol: '!',
                                            title: 'Peringatan!',
                                            message:
                                                'Yakin ingin menghapus akun?',
                                            onConfirm: () {
                                              akunController.deleteAccount();
                                              Navigator.pop(context);
                                            },
                                            height: height,
                                            width: width,
                                          );
                                        },
                                        icon: Icon(
                                          Icons.delete_forever,
                                          color: SDWcolors.error,
                                          size: height * 0.032,
                                        ),
                                      ),
                                      SizedBox(width: width * 0.032),
                                    ],
                                  ),
                                ),
                              ),
                            ],
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
      },
    );
  }
}
