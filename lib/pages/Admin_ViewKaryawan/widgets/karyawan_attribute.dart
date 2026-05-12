import 'package:flutter/material.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';

class KaryawanAttribute extends StatelessWidget {
  final String label;
  final IconData icon;
  final String value;
  final double height;
  final double width;
  const KaryawanAttribute({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: height * 0.02),
      height: height * 0.1,
      width: width * 0.92,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, color: SDWcolors.primary, size: height * 0.032),
              SizedBox(width: width * 0.02),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: SDWcolors.textD,
                  fontSize: height * 0.018,
                ),
              ),
            ],
          ),
          Expanded(
            child: Row(
              children: [
                SizedBox(width: width * 0.088),
                SizedBox(
                  height: height * 0.04,
                  child: Center(
                    child: Text(
                      value,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: SDWcolors.textD,
                        fontSize: height * 0.024,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: SDWcolors.essentialD.withAlpha(120),
            thickness: 1,
            radius: BorderRadius.circular(20),
          ),
        ],
      ),
    );
  }
}
