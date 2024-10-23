import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/modules/messages/logic/recorder_cubit/recorder_cubit.dart';
import 'package:just_chat/modules/messages/view/widgets/audio_recording_widgets/audio_recording_field.dart';

import '../../../../../core/theme/colors/colors_manager.dart';
import '../../../logic/messaging_cubit/messaging_cubit.dart';

class MessagingField extends StatelessWidget {
  final String chatId;
  const MessagingField({
    super.key,
    required this.chatId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecorderCubit, RecorderState>(
      buildWhen: (previous, current) =>
          current is RecorderViewTrigger ||
          current is RecorderViewClose,
      builder: (context, state) {
        if (state is RecorderViewTrigger) {
          return Expanded(
              child: AudioRecordingField(
            chatId: chatId,
          ));
        } else {
          return Expanded(
            child: TextField(
              controller: context.read<MessagingCubit>().textingController,
              onChanged: (value) {
                context.read<MessagingCubit>().switchSendButtonIcon();
                context.read<MessagingCubit>().setSquareBorderRadius();
              },
              minLines: 1,
              maxLines: null,
              cursorColor: ColorsManager().colorScheme.primary,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: ColorsManager().colorScheme.grey60,
                    ),
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
