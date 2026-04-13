import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../constants/sdw_colors.dart';
import '../constants/sdw_sizes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  void _checkAuth() async {
    try {
      await Future.wait([
        authController.loadRememberMe(),
        Future.delayed(Duration(seconds: 2)),
      ]);
    } catch (e) {
      print("Error Auto Login");
    }

    if (authController.token.value.isNotEmpty) {
      Get.offAllNamed('/home');
    } else {
      Get.offAllNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SDWcolors.bgL,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', width: 400, height: 400),

            SizedBox(height: 20),

            Text(
              'SADEWA',
              style: TextStyle(
                fontSize: SDWsizes.lg,
                fontWeight: FontWeight.bold,
                color: SDWcolors.textD,
              ),
            ),

            SizedBox(height: 10),

            Text(
              'Sistem Absensi Dengan Wajah',
              style: TextStyle(
                fontSize: SDWsizes.sm,
                fontWeight: FontWeight.normal,
                color: SDWcolors.essentialD,
              ),
            ),

            SizedBox(height: 30),

            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(SDWcolors.primary),
            ),
          ],
        ),
      ),
    );
  }
}
