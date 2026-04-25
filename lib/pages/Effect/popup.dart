import 'package:flutter/material.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/constants/sdw_sizes.dart';

class PopUp {
  static OverlayEntry? _overlayEntry;

  static void show(
    BuildContext, {
    required String title,
    required String message,
    required double height,
    required double width,
    IconData icon = Icons.info,
    String confirmText = 'Lanjut',
    String cancelText = 'Batal',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => Material(
        color: Colors.black.withAlpha(150),
        child: Center(
          child: _popUpContent(
            title: title,
            message: message,
            icon: icon,
            confirmText: confirmText,
            cancelText: cancelText,
            height: height,
            width: width,
            onConfirm: onConfirm,
            onCancel: onCancel,
          ),
        ),
      ),
    );
  }

  static void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

class _popUpContent extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final double height;
  final double width;

  _popUpContent({
    required this.title,
    required this.message,
    required this.icon,
    required this.confirmText,
    required this.cancelText,
    required this.height,
    required this.width,
    this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 250),
      tween: Tween(begin: 0.8, end: 1.0),
      builder: (context, scale, child) {
        return Transform.scale(scale: scale, child: child);
      },
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 50, color: Colors.blue),
            const SizedBox(height: 16),

            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(message, textAlign: TextAlign.center),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      PopUp.hide();
                      onCancel?.call();
                    },
                    child: Text(cancelText),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      PopUp.hide();
                      onConfirm?.call();
                    },
                    child: Text(confirmText),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
