import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/modules/messages/view/widgets/audio_recording_widgets/audio_slider.dart';
import 'package:just_chat/modules/messages/view/widgets/audio_recording_widgets/play_pause_button.dart';

import '../../../logic/audio_player_cubit/audio_player_cubit.dart';

class AudioMsgTile extends StatefulWidget {
  final String audioUrl;
  final String recordDuration;
  const AudioMsgTile({
    super.key,
    required this.audioUrl,
    required this.recordDuration,
  });

  @override
  State<AudioMsgTile> createState() => _AudioMsgTileState();
}

class _AudioMsgTileState extends State<AudioMsgTile> {
  @override
  void initState() {
    context.read<AudioPlayerCubit>().listenToPlayerState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
      builder: (context, state) {
        return Row(
          children: [
            PlayPauseButton(
                audioPlay: state is AudioPlayerStart,
                audioUrl: widget.audioUrl),
            SizedBox(width: 12.w),
            AudioSlider(
              recordDuration: widget.recordDuration,
              audioCompleted: state is AudioPlayerCompleted,
            ),
          ],
        );
      },
    );
  }
}
