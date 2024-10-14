import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/di/dependency_injection.dart';
import 'package:just_chat/modules/messages/data/models/message_model.dart';
import 'package:just_chat/modules/messages/logic/messaging_cubit/messaging_cubit.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/theme/colors/colors_manager.dart';

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
    return GestureDetector(
      onTap: () {
        if (context.read<MessagingCubit>().textingController.text.isNotEmpty) {
          context.read<MessagingCubit>().sendMessage(
                chatId: widget.chatId,
                message: MessageModel(
                  msgId: const Uuid().v1(),
                  senderId: getIt<FirebaseAuth>().currentUser!.uid,
                  content:
                      context.read<MessagingCubit>().textingController.text,
                  contentType: 'text',
                  sentTime: Timestamp.fromDate(DateTime.now()),
                  isSeen: true,
                  isReceived: true,
                ),
              );
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<MessagingCubit>().scrollToLastMessage();
          });
        }
      },
      child: Container(
        padding: EdgeInsets.all(16.r),
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
            return Icon(
              buttonIcon,
              color: Colors.white,
            );
          },
        ),
      ),
    );
  }
}
