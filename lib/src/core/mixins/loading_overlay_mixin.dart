import 'package:flutter/material.dart';

import '../themes/themes.dart';

mixin LoadingOverlayStateMixin<T extends StatefulWidget> on State<T> {
  OverlayEntry? _overlayEntry;

  void removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  Widget _loadingOverlay() => TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 200),
        builder: (BuildContext context, double animation, Widget? child) {
          return AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: animation,
            curve: Curves.easeInOut,
            child: Stack(
              children: [
                ModalBarrier(
                  barrierSemanticsDismissible: false,
                  dismissible: false,
                  color: Colors.grey.withOpacity(.4),
                ),
                const Center(
                  child: RefreshProgressIndicator(
                    color: AppColors.blue,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.blue),
                  ),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.aspect_ratio),
      );

  void _insertOverlay() {
    _overlayEntry = OverlayEntry(builder: (_) => _loadingOverlay());
    Overlay.of(context).insert(_overlayEntry!);
  }

  bool get isOverlayShown => _overlayEntry != null;

  void toggleOverlay() => isOverlayShown ? removeOverlay() : _insertOverlay();
}
