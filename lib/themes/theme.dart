import 'package:flutter/material.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/themes/sdwtheme/text_theme.dart';
import 'package:sadewa_fe/themes/sdwtheme/textfield_theme.dart';

class SdwAppTheme {
  SdwAppTheme._();

  static final ThemeData themeL = ThemeData(
    useMaterial3: true,
    fontFamily: 'Fredoka',
    brightness: Brightness.light,
    primaryColor: SDWcolors.primary,
    scaffoldBackgroundColor: SDWcolors.bgL,
    textTheme: SdwTexTheme.lightTextTheme,
    inputDecorationTheme: SdwTextFieldTheme.inputDecorationL,
  );

  static final ThemeData themeD = ThemeData(
    useMaterial3: true,
    fontFamily: 'Fredoka',
    brightness: Brightness.dark,
    primaryColor: SDWcolors.primary,
    scaffoldBackgroundColor: SDWcolors.bgD,
    textTheme: SdwTexTheme.darkTextTheme,
    inputDecorationTheme: SdwTextFieldTheme.inputDecorationD,
  );
}