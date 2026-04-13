import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../themes/sdwtheme/text_theme.dart';
import '../themes/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final authController = Get.find<AuthController>();
  final themeController = Get.find<SdwAppTheme>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkAuth();
  }

  void _checkAuth() async {
    try {
      await Future.wait([
        auth.controllers
      ])
    }
  }

@override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}