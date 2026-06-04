import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';

Widget otpBox(
  BuildContext context,
  TextEditingController txtController,
  FocusNode currentFocus,
  FocusNode? nextFocus,
  FocusNode? previousFocus,
) {
  return SizedBox(
    width: 50,
    height: 50,
    child: TextField(
      controller: txtController,
      focusNode: currentFocus,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      maxLength: 1,
      style: const TextStyle(
        fontSize: 20, fontWeight: 
        FontWeight.bold,
        color: SDWcolors.primary,
      ),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        counterText: '',
        fillColor: SDWcolors.bgL,
        filled: true,
        contentPadding: EdgeInsets.zero,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: SDWcolors.essentialL,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: SDWcolors.primary,
            width: 2,
          ),
        ),
      ),
      onChanged: (value) {
        if (value.length == 1 && nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        }
        if (value.isEmpty && previousFocus != null) {
          FocusScope.of(context).requestFocus(previousFocus);
        }
      },
    ),
  );
  }