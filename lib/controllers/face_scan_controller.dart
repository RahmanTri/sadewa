import 'dart:convert';

import 'package:flutter/foundation.dart';
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
import 'package:sadewa_fe/routes/app_routes.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sadewa_fe/pages/Effect/SDWOverlay.dart';
import 'package:flutter/services.dart';

class FaceScanController extends GetxController {
  final StorageService _storageService = StorageService();
  final ApiService _apiService = ApiService();
  final userData = Get.find<UserController>();
  final statusText = ''.obs;
  final token = ''.obs;
  static const platform = MethodChannel('mock_location_channel');

  double divLat = 0.0;
  double divLng = 0.0;
  double divRadius = 0.0;

  late FaceDetector _faceDetector;
  Interpreter? _interpreter;
  bool isRegist = true;

  List<double>? embeddingResult = [];
  Timer? _timer;

  final _faceRect = Rect.zero.obs;

  bool _isCapturing = false;
  bool _isCounting = false;
  bool _isDispose = false;
  final distanceUpdated = false.obs;
  final isInRadius = false.obs;
  final isMocked = false.obs;
  bool isLoading = false;
  var cosineValue = ''.obs;
  var isImageProcessed = false.obs;

  late List<CameraDescription> cameras;
  final cameraController = Rxn<CameraController>();

  @override
  void onInit() async {
    super.onInit();
    token.value = await _storageService.getToken() ?? '';
    cameras = await availableCameras();
    await _loadLocation();
    _faceDetector = FaceDetector(
      options: FaceDetectorOptions(performanceMode: FaceDetectorMode.fast),
    );
    await _loadModel();
    await _initCamera();
  }

  Future<void> _loadModel() async {
    try {
      isLoading = true;
      _interpreter = await Interpreter.fromAsset(
        'assets/models/mobilefacenet.tflite',
      );
      print("Model TFlite berhasil dimuat");
      isLoading = false;
    } catch (e) {
      print("Gagal memuat models $e");
    }
  }

  Future<void> _loadLocation() async {
    final authToken = token.value;

    try {
      isLoading = true;
      final result = await _apiService.getRequest<Map<String, dynamic>>(
        endpoint: 'user/get-division',
        parser: (body) => jsonDecode(body),
        onError: (resp) => 'Gagal memuat riwayat: ${resp.statusCode}',
        headers: {'Authorization': 'Bearer $authToken'},
      );
      final int radius = result['data']['r_tolerance'];
      divLat = result['data']['latitude'];
      divLng = result['data']['longitude'];
      divRadius = radius.toDouble();
      print("Berhasil mendapatkan data lokasi untuk divisi : $divLat, $divLng");
      isLoading = false;
    } catch (e) {
      print("Gagal mendapatkan data lokasi untuk divisi: $e");
    }
  }

  Future<void> _initCamera() async {
    final userEmbeddings = userData.user.value?.dataWajah ?? [];

    try {
      isLoading = true;
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

      if (userEmbeddings.isEmpty) {
        isRegist = true;
      } else {
        isRegist = false;
        try {
          isMocked.value = await mainMockCheck();
          isInRadius.value = await radiusProvider(divLat, divLng, divRadius);
          print("Berhasil set in radius : $isInRadius");
        } catch (e) {
          print("Gagal Kalkulasi lokasi : $e");
        }
      }

      cameraController.value!.startImageStream((CameraImage image) {
        if (_isDispose) return;
        if (!isLoading) {
          if (_isDispose || _isCapturing) return;

          if (isRegist) {
            _getEmbedding(image, userEmbeddings);
          } else {
            if (isInRadius.value && !isMocked.value) {
              print("IsInRadius controller => ${isInRadius.value.toString()}");
              _getEmbedding(image, userEmbeddings);
            } else {}
          }
        }
      });

      print("kamera berhasil dimuat");
      isLoading = false;
    } catch (e) {
      print('gagal memuat kamera: $e');
    }
  }

  Future<bool> radiusProvider(double lat, double lng, double radius) async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission;

