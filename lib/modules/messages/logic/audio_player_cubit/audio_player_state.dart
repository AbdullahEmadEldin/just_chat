part of 'audio_player_cubit.dart';

@immutable
sealed class AudioPlayerState {}

final class AudioPlayerInitial extends AudioPlayerState {}

final class AudioPlayerStart extends AudioPlayerState {
  
}
final class AudioPlayerStop extends AudioPlayerState {}
