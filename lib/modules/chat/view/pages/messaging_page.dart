import 'package:flutter/material.dart';
import 'package:just_chat/modules/chat/data/models/message_model.dart';
import 'package:just_chat/modules/chat/view/widgets/messaging_widgets/messages_page_header.dart';

import '../../../../core/theme/colors/colors_manager.dart';
import '../widgets/messaging_widgets/message_chatting_component.dart';
import '../widgets/messaging_widgets/text_message_tile.dart';

class MessagingPage extends StatelessWidget {
  static const String routeName = '/messaging_page';
  const MessagingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorsManager().colorScheme.primary20.withOpacity(0.9),
        body: Column(
          children: [
            const MessagesPageHeader(),
            TextMessageTile(
              message: m1,
            ),
            TextMessageTile(
              message: m2,
            ),
          ],
        ),
        bottomNavigationBar: const MessageChattingComponent(),
      ),
    );
  }
}

MessageModel m1 = MessageModel(
  senderId: '1',
  content:
      'This test mock message.adn This is test mock message. This is test mock message.adn This is test mock message  ',
  contentType: '',
  sentTime: DateTime(2024),
  isSeen: true,
  isReceived: true,
);
MessageModel m2 = MessageModel(
  senderId: '2',
  content: 'This is test mock message..',
  contentType: '',
  sentTime: DateTime(2024),
  isSeen: true,
  isReceived: true,
);
