import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/theme/colors/colors_manager.dart';
import 'package:just_chat/modules/nav_bar/custom_nav_bar.dart';

class AllChatsPage extends StatelessWidget {
  static const routeName = '/all_chats_page';
  const AllChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager().colorScheme.primary80,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(42.r),
            bottomRight: Radius.circular(42.r),
          ),
        ),
        child: Center(
          child: Text('This is all Chats'),
        ),
      ),
    );
  }
}
