import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/modules/messages/logic/messaging_cubit/messaging_cubit.dart';
import 'package:just_chat/modules/messages/view/widgets/sending_widgets/send_record_button.dart';
import 'messaging_field.dart';
import '../text_msg_widgets/reply_msg_box.dart';

class MessageChattingComponent extends StatefulWidget {
  final String chatId;
  const MessageChattingComponent({
    super.key,
    required this.chatId,
  });

  @override
  State<MessageChattingComponent> createState() =>
      _MessageChattingComponentState();
}

class _MessageChattingComponentState extends State<MessageChattingComponent> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessagingCubit, MessagingState>(
      buildWhen: (previous, current) =>
          current is ReplyToMessageState ||
          current is CancelReplyToMessageState ||
          current is SetBorderRadiusToSquare ||
          current is SetBorderRadiusToCircle,
      builder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: MediaQuery.sizeOf(context).width,
          margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          padding: EdgeInsets.all(4.r),
          decoration: BoxDecoration(
            borderRadius:
                state is ReplyToMessageState || state is SetBorderRadiusToSquare
                    ? BorderRadius.circular(12.r)
                    : BorderRadius.circular(64.r),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              state is ReplyToMessageState
                  ? ReplyMsgBox(msg: state.replyToMessage)
                  : const SizedBox.shrink(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MessagingField(chatId: widget.chatId),
                  SizedBox(width: 16.w),
                  SendRecordButton(chatId: widget.chatId),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
