// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  CameraController? _cameraController;

  late FaceDetector _faceDetector;
  Interpreter? _interpreter;

  final bool _isLoading = false;
  final _statusText = "".obs;

  final _registeredFaces = <Map<String, dynamic>>[].obs;
  final _faceEmbeddings = <List<double>>[].obs;

  final _faceRect = Rect.zero.obs;
  final _token = ''.obs;

  bool _isCapturing = false;

  @override
  void onInit() async {
    super.onInit();
    _faceEmbeddings.value = await _userController.userData['face'] ?? '';
    _token.value = await _storageService.getToken() ?? '';
    _faceDetector = FaceDetector(
      options: FaceDetectorOptions(performanceMode: FaceDetectorMode.fast),
    );
    _loadModel();
    _initCamera();

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
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    _cameraController = CameraController(
      frontCamera,
      ResolutionPreset.low,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.yuv420
          : ImageFormatGroup.bgra8888,
    );

    await _cameraController!.initialize();

    _cameraController!.startImageStream((CameraImage image) {
      if (!_isLoading) {
        _processCameraImage(image);
      }
    });
  }

  Future<void> _processCameraImage(CameraImage image) async {
    if (_cameraController != null &&
        _cameraController!.value.isInitialized &&
        !_isCapturing) {
      _isCapturing = true;
      try {
        XFile file = await _cameraController!.takePicture();

        final inputImage = InputImage.fromFilePath(file.path);
        final faces = await _faceDetector.processImage(inputImage);

        if (faces.isNotEmpty) {
          final face = faces.first;
          final bytes = await File(inputImage.filePath!).readAsBytes();
          final img = imeg.decodeImage(bytes);

          Rect scaledReact;

          Size imageSize = Size(img!.width.toDouble(), img.height.toDouble());
          Size previewSize = _cameraController!.value.previewSize!;

          double scaleX = previewSize.width / imageSize.width;
          double scaleY = previewSize.height / imageSize.height;

          final double mirrorLeft = imageSize.width - face.boundingBox.right;
          final double mirrorRight = imageSize.width - face.boundingBox.left;

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

          final resized = imeg.copyResize(faceCrop, width: 112, height: 112);

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

          String? matchedName;
          double maxSimilarity = 0.0;
          const double threshold = 0.9;

          for (var entry in _registeredFaces) {
            double sim = cosineSimilarity(embedding, entry['embedding']);
            if (sim > maxSimilarity && sim > threshold) {
              maxSimilarity = sim;
              matchedName = entry['name'];
            }
          }

          if (matchedName != null) {
            _statusText.value = "Wajah Dikenali sebagai : $matchedName";
          }
        } else {
          _statusText.value = "Arahkan Wajah Ke Kamera";
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
}
