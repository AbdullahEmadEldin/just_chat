import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/modules/messages/logic/messaging_cubit/messaging_cubit.dart';
import 'package:just_chat/modules/messages/view/widgets/messages_page_header.dart';
import 'package:just_chat/modules/messages/view/widgets/messages_stream_builder.dart';

import '../../../../core/theme/colors/colors_manager.dart';
import '../widgets/sending_widgets/message_chatting_component.dart';

class MessagingPageArgs {
  final String chatId;
  final String remoteUserId;

  MessagingPageArgs({
    required this.chatId,
    required this.remoteUserId,
  });
}

class MessagingPage extends StatelessWidget {
  static const String routeName = '/messaging_page';
  const MessagingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: ColorsManager().colorScheme.primary20.withOpacity(0.9),
        body: BlocBuilder<MessagingCubit, MessagingState>(
          buildWhen: (previous, current) =>
              current is FetchPageArgsLoading ||
              current is FetchPageArgsSuccess,
          builder: (context, state) {
            return state is FetchPageArgsSuccess
                ? Column(
                    children: [
                      const MessagesPageHeader(),
                      SizedBox(height: 12.h),
                      MessagesStreamBuilder(
                        chatId: context.read<MessagingCubit>().chatId,
                      )
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context)
                .viewInsets
                .bottom, // This adjusts for the keyboard
          ),
          child: MessageChattingComponent(
              chatId: context.read<MessagingCubit>().chatId),
        ),
      ),
    );
  }
}
