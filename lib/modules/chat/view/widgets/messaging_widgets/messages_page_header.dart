import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/widgets/header_back_button.dart';

import '../../../../../core/constants/image_assets.dart';
import '../../../../../core/theme/colors/colors_manager.dart';

class MessagesPageHeader extends StatelessWidget {
  const MessagesPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(36.r),
          bottomRight: Radius.circular(36.r),
        ),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(16.r),
      child: Row(
        children: [
          const HeaderBackButton(),
          SizedBox(width: 8.w),
          CircleAvatar(
            radius: 26.r,
            backgroundImage: const AssetImage(ImagesAssets.profileHolder),
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sarah Smith',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: ColorsManager().colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Active 1m ago',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: ColorsManager().colorScheme.grey60,
                      fontWeight:
                          FontWeight.bold, // fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
