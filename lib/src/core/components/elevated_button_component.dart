import 'package:flutter/material.dart';

import '../themes/themes.dart';

class ElevatedButtonComponent extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final double cornersRadius;
  final String? icon;
  final Color? bgColor;
  final Color? fontColor;

  const ElevatedButtonComponent({
    super.key,
    this.onPressed,
    this.cornersRadius = Corners.sm,
    this.bgColor,
    this.fontColor,
    this.icon,
    required this.title,
  });

  const ElevatedButtonComponent.rounded({
    super.key,
    this.onPressed,
    this.cornersRadius = Corners.rounded,
    this.bgColor,
    this.fontColor,
    this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        fixedSize: const MaterialStatePropertyAll<Size>(Size.fromHeight(maxButtonHeight)),
        backgroundColor: bgColor != null ? MaterialStatePropertyAll(bgColor) : null,
        shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cornersRadius),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(title),
    );
  }
}
