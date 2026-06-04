import 'package:flutter/material.dart';
import 'package:sadewa_fe/pages/effect/box_shadow.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';

Widget contactCard({
  required IconData icon,
  required String title,
  required Color color,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          SDWboxShadow.shadow
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            child: Icon(icon, color: SDWcolors.essentialD, size: 25),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: SDWcolors.textD,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded, 
            color: SDWcolors.textD,
            size: 18,
          ),
        ],
      ),
      )
  );
}