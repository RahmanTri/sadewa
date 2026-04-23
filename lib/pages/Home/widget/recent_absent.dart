import 'package:flutter/material.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/constants/sdw_sizes.dart';

class RecentAbsent extends StatelessWidget {
  final double width;
  final double height;
  RecentAbsent({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.12,
      width: width,
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: SDWcolors.bgL,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: SDWcolors.essentialDR.withAlpha(50),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Kehadiran Terkini",
            style: TextStyle(
              fontSize: SDWsizes.lg,
              fontWeight: FontWeight.bold,
              color: SDWcolors.textD,
            ),
          ),
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: height * 0.003,
                width: width * 0.8,
                margin: EdgeInsets.only(top: 25),
                decoration: BoxDecoration(
                  color: SDWcolors.textD,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: height * 0.04,
                          width: width * 0.09,
                          decoration: BoxDecoration(
                            color: SDWcolors.success,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: SDWcolors.bgL, width: 5),
                          ),
                          child: Icon(
                            Icons.check_circle_outline_sharp,
                            color: SDWcolors.white,
                            size: 30,
                          ),
                        ),
                        Text(
                          "sen",
                          style: TextStyle(
                            color: SDWcolors.textD,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
