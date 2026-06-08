import 'package:flutter/material.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/constants/sdw_sizes.dart';

class SDWoverlay {
  static OverlayEntry? _currentEntry;

  static void showOverlay({
    required BuildContext context,
    required String title,
    required iconData,
    required double height,
    required double width,
    String? subtitle,
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
                              child: subtitle != null
                                  ? Column(
                                      children: [
                                        Text(
                                          title,
                                          style: TextStyle(
                                            fontSize: SDWsizes.lg,
                                            fontWeight: FontWeight.bold,
                                            color: SDWcolors.textD,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          subtitle,
                                          style: TextStyle(
                                            fontSize: SDWsizes.lg,
                                            fontWeight: FontWeight.bold,
                                            color: SDWcolors.textD,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    )
                                  : Text(
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
                                if (onCancel != null)
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                    ),
                                    onPressed: () {
                                      hide();
                                      onCancel();
                                    },
                                    child: Container(
                                      height: height * 0.045,
                                      width: width * 0.35,
                                      decoration: BoxDecoration(
                                        color: SDWcolors.bgL,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Batal',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                fontSize: height * 0.02,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 2,
                                                foreground: Paint()
                                                  ..style = PaintingStyle.stroke
                                                  ..strokeWidth = 1
                                                  ..color = SDWcolors.primary,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                if (onConfirm != null)
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                    ),
                                    onPressed: () {
                                      hide();
                                      onConfirm();
                                    },
                                    child: Container(
                                      height: height * 0.045,
                                      width: width * 0.35,
                                      decoration: BoxDecoration(
                                        color: SDWcolors.primary,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Lanjut',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                fontSize: height * 0.02,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 2,
                                                foreground: Paint()
                                                  ..style = PaintingStyle.stroke
                                                  ..strokeWidth = 1
                                                  ..color = SDWcolors.textL,
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
