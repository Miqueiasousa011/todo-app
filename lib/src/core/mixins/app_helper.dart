import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_app/src/core/themes/themes.dart';

import '../components/loading_widget.dart';

mixin AppHelper<T extends StatefulWidget> on State<T> {
  OverlayEntry? _loadingOverlay;

  void showLoading() {
    removeLoading();

    _loadingOverlay = OverlayEntry(
      builder: (context) => const LoadingWidget(),
    );

    Overlay.of(context).insert(_loadingOverlay!);
  }

  void removeLoading() {
    _loadingOverlay?.remove();
    _loadingOverlay = null;
  }

  OverlayEntry? _snackbarOverlay;

  void removeSnackbar() {
    if (_snackbarOverlay == null) return;

    _snackbarOverlay?.remove();
    _snackbarOverlay = null;
  }

  void showNeutralSnackbar(
    String message, {
    Duration duration = const Duration(seconds: 6),
    Color backgroundColor = Colors.grey,
    Color contentColor = Colors.black,
    double margin = 16.0,
  }) async {
    removeSnackbar();

    _snackbarOverlay = OverlayEntry(
      builder: (context) => Align(
        alignment: Alignment.bottomRight,
        child: TweenAnimationBuilder<Offset>(
          tween: Tween(begin: Offset(-margin, 64.0), end: Offset(-margin, -margin)),
          duration: const Duration(milliseconds: 250),
          builder: (context, value, child) {
            return Transform.translate(
              offset: value,
              child: child,
            );
          },
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 250),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: child,
              );
            },
            child: ConstrainedBox(
              constraints: const BoxConstraints.tightFor(width: 512.0),
              child: Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(8.0),
                color: backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: Text(
                          message,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: contentColor,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                      IconButton(
                        onPressed: removeSnackbar,
                        icon: Icon(
                          Icons.close_rounded,
                          color: contentColor,
                          size: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_snackbarOverlay!);

    await Future.delayed(duration, removeSnackbar);
    // ScaffoldMessenger.maybeOf(context)?.removeCurrentSnackBar();
    // ScaffoldMessenger.maybeOf(context)?.showSnackBar(
    //   SnackBar(
    //     width: 512.0,
    //     dismissDirection: DismissDirection.down,
    //     content: Text(message),
    //     backgroundColor: context.appColors.red,
    //     duration: duration ?? const Duration(seconds: 6),
    //     behavior: SnackBarBehavior.floating,
    //     showCloseIcon: true,
    //   ),
    // );
  }

  void showSuccessSnackbar(
    String message, {
    Duration duration = const Duration(seconds: 6),
    double margin = 16.0,
  }) {
    return showNeutralSnackbar(
      message,
      duration: duration,
      backgroundColor: AppColors.green,
      contentColor: AppColors.blackPrimary1,
      margin: margin,
    );
  }

  void showErrorSnackbar(
    String message, {
    Duration duration = const Duration(seconds: 6),
    double margin = 16.0,
  }) {
    return showNeutralSnackbar(
      message,
      duration: duration,
      backgroundColor: AppColors.redError,
      contentColor: Colors.white,
      margin: margin,
    );
  }

  Future<S?> openDialog<S extends Object?>({
    required Widget child,
    bool barrierDismissible = false,
    double maxWidth = 564.0,
    AlignmentGeometry? alignment,
    EdgeInsets? margin,
    EdgeInsets? padding,
    DialogTransition transition = DialogTransition.scale,
  }) async {
    final data = await showGeneralDialog<S>(
      context: context,
      barrierLabel: '',
      barrierDismissible: barrierDismissible,
      transitionDuration: const Duration(milliseconds: 250),
      transitionBuilder: (context, first, second, child) {
        switch (transition) {
          case DialogTransition.scale:
            {
              final tween = Tween(begin: 0.0, end: 1.0);

              return ScaleTransition(
                scale: CurvedAnimation(parent: first.drive(tween), curve: Curves.bounceInOut),
                child: child,
              );
            }
          case DialogTransition.slideUTD:
            {
              final tweenPos = Tween(begin: const Offset(0.0, -1.0), end: Offset.zero);

              return SlideTransition(
                position: first.drive(tweenPos),
                child: child,
              );
            }
        }
      },
      pageBuilder: (context, first, second) {
        return Padding(
          padding: margin ?? EdgeInsets.zero,
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(24.0),
            alignment: alignment ?? Alignment.center,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: maxWidth,
              ),
              child: Padding(
                padding: padding ?? const EdgeInsets.all(24.0),
                child: child,
              ),
            ),
          ),
        );
      },
    );

    return data;
  }
}

enum DialogTransition { scale, slideUTD }
