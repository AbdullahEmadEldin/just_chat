import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/colors/colors_manager.dart';

class NavBarItem extends StatelessWidget {
  final String iconPath;
  final bool isSelected;

  const NavBarItem({
    super.key,
    required this.isSelected,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
      padding: EdgeInsets.all(8.r),
      height: isSelected ? 55.h : 45.h,
      width: isSelected ? 55.w : 45.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(64.r),
        color: isSelected
            ? ColorsManager().colorScheme.background
            : Colors.transparent,
      ),
      child: Image.asset(
        iconPath,
        height: 35.h,
        width: 35.w,
        color: isSelected
            ? ColorsManager().colorScheme.primary
            : ColorsManager().colorScheme.background,
      ),
    );
  }
}
