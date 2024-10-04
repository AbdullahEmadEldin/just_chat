import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/modules/onboarding/model/onboarding_model.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/theme/colors/colors_manager.dart';
import '../../../../core/widgets/app_logo.dart';

class OnboardingItem extends StatelessWidget {
  final String lottiePath;
  final String title;
  final List<SubtitleModel> subtitles;
  const OnboardingItem({
    super.key,
    required this.lottiePath,
    required this.title,
    required this.subtitles,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 25.h),
        const AppLogo(),
        Lottie.asset(
          width: 350.w,
          lottiePath,
        ),
        SizedBox(height: 24.h),
        FadeInUp(
          duration: const Duration(seconds: 1),
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: ColorsManager().colorScheme.grey80,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 12.h),
        ...subtitles.map(
          (subtitle) => FadeInUp(
            duration: const Duration(milliseconds: 1200),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 36.w),
                Icon(
                  subtitle.subtitleIcon,
                  color: ColorsManager().colorScheme.primary80,
                  size: 16.r,
                ),
                Text(
                  subtitle.subtitle,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ColorsManager().colorScheme.grey80),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
