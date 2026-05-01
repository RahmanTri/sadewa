import 'package:flutter/material.dart';
import 'package:sadewa_fe/models/riwayat_model.dart';
import '../../../constants/sdw_colors.dart';
import '../../../constants/sdw_sizes.dart';
import '../../Effect/box_shadow.dart';

class HistoryCard extends StatelessWidget {
  final Riwayat riwayat;
  final double height;
  final double width;
  final double gap;

  const HistoryCard({
    super.key,
    required this.riwayat,
    required this.height,
    required this.width,
    required this.gap,
  });

  Color getColorStatus() {
    if (riwayat.statusMasuk == 'Tepat Waktu' &&
        riwayat.statusKeluar == 'Tepat Waktu') {
      return SDWcolors.success;
    } else if (riwayat.statusMasuk == 'Tepat Waktu' &&
        riwayat.statusKeluar != 'Tepat Waktu') {
      return SDWcolors.warning;
    } else if (riwayat.statusMasuk != 'Tepat Waktu' &&
        riwayat.statusKeluar == 'Tepat Waktu') {
      return SDWcolors.warning;
    } else {
      return SDWcolors.error;
    }
  }

  Widget getIcon(String status, double size) {
    if (status == 'Terlambat') {
      return Icon(Icons.timelapse, color: SDWcolors.warning, size: size);
    } else if (status == 'Tepat Waktu') {
      return Icon(Icons.check_circle, color: SDWcolors.success, size: size);
    } else if (status == 'Lebih Awal') {
      return Icon(Icons.timelapse, color: SDWcolors.warning, size: size);
    } else {
      return Icon(Icons.cancel, color: SDWcolors.error, size: size);
    }
  }

  Color getIconColor(String status) {
    if (status == 'Terlambat') {
      return SDWcolors.warning;
    } else if (status == 'Tepat Waktu') {
      return SDWcolors.success;
    } else if (status == 'Lebih Awal') {
      return SDWcolors.warning;
    } else {
      return SDWcolors.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: gap),
      height: height * 0.128,
      width: width * 0.9,
      decoration: BoxDecoration(
        color: getColorStatus(),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          SDWboxShadow.shadow,
        ],
      ),
      child: Container(
        padding: EdgeInsets.only(left: 12),
        margin: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: SDWcolors.bgL,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 20,
                  width: 60,
                  decoration: BoxDecoration(
                    color: SDWcolors.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      riwayat.hari,
                      style: TextStyle(
                        fontSize: SDWsizes.md,
                        fontWeight: FontWeight.bold,
                        color: SDWcolors.white,
                      ),
                    ),
                  ),
                ),
                Text(
                  riwayat.tanggal,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: SDWcolors.primary,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${riwayat.bulan} ${riwayat.tahun}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: SDWcolors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
            SizedBox(width: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Check-In',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: SDWcolors.essentialD,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            left: 4,
                            right: 4,
                            top: 2,
                            bottom: 2,
                          ),
                          decoration: BoxDecoration(
                            color: getIconColor(
                              riwayat.statusMasuk,
                            ).withAlpha(70),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: getIcon(riwayat.statusMasuk, 20),
                        ),
                        SizedBox(width: 4),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Status : ${riwayat.statusMasuk}',
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    color: SDWcolors.essentialD,
                                    fontSize: 8,
                                  ),
                            ),
                            Text(
                              'Waktu : ${riwayat.waktuMasuk}',
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    color: SDWcolors.essentialD,
                                    fontSize: 8,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: 4),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Check-Out',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: SDWcolors.essentialD,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            left: 4,
                            right: 4,
                            top: 2,
                            bottom: 2,
                          ),
                          decoration: BoxDecoration(
                            color: getIconColor(
                              riwayat.statusKeluar,
                            ).withAlpha(70),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: getIcon(riwayat.statusKeluar, 20),
                        ),
                        SizedBox(width: 8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Status : ${riwayat.statusKeluar}',
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    color: SDWcolors.essentialD,
                                    fontSize: 8,
                                  ),
                            ),
                            Text(
                              'Waktu : ${riwayat.waktuKeluar}',
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    color: SDWcolors.essentialD,
                                    fontSize: 8,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