    if (!isServiceEnabled) {
      throw Exception('Lokasi tidak aktif');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Izin lokasi ditolak';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Izin lokasi ditolak secara permanen';
    }

    Position userPos = await Geolocator.getCurrentPosition(
      locationSettings: AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
        forceLocationManager: true,
        intervalDuration: const Duration(seconds: 5),
      ),
    );
    double distance = Geolocator.distanceBetween(
      lat,
      lng,
      userPos.latitude,
      userPos.longitude,
    );
    print("Jarak anda dengan divisi : $distance M");

    distanceUpdated.value = true;
    return distance <= radius;
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

  Uint8List _cvYUV2NV21(CameraImage image) {
    final yPlane = image.planes[0];
    final uPlane = image.planes[1];
    final vPlane = image.planes[2];

    final ySize = yPlane.bytes.length;
    final uvSize = uPlane.bytes.length;

    final nv21 = Uint8List(ySize + uvSize * 2);

    int index = 0;

    for (int i = 0; i < ySize; i++) {
      nv21[index++] = yPlane.bytes[i];
    }

    for (int i = 0; i < uvSize; i++) {
      nv21[index++] = vPlane.bytes[i];
      nv21[index++] = uPlane.bytes[i];
    }

    return nv21;
  }

  imeg.Image _cvYUV2Image(CameraImage image) {
    final int width = image.width;
    final int height = image.height;

    final img = imeg.Image(width: width, height: height);

    final yPlane = image.planes[0];
    final uPlane = image.planes[1];
    final vPlane = image.planes[2];

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final yIndex = y * yPlane.bytesPerRow + x;
        final uvRow = y ~/ 2;
        final uvCol = x ~/ 2;
        final uvIndex = uvRow * uPlane.bytesPerRow + uvCol;

        final yp = yPlane.bytes[yIndex];
        final up = uPlane.bytes[uvIndex];
        final vp = vPlane.bytes[uvIndex];

        int r = (yp + 1.402 * (vp - 128)).round();
        int g = (yp - 0.344136 * (up - 128) - 0.714136 * (vp - 128)).round();
        int b = (yp + 1.772 * (up - 128)).round();

        r = r.clamp(0, 255);
        g = g.clamp(0, 255);
        b = b.clamp(0, 255);

        img.setPixelRgb(x, y, r, g, b);
      }
    }

    return img;
  }

  Future<void> _getEmbedding(CameraImage image, List<double> faceData) async {
    final _cameraController = cameraController.value;
    final userEmbeddings = userData.user.value?.dataWajah;
    if (_isDispose) return;
    if (!Get.isRegistered<FaceScanController>()) return;
    if (_cameraController != null &&
        _cameraController.value.isInitialized &&
        !_isCapturing) {
      try {
        _isCapturing = true;
        final bytes = _cvYUV2NV21(image);
        final inputImage = InputImage.fromBytes(
          bytes: bytes,
          metadata: InputImageMetadata(
            size: Size(image.width.toDouble(), image.height.toDouble()),
            rotation: InputImageRotation.rotation0deg,
            format: InputImageFormat.nv21,
            bytesPerRow: image.width,
          ),
        );

        final faces = await _faceDetector.processImage(inputImage);

        if (faces.isNotEmpty) {
          if (userEmbeddings == null || userEmbeddings.isEmpty) {
            int countdown = 5;

            if (!_isCounting) {
              _isCounting = true;
              _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
                countdown--;
                statusText.value =
                    "Wajah Terdeteksi! Akan mengambil foto dalam $countdown detik";

                if (countdown == 0) {
                  timer.cancel();
                  try {
                    isImageProcessed.value = true;
                    embeddingResult = await _processFace(faces.first, image);
                    closeCamera();
                    print('Data wajah: $embeddingResult');
                    Get.offAllNamed(Routes.absenConfirm);
                  } catch (e) {
                    print('Gagal memproses wajah: $e');
                  } finally {
                    _isCapturing = false;
                    _isCounting = false;
                    isLoading = false;
                    isImageProcessed.value = false;
                  }
                }
              });
            }
          } else {
            embeddingResult = await _processFace(faces.first, image);
            double maxSimilarity = 0.0;
            const threshold = 0.78;
            try {
              double sim = cosineSimilarity(embeddingResult!, userEmbeddings);
              if (sim > maxSimilarity && sim > threshold) {
                isImageProcessed.value = true;
                Get.offAllNamed(Routes.absenConfirm);
                closeCamera();
              } else {
                statusText.value = "Wajah Terdeteksi, tapi bukan anda!";
              }
            } catch (e) {
              print('Gagal memproses wajah: $e');
            } finally {
              _isCapturing = false;
              _isCounting = false;
              isLoading = false;
            }
          }
        } else {
          statusText.value = "Arahkan Wajah Ke Kamera";
          _isCapturing = false;
        }
      } catch (e) {
        print("Error ambil foto: $e");
        _isCapturing = false;
      }
    }
  }

  Future<List<double>> _processFace(Face face, CameraImage image) async {
    final img = _cvYUV2Image(image);

    int x = face.boundingBox.left.round();
    int y = face.boundingBox.top.round();
    int w = face.boundingBox.width.round();
    int h = face.boundingBox.height.round();

    x = x.clamp(0, image.width - 1);
    y = y.clamp(0, image.height - 1);

    if (x + w > image.width) w = image.width - x;
    if (y + h > image.height) h = image.height - y;

    if (w <= 0 || h <= 0) return [];

    final faceCrop = imeg.copyCrop(img, x: x, y: y, width: w, height: h);

    final resized = imeg.copyResize(
      faceCrop,
      width: 112,
      height: 112,
      interpolation: imeg.Interpolation.linear,
    );

    if (resized.width != 112 || resized.height != 112) {
      print("Resize gagal: ${resized.width} x ${resized.height}");
      return [];
    }

    var input = List.generate(112 * 112 * 3, (i) => 0.0);
    int pixelIndex = 0;
    for (int y = 0; y < 112; y++) {
      for (int x = 0; x < 112; x++) {
        final pixel = resized.getPixel(x, y);

        input[pixelIndex++] = (pixel.r - 128) / 128.0;
        input[pixelIndex++] = (pixel.g - 128) / 128.0;
        input[pixelIndex++] = (pixel.b - 128) / 128.0;
      }
    }

    var output = List.filled(192, 0.0).reshape([1, 192]);
    _interpreter!.run(input.reshape([1, 112, 112, 3]), output);

    return List<double>.from(output[0]);
  }

  Future<void> closeCamera() async {
    final _cameraController = cameraController.value;
    _timer?.cancel();
    _timer = null;

    if (_cameraController?.value.isStreamingImages ?? false) {
      try {
        await _cameraController?.stopImageStream();
        print('Berhasil stop stream');
      } catch (e) {
        print('Gagal Stop Stream: $e');
      }
      try {
        await _cameraController?.dispose();
        _isDispose = true;
        print("Berhasil dispose Kamera");
      } catch (e) {
        print('Gagal Dispose Camera: $e');
      }
    }
    cameraController.value = null;
  }

  Future<bool> checkMockLocation1() async {
    try {
      final bool result = await platform.invokeMethod('isMockLocation');
      return result;
    } on Error {
      return false;
    }
  }

  Future<bool> checkMockLocation2() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      } else if (permission == LocationPermission.deniedForever) {
        return false;
      }
    }

    final location = await Geolocator.getCurrentPosition();

    if (location.isMocked) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> mainMockCheck() async {
    final test1 = await checkMockLocation1();
    final test2 = await checkMockLocation2();

    if (test1 || test2) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    _timer = null;
    closeCamera();
    _isCapturing = false;
    _isCounting = false;
    distanceUpdated.value = false;
    isLoading = false;
    _isDispose = false;
    isImageProcessed.value = false;
    super.onClose();
  }
}
