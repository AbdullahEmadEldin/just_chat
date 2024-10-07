import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../logic/messaging_cubit/messaging_cubit.dart';

class MessagingTextField extends StatelessWidget {
  const MessagingTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: context.read<MessagingCubit>().textingController,
        onChanged: (value) {
          context.read<MessagingCubit>().switchSendButtonIcon();
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
        ),
      ),
    );
  }
}
