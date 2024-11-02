import 'package:flutter/material.dart';
import 'package:just_chat/core/theme/colors/colors_manager.dart';
import 'package:shimmer/shimmer.dart';

import '../../helpers/ui_helpers.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorsManager().colorScheme.background,
      highlightColor: ColorsManager().colorScheme.primary20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height:
                  UiHelper.getResponsiveDimension(context, baseDimension: 135),
              width:
                  UiHelper.getResponsiveDimension(context, baseDimension: 135),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(64), color: Colors.red),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Container(
              height:
                  UiHelper.getResponsiveDimension(context, baseDimension: 28),
              width:
                  UiHelper.getResponsiveDimension(context, baseDimension: 100),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.red),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.all(16),
            height: UiHelper.getResponsiveDimension(context, baseDimension: 28),
            width: UiHelper.getResponsiveDimension(context, baseDimension: 120),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.red),
          ),
          Container(
            margin: const EdgeInsets.all(16),
            height: UiHelper.getResponsiveDimension(context, baseDimension: 28),
            width: UiHelper.getResponsiveDimension(context, baseDimension: 350),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.red),
          ),
          Container(
            margin: const EdgeInsets.all(16),
            height: UiHelper.getResponsiveDimension(context, baseDimension: 28),
            width: UiHelper.getResponsiveDimension(context, baseDimension: 350),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.red),
          ),
          Container(
            margin: const EdgeInsets.all(16),
            height: UiHelper.getResponsiveDimension(context, baseDimension: 28),
            width: UiHelper.getResponsiveDimension(context, baseDimension: 120),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.red),
          ),
          Container(
            margin: const EdgeInsets.all(16),
            height: UiHelper.getResponsiveDimension(context, baseDimension: 28),
            width: UiHelper.getResponsiveDimension(context, baseDimension: 350),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.red),
          ),
          Container(
            margin: const EdgeInsets.all(16),
            height: UiHelper.getResponsiveDimension(context, baseDimension: 28),
            width: UiHelper.getResponsiveDimension(context, baseDimension: 350),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.red),
          ),
          Container(
            margin: const EdgeInsets.all(16),
            height: UiHelper.getResponsiveDimension(context, baseDimension: 28),
            width: UiHelper.getResponsiveDimension(context, baseDimension: 350),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.red),
          ),
          Container(
            margin: const EdgeInsets.all(16),
            height: UiHelper.getResponsiveDimension(context, baseDimension: 28),
            width: UiHelper.getResponsiveDimension(context, baseDimension: 350),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.red),
          ),
        ],
      ),
    );
  }
}
