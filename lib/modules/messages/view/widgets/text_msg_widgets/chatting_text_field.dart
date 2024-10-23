import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_chat/core/helpers/extensions.dart';
import 'package:just_chat/modules/messages/view/widgets/image_widgets/preview_image.dart';

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
          suffixIcon: IconButton(
            onPressed: () async {
              await ImagePicker().pickImage(source: ImageSource.gallery).then(
                (value) {
                  if (value != null) {
                    context.pushNamed(
                      PreviewImageScreen.routeName,
                      arguments: ImagePreviewArgs(
                          imagePath: value.path, sendCubitContext: context),
                    );
                  } else {
                    return;
                  }
                },
              );
            },
            icon: Icon(CupertinoIcons.photo_camera_solid,
                color: ColorsManager().colorScheme.primary40),
          ),
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
