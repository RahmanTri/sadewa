import 'package:flutter/material.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/controllers/user_controller.dart';
import 'package:sadewa_fe/pages/User/Profile/widget/edit_profile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sadewa_fe/constants/urls.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result){
        if(didPop){
          userController.isEditing.value = false;

          userController.nameController.text = userController.user.value?.namaLengkap ?? '';
          userController.emailController.text = userController.user.value?.email ?? '';
          userController.phoneController.text = userController.user.value?.noTelp ?? '';
        }
      },
    
    child: Scaffold(
      appBar: AppBar(
        backgroundColor: SDWcolors.primary,
        toolbarHeight: 60,
        title: Text(
          'Edit Profile',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: SDWcolors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            userController.isEditing.value = false;
          
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
          color: SDWcolors.white,
        ),
      ),
      backgroundColor: SDWcolors.bgD,
      body: Stack(
        children: [
          Container(decoration: BoxDecoration(color: SDWcolors.primary)),
          Positioned(
            top: 6,
            left: 0,
            right: 0,
            child: Center(
              child: Obx(() {
                final fotoProfil = userController.user.value?.fotoProfil;

                ImageProvider image;

                if (userController.selectedImagePath.value.isNotEmpty) {
                  image = FileImage(
                    File(userController.selectedImagePath.value),
                  );
                } else if (fotoProfil != null &&
                    fotoProfil != '' &&
                    fotoProfil != 'null') {
                  image = NetworkImage('${AppUrls.imgProfileUrl}$fotoProfil');
                } else {
                  image = const AssetImage(
                    '${AppUrls.imgAssets}default-profile.png',
                  );
                }
                return Stack(
                  children: [
                    CircleAvatar(
                      radius: 63.5,
                      backgroundColor: SDWcolors.bgL,
                      child: CircleAvatar(radius: 60, backgroundImage: image),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => _showPicker(context, userController),
                        child: Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: SDWcolors.bgL,
                            shape: BoxShape.circle,
                          ),

                          child: Transform.flip(
                            flipX: true,
                            child: Icon(
                              Icons.add_a_photo_outlined,
                              color: SDWcolors.primary,
                              size: 21,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),

          Positioned(
            top: 170,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: SDWcolors.bgL,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(33),
                  topRight: Radius.circular(33),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Obx(
                  () => Column(              
                    children: [
                      editProfile(
                        icon: Icons.person,
                        title: 'Nama',
                        value: userController.user.value!.namaLengkap,
                        controller: userController.nameController,
                      ),
                      editProfile(
                        icon: Icons.email,
                        title: 'Email',
                        value: userController.user.value!.email,
                        controller: userController.emailController,
                      ),
                      editProfile(
                        icon: Icons.phone,
                        title: 'Nomor Telepon',
                        value: userController.user.value!.noTelp,
                        controller: userController.phoneController,
                      ),
                      editProfile(
                        icon: Icons.settings,
                        title: 'Divisi',
                        value: userController.user.value!.namaDivisi,
                        controller: userController.divisionController,
                      ),
                      const SizedBox(height: 30),
                      Obx(() {
                        bool editing = userController.isEditing.value;

                        if (editing) {
                          return Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(color: SDWcolors.primary, width: 2.3),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(25))
                                    ),
                                    onPressed: () {
                                      userController.toogleEdit();
                                    }, 
                                    child: const Text(
                                      'BATAL',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: SDWcolors.primary,
                                      ),
                                    )
                                  ),
                                )
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: SDWcolors.primary,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(25))
                                    ),
                                    onPressed: () {
                                      userController.updateUser();
                                      userController.toogleEdit();
                                    }, 
                                    child: const Text(
                                      'SIMPAN',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: SDWcolors.textL,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ),
                                )
                              ),
                            ],
                          );
                        } else {
                          
                          return SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: SDWcolors.primary,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(25))
                              ),
                              onPressed: () {
                                userController.toogleEdit();
                              },
                              child: const Text(
                                'UBAH',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: SDWcolors.textL,
                                ),
                              )
                            ),
                          );
                        }

                        // return SizedBox(
                        //   width: double.infinity,
                        //   height: 50,
                        //   child: ElevatedButton(
                        //     style: ElevatedButton.styleFrom(
                        //       backgroundColor: editing
                        //           ? SDWcolors.primary
                        //           : SDWcolors.primary,
                        //     ),
                        //     onPressed: () {
                        //       if (editing) {
                        //         userController.updateUser();
                        //         userController.toogleEdit();
                        //       } else {
                        //         userController.toogleEdit();
                        //       }
                        //     },
                        //     child: Text(
                        //       editing ? 'SIMPAN' : 'UBAH',
                        //       style: const TextStyle(
                        //         fontSize: 18,
                        //         color: SDWcolors.textL,
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),
                        //   ),
                        // );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    )
    );
  }
  

  void _showPicker(BuildContext context, UserController userController) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          color: SDWcolors.bgL,
        ),
        child: Wrap(
          children: [
            Row(
              children: [
                const SizedBox(width: 48),
                Expanded(
                  child: Text(
                    'Foto Profil',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: SDWcolors.textD,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                if (userController.user.value?.fotoProfil != null &&
                    userController.user.value?.fotoProfil != '' &&
                    userController.user.value?.fotoProfil != 'null')
                  IconButton(
                    onPressed: () {
                      Get.back();
                      _confirmDelete(userController);
                    },
                    icon: const Icon(
                      Icons.delete_outline,
                      color: SDWcolors.primary,
                    ),
                  )
                else
                  const SizedBox(width: 100),
              ],
            ),

            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              iconColor: SDWcolors.primary,
              title: const Text('Camera'),
              textColor: SDWcolors.textD,
              onTap: () => userController.pickImage(ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.image_outlined),
              iconColor: SDWcolors.primary,
              title: const Text('Gallery'),
              textColor: SDWcolors.textD,
              onTap: () => userController.pickImage(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(UserController userController) {
    Get.defaultDialog(
      title: 'Hapus Foto Profil',
      middleText: 'Anda yakin ingin menghapus foto profil?',
      textConfirm: 'Hapus',
      textCancel: 'Batal',
      titleStyle: TextStyle(
        color: SDWcolors.textD,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      middleTextStyle: TextStyle(
        color: SDWcolors.textD,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      titlePadding: EdgeInsets.only(top: 20),
      backgroundColor: SDWcolors.bgL,
      confirmTextColor: SDWcolors.textL,
      cancelTextColor: SDWcolors.textD,
      buttonColor: SDWcolors.primary,
      contentPadding: EdgeInsets.all(20),
      onConfirm: () {
        Get.back();
        userController.deleteProfilePic();
      },
    );
  }
}

