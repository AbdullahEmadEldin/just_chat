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

  Future<void> startRecording() async {
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
    voiceMsgRecorder!
        .setSubscriptionDuration(const Duration(milliseconds: 300));

    /// Build the UI that depends on the voiceMsgRecorder after it has been initialized
    _triggerRecordingView();
  }

  Future<String> stopRecording() async {
    final path = await voiceMsgRecorder!.stopRecorder();

    print('==============>>> Recorded file path: $path');
    return path!;
  }

  void cancelRecording() async {
    closeRecordingView();
    final path = await voiceMsgRecorder!.stopRecorder();
    voiceMsgRecorder!.deleteRecord(fileName: path!);
  }

  //! ============================================================
  //! ================= Handling UI Logic ========================
  //! ============================================================
  void uploadRecordUiTrigger() {
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
    startRecordingAnimation = false;

    emit(RecorderViewClose());
  }

  Stream<RecordingDisposition>? recordTimeStream() {
    return voiceMsgRecorder!.onProgress!;
  }
}
