import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../theme/colors/colors_manager.dart';

class UploadingAudioShimmer extends StatelessWidget {
  const UploadingAudioShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _heights.map((height) {
        return Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Shimmer(
            duration: const Duration(milliseconds: 900),
            color: ColorsManager().colorScheme.fillRed,
            direction: const ShimmerDirection.fromLeftToRight(),
            child: Container(
              width: 18.w,
              height: 100.h * height,
              decoration: BoxDecoration(
                color: ColorsManager().colorScheme.primary60,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  final List<double> _heights = const [
    0.3,
    0.7,
    0.4,
    0.8,
    0.4,
    0.5,
    0.2,
    0.5,
    0.2,
    0.3
  ];
}
