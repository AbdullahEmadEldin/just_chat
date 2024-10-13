import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/di/dependency_injection.dart';
import 'package:just_chat/modules/chat/data/models/message_model.dart';

import '../../../../../core/theme/colors/colors_manager.dart';

class TextMessageTile extends StatelessWidget {
  final MessageModel message;
  const TextMessageTile({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.senderId == getIt<FirebaseAuth>().currentUser!.uid
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.75,
        margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: message.senderId == getIt<FirebaseAuth>().currentUser!.uid
              ? ColorsManager().colorScheme.primary
              : ColorsManager().colorScheme.primary60.withOpacity(0.8),
          borderRadius: BorderRadius.only(
            topRight: message.senderId == getIt<FirebaseAuth>().currentUser!.uid
                ? Radius.zero
                : Radius.circular(32.r),
            topLeft: message.senderId != getIt<FirebaseAuth>().currentUser!.uid
                ? Radius.zero
                : Radius.circular(32.r),
            bottomRight: Radius.circular(32.r),
            bottomLeft: Radius.circular(32.r),
          ),
        ),
        child: Text(
          message.content,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
