import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/di/dependency_injection.dart';
import 'package:just_chat/core/helpers/ui_helpers.dart';
import 'package:just_chat/modules/messages/data/models/message_model.dart';
import 'package:just_chat/modules/messages/view/widgets/text_msg_widgets/reply_msg_box.dart';

import '../../../../../core/theme/colors/colors_manager.dart';
import 'long_press_selectable_widget.dart';

class TextMessageTile extends StatelessWidget {
  final MessageModel message;
  final MessageModel? replyToMessage;
  const TextMessageTile({
    super.key,
    required this.message,
    this.replyToMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: _myAlignment() ? Alignment.centerRight : Alignment.centerLeft,
      child: SelectableDismissibleWidget(
        myAlignment: _myAlignment(),
        message: message,
        child: Row(
          mainAxisSize: MainAxisSize.max, // The row takes up full width
          mainAxisAlignment:
              _myAlignment() ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              width: message.content.length > 35
                  ? MediaQuery.sizeOf(context).width * 0.75
                  : null,
              margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: _myAlignment()
                    ? ColorsManager().colorScheme.primary
                    : ColorsManager().colorScheme.primary60.withOpacity(0.8),
                borderRadius: BorderRadius.only(
                  topRight:
                      _myAlignment() ? Radius.zero : Radius.circular(16.r),
                  topLeft:
                      message.senderId != getIt<FirebaseAuth>().currentUser!.uid
                          ? Radius.zero
                          : Radius.circular(16.r),
                  bottomRight: Radius.circular(16.r),
                  bottomLeft: Radius.circular(16.r),
                ),
              ),
              child: IntrinsicWidth(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: _myAlignment()
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    if (replyToMessage != null)
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 4.h),
                        child: ReplyMsgBox(
                          msg: replyToMessage!,
                          cancelAction: true,
                        ),
                      ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: _myAlignment()
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Text(
                            message.content,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            UiHelper.formatTimestampToDate(
                                timestamp: message.sentTime),
                            textAlign: TextAlign.right,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.white60),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _myAlignment() {
    return message.senderId == getIt<FirebaseAuth>().currentUser!.uid;
  }
}
