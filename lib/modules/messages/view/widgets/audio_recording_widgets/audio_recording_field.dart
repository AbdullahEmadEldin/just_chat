import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/helpers/network_helper.dart';
import 'package:just_chat/modules/messages/data/models/message_model.dart';
import 'package:just_chat/modules/messages/view/widgets/audio_recording_widgets/record_timer.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
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
  late RecorderCubit _recorderCubit;
  Duration recordDuration = Duration.zero;

  @override
  void initState() {
    _messagingCubit = context.read<MessagingCubit>();
    _recorderCubit = context.read<RecorderCubit>();
    super.initState();
  }

  @override
  void dispose() {
    // _recorderCubit.voiceMsgRecorder!.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlocBuilder<RecorderCubit, RecorderState>(
          buildWhen: (previous, current) => current is RecordTimerUpdate,
          builder: (context, state) {
            recordDuration =
                state is RecordTimerUpdate ? state.timer : Duration.zero;
            final String recordTime =
                '${recordDuration.inMinutes.toString().padLeft(2, '0')}:${recordDuration.inSeconds.remainder(60).toString().padLeft(2, '0')}';

            return RecordTimer(recordTime: recordTime);
          },
        ),
        BlocBuilder<RecorderCubit, RecorderState>(
          buildWhen: (previous, current) => current is UploadRecordUiTrigger,
          builder: (context, state) {
            return Row(
              children: [
                IconButton(
                  onPressed: state is UploadRecordUiTrigger
                      ? null
                      : () {
                          _recorderCubit.cancelRecording();
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
                        ? Shimmer(
                            duration: const Duration(milliseconds: 900),
                            child: Icon(
                              Icons.send,
                              color: ColorsManager().colorScheme.grey60,
                              size: 24.r,
                            ))
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
    await _recorderCubit.stopRecording().then(
      (recordPath) async {
        _recorderCubit.uploadRecordUiTrigger();

        final recordUrl = await NetworkHelper.uploadFileToFirebase(recordPath);
        _recorderCubit.closeRecordingView();

        _messagingCubit.sendMessage(
          message: MessageModel(
            chatId: widget.chatId,
            msgId: const Uuid().v1(),
            senderId: getIt<FirebaseAuth>().currentUser!.uid,
            replyMsgId: _messagingCubit.replyToMessage?.msgId,
            content: recordUrl,
            contentType: MsgType.audio.name,
            sentTime: Timestamp.fromDate(DateTime.now()),
            isSeen: false,
            recordDuration: recordDuration.inSeconds.toString(),
          ),
        );
        recordDuration = Duration.zero;
      },
    );
  }
}
