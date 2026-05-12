import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';

Widget changePassword({
  required TextEditingController controller,
  required String label, 
  required RxBool isObscure,
}) {
  return Obx(() => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
    child: TextFormField(
      controller: controller,
      obscureText: isObscure.value,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: IconButton(
          icon: Icon(isObscure.value ? Icons.visibility_off : Icons.visibility),
          color: SDWcolors.primary,
          onPressed: () =>  isObscure.toggle(),
        ),
      ),
    ),
  )
);
}