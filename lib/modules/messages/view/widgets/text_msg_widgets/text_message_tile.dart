import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/di/dependency_injection.dart';
import 'package:just_chat/core/helpers/ui_helpers.dart';
import 'package:just_chat/modules/messages/data/models/message_model.dart';
import 'package:just_chat/modules/messages/view/widgets/text_msg_widgets/reply_msg_box.dart';
import 'package:just_chat/modules/messages/view/widgets/text_msg_widgets/seen_widget.dart';

import '../../../../../core/constants/enums.dart';
import '../../../../../core/theme/colors/colors_manager.dart';
import '../../../logic/audio_player_cubit/audio_player_cubit.dart';
import '../audio_recording_widgets/audio_msg_tile.dart';
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
                    ? ColorsManager().colorScheme.primary80
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
                          _handleMsgType(context),
                          SizedBox(width: 12.w),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                UiHelper.formatTimestampToDate(
                                    timestamp: message.sentTime),
                                textAlign: TextAlign.right,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: Colors.white60),
                              ),
                              SizedBox(width: 4.w),
                              _myAlignment()
                                  ? SeenWidget(isSeen: message.isSeen)
                                  : const SizedBox.shrink(),
                            ],
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

  Widget _handleMsgType(BuildContext context) {
    if (message.contentType == MsgType.audio.name) {
      return BlocProvider(
        //? Why here? ==> Because each record should have it's own player.
        create: (context) => AudioPlayerCubit(),
        child: AudioMsgTile(
          audioUrl: message.content,
          recordDuration: message.recordDuration!,
        ),
      );
    }
    return Text(
      message.content,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
    );
  }

  bool _myAlignment() {
    return message.senderId == getIt<FirebaseAuth>().currentUser!.uid;
  }
}
