import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/helpers/extensions.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/services/cache/cache_helper.dart';
import '../../../../core/theme/colors/colors_manager.dart';

class GetStartedButton extends StatefulWidget {
  const GetStartedButton({
    super.key,
  });

  @override
  State<GetStartedButton> createState() => _GetStartedButtonState();
}

class _GetStartedButtonState extends State<GetStartedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  bool isAnimationStopped = false;
  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    _controller = AnimationController(
      duration: const Duration(
          milliseconds: 1000), // Duration for one complete swing cycle
      vsync: this,
    )..repeat(reverse: true); // Repeat the animation with a reverse swing

    // Use a Tween to swing between -0.1 and 0.1 radians (~6 degrees)
    // to decrease the degrees of the swing decrease the values
    _animation = Tween<double>(begin: -0.08, end: 0.08).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut, // Smooth swinging effect
      ),
    );

    _stopAnimation();
  }

  void _stopAnimation() async {
    await Future.delayed(const Duration(seconds: 4), () {
      _controller.stop();
      setState(() {
        isAnimationStopped = true;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 3500),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) => Transform.rotate(
          angle: isAnimationStopped ? 0 : _animation.value,
          child: Shimmer(
            duration: const Duration(seconds: 1),
            direction: const ShimmerDirection.fromLTRB(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 38),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    ColorsManager().colorScheme.primary,
                  ),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  minimumSize: WidgetStateProperty.all(
                    Size(double.infinity, 64.h),
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                onPressed: () async => await CacheHelper.saveData(
                        key: SharedPrefKeys.firstLaunch, value: false)
                    .then((v) =>
                        context.pushReplacementNamed('LoginPage.routeName')),
                child: Text(
                  ' AppStrings.getStarted.tr()',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: ColorsManager().colorScheme.background,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
