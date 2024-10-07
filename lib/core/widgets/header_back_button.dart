import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/colors/colors_manager.dart';

class HeaderBackButton extends StatelessWidget {
  const HeaderBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 24.r,
      backgroundColor: ColorsManager().colorScheme.primary20,
      child: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          CupertinoIcons.chevron_back,
          color: Colors.white,
        ),
      ),
    );
  }
}
