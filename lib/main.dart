import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/app_entry.dart';
import 'package:just_chat/modules/auth/view/page/phone_auth_page.dart';
import 'package:just_chat/modules/chat/view/all_chats_page.dart';
import 'package:just_chat/modules/onboarding/view/page/onboarding_page.dart';

import 'core/constants/constants.dart';
import 'core/di/dependency_injection.dart';
import 'core/lang_manager.dart';
import 'core/services/cache/cache_helper.dart';
import 'core/theme/colors/colors_manager.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await ScreenUtil.ensureScreenSize();
  await EasyLocalization.ensureInitialized();
  setUpGetIt();
  await CacheHelper.init();
  //setUpGetIt();
  final String startLocale = await LanguageManager.getAppLang();
  CacheHelper.init();
  // Set initial route
  final String initialRoute = await handleInitialRoute();
  // Set the status bar to the app background
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: ColorsManager()
          .colorScheme
          .background, // Make the status bar transparent
      statusBarIconBrightness:
          Brightness.dark, // Set icon brightness (optional)
    ),
  );

  // runApp(DevicePreview(enabled: !kReleaseMode, builder: (_) => MyApp()));
  runApp(
    EasyLocalization(
        startLocale: Locale(startLocale),
        supportedLocales: [
          Locale(LanguageType.english.code),
          Locale(LanguageType.arabic.code)
        ],
        path: 'assets/translations',
        child: JustChatApp(
          initialRoute: initialRoute,
        )),
  );
}

Future<String> handleInitialRoute() async {
  String initialRoute;
  bool firstLaunch =
      await CacheHelper.getData(key: SharedPrefKeys.firstLaunch) ?? true;

  if (firstLaunch) {
    initialRoute = OnboardingPage.routeName;
  } else if (getIt<FirebaseAuth>().currentUser != null) {
    initialRoute = AllChatsPage.routeName;
  } else {
    initialRoute = PhoneAuthPage.routeName;
  }
  // if(!token.isNullOrEmpty()){
  return initialRoute;
}
