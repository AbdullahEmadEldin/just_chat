import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/helpers/network_helper.dart';
import 'package:just_chat/modules/messages/data/models/message_model.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/constants/enums.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/theme/colors/colors_manager.dart';
import '../../../logic/messaging_cubit/messaging_cubit.dart';
import '../../../logic/recorder_cubit/recorder_cubit.dart';

class AudioRecordingField extends StatefulWidget {
  final String chatId;
  const AudioRecordingField({super.key, required this.chatId});

  @override
  State<AudioRecordingField> createState() => _AudioRecordingFieldState();
}

class _AudioRecordingFieldState extends State<AudioRecordingField> {
  late MessagingCubit _messagingCubit;
  late String recordUrl;
  @override
  void initState() {
    _messagingCubit = context.read<MessagingCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        StreamBuilder(
          stream: context.read<RecorderCubit>().recordTimeStream(),
          builder: (context, snapshot) {
            final duration =
                snapshot.hasData ? snapshot.data!.duration : Duration.zero;
            final String recordTime =
                '${duration.inMinutes.toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text.rich(TextSpan(
                children: [
                  TextSpan(
                    text: 'Recording... ',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: ColorsManager().colorScheme.grey80,
                        ),
                  ),
                  TextSpan(
                    text: recordTime,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: ColorsManager().colorScheme.fillPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              )),
            );
          },
        ),
        BlocBuilder<RecorderCubit, RecorderState>(
          builder: (context, state) {
            return Row(
              children: [
                IconButton(
                  onPressed: state is UploadRecordUiTrigger
                      ? null
                      : () {
                          context.read<RecorderCubit>().cancelRecording();
                        },
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    color: state is UploadRecordUiTrigger
                        ? Colors.redAccent
                        : ColorsManager().colorScheme.fillRed,
                    size: 24.r,
                  ),
                ),
                InkWell(
                  onTap: state is UploadRecordUiTrigger
                      ? null
                      : () async {
                          await _stopAndSend();
                        },
                  child: Transform.rotate(
                    angle: -45,
                    child: state is UploadRecordUiTrigger
                        ? const CircularProgressIndicator()
                        : Icon(
                            Icons.send,
                            color: ColorsManager().colorScheme.fillPrimary,
                            size: 24.r,
                          ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  _stopAndSend() async {
    await context.read<RecorderCubit>().stopRecording().then(
      (recordPath) async {
        context.read<RecorderCubit>().uploadRecordUiTrigger();

        recordUrl = await NetworkHelper.uploadFileToFirebase(recordPath);
        context.read<RecorderCubit>().closeRecordingView();

        _messagingCubit.sendMessage(
          message: MessageModel(
            chatId: widget.chatId,
            msgId: const Uuid().v1(),
            senderId: getIt<FirebaseAuth>().currentUser!.uid,
            replyMsgId: context.read<MessagingCubit>().replyToMessage?.msgId,
            content: recordUrl,
            contentType: MsgType.audio.name,
            sentTime: Timestamp.fromDate(DateTime.now()),
            isSeen: false,
          ),
        );
      },
    );
  }
}
