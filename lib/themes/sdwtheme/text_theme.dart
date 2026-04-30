import 'package:flutter/material.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class SdwTexTheme {
  SdwTexTheme._();

  static TextTheme lightTextTheme = TextTheme(

    //Headline
    headlineLarge: TextStyle(
      fontSize: 60,
      fontWeight: FontWeight.bold,
      color: SDWcolors.textD,
      fontFamily: GoogleFonts.josefinSans().fontFamily,
      height: 1.2,
    ),
    headlineMedium: TextStyle(
      fontSize: 48,
      fontWeight: FontWeight.bold,
      color: SDWcolors.textD,
      fontFamily: GoogleFonts.josefinSans().fontFamily,
      height: 1.2,
    ),
    headlineSmall: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textD,
      fontFamily: GoogleFonts.josefinSans().fontFamily,
      height: 1.2,
    ),

    //Title
    titleLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: SDWcolors.textD,
      fontFamily: GoogleFonts.josefinSans().fontFamily,
      height: 1.2,
    ),
    titleMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: SDWcolors.textD,
      fontFamily: GoogleFonts.josefinSans().fontFamily,
      height: 1.2,
    ),
    titleSmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textD,
      fontFamily: GoogleFonts.josefinSans().fontFamily,
      height: 1.2,
    ),

    //Body
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textD,
      fontFamily: GoogleFonts.fredoka().fontFamily,
      height: 1.2,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textD,
      fontFamily: GoogleFonts.fredoka().fontFamily,
      height: 1.2,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textD,
      fontFamily: GoogleFonts.fredoka().fontFamily,
      height: 1.2,
    ),

    //Label
    labelLarge: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textD,
      fontFamily: GoogleFonts.fredoka().fontFamily,
      height: 1.2,
    ),
    labelMedium: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textD,
      fontFamily: GoogleFonts.fredoka().fontFamily,
      height: 1.2,
    ),
    labelSmall: TextStyle(
      fontSize: 8,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textD,
      fontFamily: GoogleFonts.fredoka().fontFamily,
      height: 1.2,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(

    //Headline
    headlineLarge: TextStyle(
      fontSize: 48,
      fontWeight: FontWeight.bold,
      color: SDWcolors.textL,
      fontFamily: GoogleFonts.josefinSans().fontFamily,
      height: 1.2,
    ),
    headlineMedium: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: SDWcolors.textL,
      fontFamily: GoogleFonts.josefinSans().fontFamily,
      height: 1.2,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textL,
      fontFamily: GoogleFonts.josefinSans().fontFamily,
      height: 1.2,
    ),

    //Title
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: SDWcolors.textL,
      fontFamily: GoogleFonts.josefinSans().fontFamily,
      height: 1.2,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: SDWcolors.textL,
      fontFamily: GoogleFonts.josefinSans().fontFamily,
      height: 1.2,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textL,
      fontFamily: GoogleFonts.josefinSans().fontFamily,
      height: 1.2,
    ),

    //Body
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textL,
      fontFamily: GoogleFonts.fredoka().fontFamily,
      height: 1.2,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textL,
      fontFamily: GoogleFonts.fredoka().fontFamily,
      height: 1.2,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textL,
      fontFamily: GoogleFonts.fredoka().fontFamily,
      height: 1.2,
    ),

    //Label
    labelLarge: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textL,
      fontFamily: GoogleFonts.fredoka().fontFamily,
      height: 1.2,
    ),
    labelMedium: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textL,
      fontFamily: GoogleFonts.fredoka().fontFamily,
      height: 1.2,
    ),
    labelSmall: TextStyle(
      fontSize: 8,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textL,
      fontFamily: GoogleFonts.fredoka().fontFamily,
      height: 1.2,
    ),
  );
}