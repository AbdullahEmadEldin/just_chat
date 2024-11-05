import '../../constants/constants.dart';
import '../../services/cache/cache_helper.dart';
import 'colors_scheme.dart';

class ColorsManager {
  static final ColorsManager _instance = ColorsManager._internal();
  factory ColorsManager() => _instance;
  ColorsManager._internal();

  AppColorScheme _colorScheme =
      CacheHelper.getData(key: SharedPrefKeys.isDark) ?? false
          ? DarkColorScheme()
          : LightColorScheme(); // Default to light theme

  AppColorScheme get colorScheme => _colorScheme;

  /// Updating the Colors theme according to the user choice
  void updateTheme(bool isDark) {
    if (isDark) {
      _colorScheme = DarkColorScheme();
    } else {
      _colorScheme = LightColorScheme();
    }
  }
}
