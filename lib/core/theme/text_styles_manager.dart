// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helpers/ui_helpers.dart';
import '../lang_manager.dart';
import 'colors/colors_manager.dart';
import 'fonts_manager.dart';

class AppTextThemes {
  static TextTheme lightTextTheme(BuildContext context) => TextTheme(
        displayLarge: getTextStyle(
          context,
          color: ColorsManager().colorScheme.primary,
          fontSize: UiHelper.getResponsiveDimension(context, baseDimension: 57),
        ),
        displayMedium: getTextStyle(
          context,
          color: ColorsManager().colorScheme.primary,
          fontSize: UiHelper.getResponsiveDimension(context, baseDimension: 45),
        ),
        displaySmall: getTextStyle(
          context,
          color: ColorsManager().colorScheme.primary,
          fontSize: UiHelper.getResponsiveDimension(context, baseDimension: 36),
        ),
        headlineLarge: getTextStyle(
          context,
          color: ColorsManager().colorScheme.primary,
          fontSize: UiHelper.getResponsiveDimension(context, baseDimension: 32),
        ),
        headlineMedium: getTextStyle(
          context,
          color: ColorsManager().colorScheme.primary,
          fontSize: UiHelper.getResponsiveDimension(context, baseDimension: 28),
        ),
        headlineSmall: getTextStyle(
          context,
          color: ColorsManager().colorScheme.primary,
          fontSize: UiHelper.getResponsiveDimension(context, baseDimension: 26),
        ),
        titleLarge: getTextStyle(context,
            color: ColorsManager().colorScheme.primary,
            fontSize:
                UiHelper.getResponsiveDimension(context, baseDimension: 24),
            fontWeight: FontWeight.w900),
        titleMedium: getTextStyle(
          context,
          color: ColorsManager().colorScheme.primary,
          fontSize: UiHelper.getResponsiveDimension(context, baseDimension: 22),
        ),
        titleSmall: getTextStyle(
          context,
          color: ColorsManager().colorScheme.primary,
          fontSize: UiHelper.getResponsiveDimension(context, baseDimension: 20),
        ),
        bodyLarge: getTextStyle(
          context,
          color: ColorsManager().colorScheme.primary,
          fontSize: UiHelper.getResponsiveDimension(context, baseDimension: 18),
        ),
        bodyMedium: getTextStyle(
          context,
          color: ColorsManager().colorScheme.grey60,
          fontSize: UiHelper.getResponsiveDimension(context, baseDimension: 16),
        ),
        bodySmall: getTextStyle(
          context,
          color: ColorsManager().colorScheme.grey70,
          fontSize: UiHelper.getResponsiveDimension(context, baseDimension: 14),
        ),
      );

//!! Dark theme !!!
}

/// *******************************************************
/// This methods to make calling text styles more easier
/// And determine the needed properties in TextStyle.
/// *******************************************************
TextStyle getTextStyle(BuildContext context,
    {required double fontSize, FontWeight? fontWeight, required Color color}) {
  return TextStyle(
      fontSize: fontSize.sp,
      fontFamily: context.locale.languageCode == LanguageType.arabic.code
          ? AppFonts.notoKufiArabic
          : AppFonts.fredoka,
      color: color,
      fontWeight: fontWeight);
}
