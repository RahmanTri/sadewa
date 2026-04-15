import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/controllers/home_controller.dart';

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
      body: Stack(
        children: [
          Container(
            height: height * 0.6, 
            decoration: BoxDecoration(
              // color: SDWcolors.primary,
            )),
          Text('Selamat Pagi ${homeController.userData['nama']}'),
        ],
      ),
    );
  }
}
