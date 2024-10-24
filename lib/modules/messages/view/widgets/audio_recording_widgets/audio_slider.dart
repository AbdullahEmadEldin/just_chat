import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/colors/colors_manager.dart';
import '../../../logic/audio_player_cubit/audio_player_cubit.dart';

class AudioSlider extends StatefulWidget {
  final String recordDuration;
  final bool audioCompleted;
  const AudioSlider({
    super.key,
    required this.recordDuration,
    required this.audioCompleted,
  });

  @override
  State<AudioSlider> createState() => _AudioSliderState();
}

class _AudioSliderState extends State<AudioSlider> {
  Duration totalDuration = Duration.zero;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: context.read<AudioPlayerCubit>().audioPlayer.onPositionChanged,
        builder: (context, snapshot) {
          _calTotalDuration(context).then((value) => totalDuration = value);
          //
          Duration progress =
              snapshot.hasData ? snapshot.data ?? Duration.zero : Duration.zero;
          if (widget.audioCompleted) {
            progress = Duration.zero;
          }
          return Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 12.h),
              child: ProgressBar(
                total: totalDuration,
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

  /// This function will calculate the total duration of the audio if it wasn't a record but sent from media.
  Future<Duration> _calTotalDuration(BuildContext context) async {
    Duration totalDuration = Duration(
      seconds: int.parse(widget.recordDuration),
    );
    if (totalDuration == Duration.zero) {
      totalDuration =
          await context.read<AudioPlayerCubit>().audioPlayer.getDuration() ??
            const  Duration(seconds: 0);
    }
    return totalDuration;
  }
}
