import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:video_player/video_player.dart';

part 'video_player_state.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  VideoPlayerCubit() : super(VideoPlayerInitial());

  late VideoPlayerController videoController;
  Duration? videoDuration;

  /// This method will be used in Preview Video before send...
  void initVideoPlayerFromLocal({required String videoPath}) {
    videoController = VideoPlayerController.file(File(videoPath))
      ..initialize().then(
        (_) {
          emit(
            VideoInitialized(),
          );
          videoDuration = videoController.value.duration;
        },
      );
  }

  void initVideoPlayerFromUrl({required String videoUrl}) {
    videoController = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
      ..initialize().then(
        (_) {
          emit(
            VideoInitialized(),
          );
          videoDuration = videoController.value.duration;
        },
      );
  }

  void durationListener() {
    videoController.addListener(() {
      videoDuration = videoController.value.position;
      log('===============>>>>> XXXX init video: $videoDuration');

      emit(VideoDurationProgress());

      if (videoController.value.isCompleted) {
        emit(VideoStateChanged(newIcon: CupertinoIcons.play));
      }
    });
  }

  void playPauseVideo() {
    if (videoController.value.isPlaying) {
      videoController.pause();

      emit(VideoStateChanged(newIcon: CupertinoIcons.play));
    } else {
      videoController.play();
      emit(VideoStateChanged(newIcon: CupertinoIcons.pause));
    }
  }

  @override
  Future<void> close() {
    videoController.dispose();
    return super.close();
  }
}
