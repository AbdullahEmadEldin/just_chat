import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/colors/colors_manager.dart';
import '../../../logic/audio_player_cubit/audio_player_cubit.dart';

class PlayPauseButton extends StatelessWidget {
  final bool audioPlay;
  final String audioUrl;
  const PlayPauseButton({
    super.key,
    required this.audioPlay,
    required this.audioUrl,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (audioPlay) {
          context.read<AudioPlayerCubit>().stopAudio();
        } else {
          context.read<AudioPlayerCubit>().playAudio(audioUrl);
        }
      },
      child: Container(
          padding: EdgeInsets.all(12.r),
          margin: EdgeInsets.only(top: 8.h),
          decoration: BoxDecoration(
            color: ColorsManager().colorScheme.primary20,
            borderRadius: BorderRadius.circular(32.r),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
            child: audioPlay
                ? Icon(
                    key: const ValueKey('pause'),
                    Icons.pause,
                    color: ColorsManager().colorScheme.fillPrimary,
                    size: 24.r,
                  )
                : Icon(
                    key: const ValueKey('playIcon'),
                    CupertinoIcons.play_arrow_solid,
                    color: ColorsManager().colorScheme.fillPrimary,
                    size: 24.r,
                  ),
          )),
    );
  }
}
