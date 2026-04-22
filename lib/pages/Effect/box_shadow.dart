import 'package:flutter/material.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';

class SDWboxShadow {
  SDWboxShadow._();

  static BoxShadow shadow = BoxShadow(
    color: SDWcolors.essentialDR.withAlpha(50),
    spreadRadius: 0,
    blurRadius: 4,
    offset: const Offset(0, 2),
  );
}
