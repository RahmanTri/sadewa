import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/binding/app_binding.dart';
import 'package:sadewa_fe/routes/app_pages.dart';
import 'package:sadewa_fe/themes/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SADEWA',
      debugShowCheckedModeBanner: true,
      initialBinding: AppBinding(),
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      theme: SdwAppTheme.themeL,
      darkTheme: SdwAppTheme.themeD,
    );
  }
}
