import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/helpers/extensions.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/constants/loties_assets.dart';
import '../../../../../core/theme/colors/colors_manager.dart';
import '../../../logic/messaging_cubit/messaging_cubit.dart';
import 'text_message_tile.dart';

class MessagesStreamBuilder extends StatelessWidget {
  final String chatId;
  const MessagesStreamBuilder({
    super.key,
    required this.chatId,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: context.read<MessagingCubit>().getChatMessages(chatId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _handleWaitingSnapshot();
        }
        if (snapshot.hasError) {
          return _handleErrorSnapshot(snapshot.error.toString());
        }
        if (!snapshot.hasData || snapshot.data.isNullOrEmpty()) {
          return _handleEmptySnapshot(context);
        }

        var messages = snapshot.data!;

        return Expanded(
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              print('========>>> MEssageL : ${messages[index].content}');
              return TextMessageTile(
                message: messages[index],
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
        SizedBox(height: 120.h),
        Lottie.asset(LottiesAssets.emptyChat, width: 200.w),
        Text(
          'Start a new chat...',
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