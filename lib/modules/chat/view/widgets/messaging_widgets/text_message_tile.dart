import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/di/dependency_injection.dart';
import 'package:just_chat/core/helpers/ui_helpers.dart';
import 'package:just_chat/modules/chat/data/models/message_model.dart';

import '../../../../../core/theme/colors/colors_manager.dart';

class TextMessageTile extends StatelessWidget {
  final MessageModel message;
  const TextMessageTile({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: _myAlignment() ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        //  width: MediaQuery.sizeOf(context).width * 0.75,
        margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: _myAlignment()
              ? ColorsManager().colorScheme.primary
              : ColorsManager().colorScheme.primary60.withOpacity(0.8),
          borderRadius: BorderRadius.only(
            topRight: _myAlignment() ? Radius.zero : Radius.circular(16.r),
            topLeft: message.senderId != getIt<FirebaseAuth>().currentUser!.uid
                ? Radius.zero
                : Radius.circular(16.r),
            bottomRight: Radius.circular(16.r),
            bottomLeft: Radius.circular(16.r),
          ),
        ),
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          
          crossAxisAlignment: _myAlignment()
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,

          children: [
            Text(
              message.content,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 12.w),
            Text(
              UiHelper.formatTimestampToDate(timestamp: message.sentTime),
              textAlign: TextAlign.right,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.white60),
            ),
          ],
        ),
      ),
    );
  }

  bool _myAlignment() {
    return message.senderId == getIt<FirebaseAuth>().currentUser!.uid;
  }
}
