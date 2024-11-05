import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/constants/app_strings.dart';
import 'package:just_chat/core/helpers/extensions.dart';
import 'package:just_chat/core/widgets/custom_toast.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constants/image_assets.dart';
import '../../../../core/theme/colors/colors_manager.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../messages/view/pages/messaging_page.dart';

class SearchResultTile extends StatelessWidget {
  final UserModel user;
  final bool isMyPhone;
  const SearchResultTile(
      {super.key, required this.user, required this.isMyPhone});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isMyPhone) {
          showCustomToast(context, AppStrings.cannotChatWithSelf.tr(),
              isError: true);
        } else {
          final newChatId = const Uuid().v4();

          context.pushNamed(
            MessagingPage.routeName,
            arguments: MessagingPageArgs(
              chatId: newChatId,
              remoteUserId: user.uid,
            ),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            24.r,
          ),
          color: ColorsManager().colorScheme.primary80.withOpacity(0.8),
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
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: ColorsManager().colorScheme.grey40,
                        )),
                SizedBox(height: 4.h),
                isMyPhone
                    ? Text(
                        AppStrings.yourNumber.tr(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: ColorsManager().colorScheme.grey40,
                            ),
                      )
                    : Text(
                        user.name,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: ColorsManager().colorScheme.grey40,
                            ),
                      ),
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
