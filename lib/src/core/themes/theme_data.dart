import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'corners.dart';
import 'extensions/build_context_extension.dart';
import 'colors.dart';
import 'dimensions.dart';
import 'spacings.dart';

ThemeData appLightTheme(BuildContext context) {
  final themeBase = Theme.of(context);

  return Theme.of(context).copyWith(
      useMaterial3: false,
      textTheme: GoogleFonts.robotoTextTheme(),
      inputDecorationTheme: inputDecorationTheme(context),
      elevatedButtonTheme: _buildElevatedButtonThemeData(themeBase),
      outlinedButtonTheme: _buildOutlinedButtonThemeThemeData(themeBase),
      textButtonTheme: _buildTextButtonTheme(themeBase),
      appBarTheme: _makeAppBarTheme(context),
      tabBarTheme: _makeTabBarTheme(context),
      scaffoldBackgroundColor: Colors.white);
}

InputDecorationTheme inputDecorationTheme(BuildContext context) {
  final themeBase = Theme.of(context);

  return themeBase.inputDecorationTheme.copyWith(
    contentPadding: const EdgeInsets.symmetric(
      horizontal: AppSpacings.medium,
      vertical: AppSpacings.xSmall,
    ),
    labelStyle: MaterialStateTextStyle.resolveWith(
      (states) {
        final styleBase = context.textTheme.bodySmall!.copyWith(
          fontSize: 12,
          color: AppColors.blackSecondary2,
        );

        if (states.contains(MaterialState.error)) {
          return styleBase.copyWith(color: AppColors.redError);
        }

        return styleBase;
      },
    ),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    fillColor: Colors.transparent,
    hintStyle: context.textTheme.bodySmall?.copyWith(
      fontSize: 16,
      letterSpacing: .5,
      color: AppColors.blackSecondary2.withOpacity(.8),
    ),
    errorStyle: context.textTheme.bodySmall?.copyWith(
      fontSize: 12,
      color: AppColors.redError,
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.redError),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.redError),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.blue),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.blackSecondary2,
      ),
    ),
  );
}

ElevatedButtonThemeData _buildElevatedButtonThemeData(ThemeData themeBase) {
  return ElevatedButtonThemeData(
    style: ButtonStyle(
      fixedSize: const MaterialStatePropertyAll<Size>(Size.fromHeight(maxButtonHeight)),
      elevation: const MaterialStatePropertyAll<double>(0),
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return AppColors.grey3;
        }

        return AppColors.blackSecondary2;
      }),
      foregroundColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.grey30;
          }

          return Colors.white;
        },
      ),
      textStyle: MaterialStatePropertyAll<TextStyle?>(
        themeBase.textTheme.labelLarge?.copyWith(
          fontSize: 14,
          letterSpacing: 0.1,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

OutlinedButtonThemeData _buildOutlinedButtonThemeThemeData(ThemeData themeBase) {
  return OutlinedButtonThemeData(
    style: ButtonStyle(
      fixedSize: const MaterialStatePropertyAll<Size>(Size.fromHeight(maxButtonHeight)),
      elevation: const MaterialStatePropertyAll<double>(0),
      overlayColor: MaterialStatePropertyAll(Colors.grey.withOpacity(.1)),
      side: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return const BorderSide(
              color: AppColors.grey3,
            );
          }

          return const BorderSide(color: AppColors.blackPrimary1);
        },
      ),
      backgroundColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.grey3;
          }

          return Colors.white;
        },
      ),
      foregroundColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.grey30;
          }

          return AppColors.blackPrimary1;
        },
      ),
      textStyle: MaterialStatePropertyAll<TextStyle?>(
        themeBase.textTheme.labelLarge?.copyWith(
          fontSize: 14,
          letterSpacing: 0.1,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

TextButtonThemeData _buildTextButtonTheme(ThemeData themeBase) {
  return TextButtonThemeData(
    style: ButtonStyle(
      fixedSize: const MaterialStatePropertyAll<Size>(Size.fromHeight(maxButtonHeight)),
      foregroundColor: const MaterialStatePropertyAll<Color>(AppColors.blue),
      textStyle: MaterialStatePropertyAll<TextStyle?>(
        themeBase.textTheme.labelLarge?.copyWith(
          color: AppColors.blue,
          fontSize: 16,
          letterSpacing: 0.25,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

AppBarTheme _makeAppBarTheme(BuildContext context) {
  final themeBase = Theme.of(context);
  return themeBase.appBarTheme.copyWith(
    elevation: 1,
    backgroundColor: Colors.white,
    foregroundColor: Colors.white,
    centerTitle: true,
    iconTheme: const IconThemeData(color: AppColors.blackSecondary2),
    actionsIconTheme: const IconThemeData(color: AppColors.blackSecondary2),
    titleTextStyle: context.textTheme.bodyMedium?.copyWith(
      fontSize: 16,
      letterSpacing: .25,
      fontWeight: FontWeight.w500,
      color: AppColors.blackSecondary2,
    ),
  );
}

TabBarTheme _makeTabBarTheme(BuildContext context) {
  final themeBase = Theme.of(context);

  final textStyleBase = context.textTheme.bodyMedium?.copyWith(
    fontSize: 14,
    letterSpacing: .1,
    fontWeight: FontWeight.w600,
  );

  return themeBase.tabBarTheme.copyWith(
    unselectedLabelColor: AppColors.blackSecondary2.withOpacity(.5),
    labelColor: AppColors.blackSecondary2,
    labelStyle: textStyleBase,
    unselectedLabelStyle: textStyleBase?.copyWith(fontWeight: FontWeight.w500),
    indicatorColor: AppColors.blackSecondary2,
    indicatorSize: TabBarIndicatorSize.label,
    labelPadding: const EdgeInsets.symmetric(vertical: 14),
    indicator: const UnderlineTabIndicator(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(Corners.md),
        topRight: Radius.circular(Corners.md),
      ),
      borderSide: BorderSide(
        width: 3,
        color: AppColors.blackSecondary2,
      ),
    ),
  );
}
