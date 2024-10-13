import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/helpers/extensions.dart';
import 'package:just_chat/core/widgets/circle_cached_image.dart';

import '../../../../../core/theme/colors/colors_manager.dart';
import '../../../../auth/data/models/user_model.dart';
import '../../../data/models/chat_model.dart';
import '../../pages/messaging_page.dart';

class ChatTile extends StatelessWidget {
  final ChatModel chat;
  final UserModel opponentUser;
  const ChatTile({
    super.key,
    required this.chat,
    required this.opponentUser,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(MessagingPage.routeName,
            arguments: MessagingPageArgs(
              chat: chat,
              opponentUser: opponentUser,
            ));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            48.r,
          ),
          color: ColorsManager().colorScheme.grey20,
        ),
        child: Row(
          children: [
            CircleCachedImage(imageUrl: opponentUser.profilePicUrl!),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _nameTimeRow(context),
                SizedBox(height: 4.h),
                _messageRow(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row _messageRow(BuildContext context) {
    return Row(
      children: [
        Text(
          'Hi, how are you?',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: ColorsManager().colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(width: 4.w),
        Badge(
          label: Text(
            '1',
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.white),
          ),
          backgroundColor: ColorsManager().colorScheme.fillGreen,
        ),
      ],
    );
  }

  Row _nameTimeRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          opponentUser.name,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: ColorsManager().colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(width: 90.w),
        Text(
          '10:30 AM',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: ColorsManager().colorScheme.grey60,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
