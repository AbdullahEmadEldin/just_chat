import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/modules/auth/logic/user_data_cubit/user_data_cubit.dart';
import 'package:just_chat/modules/chat/logic/all_chats/all_chats_cubit.dart';
import 'package:just_chat/modules/chat/view/pages/all_chats_page.dart';
import 'package:just_chat/modules/nav_bar/nav_bar_item.dart';
import 'package:just_chat/modules/profile/view/profile_page.dart';
import 'package:just_chat/modules/settings/view/page/settings_page.dart';

import '../../core/constants/image_assets.dart';
import '../../core/theme/colors/colors_manager.dart';
import '../../core/theme/theme_manager.dart';

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
            currentIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: ValueListenableBuilder<ThemeMode?>(
        valueListenable: AppThemes.instance.themeNotifier,
        builder: (context, themeMode, child) => Container(
            height: 70.h,
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: ColorsManager().colorScheme.navBarGradient,
            ),
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
      ),
    );
  }

  final List<String> _navBarItems = [
    ImagesAssets.settingsIcon,
    ImagesAssets.chatIcon,
    ImagesAssets.profileIcon
  ];

  final _pages = [
    const SettingsPage(),
    BlocProvider(
      create: (context) => AllChatsCubit(),
      child: const AllChatsPage(),
    ),
    BlocProvider(
      create: (context) => UserDataCubit()..getUserData(),
      child: const ProfilePage(),
    ),
  ];
}
