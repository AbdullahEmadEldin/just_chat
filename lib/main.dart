import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/app_entry.dart';
import 'package:just_chat/core/services/firebase_notifiaction/firebase_cloud_msgs.dart';
import 'package:just_chat/core/services/firestore_service.dart';
import 'package:just_chat/modules/auth/view/page/phone_auth_page.dart';
import 'package:just_chat/modules/nav_bar/custom_nav_bar.dart';
import 'package:just_chat/modules/onboarding/view/page/onboarding_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/constants/constants.dart';
import 'core/di/dependency_injection.dart';
import 'core/lang_manager.dart';
import 'core/services/cache/cache_helper.dart';
import 'core/theme/colors/colors_manager.dart';
import 'firebase_options.dart';

Future<void> _onBackgroundMessage(remoteMsg) async {
  FcmService.handleCustomNotificationUi(remoteMsg);
  log('================>>> Background Message: ${remoteMsg.data}');
}

void main() async {
  /// Firebase Initialization
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// Dependency Injection Initialization..
  setUpGetIt();

  /// ScreenUtil Initialization
  await ScreenUtil.ensureScreenSize();

  /// EasyLocalization Initialization.
  await EasyLocalization.ensureInitialized();

  /// Firebase Messaging Initialization
  FirebaseMessaging.onBackgroundMessage(
    _onBackgroundMessage,
  );

  /// Init Awesome notification
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: AppConstants.awesomeNotificationChanel,
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color(0xff4556F8),
          ledColor: Colors.white,
        )
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true);

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
  // FcmService.setupInteractedMessage();

  /// CacheHelper Initialization
  await CacheHelper.init();
  final String startLocale = await LanguageManager.getAppLang();

  /// Set initial route
  final String initialRoute = await handleInitialRoute();

  /// This bool comes from settings page where user can turn on/off notifications
  final bool notificationStatus =
      await CacheHelper.getData(key: SharedPrefKeys.notification) ?? true;
  //
  if (notificationStatus == true) {
    log('=========>>> notificationStatus = $notificationStatus');
    FcmService.setupInteractedMessage();
  }
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
   await Supabase.initialize(
    url:await FirebaseGeneralServices.getAppVar(docName: 'supabaseVar', varName: 'appUrl'),
    anonKey: await FirebaseGeneralServices.getAppVar(docName: 'supabaseVar', varName: 'anonKey'),
  );

  runApp(
    EasyLocalization(
        startLocale: Locale(startLocale),
        supportedLocales: [
          Locale(LanguageType.English.code),
          Locale(LanguageType.Arabic.code)
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
    _setFcmTokenToUserModel();
    initialRoute = CustomNavBar.routeName;
  } else {
    initialRoute = PhoneAuthPage.routeName;
  }
  // if(!token.isNullOrEmpty()){
  return initialRoute;
}

_setFcmTokenToUserModel() async {
  final fcmToken = await getIt<FirebaseMessaging>().getToken();
  log('fcm token = $fcmToken');
  FcmService.setFcmToken(fcmToken!);

  getIt<FirebaseMessaging>()
      .onTokenRefresh
      .listen((newToken) => FcmService.setFcmToken(newToken));
}
