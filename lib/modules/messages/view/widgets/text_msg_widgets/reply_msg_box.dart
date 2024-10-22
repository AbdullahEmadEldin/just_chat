import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/di/dependency_injection.dart';
import 'package:just_chat/core/helpers/ui_helpers.dart';
import 'package:just_chat/modules/messages/data/models/message_model.dart';
import 'package:just_chat/modules/messages/logic/messaging_cubit/messaging_cubit.dart';

import '../../../../../core/theme/colors/colors_manager.dart';

class ReplyMsgBox extends StatelessWidget {
  final MessageModel msg;
  final bool cancelAction;
  const ReplyMsgBox({
    super.key,
    required this.msg,
    this.cancelAction = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
      padding: EdgeInsets.only(right: 4.w),
      //height: 45.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: ColorsManager().colorScheme.primary20.withOpacity(0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                  width: 6.w,
                  height: 45.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.r),
                      bottomLeft: Radius.circular(8.r),
                    ),
                    color: ColorsManager().colorScheme.fillPrimary,
                  )),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _handleMsgSenderName(context),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: ColorsManager().colorScheme.fillPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    UiHelper.limitStringLength(str: msg.content, maxLength: 35),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: cancelAction
                              ? Colors.white60
                              : ColorsManager().colorScheme.grey80,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ],
          ),
          if (!cancelAction)
            IconButton(
              onPressed: () =>
                  context.read<MessagingCubit>().cancelReplyToMsgBox(),
              icon: const Icon(
                Icons.cancel_outlined,
                color: Colors.redAccent,
              ),
            ),
        ],
      ),
    );
  }

  String _handleMsgSenderName(BuildContext context) {
    if (getIt<FirebaseAuth>().currentUser?.uid == msg.senderId) {
      return 'You';
    } else {
      return context.read<MessagingCubit>().opponentUser!.name;
    }
  }
}
