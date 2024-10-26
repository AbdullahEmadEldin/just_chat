import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../theme/colors/colors_manager.dart';

class ChatTileShimmerList extends StatelessWidget {
  const ChatTileShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView(
            children: [for (int i = 0; i < 7; i++) _shimmer(context)]));
  }

  Container _shimmer(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          36.r,
        ),
        color: ColorsManager().colorScheme.grey20,
      ),
      child: Row(children: [
        Shimmer(
          duration: const Duration(milliseconds: 900),
          // gradient: _shimmerGradient(),
          child: Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorsManager().colorScheme.grey40,
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer(
              duration: const Duration(milliseconds: 900),

              // gradient: _shimmerGradient(),
              child: Container(
                width: 80.w,
                height: 16.h,
                decoration: BoxDecoration(
                  color: ColorsManager().colorScheme.grey40,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
            SizedBox(height: 4.h),
            Shimmer(
              duration: const Duration(milliseconds: 900),

              // gradient: _shimmerGradient(),
              child: Container(
                width: 100.w,
                height: 16.h,
                decoration: BoxDecoration(
                  color: ColorsManager().colorScheme.grey40,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ],
        ))
      ]),
    );
  }


}
