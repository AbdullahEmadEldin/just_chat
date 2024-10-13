import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/modules/chat/view/widgets/messaging_widgets/send_record_button.dart';
import 'messaging_text_field.dart';

class MessageChattingComponent extends StatelessWidget {
  final String chatId;
  const MessageChattingComponent({
    super.key,
    required this.chatId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      margin: EdgeInsets.all(16.r),
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(64.r),
        color: Colors.white,
      ),
      child: Row(
        children: [
          const MessagingTextField(),
          SizedBox(width: 16.w),
          SendRecordButton(
            chatId: chatId,
          ),
        ],
      ),
    );
  }
}
