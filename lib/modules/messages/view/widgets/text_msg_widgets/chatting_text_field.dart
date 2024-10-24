import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/colors/colors_manager.dart';
import '../../../logic/messaging_cubit/messaging_cubit.dart';

class ChattingTextField extends StatelessWidget {
  const ChattingTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: context.read<MessagingCubit>().textingController,
        onChanged: (value) {
          context.read<MessagingCubit>().switchSendButtonIcon();
          context.read<MessagingCubit>().setSquareBorderRadius();
        },
        minLines: 1,
        maxLines: null,
        cursorHeight: 24.h,
        cursorColor: ColorsManager().colorScheme.primary,
        decoration: InputDecoration(
         
          hintText: 'Type a message...',
          hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: ColorsManager().colorScheme.grey60,
              ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        ),
      ),
    );
  }
}
