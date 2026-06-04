import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HeaderPage extends StatelessWidget {
  final double width;
  final double height;

  const HeaderPage({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height * 0.05,
      padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Align(
              alignment: Alignment.centerLeft,
              child: Icon(
                FontAwesomeIcons.arrowLeft,
                size: height * 0.03,
                color: SDWcolors.textL,
              ),
            ),
          ),

          Center(
            child: Text(
              "Peringkat Teratas",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: SDWcolors.textL,
                fontSize: width * 0.05,
                letterSpacing: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
