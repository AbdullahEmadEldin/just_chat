import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../services/cache/cache_helper.dart';
import 'colors/colors_manager.dart';
import 'text_styles_manager.dart';

class AppThemes {
  /// define a singleton instance
  ///
  AppThemes._internal();
  static final instance = AppThemes._internal();

  static ThemeMode? _value;
  ThemeMode? get themeMode => _value;

  updateThemeValue(bool isDark) {
    if (CacheHelper.getData(key: SharedPrefKeys.isDark) != null) {
      _value = CacheHelper.getData(key: SharedPrefKeys.isDark)
          ? ThemeMode.dark
          : ThemeMode.light;
    }
    _value = isDark ? ThemeMode.dark : ThemeMode.light;
    themeNotifier.value = _value;
  }

  final ValueNotifier<ThemeMode?> themeNotifier = ValueNotifier(
      CacheHelper.getData(key: SharedPrefKeys.isDark) ?? false
          ? ThemeMode.dark
          : _value);

  ThemeData lightAppTheme(BuildContext context) => ThemeData(
        // main colors
        primaryColor: ColorsManager().colorScheme.primary,
        primaryColorLight: ColorsManager().colorScheme.primary60,
        primaryColorDark: ColorsManager().colorScheme.grey100,
        scaffoldBackgroundColor:
            ColorsManager().colorScheme.background, // ripple effect color
        // card view theme

        // elevated button them
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: getTextStyle(context,
                color: ColorsManager().colorScheme.onPrimary, fontSize: 17),
            backgroundColor: ColorsManager().colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        textTheme: AppTextThemes.lightTextTheme(context),
        // label style
        progressIndicatorTheme: ProgressIndicatorThemeData(
            color: ColorsManager().colorScheme.primary),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: ColorsManager().colorScheme.primary80),
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return ColorsManager().colorScheme.primary;
            } else {
              return Colors.transparent;
            }
          }),
          checkColor:
              WidgetStatePropertyAll(ColorsManager().colorScheme.onPrimary),
          side: BorderSide(color: ColorsManager().colorScheme.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      );

  ThemeData darkAppTheme(BuildContext context) => ThemeData(
        scaffoldBackgroundColor: Colors.red, // ripple effect color
        brightness: Brightness.dark,
        textTheme: AppTextThemes.lightTextTheme(context),
      );
}
