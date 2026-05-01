import 'package:flutter/material.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/pages/Effect/box_shadow.dart';
import '../../../models/riwayat_poin.dart';

class HistoriPoinCard extends StatelessWidget {
  final RiwayatPoin riwayatPoin;
  final double height;
  final double width;
  const HistoriPoinCard({
    super.key,
    required this.height,
    required this.width,
    required this.riwayatPoin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.064,
      width: width * 0.92,
      margin: EdgeInsets.only(bottom: 6),
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: SDWcolors.bgL,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [SDWboxShadow.shadow],
      ),
      child: Row(
        children: [
          Icon(
            riwayatPoin.poinDidapat.isNegative
                ? Icons.remove_circle
                : Icons.add_circle,
            color: riwayatPoin.poinDidapat.isNegative
                ? SDWcolors.error
                : SDWcolors.success,
            size: 40,
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${riwayatPoin.hari} ${riwayatPoin.tanggal} ${riwayatPoin.bulan} ${riwayatPoin.tahun}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: SDWcolors.textD,
                  fontSize: height * 0.016,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                riwayatPoin.statusKehadiran == 'Hadir'
                    ? '${riwayatPoin.statusKehadiran} | ${riwayatPoin.statusLog}'
                    : riwayatPoin.statusKehadiran,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: SDWcolors.textD,
                  fontSize: height * 0.012,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: height * 0.064,
                  height: height * 0.048,
                  child: Center(
                    child: Text(
                      riwayatPoin.poinDidapat.isNegative
                          ? '${riwayatPoin.poinDidapat}'
                          : '+${riwayatPoin.poinDidapat}',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: SDWcolors.textD,
                        fontSize: height * 0.024,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
