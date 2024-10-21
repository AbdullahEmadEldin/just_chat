import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:meta/meta.dart';

part 'audio_player_state.dart';

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  AudioPlayerCubit() : super(AudioPlayerInitial());
  FlutterSoundPlayer? audioPlayer = FlutterSoundPlayer();
  void playAudio(String url) async {
    await audioPlayer!.openPlayer();

    audioPlayer!
        .startPlayer(
            fromURI: url,
            whenFinished: () {
              print(
                  'This audio has finished playing! and closing player instance');
              // audioPlayer!.closePlayer();
              emit(AudioPlayerStop());
            })
        .then((duration) {
      print(
          'Playing audio- -----------------------------------------------------+++++');

      emit(AudioPlayerStart(duration: duration!));
    });
  }

  void stopAudio() async {
    audioPlayer!.stopPlayer();

    emit(AudioPlayerStop());
  }
}
