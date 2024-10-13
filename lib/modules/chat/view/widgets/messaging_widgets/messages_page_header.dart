import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/widgets/circle_cached_image.dart';
import 'package:just_chat/core/widgets/header_back_button.dart';

import '../../../../../core/constants/image_assets.dart';
import '../../../../../core/theme/colors/colors_manager.dart';
import '../../../../auth/data/models/user_model.dart';

class MessagesPageHeader extends StatelessWidget {
  final UserModel user;
  const MessagesPageHeader({super.key, required this.user});

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
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        children: [
          const HeaderBackButton(),
          SizedBox(width: 8.w),
          CircleCachedImage(
            imageUrl: user.profilePicUrl!,
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: ColorsManager().colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
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
