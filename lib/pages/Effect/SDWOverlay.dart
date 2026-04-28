import 'package:flutter/material.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/constants/sdw_sizes.dart';

class Sdwoverlay {
  static OverlayEntry? _currentEntry;

  static void showOverlay({
    required BuildContext context,
    required String title,
    required iconData,
    required double height,
    required double width,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    _currentEntry?.remove();

    _currentEntry = OverlayEntry(
      builder: (_) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              child: Container(color: SDWcolors.black.withAlpha(100)),
              // onTap: () => hide(),
            ),
          ),

          Center(
            child: Material(
              color: Colors.transparent,
              child: SizedBox(
                width: height * 0.4,
                height: height * 0.5,
                child: Stack(
                  children: [
                    Container(
                      height: height * 0.3,
                      width: width,
                      margin: EdgeInsets.only(top: 180),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        color: SDWcolors.bgD,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 80),
                          SizedBox(
                            height: 120,
                            width: width,
                            child: Center(
                              child: Text(
                                title,
                                style: TextStyle(
                                  fontSize: SDWsizes.lg,
                                  fontWeight: FontWeight.bold,
                                  color: SDWcolors.textD,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),

                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                  ),
                                  onPressed: () {
                                    hide();
                                    if (onCancel != null) {
                                      onCancel();
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 180,
                                    decoration: BoxDecoration(
                                      color: SDWcolors.bgL,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Batal',
                                        style: TextStyle(
                                          color: SDWcolors.primary,
                                          fontSize: SDWsizes.lg,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                  ),
                                  onPressed: () {
                                    hide();
                                    if (onConfirm != null) {
                                      onConfirm();
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 180,
                                    decoration: BoxDecoration(
                                      color: SDWcolors.primary,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Lanjut',
                                        style: TextStyle(
                                          color: SDWcolors.bgL,
                                          fontSize: SDWsizes.lg,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 125,
                      width: 125,
                      margin: EdgeInsets.only(left: width * 0.3, top: 115),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: SDWcolors.primary,
                      ),
                      child: Container(
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: SDWcolors.white, width: 5),
                        ),
                        child: Icon(iconData, size: 50, color: SDWcolors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_currentEntry!);
  }

  static void hide() {
    _currentEntry?.remove();
    _currentEntry = null;
  }
}
