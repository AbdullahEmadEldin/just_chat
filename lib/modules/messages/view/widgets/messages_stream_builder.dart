import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/constants/app_strings.dart';
import 'package:just_chat/core/helpers/extensions.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/loties_assets.dart';
import '../../../../core/theme/colors/colors_manager.dart';
import '../../data/models/message_model.dart';
import '../../logic/messaging_cubit/messaging_cubit.dart';
import 'shared/message_tile.dart';

class MessagesStreamBuilder extends StatefulWidget {
  final String chatId;
  const MessagesStreamBuilder({
    super.key,
    required this.chatId,
  });

  @override
  State<MessagesStreamBuilder> createState() => _MessagesStreamBuilderState();
}

class _MessagesStreamBuilderState extends State<MessagesStreamBuilder> {
  bool _loadingMsgsFirstTimeOnly = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: context.read<MessagingCubit>().getChatMessages(widget.chatId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            !_loadingMsgsFirstTimeOnly) {
          _loadingMsgsFirstTimeOnly = true;
          return _handleWaitingSnapshot();
        }
        if (snapshot.hasError) {
          return _handleErrorSnapshot(snapshot.error.toString());
        }
        if (!snapshot.hasData || snapshot.data.isNullOrEmpty()) {
          context.read<MessagingCubit>().firstMsgInChat = true;
          log('First MSG here active..${context.read<MessagingCubit>().firstMsgInChat}....');
          return _handleEmptySnapshot(context);
        }
        var messages = snapshot.data!;

        if (messages.isNotEmpty) {
          log('Mark seen active......');
          context.read<MessagingCubit>().markMsgAsSeen();
        }

        return Expanded(
          child: ListView.builder(
            // shrinkWrap: true,
            reverse: true,
            controller: context.read<MessagingCubit>().scrollController,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              /// get the replyToMsg if it exists to view it in the message tile.
              MessageModel? replyToMsg;
              for (int i = 0; i < messages.length; i++) {
                if (messages[i].msgId == messages[index].replyMsgId) {
                  replyToMsg = messages[i];
                  break;
                }
              }
              return MessageTile(
                message: messages[index],
                replyToMessage: replyToMsg,
              );
            },
          ),
        );
      },
    );
  }

  Widget _handleWaitingSnapshot() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _handleEmptySnapshot(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 80.h),
        Lottie.asset(LottiesAssets.emptyChat, width: 200.w),
        Text(
          AppStrings.startNewChat.tr(),
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: ColorsManager().colorScheme.background,
              ),
        ),
      ],
    ));
  }

  Widget _handleErrorSnapshot(String error) {
    return Center(
        child:
            Text('Error: $error', style: const TextStyle(color: Colors.red)));
  }
}
