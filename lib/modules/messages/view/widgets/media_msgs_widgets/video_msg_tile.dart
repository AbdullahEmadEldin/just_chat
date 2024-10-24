import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/constants/loties_assets.dart';
import '../../../../../core/theme/colors/colors_manager.dart';
//TODO Make State management of this widget with cubt
//TODO  each part of it (video , play button , timer) should have a separate BLOC BUILDER...
class VideoMsgTile extends StatefulWidget {
  final String videoUrl;
  const VideoMsgTile({super.key, required this.videoUrl});

  @override
  State<VideoMsgTile> createState() => _VideoMsgTileState();
}

class _VideoMsgTileState extends State<VideoMsgTile> {
  late VideoPlayerController _controller;
  late Duration _videoDuration;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        widget.videoUrl,
      ),
    )..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _videoDuration = _controller.value.duration;
        });
      });

    _controller.addListener(() {
      setState(() {
        _videoDuration = _controller.value.position;
      });
      if (_controller.value.isCompleted) {
        setState(() {});
        _controller.pause();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.all(4.r),
                  margin: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(64.r),
                    color: ColorsManager().colorScheme.grey80.withOpacity(0.5),
                  ),
                  child: Text(
                    '${_videoDuration.inMinutes} : ${_videoDuration.inSeconds % 60}',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.white60,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                bottom: 0,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                    });
                  },
                  icon: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : _controller.value.isCompleted
                            ? Icons.play_arrow
                            : Icons.play_arrow,
                    color: ColorsManager().colorScheme.primary,
                  ),
                ),
              ),
            ],
          )
        : Center(
            child: Lottie.asset(
              LottiesAssets.loadingChat,
              width: 100.w,
              height: 100.h,
            ),
          );
  }
}
