import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/constants/image_assets.dart';
import 'package:just_chat/core/constants/loties_assets.dart';
import 'package:just_chat/core/helpers/extensions.dart';
import 'package:just_chat/core/helpers/network_helper.dart';
import 'package:just_chat/modules/auth/view/page/phone_auth_page.dart';
import 'package:just_chat/modules/settings/view/widget/notification_switcher.dart';
import 'package:just_chat/modules/settings/view/widget/settings_item.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/lang_manager.dart';
import '../../../../core/services/cache/cache_helper.dart';
import '../../../../core/services/firestore_service.dart';
import '../../../../core/theme/colors/colors_manager.dart';
import '../../../../core/theme/theme_manager.dart';
import '../../../auth/data/repos/user_data_repo.dart';
import '../widget/pop_menu_component.dart';
import '../widget/theme_switcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager().colorScheme.primary80,
      body: Container(
        padding: EdgeInsets.only(top: 36.h),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorsManager().colorScheme.background,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(42.r),
            bottomRight: Radius.circular(42.r),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 28.h),
            Text(
              AppStrings.settings.tr(),
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: ColorsManager().colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Container(
              margin: EdgeInsets.only(left: 24.w, right: 24.w, top: 24.h),
              decoration: BoxDecoration(
                color: ColorsManager().colorScheme.primary80.withOpacity(0.5),
                image: const DecorationImage(
                  image: AssetImage(
                    ImagesAssets.settingsIcon,
                  ),
                ),
                borderRadius: BorderRadius.circular(32.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32.r),
                child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            ColorsManager()
                                .colorScheme
                                .primary80
                                .withOpacity(0.3),
                            const Color.fromARGB(255, 18, 150, 186)
                                .withOpacity(0.3),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(32.r),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 16.h),
                      child: Column(
                        children: [
                          SettingsItem(
                            title: AppStrings.theme.tr(),
                            suffixIconData: Icons.mode_night_outlined,
                            actionIcon: ValueSwitcher(
                              value: CacheHelper.getData(
                                      key: SharedPrefKeys.isDark) ??
                                  false,
                              onChanged: (value) {
                                CacheHelper.saveData(
                                    key: SharedPrefKeys.isDark, value: value);
                                AppThemes.instance.updateThemeValue(value);
                                ColorsManager().updateTheme(value);
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(height: 12.h),
                          SettingsItem(
                            title: AppStrings.notifications.tr(),
                            suffixIconData: CupertinoIcons.bell_fill,
                            actionIcon: const NotificationSwitcher(),
                          ),
                          SizedBox(height: 12.h),
                          SettingsItem(
                            title: AppStrings.language.tr(),
                            suffixIconData: Icons.language,
                            actionIcon: PopMenuComponent(
                                initialValue: context.locale.languageCode,
                                items: LanguageType.values
                                    .map(
                                      (lang) => PopupMenuItem(
                                          child: Text(
                                            lang.name.tr(),
                                          ),
                                          onTap: () =>
                                              LanguageManager.changeAppLang(
                                                  context,
                                                  lang: lang)),
                                    )
                                    .toList()),
                          ),
                          SizedBox(height: 12.h),
                          SettingsItem(
                            title: AppStrings.aboutUs.tr(),
                            suffixIconData: Icons.error_outline,
                            actionIcon: IconButton(
                              onPressed: () async {
                                final String url =
                                    await FirebaseGeneralServices.getAppVar(
                                        docName: 'aboutUs', varName: 'link');
                                NetworkHelper.customLaunchUrl(context,
                                    url: url);
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: ColorsManager().colorScheme.grey40,
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          SettingsItem(
                            title: AppStrings.logout.tr(),
                            suffixIconData: CupertinoIcons.power,
                            actionIcon: IconButton(
                              onPressed: () async {
                                await UserDataRepo.updateUserStatus(false);
                                await FirebaseGeneralServices.logout()
                                    .then((value) {
                                  context.pushNamedAndRemoveUntil(
                                    PhoneAuthPage.routeName,
                                    predicate: (Route<dynamic> route) =>
                                        false, // false means remove all routes the exists in the stack
                                  );
                                });
                              },
                              icon: Icon(
                                CupertinoIcons.right_chevron,
                                color: ColorsManager().colorScheme.grey40,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
            SizedBox(height: 24.h),
            Lottie.asset(LottiesAssets.settings, height: 250.h),
          ],
        ),
      ),
    );
  }
}
