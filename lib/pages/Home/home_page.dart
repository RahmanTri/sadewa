import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/controllers/home_controller.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/constants/sdw_sizes.dart';
import '../Effect/box_shadow.dart';
import 'package:marquee/marquee.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Widget> pages = [];

  final List<BottomNavigationBarItem> navbar = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
    BottomNavigationBarItem(icon: Icon(Icons.point_of_sale), label: 'Point'),
  ];

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: SDWcolors.bgD,
      body: Stack(
        children: [
          Container(
            height: height * 0.4,
            decoration: BoxDecoration(
              color: SDWcolors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 15),
                      width: width * 0.65,
                      height: height * 0.1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Selamat Pagi',
                            style: TextStyle(
                              fontSize: SDWsizes.lg,
                              fontWeight: FontWeight.normal,
                              color: SDWcolors.white,
                            ),
                          ),

                          // SizedBox(
                          //   height: 50,
                          //   child: Marquee(
                          //     text: "Suwito",
                          //     style: TextStyle(
                          //       fontSize: SDWsizes.xl,
                          //       fontWeight: FontWeight.bold,
                          //       color: SDWcolors.white,
                          //     ),
                          //     scrollAxis: Axis.horizontal,
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     blankSpace: 20.0,
                          //     velocity: 30.0,
                          //     pauseAfterRound: Duration(seconds: 2),
                          //   ),
                          // ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              "Suwito",
                              style: TextStyle(
                                fontSize: SDWsizes.xl,
                                fontWeight: FontWeight.bold,
                                color: SDWcolors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: width * 0.22,
                      height: height * 0.1,
                      decoration: BoxDecoration(
                        color: SDWcolors.essential,
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: SDWcolors.essentialDR.withAlpha(50),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Poin dan Absen
                Row(
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
                ),

                // Quick Action
                Container(
                  height: height * 0.22,
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: SDWcolors.bgL,
                    borderRadius: BorderRadius.circular(20),
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
                        "Quick Action",
                        style: TextStyle(
                          fontSize: SDWsizes.lg,
                          fontWeight: FontWeight.bold,
                          color: SDWcolors.textD,
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: width * 0.2,
                                height: height * 0.09,
                                decoration: BoxDecoration(
                                  color: SDWcolors.bgD,
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/icons/riwayat_kehadiran.png',
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Container(
                                width: width * 0.2,
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  "Riwayat Kehadiran",
                                  style: TextStyle(
                                    fontSize: SDWsizes.lg * 0.75,
                                    fontWeight: FontWeight.bold,
                                    color: SDWcolors.textD,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: width * 0.1),
                          Column(
                            children: [
                              Container(
                                width: width * 0.2,
                                height: height * 0.09,
                                decoration: BoxDecoration(
                                  color: SDWcolors.bgD,
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/icons/peringkat_karyawan.png',
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Container(
                                width: width * 0.2,
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  "Peringkat Karyawan",
                                  style: TextStyle(
                                    fontSize: SDWsizes.lg * 0.75,
                                    fontWeight: FontWeight.bold,
                                    color: SDWcolors.textD,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: width * 0.1),
                          Column(
                            children: [
                              Container(
                                width: width * 0.2,
                                height: height * 0.09,
                                decoration: BoxDecoration(
                                  color: SDWcolors.bgD,
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/icons/peringatan.png',
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Container(
                                width: width * 0.2,
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  "Peringatan",
                                  style: TextStyle(
                                    fontSize: SDWsizes.lg * 0.75,
                                    fontWeight: FontWeight.bold,
                                    color: SDWcolors.textD,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Kehadiran Terkini
                Container(
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
                                        border: Border.all(
                                          color: SDWcolors.bgL,
                                          width: 5,
                                        ),
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
                ),

                // Log History
                SizedBox(height: 20),
                Text(
                  "Log Aktivitas",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SDWsizes.lg,
                    color: SDWcolors.textD,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: BouncingScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        height: height * 0.1,
                        width: width,
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Container(
                              width: width * 0.67,
                              height: height,
                              decoration: BoxDecoration(
                                color: SDWcolors.bgL,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [SDWboxShadow.shadow],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: height,
                                    width: width * 0.13,
                                    margin: EdgeInsets.only(right: 30),
                                    decoration: BoxDecoration(
                                      color: SDWcolors.bgL,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(
                                      Icons.exit_to_app,
                                      color: SDWcolors.primary,
                                      size: 70,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Absen Keluar",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: SDWcolors.textD,
                                          decoration: TextDecoration.underline,
                                          decorationColor: SDWcolors.textD,
                                          fontSize: SDWsizes.lg * 0.65,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.ring_volume_outlined,
                                            color: SDWcolors.textD,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            "Tepat Waktu",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              color: SDWcolors.textD,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.date_range_outlined,
                                            color: SDWcolors.textD,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            "data",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              color: SDWcolors.textD,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              width: width * 0.175,
                              height: height,
                              decoration: BoxDecoration(
                                color: SDWcolors.bgL,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [SDWboxShadow.shadow],
                              ),
                              child: Icon(
                                Icons.check_circle,
                                color: SDWcolors.success,
                                size: 70,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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
