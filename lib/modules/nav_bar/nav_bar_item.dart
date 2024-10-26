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
      padding: EdgeInsets.all(12.r),
      height: 56.h,
      width: 56.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(64.r),
        color: isSelected ? Colors.white : Colors.transparent,
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
