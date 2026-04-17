import 'package:flutter/material.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';

class SDWScrollTheme extends MaterialScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return GlowingOverscrollIndicator(
      axisDirection: details.direction,
      color: SDWcolors.essentialDR,
      child: child,
    );
  }
}
