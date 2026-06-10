import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/controllers/user_controller.dart';
import 'package:sadewa_fe/pages/user/Profile/widget/profile_menu.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/pages/User/Profile/widget/logout.dart';
import 'package:sadewa_fe/constants/urls.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sadewa_fe/routes/app_routes.dart';

class AdminProfile extends StatelessWidget {
  const AdminProfile({super.key});

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
                    // final fotoProfil = userController.admin.value?.fotoProfil;
                    ImageProvider image;
                    image = const AssetImage(
                      '${AppUrls.imgAssets}default-profile.png',
                    );

                    // if (userController.selectedImagePath.value.isNotEmpty) {
                    //   // Jika selectedImagePath tidak kosong, gunakan gambar yang dipilih
                    //   image = FileImage(
                    //     File(userController.selectedImagePath.value),
                    //   );
                    // } else if (fotoProfil != null &&
                    //     fotoProfil != '' &&
                    //     fotoProfil != 'null') {
                    //   // Jika fotoProfil ada, gunakan URL gambar
                    //   image = NetworkImage(
                    //     '${AppUrls.imgProfileUrl}$fotoProfil',
                    //   );
                    // } else {
                    //   // Jika fotoProfil tidak ada, gunakan gambar default
                    // }

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
                          userController.admin.value!.name.toString(),
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(color: SDWcolors.textL, fontSize: 20),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          userController.admin.value!.role.toString(),
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
                    icon: Icons.exit_to_app,
                    title: 'Log Out',
                    onTap: () => logoutDialog(context),
                  ),
                  profileMenu(
                    icon: FontAwesomeIcons.peopleRoof,
                    title: 'Akun Manajer',
                    onTap: () => Get.toNamed(Routes.akunManajer),
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
