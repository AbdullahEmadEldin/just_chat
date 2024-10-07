import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/modules/chat/view/widgets/messaging_widgets/send_record_button.dart';

import '../../../../../core/theme/colors/colors_manager.dart';
import '../../../logic/messaging_cubit/messaging_cubit.dart';

class MessageChattingComponent extends StatefulWidget {
  const MessageChattingComponent({super.key});

  @override
  State<MessageChattingComponent> createState() =>
      _MessageChattingComponentState();
}

class _MessageChattingComponentState extends State<MessageChattingComponent> {
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
          Expanded(
            child: TextField(
              controller: context.read<MessagingCubit>().textingController,
              onChanged: (value) {
                context.read<MessagingCubit>().switchSendButtonIcon();
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          SendRecordButton(),
        ],
      ),
    );
  }
}
