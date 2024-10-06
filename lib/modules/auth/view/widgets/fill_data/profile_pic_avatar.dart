import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/theme/colors/colors_manager.dart';

import '../../../../../core/helpers/ui_helpers.dart';

class ProfilePicAvatar extends StatelessWidget {
  final ImageProvider<Object>? profileAvatar;
  final Function()? onPressed;
  final bool checkIcon;
  final bool isLoading;
  const ProfilePicAvatar({
    super.key,
    required this.profileAvatar,
    required this.onPressed,
    this.checkIcon = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    // Using Stack to put the camera picker button on top-side of the avatar
    return Stack(
      children: [
        SizedBox(
          height: UiHelper.getResponsiveDimension(context, baseDimension: 130),
          width: UiHelper.getResponsiveDimension(context, baseDimension: 160),
          child: isLoading
              ? const Center(child: CircularProgressIndicator.adaptive())
              : CircleAvatar(
                  backgroundColor: ColorsManager().colorScheme.primary,
                  backgroundImage: profileAvatar,
                ),
        ),
        Positioned(
          bottom: 10,
          right: -1,
          child: Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
                color: ColorsManager().colorScheme.primary,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2)),
            child: IconButton(
                onPressed: onPressed,
                icon: Icon(
                  checkIcon ? Icons.check : Icons.camera_alt_rounded,
                  color: Colors.white,
                )),
          ),
        )
      ],
    );
  }
}
