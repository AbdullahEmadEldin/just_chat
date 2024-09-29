import 'package:flutter/material.dart';

/// This is an interface for color scheme used everywhere in the app
/// for light and dark mode which they are implemented in LightColorScheme and DarkColorScheme
/// ==> This solution comes to prevent code duplication and over user of conditions over the app
abstract class AppColorScheme {
  /// Background color gradients
  Color get background;
  Color get body;
  Color get black;

  /// Primary color gradients
  Color get primary;
  Color get primary80;
  Color get primary60;
  Color get primary40;
  Color get primary20;
  Color get onPrimary;

  /// Grey color gradients
  Color get grey10;
  Color get grey20;
  Color get grey30;
  Color get grey40;
  Color get grey50;
  Color get grey60;
  Color get grey70;
  Color get grey80;
  Color get grey90;
  Color get grey100;

  /// Secondary color gradients
  Color get surfaceBlue;
  Color get surfaceRed;
  Color get surfaceGreen;
  Color get fillPrimary;
  Color get fillRed;
  Color get fillGreen;
}

class LightColorScheme implements AppColorScheme {
  //********************************** Background0 Color IMPL **************************** */
  @override
  Color get background => const Color(0xffFFFFFF);

  @override
  Color get black => const Color(0xff161616);

  @override
  Color get body => const Color(0xff7A7A7A);

  //********************************** PRIMARY Color IMPL **************************** */
  @override
  Color get primary => const Color(0xff4556F8);
  @override
  Color get primary80 => const Color(0xff5162F9);
  @override
  Color get primary60 => const Color(0xff6C7AFA);
  @override
  Color get primary40 => const Color(0xff949EFB);
  @override
  Color get primary20 => const Color(0xffAFB7FC);
  @override
  Color get onPrimary => const Color(0xffA7CBFF);

  //****************************** GREY Color IMPL ************************* */
  @override
  Color get grey10 => const Color(0xffF5F5F5);
  @override
  Color get grey20 => const Color(0xffF5F5F5);
  @override
  Color get grey30 => const Color(0xffEDEDED);
  @override
  Color get grey40 => const Color(0xffE0E0E0);
  @override
  Color get grey50 => const Color(0xffC2C2C2);
  @override
  Color get grey60 => const Color(0xff9E9E9E);
  @override
  Color get grey70 => const Color(0xff757575);
  @override
  Color get grey80 => const Color(0xff616161);
  @override
  Color get grey90 => const Color(0xff404040);
  @override
  Color get grey100 => const Color(0xff242424);

  //***************************************** Secondary Color IMPL **************************** */
  @override
  Color get fillPrimary => const Color(0xff0920F0);

  @override
  Color get fillGreen => const Color(0xff22C55E);

  @override
  Color get fillRed => const Color(0xffFF4C5E);

  @override
  Color get surfaceBlue => const Color(0xffEAF2FF);

  @override
  Color get surfaceGreen => const Color(0xffE9FAEF);

  @override
  Color get surfaceRed => const Color(0xffEAF2FF);
}

class DarkColorScheme implements AppColorScheme {
  //********************************** Background0 Color IMPL **************************** */
  @override
  Color get background => const Color(0xffFFFFFF);

  @override
  Color get black => const Color(0xff161616);

  @override
  Color get body => const Color(0xff7A7A7A);

  //********************************** PRIMARY Color IMPL **************************** */
  @override
  Color get primary => const Color(0xff247CFF);
  @override
  Color get primary80 => const Color(0xff5096FF);
  @override
  Color get primary60 => const Color(0xff7CB0FF);
  @override
  Color get primary40 => const Color(0xffD3E5FF);
  @override
  Color get primary20 => const Color(0xffEAF2FF);
  @override
  Color get onPrimary => const Color(0xffA7CBFF);

  //****************************** GREY Color IMPL ************************* */
  @override
  Color get grey10 => const Color(0xffF5F5F5);
  @override
  Color get grey20 => const Color(0xffF5F5F5);
  @override
  Color get grey30 => const Color(0xffEDEDED);
  @override
  Color get grey40 => const Color(0xffE0E0E0);
  @override
  Color get grey50 => const Color(0xffC2C2C2);
  @override
  Color get grey60 => const Color(0xff9E9E9E);
  @override
  Color get grey70 => const Color(0xff757575);
  @override
  Color get grey80 => const Color(0xff616161);
  @override
  Color get grey90 => const Color(0xff404040);
  @override
  Color get grey100 => const Color(0xff242424);

  //***************************************** Secondary Color IMPL **************************** */
  @override
  Color get fillPrimary => const Color(0xff247CFF);

  @override
  Color get fillGreen => const Color(0xff22C55E);

  @override
  Color get fillRed => const Color(0xffFF4C5E);

  @override
  Color get surfaceBlue => const Color(0xffEAF2FF);

  @override
  Color get surfaceGreen => const Color(0xffE9FAEF);

  @override
  Color get surfaceRed => const Color(0xffEAF2FF);
}
