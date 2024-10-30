class AppConstants {
  static const int splashTimer = 2;
  static const int pageSize = 50;
  static const int onBoardingAnimationTimerInMilli = 1000;
  static const Duration transitionDurationInSec = Duration(seconds: 1);
  static const String awesomeNotificationChanel = 'basic_channel';
  //********************** FIREBASE CONSTANTS ***********************/

  static const String userCollection = 'users';
  static const String chatCollection = 'chats';
  static const String messageCollection = 'messages';
  static const String uploadsPath = 'uploads';
}

class SharedPrefKeys {
  static String lang = 'lang';
  static String firstLaunch = 'firstLaunch';
  static String stayLoggedIn = 'stayLoggedIn';
  static String token = 'userToken';
  static String userId = 'id';
  static String isDark = 'isDark';
}
