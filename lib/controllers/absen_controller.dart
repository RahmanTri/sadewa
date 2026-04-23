// import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image/image.dart' as imeg;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/services/api_service.dart';
import 'package:sadewa_fe/services/storage_service.dart';
import 'package:sadewa_fe/controllers/user_controller.dart';

class AbsenController extends GetxController {
  final ApiService _apiService = ApiService();
  final StorageService _storageService = StorageService();
  final UserController _userController = UserController();

  late FaceDetector _faceDetector;
  Interpreter? _interpreter;

  final bool _isLoading = false;
  final statusText = "".obs;

  List<double>? _registEmbeddings = [];
  List<double>? _userEmbeddings = [];

  final _faceRect = Rect.zero.obs;
  final _token = ''.obs;

  bool _isCapturing = false;

  late List<CameraDescription> cameras;
  final cameraController = Rxn<CameraController>();

  @override
  void onInit() async {
    super.onInit();
    cameras = await availableCameras();
    _userEmbeddings = _userController.user.value?.dataWajah;
    _token.value = await _storageService.getToken() ?? '';
    _faceDetector = FaceDetector(
      options: FaceDetectorOptions(performanceMode: FaceDetectorMode.fast),
    );
    await _loadModel();
    await _initCamera();

    void updateFaceRect(Rect scalledRect) {
      _faceRect.value = scalledRect;
    }
  }

  Future<void> _loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset(
        'assets/models/mobilefacenet.tflite',
      );
      print("Model TFlite berhasil dimuat");
    } catch (e) {
      print("Gagal memuat models $e");
    }
  }

  Future<void> _initCamera() async {
    try {
      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      cameraController.value = CameraController(
        frontCamera,
        ResolutionPreset.low,
        enableAudio: false,
        imageFormatGroup: Platform.isAndroid
            ? ImageFormatGroup.yuv420
            : ImageFormatGroup.bgra8888,
      );

      await cameraController.value!.initialize();
      cameraController.refresh();

      cameraController.value!.startImageStream((CameraImage image) {
        if (!_isLoading) {
          _getEmbedding(image);
        }
      });

      print("kamera berhasil dimuat");
    } catch (e) {
      print('gagal memuat kamera: $e');
    }
  }

  Future<void> _registFaceData(List<double> faceData) async {
    final embeddingsData = {'face_data': _registEmbeddings};
    try {
      final result = await _apiService.postRequest<Map<String, dynamic>>(
        endpoint: 'employee/regface',
        data: embeddingsData,
        parser: (body) => jsonDecode(body),
        onError: (resp) => 'Gagal memuat riwayat: ${resp.statusCode}',
      );

      Get.snackbar(
        "Registrasi Wajah Berhasil",
        "Registrasi data wajah berhasil",
      );
      Get.offAllNamed("home");
    } catch (e) {
      print(e);
    }
  }

  Future<void> _getEmbedding(CameraImage image) async {
    final _cameraController = cameraController.value;
    if (_cameraController != null &&
        _cameraController.value.isInitialized &&
        !_isCapturing) {
      _isCapturing = true;

      try {
        XFile file = await _cameraController.takePicture();

        final inputImage = InputImage.fromFilePath(file.path);
        final faces = await _faceDetector.processImage(inputImage);

        if (faces.isNotEmpty) {
          int countdown = 5;

          Timer.periodic(Duration(seconds: 1), (timer) async {
            countdown--;
            statusText.value =
                "Wajah Terdeteksi! Akan mengambil foto dalam $countdown detik";

            if (countdown == 0) {
              final face = faces.first;
              final bytes = await File(inputImage.filePath!).readAsBytes();
              final img = imeg.decodeImage(bytes);

              Rect scaledReact;

              Size imageSize = Size(
                img!.width.toDouble(),
                img.height.toDouble(),
              );
              Size previewSize = _cameraController.value.previewSize!;

              double scaleX = previewSize.width / imageSize.width;
              double scaleY = previewSize.height / imageSize.height;

              final double mirrorLeft =
                  imageSize.width - face.boundingBox.right;
              final double mirrorRight =
                  imageSize.width - face.boundingBox.left;

              scaledReact = Rect.fromLTRB(
                mirrorLeft * scaleX,
                face.boundingBox.top * scaleY,
                mirrorRight * scaleX,
                face.boundingBox.bottom * scaleY,
              );

              final faceCrop = imeg.copyCrop(
                img,
                x: face.boundingBox.left.toInt(),
                y: face.boundingBox.top.toInt(),
                width: face.boundingBox.width.toInt(),
                height: face.boundingBox.height.toInt(),
              );

              final resized = imeg.copyResize(
                faceCrop,
                width: 112,
                height: 112,
              );

              var input = List.generate(1 * 112 * 112 * 3, (i) => 0.0);
              int pixelIndex = 0;
              for (int y = 0; y < 112; y++) {
                for (int x = 0; x < 112; x++) {
                  final pixel = resized.getPixel(x, y);
                  int r = pixel.r.toInt();
                  int g = pixel.g.toInt();

                  int b = pixel.b.toInt();

                  input[pixelIndex++] = (r - 128) / 128.0;
                  input[pixelIndex++] = (g - 128) / 128.0;
                  input[pixelIndex++] = (b - 128) / 128.0;
                }
              }

              var output = List.filled(192, 0.0).reshape([1, 192]);
              _interpreter!.run(input.reshape([1, 112, 112, 3]), output);

              List<double> embedding = List<double>.from(output[0]);
              _registEmbeddings = embedding;

              statusText.value = "selesai";
              _isCapturing = false;
              timer.cancel();
            }
          });
        } else {
          statusText.value = "Arahkan Wajah Ke Kamera";
        }
      } catch (e) {
        print("Error ambil foto: $e");
      } finally {
        _isCapturing = false;
      }
    }
  }

  double cosineSimilarity(List<double> a, List<double> b) {
    double dot = 0.0;
    double normA = 0.0;
    double normB = 0.0;

    for (int i = 0; i < a.length; i++) {
      dot += a[i] * b[i];
      normA += a[i] * a[i];
      normB += b[i] * b[i];
    }

    return dot / (sqrt(normA) * sqrt(normB));
  }

  @override
  void onClose() {
    final _cameraController = cameraController.value;
    _cameraController?.stopImageStream();
    _cameraController?.dispose();
    super.onClose();
  }
}
