import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/helpers/extensions.dart';
import 'package:just_chat/core/helpers/network_helper.dart';
import 'package:just_chat/core/theme/colors/colors_manager.dart';
import 'package:just_chat/modules/messages/logic/messaging_cubit/messaging_cubit.dart';
import 'package:just_chat/modules/messages/view/pages/messaging_page.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/constants/enums.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../data/models/message_model.dart';

class ImagePreviewArgs {
  final String imagePath;
  final BuildContext sendCubitContext;

  ImagePreviewArgs({required this.imagePath, required this.sendCubitContext});
}

class PreviewImageScreen extends StatefulWidget {
  static const String routeName =
      '${MessagingPage.routeName}/previewImageScreen';
  //
  final ImagePreviewArgs args;
  const PreviewImageScreen({
    super.key,
    required this.args,
  });

  @override
  State<PreviewImageScreen> createState() => _PreviewImageScreenState();
}

class _PreviewImageScreenState extends State<PreviewImageScreen> {
  bool uploading = false;
late MessagingCubit messagingCubit;

@override
  void initState() {
    messagingCubit = widget.args.sendCubitContext.read<MessagingCubit>();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.file(
          File(widget.args.imagePath),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 42.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _actionButton(
              onTap: () => context.pop(),
              containerColor: ColorsManager().colorScheme.fillRed,
              icon: Icon(
                Icons.cancel,
                color: Colors.white,
                size: 36.r,
              ),
            ),
            SizedBox(width: 16.w),
            _actionButton(
              onTap: () async {
                await _sendImage(context);
              },
              containerColor: ColorsManager().colorScheme.primary,
              icon: uploading
                  ? const CircularProgressIndicator.adaptive(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    )
                  : Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 36.r,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendImage(BuildContext context) async {
    setState(() {
      uploading = true;
    });
   messagingCubit
        .sendMessage(
          message: MessageModel(
            chatId: messagingCubit
                .chatModel
                .chatId,
            msgId: const Uuid().v1(),
            senderId: getIt<FirebaseAuth>().currentUser!.uid,
            content:
                await NetworkHelper.uploadFileToFirebase(widget.args.imagePath),
            contentType: MsgType.image.name,
            sentTime: Timestamp.fromDate(DateTime.now()),
            isSeen: false,
          ),
        )
        .then((_) {
      setState(() {
        uploading = false;
      });
      context.pop();
    });
  }

  Widget _actionButton({
    required Color containerColor,
    required Widget icon,
    required Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(64.r),
      child: Ink(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(64.r),
          ),
          child: icon),
    );
  }
}
