import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/theme/colors/colors_manager.dart';
import 'package:just_chat/modules/onboarding/view/widgets/get_started_button.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/loties_assets.dart';

class OnBoardingBottomSheetWidget extends StatefulWidget {
  final int itemCount;
  final int currentIndex;
  final void Function() onNextFunction;

  /// #### View navigation between pages buttons and skip to Login page
  const OnBoardingBottomSheetWidget({
    super.key,
    required this.itemCount,
    required this.currentIndex,
    required this.onNextFunction,
  });

  @override
  State<OnBoardingBottomSheetWidget> createState() =>
      _OnBoardingBottomSheetWidgetState();
}

class _OnBoardingBottomSheetWidgetState
    extends State<OnBoardingBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsManager().colorScheme.background,
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w,
          widget.currentIndex != widget.itemCount - 1 ? 64.h : 36.h),
      child: widget.currentIndex == widget.itemCount - 1
          ? const GetStartedButton()
          : FadeInUp(
              child: Lottie.asset(LottiesAssets.rightArrow, width: 120.w)),
    );
  }
}
