import 'package:flutter/material.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';


Widget profileMenu({
  required IconData icon,
  required String title,
  required VoidCallback onTap,
}) {
  return ListTile(
    onTap: onTap,
    leading: CircleAvatar(
      backgroundColor: SDWcolors.primary, 
      child: Icon(icon, color: SDWcolors.bgL),
    ),
    title: Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        color: SDWcolors.textD,
      ),
    ),
    trailing: const Icon(Icons.chevron_right, color: SDWcolors.essential),
  );
}
