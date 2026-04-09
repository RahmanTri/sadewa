import 'package:flutter/material.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';

class SdwTexTheme {
  SdwTexTheme._();

  static TextTheme lightTextTheme = TextTheme(

    //Headline
    headlineLarge: TextStyle(
      fontSize: 48,
      fontWeight: FontWeight.bold,
      color: SDWcolors.textD,
    ),
    headlineMedium: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: SDWcolors.textD,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textD,
    ),

    //Title
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: SDWcolors.textD,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: SDWcolors.textD,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textD,
    ),

    //Body
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textD,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textD,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textD,
    ),

    //Label
    labelLarge: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textD,
    ),
    labelMedium: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textD,
    ),
    labelSmall: TextStyle(
      fontSize: 8,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textD,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(

    //Headline
    headlineLarge: TextStyle(
      fontSize: 48,
      fontWeight: FontWeight.bold,
      color: SDWcolors.textL,
    ),
    headlineMedium: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: SDWcolors.textL,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textL,
    ),

    //Title
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: SDWcolors.textL,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: SDWcolors.textL,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textL,
    ),

    //Body
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textL,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textL,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textL,
    ),

    //Label
    labelLarge: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textL,
    ),
    labelMedium: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textL,
    ),
    labelSmall: TextStyle(
      fontSize: 8,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textL,
    ),
  );
}