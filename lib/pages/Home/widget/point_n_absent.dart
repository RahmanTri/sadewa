import 'package:flutter/material.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/constants/sdw_sizes.dart';

class PointAbsent extends StatelessWidget {
  final double width;
  final double height;
  PointAbsent({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          height: height * 0.14,
          width: width * 0.59,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                color: SDWcolors.success,
                size: SDWsizes.iconsXL * 1.5,
              ),
              Text(
                "Anda Sudah Absen Hari Ini",
                style: TextStyle(
                  fontSize: SDWsizes.lg * 0.8,
                  fontWeight: FontWeight.bold,
                  color: SDWcolors.textD,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "Laksanakan Tugas Anda Dengan Sepenuh Hati",
                style: TextStyle(
                  fontSize: SDWsizes.md * 1,
                  fontWeight: FontWeight.w300,
                  color: SDWcolors.textD,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20, left: 10),
          height: height * 0.14,
          width: width * 0.3,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Poin Saya",
                style: TextStyle(
                  fontSize: SDWsizes.lg * 0.9,
                  fontWeight: FontWeight.bold,
                  color: SDWcolors.textD,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "92",
                style: TextStyle(
                  fontSize: SDWsizes.lg * 2,
                  fontWeight: FontWeight.w800,
                  color: SDWcolors.success,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "Pertahankan Terus!",
                style: TextStyle(
                  fontSize: SDWsizes.md * 1,
                  fontWeight: FontWeight.w500,
                  color: SDWcolors.textD,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "lihat benefit",
                style: TextStyle(
                  fontSize: SDWsizes.md * 1.2,
                  fontWeight: FontWeight.w300,
                  color: SDWcolors.textD,
                  decoration: TextDecoration.underline,
                  decorationColor: SDWcolors.essentialD,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
