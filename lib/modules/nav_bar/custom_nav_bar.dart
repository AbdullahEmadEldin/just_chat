import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/modules/chat/logic/all_chats_cubit/all_chats_cubit.dart';
import 'package:just_chat/modules/chat/view/pages/all_chats_page.dart';
import 'package:just_chat/modules/nav_bar/nav_bar_item.dart';
import 'package:just_chat/modules/profile/view/profile_page.dart';

import '../../core/constants/image_assets.dart';
import '../../core/theme/colors/colors_manager.dart';

class CustomNavBar extends StatefulWidget {
  static const String routeName = '/custom_nav_bar';
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  final PageController _pageController = PageController(initialPage: 1);

  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager().colorScheme.primary80,
      body: PageView(
        
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            log('Ehhhhhhh');
            currentIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: Container(
          height: 80.h,
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              ColorsManager().colorScheme.primary80,
              const Color.fromARGB(255, 18, 150, 186),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              _navBarItems.length,
              (index) => GestureDetector(
                onTap: () {
                  setState(() => currentIndex = index);
                  _pageController.jumpToPage(index);
                },
                child: NavBarItem(
                  iconPath: _navBarItems[index],
                  isSelected: currentIndex == index,
                ),
              ),
            ),
          )),
    );
  }

  final List<String> _navBarItems = [
    ImagesAssets.settingsIcon,
    ImagesAssets.chatIcon,
    ImagesAssets.profileIcon
  ];

  final _pages = [
    Center(
      child: Text('This is Settings'),
    ),
    BlocProvider(
      create: (context) => AllChatsCubit()..getAllChats(),
      child: const AllChatsPage(),
    ),
    const ProfilePage(),
  ];
}
