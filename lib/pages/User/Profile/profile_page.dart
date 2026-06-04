import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/controllers/user_controller.dart';
import 'package:sadewa_fe/pages/User/Profile/widget/profile_menu.dart';
import 'package:sadewa_fe/constants/urls.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: SDWcolors.primary,
        toolbarHeight: 60,
        title: Text(
          'Profile',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: SDWcolors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: Get.back,
          icon: Icon(Icons.arrow_back),
          color: SDWcolors.white,
        ),
      ),
      backgroundColor: SDWcolors.bgD,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 220,
                  decoration: BoxDecoration(
                    color: SDWcolors.primary,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(28),
                      bottomRight: Radius.circular(28),
                    ),
                  ),
                ),
                Center(
                  child: Obx(() {
                    final fotoProfil = userController.user.value?.fotoProfil;

                    ImageProvider image;

                    if (userController.selectedImagePath.value.isNotEmpty) {
                      // Jika selectedImagePath tidak kosong, gunakan gambar yang dipilih
                      image = FileImage(
                        File(userController.selectedImagePath.value),
                      );
                    } else if (fotoProfil != null &&
                        fotoProfil != '' &&
                        fotoProfil != 'null') {
                      // Jika fotoProfil ada, gunakan URL gambar
                      image = NetworkImage(
                        '${AppUrls.imgProfileUrl}$fotoProfil',
                      );
                    } else {
                      // Jika fotoProfil tidak ada, gunakan gambar default
                      image = const AssetImage(
                        '${AppUrls.imgAssets}default-profile.png',
                      );
                    }
                    return Column(
                      children: [
                        CircleAvatar(
                          radius: 63.5,
                          backgroundColor: SDWcolors.bgL,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: image,
                          ),
                        ),
                        const SizedBox(height: 22),
                        Text(
                          userController.user.value!.username.toString(),
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(color: SDWcolors.textL, fontSize: 20),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          userController.user.value!.namaDivisi.toString(),
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(color: SDWcolors.textL, fontSize: 15),
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
            const SizedBox(height: 41),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Column(
                children: [
                  profileMenu(
                    icon: Icons.edit,
                    title: 'Edit Profile',
                    onTap: () => Get.toNamed('/editProfile'),
                  ),
                  const SizedBox(height: 17),
                  profileMenu(
                    icon: Icons.lock_clock_outlined,
                    title: 'Ubah Password',
                    onTap: () => Get.toNamed('/changePassword'),
                  ),
                  const SizedBox(height: 17),
                  profileMenu(
                    icon: Icons.help_outlined,
                    title: 'Pusat Bantuan',
                    onTap: () => Get.toNamed('/help-center'),
                  ),
                  const SizedBox(height: 17),
                  profileMenu(
                    icon: Icons.logout,
                    title: 'Logout',
                    onTap: () => userController.user.value?.loggedOut,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
