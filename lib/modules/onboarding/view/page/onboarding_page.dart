import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:just_chat/core/constants/app_strings.dart';
import 'package:just_chat/modules/onboarding/model/onboarding_model.dart';
import 'package:just_chat/modules/onboarding/view/page/onboarding_page_view_item.dart';
import 'package:just_chat/modules/onboarding/view/widgets/on_boarding_bottom_sheet.dart';

import '../../../../core/constants/loties_assets.dart';

class OnboardingPage extends StatefulWidget {
  static const String routeName = '/onboarding';

  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) => setState(() {
          currentIndex = index;
        }),
        itemCount: onboardingList().length,
        itemBuilder: (context, index) {
          print('index == $index');

          currentIndex = index;
          return OnboardingItem(
            lottiePath: onboardingList()[index].lottiePath,
            title: onboardingList()[index].title,
            subtitles: onboardingList()[index].subtitles,
          );
        },
      ),
      bottomSheet: OnBoardingBottomSheetWidget(
        itemCount: onboardingList().length,
        currentIndex: currentIndex,
        onNextFunction: () {
          _pageController.animateToPage(
            currentIndex,
            duration: const Duration(milliseconds: 1500),
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }

  List<OnboardingModel> onboardingList() {
    return [
      OnboardingModel(
          title: AppStrings.onBoardingTitle1.tr(),
          subtitles: [
            SubtitleModel(
              subtitle: AppStrings.onBoardingSubTitle1.tr(),
              subtitleIcon: Icons.chat,
            ),
            SubtitleModel(
              subtitle: AppStrings.onBoardingSubTitle2.tr(),
              subtitleIcon: Icons.call,
            ),
            SubtitleModel(
              subtitle: AppStrings.onBoardingSubTitle3.tr(),
              subtitleIcon: Icons.share,
            ),
          ],
          lottiePath: LottiesAssets.onboarding1),
      OnboardingModel(
          title: AppStrings.onBoardingTitle2.tr(),
          subtitles: [
            SubtitleModel(
              subtitle: AppStrings.onBoardingSubTitle4.tr(),
              subtitleIcon: Icons.person_add,
            ),
            SubtitleModel(
              subtitle: AppStrings.onBoardingSubTitle5.tr(),
              subtitleIcon: Icons.timelapse_outlined,
            ),
          ],
          lottiePath: LottiesAssets.onboardingAuth),
    ];
  }
}
