import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/controllers/user_controller.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/pages/User/Profile/edit_profile.dart';
import 'package:sadewa_fe/constants/urls.dart';

class ProfilePicPreview extends StatelessWidget {
  const ProfilePicPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();

    return Scaffold(
      backgroundColor: SDWcolors.black,
      appBar: AppBar(
        backgroundColor: SDWcolors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(Icons.arrow_back, color: SDWcolors.white),
        ),
        title: const Text(
          'Foto Profil',
          style: TextStyle(color: SDWcolors.white, fontSize: 18),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showPicker(context, userController);
            },
            icon: const Icon(Icons.edit, color: SDWcolors.white),
          ),
        ],
      ),
      body: Center(
        child: Obx(() {
          //Check if there is an image in local storage
          if (userController.selectedImagePath.value.isNotEmpty) {
            return Image.file(
              File(userController.selectedImagePath.value),
              fit: BoxFit.contain,
              width: double.infinity,
            );
          }

          final photoUrl = userController.user.value?.fotoProfil;
          if (photoUrl != null && photoUrl != '' && photoUrl != 'null') {
            return Image.network(
              '${AppUrls.imgProfileUrl}$photoUrl',
              fit: BoxFit.contain,
              width: double.infinity,
            );
          }
          return Container();
        }),
      ),
    );
  }
}
