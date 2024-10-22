import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/helpers/extensions.dart';
import 'package:just_chat/core/helpers/ui_helpers.dart';
import 'package:just_chat/core/widgets/circle_cached_image.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/theme/colors/colors_manager.dart';
import '../../../auth/data/models/user_model.dart';
import '../../data/models/chat_model.dart';
import '../../../messages/view/pages/messaging_page.dart';

class ChatTile extends StatelessWidget {
  final ChatModel chat;
  final UserModel opponentUser;
  final int unreadMsgsCount;
  const ChatTile({
    super.key,
    required this.chat,
    required this.opponentUser,
    required this.unreadMsgsCount,
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
        width: MediaQuery.sizeOf(context).width,
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            36.r,
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

  Widget _messageRow(BuildContext context) {
    return chat.lastMessage != null
        ? Row(
            children: [
              Text(
                UiHelper.limitStringLength(
                    str: chat.lastMessage!, maxLength: 30),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: ColorsManager().colorScheme.grey60,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(width: 4.w),
              _countOfUnreadMessages()
                  ? Badge(
                      label: Text(
                        unreadMsgsCount.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.white),
                      ),
                      backgroundColor: ColorsManager().colorScheme.fillGreen,
                    )
                  : const SizedBox.shrink(),
            ],
          )
        : const SizedBox.shrink();
  }

  Widget _nameTimeRow(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.65,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            opponentUser.name,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: ColorsManager().colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          // SizedBox(width: 120.w),
          Text(
            UiHelper.formatTimestampToDate(
                timestamp: chat.lastMessageTimestamp!),
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: ColorsManager().colorScheme.grey60,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }

  bool _countOfUnreadMessages() {
    if (chat.lastMessageSenderId != getIt<FirebaseAuth>().currentUser!.uid &&
        unreadMsgsCount > 0) {
      return true;
    }
    return false;
  }
}
