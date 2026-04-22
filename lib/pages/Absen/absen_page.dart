import 'package:flutter/material.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/constants/sdw_sizes.dart';
import '../Effect/box_shadow.dart';

class AbsenPage extends StatelessWidget {
  AbsenPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: SDWcolors.bgD,
      body: Stack(
        children: [
          // Header
          Container(
            height: height * 0.13,
            width: width,
            child: Stack(
              children: [
                Container(
                  height: height * 0.13,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back),
                    color: SDWcolors.textD,
                    iconSize: 40,
                  ),
                ),

                Container(
                  height: height * 0.13,
                  width: width,
                  alignment: Alignment.center,
                  child: Text(
                    'Absen Wajah',
                    style: TextStyle(
                      fontSize: SDWsizes.xl,
                      fontWeight: FontWeight.bold,
                      color: SDWcolors.textD,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Camera Box
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: height * 0.1),
            height: height * 0.5,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: SDWcolors.primary,
            ),
          ),

          // Text Wrapper
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: height * 0.62),
            height: height * 0.3,
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Status Check",
                  style: TextStyle(
                    color: SDWcolors.textD,
                    fontSize: SDWsizes.xl,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Notis Check",
                  style: TextStyle(
                    color: SDWcolors.error,
                    fontSize: SDWsizes.lg * 0.7,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                                SizedBox(height: 20),
                Text(
                  "Arahan",
                  style: TextStyle(
                    color: SDWcolors.textD,
                    fontSize: SDWsizes.lg * 0.7,
                    fontWeight: FontWeight.w300,
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
