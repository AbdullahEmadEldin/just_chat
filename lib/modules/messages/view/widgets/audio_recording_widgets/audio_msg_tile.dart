import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/modules/messages/view/widgets/audio_recording_widgets/play_pause_button.dart';

import '../../../../../core/theme/colors/colors_manager.dart';
import '../../../logic/audio_player_cubit/audio_player_cubit.dart';

class AudioMsgTile extends StatelessWidget {
  final String audioUrl;
  final String recordDuration;
  const AudioMsgTile({
    super.key,
    required this.audioUrl,
    required this.recordDuration,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      //? Why here? ==> Because each record should have it's own player.
      create: (context) => AudioPlayerCubit(),
      child: BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
        builder: (context, state) {
          return Row(
            children: [
              PlayPauseButton(
                  audioPlay: state is AudioPlayerStart, audioUrl: audioUrl),
              SizedBox(width: 12.w),
              StreamBuilder(
                  stream:
                      context.read<AudioPlayerCubit>().audioPlayer.onProgress,
                  builder: (context, snapshot) {
                    Duration? progress = snapshot.hasData
                        ? snapshot.data!.position
                        : Duration.zero;
                    return Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 12.h),
                        child: ProgressBar(
                          total: Duration(
                            seconds: int.parse(recordDuration),
                          ),
                          progress: progress,
                          baseBarColor: ColorsManager().colorScheme.primary20,
                          progressBarColor:
                              ColorsManager().colorScheme.fillPrimary,
                          thumbColor: ColorsManager().colorScheme.fillPrimary,
                          thumbRadius: 7.r,
                          thumbCanPaintOutsideBar: false,
                          timeLabelType: TimeLabelType.totalTime,
                          timeLabelTextStyle:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Colors.white60,
                                  ),
                        ),
                      ),
                    );
                  })
            ],
          );
        },
      ),
    );
  }
}
