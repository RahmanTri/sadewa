import 'package:flutter/material.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/constants/urls.dart';
import 'package:sadewa_fe/models/karyawan_model.dart';
import 'package:sadewa_fe/pages/Effect/box_shadow.dart';

class KaryawanCard extends StatelessWidget {
  final Karyawan karyawan;
  final double width;
  final double height;
  final double gap;

  const KaryawanCard({
    super.key,
    required this.karyawan,
    required this.width,
    required this.height,
    required this.gap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: gap),
      height: height * 0.1,
      width: width * 0.92,
      decoration: BoxDecoration(
        color: SDWcolors.bgL,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [SDWboxShadow.shadow],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(left: width * 0.04, right: width * 0.04),
            height: height * 0.08,
            width: height * 0.08,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('${AppUrls.imgAssets}default-profile.png'),
              ),
              border: Border.all(color: SDWcolors.primary, width: 4),
            ),
            child: karyawan.fotoProfil != 'null' && karyawan.fotoProfil != ''
                ? Container(
                  width: height * 0.8,
                  height: height * 0.8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage('${AppUrls.imgProfileUrl}${karyawan.fotoProfil}'),
                    ),
                  ),
                )
                : null,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                karyawan.namaLengkap,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: SDWcolors.textD,
                  fontWeight: FontWeight.bold,
                  fontSize: height * 0.022,
                ),
              ),
              Text(
                karyawan.idPerusahaan,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: SDWcolors.textD,
                  fontWeight: FontWeight.normal,
                  fontSize: height * 0.016,
                ),
              ),
              Text(
                karyawan.namaDivisi,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: SDWcolors.textD,
                  fontWeight: FontWeight.normal,
                  fontSize: height * 0.016,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
