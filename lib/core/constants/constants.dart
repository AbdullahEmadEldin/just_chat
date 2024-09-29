class AppConstants {
  static SqlKeys sqlKeys = SqlKeys();
  static const int splashTimer = 2;
  static const int pageSize = 50;
  static const int onBoardingAnimationTimerInMilli = 1000;
  static const Duration transitionDurationInSec = Duration(seconds: 1);
}

class SharedPrefKeys {
  static String lang = 'lang';
  static String firstLaunch = 'firstLaunch';
  static String stayLoggedIn = 'stayLoggedIn';
  static String token = 'userToken';
  static String userId = 'id';
  static String isDark = 'isDark';
}

class SqlKeys {
  String savedBooksTable = 'savedBooks';
  String downloadsTable = 'downloads';
  String bookId = 'bookId';
  String bookName = 'bookName';
  String bookImage = 'image';
}
