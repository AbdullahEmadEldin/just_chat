import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      create: (context) => AudioPlayerCubit(),
      child: BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
        builder: (context, state) {
          return Row(
            children: [
              InkWell(
                onTap: () {
                  if (state is AudioPlayerStart) {
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
                  child: Icon(
                    state is AudioPlayerStart
                        ? Icons.pause
                        : CupertinoIcons.play_arrow_solid,
                    color: ColorsManager().colorScheme.fillPrimary,
                    size: 24.r,
                  ),
                ),
              ),
              SizedBox(width: 12.w),

              // Text(
              //   state is AudioPlayerStart
              //       ? '${state.duration.inSeconds}s'
              //       : '0s',
              //   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              //         color: ColorsManager().colorScheme.background,
              //       ),
              // ),
            ],
          );
        },
      ),
    );
  }
}
