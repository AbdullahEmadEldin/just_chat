import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:meta/meta.dart';

part 'audio_player_state.dart';

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  AudioPlayerCubit() : super(AudioPlayerInitial());
  FlutterSoundPlayer audioPlayer = FlutterSoundPlayer();

  void playAudio(String url) async {
    /// Open the audio player must be called before using any other method
    await audioPlayer.openPlayer();

    audioPlayer
        .startPlayer(
            fromURI: url,
            whenFinished: () {
              // audioPlayer!.closePlayer();
              emit(AudioPlayerStop());
            })
        .then((duration) {
      print(
          'Playing audio- -----------------------------------------------------+++++');

      emit(AudioPlayerStart());
    });

    /// This is to make the onProgress callback stream update it self every 300 ms
    audioPlayer.setSubscriptionDuration(const Duration(milliseconds: 300));
  }

  void stopAudio() async {
    audioPlayer.stopPlayer();

    emit(AudioPlayerStop());
  }

  void getDurationProgress() async {
    audioPlayer.onProgress!.listen((duration) {});
  }
}
