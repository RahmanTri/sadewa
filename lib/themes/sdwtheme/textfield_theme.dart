import 'package:flutter/material.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';

class SdwTextFieldTheme {
  SdwTextFieldTheme._();

  //Unfinished**

  static InputDecorationTheme inputDecorationL = InputDecorationTheme(
    errorMaxLines: 3,
    focusColor: SDWcolors.primary,
    prefixIconColor: SDWcolors.essentialL,
    suffixIconColor: SDWcolors.essentialL,

    labelStyle: TextStyle().copyWith(color: SDWcolors.essentialL),
    hintStyle: TextStyle().copyWith(color: SDWcolors.essentialL),
    errorStyle: TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: TextStyle().copyWith(
      color: Colors.black.withValues(alpha: 0.8),
    ),

    outlineBorder: BorderSide(width: 1, color: SDWcolors.essentialL),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(width: 2, color: SDWcolors.essentialL),
    ),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(width: 2, color: SDWcolors.essentialL),
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(width: 2, color: SDWcolors.primary),
    ),

    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(width: 2, color: SDWcolors.error),
    ),

    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(width: 2, color: SDWcolors.error),
    ),
  );

  static InputDecorationTheme inputDecorationD = InputDecorationTheme(
    errorMaxLines: 3,
    focusColor: SDWcolors.primary,
    prefixIconColor: SDWcolors.essentialL,
    suffixIconColor: SDWcolors.essentialL,

    labelStyle: TextStyle().copyWith(color: SDWcolors.essentialL),
    hintStyle: TextStyle().copyWith(color: SDWcolors.essentialL),
    errorStyle: TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: TextStyle().copyWith(
      color: Colors.black.withValues(alpha: 0.8),
    ),

    outlineBorder: BorderSide(width: 1, color: SDWcolors.essentialL),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(width: 2, color: SDWcolors.essentialL),
    ),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(width: 2, color: SDWcolors.essentialL),
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(width: 2, color: SDWcolors.primary),
    ),

    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(width: 2, color: SDWcolors.error),
    ),

    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(width: 2, color: SDWcolors.error),
    ),
  );
}
