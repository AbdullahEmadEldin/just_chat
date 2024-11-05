import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/colors/colors_manager.dart';

class HeaderBackButton extends StatelessWidget {
  const HeaderBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6.0,
      borderRadius: BorderRadius.circular(32.r),
      child: CircleAvatar(
        radius: 22.r,
        backgroundColor: ColorsManager().colorScheme.background,
        child: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            CupertinoIcons.chevron_back,
            color: ColorsManager().colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
