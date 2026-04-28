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
    ),
    headlineMedium: TextStyle(
      fontSize: 48,
      fontWeight: FontWeight.bold,
      color: SDWcolors.textD,
      fontFamily: GoogleFonts.josefinSans().fontFamily,
    ),
    headlineSmall: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textD,
      fontFamily: GoogleFonts.josefinSans().fontFamily,
    ),

    //Title
    titleLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: SDWcolors.textD,
      fontFamily: GoogleFonts.josefinSans().fontFamily,
    ),
    titleMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: SDWcolors.textD,
      fontFamily: GoogleFonts.josefinSans().fontFamily,
    ),
    titleSmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textD,
      fontFamily: GoogleFonts.josefinSans().fontFamily,
    ),

    //Body
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textD,
      fontFamily: GoogleFonts.fredoka().fontFamily,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textD,
      fontFamily: GoogleFonts.fredoka().fontFamily,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textD,
      fontFamily: GoogleFonts.fredoka().fontFamily,
    ),

    //Label
    labelLarge: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textD,
      fontFamily: GoogleFonts.fredoka().fontFamily,
    ),
    labelMedium: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textD,
      fontFamily: GoogleFonts.fredoka().fontFamily,
    ),
    labelSmall: TextStyle(
      fontSize: 8,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textD,
      fontFamily: GoogleFonts.fredoka().fontFamily,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(

    //Headline
    headlineLarge: TextStyle(
      fontSize: 48,
      fontWeight: FontWeight.bold,
      color: SDWcolors.textL,
      fontFamily: GoogleFonts.josefinSans().fontFamily,
    ),
    headlineMedium: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: SDWcolors.textL,
      fontFamily: GoogleFonts.josefinSans().fontFamily,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textL,
      fontFamily: GoogleFonts.josefinSans().fontFamily,
    ),

    //Title
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: SDWcolors.textL,
      fontFamily: GoogleFonts.josefinSans().fontFamily,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: SDWcolors.textL,
      fontFamily: GoogleFonts.josefinSans().fontFamily,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textL,
      fontFamily: GoogleFonts.josefinSans().fontFamily,
    ),

    //Body
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textL,
      fontFamily: GoogleFonts.fredoka().fontFamily,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textL,
      fontFamily: GoogleFonts.fredoka().fontFamily,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textL,
      fontFamily: GoogleFonts.fredoka().fontFamily,
    ),

    //Label
    labelLarge: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textL,
      fontFamily: GoogleFonts.fredoka().fontFamily,
    ),
    labelMedium: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textL,
      fontFamily: GoogleFonts.fredoka().fontFamily,
    ),
    labelSmall: TextStyle(
      fontSize: 8,
      fontWeight: FontWeight.normal,
      color: SDWcolors.textL,
      fontFamily: GoogleFonts.fredoka().fontFamily,
    ),
  );
}