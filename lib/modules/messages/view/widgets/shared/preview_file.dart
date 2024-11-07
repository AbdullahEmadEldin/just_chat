import 'dart:developer';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/helpers/extensions.dart';
import 'package:just_chat/core/helpers/network_helper.dart';
import 'package:just_chat/core/theme/colors/colors_manager.dart';
import 'package:just_chat/modules/messages/logic/audio_player_cubit/audio_player_cubit.dart';
import 'package:just_chat/modules/messages/logic/messaging_cubit/messaging_cubit.dart';
import 'package:just_chat/modules/messages/logic/video_player_cubit/video_player_cubit.dart';
import 'package:just_chat/modules/messages/view/pages/messaging_page.dart';
import 'package:just_chat/modules/messages/view/widgets/audio_recording_widgets/audio_msg_tile.dart';
import 'package:just_chat/modules/messages/view/widgets/media_msgs_widgets/video_msg_tile.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../data/models/message_model.dart';

class PreviewFileArgs {
  final String filePath;
  final BuildContext sendCubitContext;
  final FileType fileType;

  PreviewFileArgs({
    required this.filePath,
    required this.sendCubitContext,
    required this.fileType,
  });
}

class PreviewFileScreen extends StatefulWidget {
  static const String routeName =
      '${MessagingPage.routeName}/previewImageScreen';
  //
  final PreviewFileArgs args;
  const PreviewFileScreen({
    super.key,
    required this.args,
  });

  @override
  State<PreviewFileScreen> createState() => _PreviewFileScreenState();
}

class _PreviewFileScreenState extends State<PreviewFileScreen> {
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
        child: widget.args.fileType == FileType.image
            ? Image.file(
                File(widget.args.filePath),
              )
            : widget.args.fileType == FileType.video
                ? BlocProvider(
                    create: (context) => VideoPlayerCubit(),
                    child: VideoMsgTile(
                      videoUrl: widget.args.filePath,
                      playFromLocal: true,
                    ),
                  )
                : widget.args.fileType == FileType.audio
                    ? BlocProvider(
                        create: (context) => AudioPlayerCubit(),
                        child: AudioMsgTile(
                            audioUrl: widget.args.filePath,
                            recordDuration: '0'),
                      )
                    : Text('Something stupid',
                        style: TextStyle(color: Colors.white, fontSize: 32.sp)),
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
                Icons.close,
                color: Colors.white,
                size: 36.r,
              ),
            ),
            SizedBox(width: 16.w),
            _actionButton(
              onTap: () async {
                await _sendFile(context);
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

  Future<void> _sendFile(BuildContext context) async {
    setState(() {
      uploading = true;
    });
    try {
      messagingCubit
          .sendMessage(
        message: MessageModel(
          chatId: messagingCubit.chatId,
          msgId: const Uuid().v1(),
          senderId: getIt<FirebaseAuth>().currentUser!.uid,
          content:
              await NetworkHelper.uploadFileToFirebase(widget.args.filePath),
          contentType: widget.args.fileType.name,
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
    } catch (e) {
      log('Error sending file: $e');
      setState(() {
        uploading = false;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: AppStrings.errorOccurred.tr(),
          desc: e.toString(),
          btnOkOnPress: () {},
        ).show();
      });
    }
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
