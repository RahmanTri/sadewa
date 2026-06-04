import 'package:flutter/material.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/controllers/user_controller.dart';
import 'package:get/get.dart';

Widget editProfile( {
  required IconData icon,
  required String title,
  required String value,
  required TextEditingController controller,
}) {
  final userController = Get.find<UserController>();

  return Obx(() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 30),
      Row(
        children: [
          Icon(icon, color: SDWcolors.primary),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              color: SDWcolors.textD,
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(
          top: 2, 
          bottom: 13, 
          left: 33
        ),
        child: userController.isEditing.value ? 
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            isDense: true, 

            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
          ),
        )
        :Text(
          value, 
          // _getValuebyTitle(title, userController),
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            color: SDWcolors.textD,
            fontSize: 15,
          ),
        ),
      ),
      const SizedBox(height: 10),
      const Divider(
        height: 1,
        thickness: 1,
        indent: 9,
        endIndent: 9,
        color: SDWcolors.essentialL,
      ),
      const SizedBox(height: 7),
    ]
  ));
}

  // String _getValuebyTitle(String title, UserController controller) {
  //   final user = controller.user.value;
  //   if (user == null) return '-';
    
  //   String t = title.toLowerCase();
  
  //   if (t.contains('nama')) return user.namaLengkap;
  //   if (t.contains('email')) return user.email;
  //   if (t.contains('telepon') || t.contains('phone')) return user.noTelp;
  //   if (t.contains('divisi')) return user.namaDivisi;

  //   return '-';
  // }
