import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/constants/enums.dart';
import 'package:just_chat/core/di/dependency_injection.dart';
import 'package:just_chat/modules/messages/data/models/message_model.dart';
import 'package:just_chat/modules/messages/logic/messaging_cubit/messaging_cubit.dart';
import 'package:just_chat/modules/messages/logic/recorder_cubit/recorder_cubit.dart';
import 'package:just_chat/modules/messages/view/widgets/audio_recording_widgets/record_waves_button_view.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/theme/colors/colors_manager.dart';

class SendRecordButton extends StatefulWidget {
  final String chatId;
  const SendRecordButton({
    super.key,
    required this.chatId,
  });

  @override
  State<SendRecordButton> createState() => _SendRecordButtonState();
}

class _SendRecordButtonState extends State<SendRecordButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (context.read<MessagingCubit>().textingController.text.isNotEmpty) {
          _sendTextMsg(context);
        } else {
          context.read<RecorderCubit>().startRecording();
        }
      },
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(64.r),
          color: ColorsManager().colorScheme.primary,
        ),
        child: BlocBuilder<MessagingCubit, MessagingState>(
          buildWhen: (previous, current) => current is SwitchSendButtonIcon,
          builder: (context, state) {
            IconData buttonIcon = CupertinoIcons.mic;
            if (state is SwitchSendButtonIcon) {
              buttonIcon = state.newIcon;
            }
            return CustomRecordingWaveWidget(defaultIcon: buttonIcon);
          },
        ),
      ),
    );
  }

  void _sendTextMsg(BuildContext context) {
    context.read<MessagingCubit>().sendMessage(
          message: MessageModel(
            chatId: widget.chatId,
            msgId: const Uuid().v1(),
            senderId: getIt<FirebaseAuth>().currentUser!.uid,
            replyMsgId: context.read<MessagingCubit>().replyToMessage?.msgId,
            content: context.read<MessagingCubit>().textingController.text,
            contentType: MsgType.text.name,
            sentTime: Timestamp.fromDate(DateTime.now()),
            isSeen: false,
          ),
        );
    context.read<MessagingCubit>().switchSendButtonIcon();
  }
}
