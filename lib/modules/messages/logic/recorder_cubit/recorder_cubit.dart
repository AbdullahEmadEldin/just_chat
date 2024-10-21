import 'package:bloc/bloc.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

part 'recorder_state.dart';

class RecorderCubit extends Cubit<RecorderState> {
  RecorderCubit() : super(RecorderInitial());

  //! ============================================================
  //! ================= Recording Logic ========================
  //! ============================================================
  FlutterSoundRecorder? voiceMsgRecorder;
  bool isRecording = false;
  initRecording() async {
    voiceMsgRecorder = await FlutterSoundRecorder().openRecorder();
  }

  Future<void> startRecording() async {
    if (!isRecording) {
      isRecording = true;
      String recordId = const Uuid().v1();

      // getting mic request.
      var permissionStatus = await Permission.microphone.status;
      if (!permissionStatus.isGranted) {
        await Permission.microphone.request();
      }
      print('====> Permission granted');
    voiceMsgRecorder = await FlutterSoundRecorder().openRecorder();

      await voiceMsgRecorder!.startRecorder(
        toFile: recordId,
      );
      await voiceMsgRecorder!
          .setSubscriptionDuration(const Duration(milliseconds: 300));

      _triggerRecordingView();

      /// Build the UI that depends on the voiceMsgRecorder after it has been initialized
    } else {
      print(
          'Already recording000000000000000000000000000000000000000000000000');
    }
  }

  Future<String> stopRecording() async {
    final path = await voiceMsgRecorder!.stopRecorder();

    print('==============>>> Recorded file path: $path');
    return path!;
  }

  void cancelRecording() async {
    isRecording = false;
    closeRecordingView();
    final path = await voiceMsgRecorder!.stopRecorder();
    voiceMsgRecorder!.deleteRecord(fileName: path!);
  }

  //! ============================================================
  //! ================= Handling UI Logic ========================
  //! ============================================================
  void uploadRecordUiTrigger() {
    isRecording = false;
    emit(UploadRecordUiTrigger());
  }

  bool startRecordingAnimation = false;
  void _triggerRecordingView() {
    emit(RecorderViewTrigger());

    Future.delayed(const Duration(milliseconds: 80), () {
      startRecordingAnimation = true;
    });
  }

  void closeRecordingView() {
    isRecording = false;
    startRecordingAnimation = false;

    emit(RecorderViewClose());
  }

  Stream<RecordingDisposition>? recordTimeStream() {
    return voiceMsgRecorder!.onProgress!;
  }
}
