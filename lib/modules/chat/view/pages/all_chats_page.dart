import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/theme/colors/colors_manager.dart';
import 'package:just_chat/modules/chat/view/widgets/all_chats_widgets/chat_tile.dart';

import '../widgets/all_chats_widgets/chats_page_header.dart';

class AllChatsPage extends StatelessWidget {
  static const routeName = '/all_chats_page';
  const AllChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager().colorScheme.primary80,
      body: Container(
        padding: EdgeInsets.only(top: 48.h),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(42.r),
            bottomRight: Radius.circular(42.r),
          ),
        ),
        child: Column(
          children: [
            const ChatsPageHeader(),
            SizedBox(height: 24.h),
            Expanded(
              child: ListView.builder(
                itemCount: _chatList().length,
                itemBuilder: (context, index) => _chatList()[index],
              ),
            )
          ],
        ),
      ),
    );
  }

  _chatList() => [
        ChatTile(),
        ChatTile(),
        ChatTile(),
        ChatTile(),
        ChatTile(),
        ChatTile(),
        ChatTile(),
        ChatTile(),
        ChatTile(),
        ChatTile(),
        ChatTile(),
      ];
}
