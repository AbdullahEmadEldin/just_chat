import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/constants/enums.dart';
import 'package:just_chat/core/constants/loties_assets.dart';
import 'package:just_chat/core/theme/colors/colors_manager.dart';
import 'package:just_chat/modules/chat/logic/all_chats/all_chats_cubit.dart';
import 'package:lottie/lottie.dart';

import '../widgets/friends_chats.dart';
import '../widgets/chats_page_header.dart';

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
          color: ColorsManager().colorScheme.background,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(42.r),
            bottomRight: Radius.circular(42.r),
          ),
        ),
        child: Column(
          children: [
            const ChatsPageHeader(),
            BlocBuilder<AllChatsCubit, AllChatsState>(
              buildWhen: (previous, current) =>
                  current is SwitchBetweenChatTypes,
              builder: (context, state) {
                if (state is SwitchBetweenChatTypes) {
                  return AnimatedSwitcher(
                    duration: const Duration(seconds: 1),
                    child: state.chatType == ChatType.group
                        ? _groupChat()
                        : const FriendsChatBody(),
                    transitionBuilder: (child, animation) => SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeInOut,
                        ),
                      ),
                      child: child,
                    ),
                  );
                }
                return const FriendsChatBody();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _groupChat() {
    return Center(child: Lottie.asset(LottiesAssets.underConstruction));
  }
}
