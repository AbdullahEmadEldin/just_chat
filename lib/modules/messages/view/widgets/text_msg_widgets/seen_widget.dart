import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_chat/core/constants/image_assets.dart';

import '../../../../../core/theme/colors/colors_manager.dart';

class SeenWidget extends StatelessWidget {
  final bool isSeen;
  const SeenWidget({
    super.key,
    required this.isSeen,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin:const Offset(1, 0), // Slide from the right
            end:const Offset(0, 0),
          ).animate(animation),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      child: isSeen
          ? SvgPicture.asset(
              key: const ValueKey('seen'),
              ImagesAssets.seenSvg,
              color: ColorsManager().colorScheme.fillGreen,
            )
          : SvgPicture.asset(
              key: const ValueKey('notSeen'),
              ImagesAssets.checkMrkSvg,
              color: isSeen
                  ? ColorsManager().colorScheme.fillGreen
                  : ColorsManager().colorScheme.grey40,
            ),
    );
  }
}
