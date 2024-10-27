import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/services/firebase_cloud_msgs.dart';

import 'core/router/app_router.dart';
import 'core/theme/theme_manager.dart';

class JustChatApp extends StatefulWidget {
  final String initialRoute;

  /// Making the MyApp a singleton to ensure that there is only one entry point of the application through it's life cycle.
  /// and to enable use it in di or state management.
  const JustChatApp({super.key, required this.initialRoute});

  @override
  State<JustChatApp> createState() => _JustChatAppState();
}

class _JustChatAppState extends State<JustChatApp> {
  @override
  void initState() {
    FcmService.setupInteractedMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(
        'Initial Theme ===>>> ${AppThemes.instance.themeNotifier.value}');

    return ScreenUtilInit(
      designSize: const Size(375, 812), // this size from UI figma design.
      builder: (context, child) {
        return ValueListenableBuilder<ThemeMode?>(
            valueListenable: AppThemes.instance.themeNotifier,
            builder: (context, themeMode, child) {
              return MaterialApp(
                locale: context.locale,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                debugShowCheckedModeBanner: false,
                onGenerateRoute: AppRouter.onGenerate,
                initialRoute: widget.initialRoute,
                themeMode: themeMode,
                theme: AppThemes.instance.lightAppTheme(context),
              );
            });
      },
    );
  }
}
