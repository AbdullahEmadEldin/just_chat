import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/colors/colors_manager.dart';
import '../widgets/app_logo.dart';
import '../widgets/get_started_button.dart';
import '../widgets/onboarding_content.dart';

class OnboardingPage extends StatelessWidget {
  static const String routeName = '/onboarding';
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.h),
              // FadeInUp(
              //   duration: const Duration(milliseconds: 500),
              //   child: const AppLogo(),
              // ),
              SizedBox(height: 40.h),
              // const OnBoardingContent(),
              FadeInUp(
                duration: const Duration(milliseconds: 2500),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    'AppStrings.onBoardingText2.tr()',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: ColorsManager().colorScheme.grey60),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 25.h),
              const GetStartedButton()
              // SwingingButton()
            ],
          ),
        ),
      ),
    );
  }
}
