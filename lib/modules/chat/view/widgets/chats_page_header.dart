import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/helpers/extensions.dart';
import 'package:just_chat/core/theme/colors/colors_manager.dart';
import 'package:just_chat/modules/add_friends/view/search_for_friends_page.dart';

import '../../../../core/constants/enums.dart';
import '../../logic/all_chats/all_chats_cubit.dart';
import 'all_chats_header_custom_painter.dart';

class ChatsPageHeader extends StatefulWidget {
  const ChatsPageHeader({super.key});

  @override
  State<ChatsPageHeader> createState() => _ChatsPageHeaderState();
}

class _ChatsPageHeaderState extends State<ChatsPageHeader> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      width: 400.w,
      child: Stack(
        alignment: Alignment.topCenter,
        // clipBehavior: Clip.antiAliasWithSaveLayer,
        children: [
          SizedBox(
            width: 100.w,
            height: 50.h,
            child: CustomPaint(
              painter: AllChatsHeaderCustomPainter(),
            ),
          ),
          Positioned(
            top: 22.h,
            left: 24.w,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                context.read<AllChatsCubit>().switchBetweenChatTypes(
                      ChatType.friend,
                    );
                setState(() {
                  selectedIndex = 0;
                });
              },
              child: _headerButton(
                context,
                title: ' Friends',
                icon: Icons.people_alt_rounded,
                isSelected: selectedIndex == 0,
              ),
            ),
          ),
          Positioned(
            top: 15.h,
            left: 155.w,
            child: Container(
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                ),
              ),
              child: IconButton(
                onPressed: () {
                  context.pushNamed(SearchForFriendsPage.routeName);
                },
                icon: Icon(
                  Icons.search,
                  size: 32.r,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            top: 22.h,
            left: 213.w,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque, // Ensures full tap area
              onTap: () {
                context.read<AllChatsCubit>().switchBetweenChatTypes(
                      ChatType.group,
                    );
                setState(() {
                  selectedIndex = 1;
                });
              },
              child: _headerButton(
                context,
                title: ' Groups ',
                icon: Icons.groups_2,
                textIsFirst: true,
                isSelected: selectedIndex == 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerButton(
    BuildContext context, {
    required String title,
    required IconData icon,
    bool isSelected = false,
    bool textIsFirst = false,
  }) =>
      Container(
        padding: EdgeInsetsDirectional.only(
            end: textIsFirst ? 0 : 8.w, start: textIsFirst ? 8.w : 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(64),
          color: isSelected ? Colors.white : Colors.transparent,
        ),
        child: Row(
          children: [
            if (textIsFirst)
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: isSelected
                          ? ColorsManager().colorScheme.primary
                          : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            Container(
              height: 45.h,
              width: 45.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? ColorsManager().colorScheme.grey30
                    : Colors.transparent,
                border: Border.all(
                  color: ColorsManager().colorScheme.grey10,
                ),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? ColorsManager().colorScheme.primary
                    : Colors.white,
              ),
            ),
            if (!textIsFirst)
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: isSelected
                          ? ColorsManager().colorScheme.primary
                          : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
          ],
        ),
      );
}
