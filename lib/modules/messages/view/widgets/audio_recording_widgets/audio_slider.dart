import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/colors/colors_manager.dart';
import '../../../logic/audio_player_cubit/audio_player_cubit.dart';

class AudioSlider extends StatelessWidget {
  final String recordDuration;
  final bool audioCompleted;
  const AudioSlider({
    super.key,
    required this.recordDuration,
    required this.audioCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: context.read<AudioPlayerCubit>().audioPlayer.onPositionChanged,
        builder: (context, snapshot) {
          Duration progress =
              snapshot.hasData ? snapshot.data ?? Duration.zero : Duration.zero;

          if (audioCompleted) {
            progress = Duration.zero;
          }
          return Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 12.h),
              child: ProgressBar(
                total: Duration(
                  seconds: int.parse(recordDuration),
                ),
                progress: progress,
                baseBarColor: ColorsManager().colorScheme.primary20,
                progressBarColor: ColorsManager().colorScheme.fillPrimary,
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
        });
  }
}
