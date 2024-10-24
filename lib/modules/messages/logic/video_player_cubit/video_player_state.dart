part of 'video_player_cubit.dart';

@immutable
sealed class VideoPlayerState {}

final class VideoPlayerInitial extends VideoPlayerState {}

final class VideoInitialized extends VideoPlayerState {}

final class VideoDurationProgress extends VideoPlayerState {}

final class VideoStateChanged extends VideoPlayerState {
  final IconData newIcon;
  VideoStateChanged({required this.newIcon});
}
