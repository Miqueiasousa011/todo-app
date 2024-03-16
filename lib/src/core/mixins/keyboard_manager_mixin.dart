import 'package:flutter/material.dart';

mixin HideKeyboardMixin<T extends StatefulWidget> on State<T> {
  void hindeKeyBoard() {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  bool get isLargeScreen => MediaQuery.of(context).size.width > 700;

  double get screenWidth => isLargeScreen ? 700 : 500;
}
