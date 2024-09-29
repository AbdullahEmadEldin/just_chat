import 'package:flutter/material.dart';

import '../theme/theme_manager.dart';

class UiHelper {
  /// This method to handle the string length to a limited length
  /// you can determine the max length for the string.
  static String limitStringLength(
      {required String str, required int maxLength}) {
    if (str.length > maxLength) {
      return '${str.substring(0, maxLength)}...';
    } else {
      return str;
    }
  }

//*========================== IMP Explanation ========================== *//
  /// This method to calculate the responsive dimension of a widget
  /// according to the screen size and the device pixel ratio
  /// it could be used with determining width or height and Widget or text.
//! Why not using MediaQuery ??????????
//? ===>> As in multiple cases the the widget size to the device pixel ratio will be too small or too large.
//? So we have to calculate the scale factor and limit it with max and min values.
//? STEPS:
//! 1- Determine a break point for each platform
  ///   ======>>> It's determined by approximation according to width only not height. <<<<=======.
  ///   On this BP the base dimension will set.
  ///   Under this BP the base dimension will be multiplied by the scale factor to decrease it.
  ///   Above this BP the base dimension will be multiplied by the scale factor to increase it.
  /// ?===> And to avoid too small or too large dimension we will limit it with [min] and [max] values.
  //! 2- get Scale Factor //? ==> as BP also there is a Scale Factor for each Platform.
  //?    SF = currentScreenSize(from MediaQuery) / BP.
  //! 2- get Responsive Dimension
  ///?    RD = baseDimension * SF

  static double getResponsiveDimension(
    BuildContext context, {
    required double baseDimension,
  }) {
    // get Scale Factor
    final Size currentSize = MediaQuery.sizeOf(context);
    final scaleFactor = _getScaleFactor(currentSize);
    double responsiveDimension = baseDimension * scaleFactor;
    double upperLimit = baseDimension * 1.1;
    double lowerLimit = baseDimension * 0.8;

    responsiveDimension = responsiveDimension.clamp(lowerLimit, upperLimit);
    return responsiveDimension;
  }

  static double _getScaleFactor(Size currentSize) {
    final width = currentSize.width;
    double scaleFactor;
    if (width < 600) {
      scaleFactor =
          currentSize.width / 400; // approximated breakPoint for mobile
    } else if (width < 900) {
      scaleFactor = currentSize.width / 700;
    } else {
      scaleFactor = currentSize.width / 1000;
    }

    return double.parse(scaleFactor.toStringAsFixed(1));
  }

  static LinearGradient gradientContainerColors() {
    return LinearGradient(
      colors: AppThemes.instance.themeNotifier.value == ThemeMode.dark
          ? const [
              Color(0xff2c3e50),
              Color(0xff2b5876),
            ]
          : const [
              Color.fromARGB(177, 234, 236, 198),
              Color.fromARGB(186, 191, 233, 255),
            ],
    );
  }
}
