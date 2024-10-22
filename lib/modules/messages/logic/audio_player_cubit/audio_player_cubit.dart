import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'audio_player_state.dart';

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  AudioPlayerCubit() : super(AudioPlayerInitial());
  final audioPlayer = AudioPlayer();

  void playAudio(String url) async {
    audioPlayer.play(UrlSource(url), volume: 10.0);
    //
    emit(AudioPlayerStart());
    //
  }

  void pauseAudio() async {
    audioPlayer.pause();

    emit(AudioPlayerCompleted());
  }

  void listenToPlayerState() async {
    audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.paused) {
        debugPrint('=================>>>>> record paused');
        // it seems that the package handle pause and resume automatically 
        // so this state is useless but I will keep it.
         emit(AudioPlayerPaused());
      }

      if (event == PlayerState.completed) {
        debugPrint('=================>>>>> record completed');
        emit(AudioPlayerCompleted());
      }
    });
  }

  @override
  Future<void> close() {
    /// dispose the player for a specific record.
    audioPlayer.dispose();
    return super.close();
  }
}
