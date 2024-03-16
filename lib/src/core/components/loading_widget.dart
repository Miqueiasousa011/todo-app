import 'package:flutter/material.dart';
import 'package:todo_app/src/core/themes/themes.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black26,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(AppColors.blackPrimary1),
      ),
    );
  }
}
