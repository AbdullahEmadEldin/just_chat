import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_chat/modules/messages/logic/recorder_cubit/recorder_cubit.dart';
import 'package:just_chat/modules/messages/view/widgets/audio_recording_widgets/audio_recording_field.dart';
import 'package:just_chat/modules/messages/view/widgets/text_msg_widgets/chatting_text_field.dart';

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
          current is RecorderViewTrigger || current is RecorderViewClose,
      builder: (context, state) {
        if (state is RecorderViewTrigger) {
          return Expanded(
              child: AudioRecordingField(
            chatId: chatId,
          ));
        } else {
          return const ChattingTextField();
        }
      },
    );
  }
}
