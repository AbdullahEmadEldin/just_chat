import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/helpers/extensions.dart';
import 'package:just_chat/core/router/app_router.dart';
import 'package:just_chat/modules/add_friends/logic/cubit/add_friends_cubit.dart';

import '../../../../core/constants/image_assets.dart';
import '../../../../core/theme/colors/colors_manager.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../messages/view/pages/messaging_page.dart';

class SearchResultTile extends StatelessWidget {
  final UserModel user;
  const SearchResultTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        context.pushNamed(MessagingPage.routeName);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            24.r,
          ),
          color: ColorsManager().colorScheme.grey20,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28.r,
              backgroundImage: const AssetImage(ImagesAssets.profileHolder),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.phoneNumber,
                    style: Theme.of(context).textTheme.bodyMedium),
                SizedBox(height: 4.h),
                Text(user.name, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            const Spacer(),
            Icon(Icons.chat,
                color: ColorsManager().colorScheme.primary, size: 24.sp),
          ],
        ),
      ),
    );
  }
}
