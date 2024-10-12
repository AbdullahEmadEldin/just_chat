import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/theme/colors/colors_manager.dart';

import '../widgets/all_chats_widgets/all_chats_body.dart';
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
        child: const Column(
          children: [
            ChatsPageHeader(),
            AllChatsBody(),
          ],
        ),
      ),
    );
  }

  // _chatList() => [
  //       ChatTile(),
  //       ChatTile(),
  //       ChatTile(),
  //       ChatTile(),
  //       ChatTile(),
  //       ChatTile(),
  //       ChatTile(),
  //       ChatTile(),
  //       ChatTile(),
  //       ChatTile(),
  //       ChatTile(),
  //     ];
}
