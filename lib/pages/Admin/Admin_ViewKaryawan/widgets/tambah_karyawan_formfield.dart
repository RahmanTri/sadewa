import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/controllers/karyawan_controller.dart';

class KaryawanFormField extends StatelessWidget {
  final String title;
  final String hint;
  final bool isPassword;
  const KaryawanFormField({
    super.key,
    required this.title,
    required this.hint,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    final karyawanController = Get.find<KaryawanController>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width * 0.8,
      height: height * 0.108,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
              controller: title == 'Username'
                  ? karyawanController.usernameNew
                  : title == 'Password'
                  ? karyawanController.passwordNew
                  : title == 'Email'
                  ? karyawanController.emailNew
                  : title == 'Nama Lengkap'
                  ? karyawanController.namaLengkapNew
                  : karyawanController.noTelpNew,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: SDWcolors.textD,
                fontSize: height * 0.024,
              ),
              onChanged: (val) {
                if (title == 'Username') {
                  karyawanController.usernameError.value = '';
                } else if (title == 'Password') {
                  karyawanController.passwordError.value = '';
                } else if (title == 'Email') {
                  karyawanController.emailError.value = '';
                } else if (title == 'Nama Lengkap') {
                  karyawanController.namaLengkapError.value = '';
                } else if (title == 'No. Telepon') {
                  karyawanController.noTelpError.value = '';
                }
              },
              onEditingComplete: () {
                if (title == 'Username') {
                  karyawanController.checkUsernameField();
                } else if (title == 'Password') {
                  karyawanController.checkPasswordField();
                } else if (title == 'Email') {
                  karyawanController.checkEmailField();
                } else if (title == 'Nama Lengkap') {
                  karyawanController.checkNameField();
                } else if (title == 'No. Telepon') {
                  karyawanController.checkPhoneField();
                }
              },
              keyboardType: title == 'No. Telepon' ? TextInputType.number : title == 'Email' ? TextInputType.emailAddress : null,
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(left: width * 0.04),
              ),
            ),
          ),
          Obx(() {
            if (title == 'Username') {
              return Text(
                karyawanController.usernameError.value,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: SDWcolors.error,
                  fontSize: height * 0.012,
                  fontStyle: FontStyle.italic,
                ),
              );
            } else if (title == 'Password') {
              return Text(
                karyawanController.passwordError.value,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: SDWcolors.error,
                  fontSize: height * 0.012,
                  fontStyle: FontStyle.italic,
                ),
              );
            } else if (title == 'Email') {
              return Text(
                karyawanController.emailError.value,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: SDWcolors.error,
                  fontSize: height * 0.012,
                  fontStyle: FontStyle.italic,
                ),
              );
            } else if (title == 'Nama Lengkap') {
              return Text(
                karyawanController.namaLengkapError.value,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: SDWcolors.error,
                  fontSize: height * 0.012,
                  fontStyle: FontStyle.italic,
                ),
              );
            } else if (title == 'No. Telepon') {
              return Text(
                karyawanController.noTelpError.value,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: SDWcolors.error,
                  fontSize: height * 0.012,
                  fontStyle: FontStyle.italic,
                ),
              );
            } else {
              return SizedBox.shrink();
            }
          }),
        ],
      ),
    );
  }
}
