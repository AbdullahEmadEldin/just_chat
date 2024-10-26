import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/modules/messages/logic/video_player_cubit/video_player_cubit.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/constants/loties_assets.dart';
import '../../../../../core/theme/colors/colors_manager.dart';

class VideoMsgTile extends StatefulWidget {
  final String videoUrl;
  final bool playFromLocal;
  const VideoMsgTile({
    super.key,
    required this.videoUrl,
    this.playFromLocal = false,
  });

  @override
  State<VideoMsgTile> createState() => _VideoMsgTileState();
}

class _VideoMsgTileState extends State<VideoMsgTile> {
  late VideoPlayerCubit _videoPlayerCubit;

  @override
  void initState() {
    super.initState();

    _videoPlayerCubit = context.read<VideoPlayerCubit>();

    widget.playFromLocal
        ? _videoPlayerCubit.initVideoPlayerFromLocal(videoPath: widget.videoUrl)
        : _videoPlayerCubit.initVideoPlayerFromUrl(videoUrl: widget.videoUrl);
    _videoPlayerCubit.durationListener();
  }

  @override
  void dispose() {
    _videoPlayerCubit.videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
      buildWhen: (previous, current) => current is VideoInitialized,
      builder: (context, state) {
        return state is VideoInitialized
            ? Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: AspectRatio(
                      aspectRatio:
                          _videoPlayerCubit.videoController.value.aspectRatio,
                      child: VideoPlayer(_videoPlayerCubit.videoController),
                    ),
                  ),
                  _videoTimer(context),
                  _playPauseButton(),
                ],
              )
            : Center(
                child: Lottie.asset(
                  LottiesAssets.loadingChat,
                  width: 100.w,
                  height: 100.h,
                ),
              );
      },
    );
  }

  Positioned _playPauseButton() {
    return Positioned(
      left: 0,
      bottom: 0,
      child: BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
        buildWhen: (previous, current) => current is VideoStateChanged,
        builder: (context, state) {
          var stateIcon =
              state is VideoStateChanged ? state.newIcon : CupertinoIcons.play;
          return IconButton(
            onPressed: () {
              _videoPlayerCubit.playPauseVideo();
            },
            icon: Container(
              padding: EdgeInsets.all(8.r),
              // margin: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(64.r),
                color: ColorsManager().colorScheme.grey80.withOpacity(0.5),
              ),
              child: Icon(
                stateIcon,
                color: ColorsManager().colorScheme.primary,
              ),
            ),
          );
        },
      ),
    );
  }

  Positioned _videoTimer(BuildContext context) {
    return Positioned(
      right: 0,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.all(4.r),
        margin: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(64.r),
          color: ColorsManager().colorScheme.grey80.withOpacity(0.5),
        ),
        child: BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
          buildWhen: (previous, current) => current is VideoDurationProgress,
          builder: (context, state) {
            var duration = _videoPlayerCubit.videoDuration;
            return Text(
              '${duration!.inMinutes} : ${duration.inSeconds % 60}',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.white60,
                    fontWeight: FontWeight.bold,
                  ),
            );
          },
        ),
      ),
    );
  }
}
