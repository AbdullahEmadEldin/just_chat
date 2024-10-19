import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/modules/messages/logic/recorder_cubit/recorder_cubit.dart';

import '../../logic/messaging_cubit/messaging_cubit.dart';

class MessagingTextField extends StatelessWidget {
  const MessagingTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecorderCubit, RecorderState>(
      builder: (context, state) {
        if (state is RecorderViewTrigger) {
          return const Expanded(child:  Text('This is audio recording view'));
        } else {
          return Expanded(
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
          );
        }
      },
    );
  }
}
