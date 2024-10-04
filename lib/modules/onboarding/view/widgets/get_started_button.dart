import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/helpers/extensions.dart';
import 'package:just_chat/modules/auth/view/page/phone_auth_page.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/services/cache/cache_helper.dart';
import '../../../../core/theme/colors/colors_manager.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(seconds: 1),
      child: Shimmer(
        duration: const Duration(seconds: 1),
        direction: const ShimmerDirection.fromLTRB(),
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              ColorsManager().colorScheme.primary,
            ),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: WidgetStateProperty.all(
              Size(double.infinity, 56.h),
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          onPressed: () async => await CacheHelper.saveData(
                  key: SharedPrefKeys.firstLaunch, value: false)
              .then((v) => context.pushReplacementNamed(PhoneAuthPage.routeName)),
          child: Text(
            AppStrings.getStarted.tr(),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: ColorsManager().colorScheme.background,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
