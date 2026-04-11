import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/services/storage_service.dart';

class AuthController extends GetxController {
  final StorageService _storageService = StorageService();
  final formKey = GlobalKey<FormState>();

  final email = TextEditingController();
  final password = TextEditingController();

  

}