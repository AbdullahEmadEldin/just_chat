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
import 'package:just_chat/modules/messages/view/widgets/sending_widgets/record_waves_button_view.dart';
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
  double width = 20.w, height = 20.h;
  bool startRecordingAnimation = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (context.read<MessagingCubit>().textingController.text.isNotEmpty) {
          _sendTextMsg(context);
        } else {
          //_sendRecordMsg(context);
        }
      },
      onLongPress: () {
        print('===,,,,,');
        context.read<RecorderCubit>().triggerRecordingView();
        setState(() {
          height = 47.h;
          width = 47.w;
        });
        Future.delayed(const Duration(milliseconds: 80), () {
          setState(() {
            startRecordingAnimation = true;
          });
        });
      },
      onLongPressEnd: (details) {
                context.read<RecorderCubit>().closeRecordingView();

        setState(() {
          height = 20.h;
          width = 20.w;
          startRecordingAnimation = false;
        });
      },
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(64.r),
          color: ColorsManager().colorScheme.primary,
        ),
        child: BlocBuilder<MessagingCubit, MessagingState>(
          builder: (context, state) {
            IconData buttonIcon = CupertinoIcons.mic;
            if (state is SwitchSendButtonIcon) {
              buttonIcon = state.newIcon;
            }
            return AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              width: width,
              height: height,
              child: height == 47.h && startRecordingAnimation
                  ? const CustomRecordingWaveWidget()
                  : Icon(
                      buttonIcon,
                      color: Colors.white,
                    ),
            );
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
