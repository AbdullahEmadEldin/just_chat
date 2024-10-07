import 'package:flutter/material.dart';
import 'package:just_chat/modules/chat/view/widgets/messaging_widgets/messages_page_header.dart';

import '../../../../core/theme/colors/colors_manager.dart';
import '../widgets/messaging_widgets/message_chatting_component.dart';

class MessagingPage extends StatelessWidget {
  static const String routeName = '/messaging_page';
  const MessagingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorsManager().colorScheme.primary20,
        body: Column(
          children: [
            const MessagesPageHeader(),
          ],
        ),
        bottomNavigationBar: MessageChattingComponent(),
      ),
    );
  }
}