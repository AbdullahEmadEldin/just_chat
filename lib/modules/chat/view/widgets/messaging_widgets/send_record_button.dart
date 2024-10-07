import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/modules/chat/logic/messaging_cubit/messaging_cubit.dart';

import '../../../../../core/theme/colors/colors_manager.dart';

class SendRecordButton extends StatefulWidget {
  const SendRecordButton({super.key});

  @override
  State<SendRecordButton> createState() => _SendRecordButtonState();
}

class _SendRecordButtonState extends State<SendRecordButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(64.r),
          color: ColorsManager().colorScheme.primary,
        ),
        child: BlocBuilder<MessagingCubit, MessagingState>(
          builder: (context, state) {
            IconData buttonIcon = CupertinoIcons.mic;
            if (state is SwitchSendButtonIcon) {
              print('==================================');
              buttonIcon = state.newIcon;
            }
            return Icon(
              buttonIcon,
              color: Colors.white,
            );
          },
        ),
      ),
    );
  }
}
/**
 * 
 BlocBuilder<MessagingCubit, MessagingState>(
          builder: (context, state) {
            IconData buttonIcon = CupertinoIcons.mic;
            if (state is SwitchSendButtonIcon) {
              print('==================================');
              buttonIcon = state.newIcon;
            }
            return Icon(
              buttonIcon,
              color: Colors.white,
            );
          },
        ),
 */