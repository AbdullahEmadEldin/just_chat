import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

part 'recorder_state.dart';

class RecorderCubit extends Cubit<RecorderState> {
  RecorderCubit() : super(RecorderInitial());

  //! ============================================================
  //! ================= Recording Logic ========================
  //! ============================================================
  final AudioRecorder record = AudioRecorder();

  /// both these vars for visualizing recording timer..
  late final Stopwatch stopwatch = Stopwatch();
  Timer? _timer;

  /// This bool to prevent double activate startRecording method at the same time
  bool isRecording = false;

  Future<void> startRecording() async {
    if (!isRecording) {
      //
      if (await record.hasPermission()) {
        isRecording = true;

        // Start recording to file
        await record
            .start(
              const RecordConfig(
                encoder: AudioEncoder
                    .aacLc, // this encoder make volume louder but not the best.
                bitRate:
                    256000, // this bitRate make volume louder but not the best.
              ),
              path:
                  await _getFilePath(), // create a unique file path for the record.
            )
            .then((_) =>
                updateTimer()); // mimic the timer of record as this package hasn't support it.

        _triggerRecordingView(); // this method will trigger the view of timer and send record.
      }
    } else {
      debugPrint('Already recording...');
    }
  }

  updateTimer() {
    stopwatch.start(); // start the timer
    // update the timer every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      emit(RecordTimerUpdate(timer: stopwatch.elapsed));
    });
  }

  /// cancel and reset all values of a specific record.
  _stopTimer() {
    stopwatch.reset();
    stopwatch.stop();

    _timer?.cancel();
  }

  /// stop record to send it to firebase.
  Future<String> stopRecording() async {
    final path = await record.stop();
    _stopTimer();
    return path!;
  }

  /// cancel without send.
  void cancelRecording() async {
    isRecording = false;
    closeRecordingView();
    await record.stop();
    _stopTimer();
  }

  /// Create a record path...
  Future<String> _getFilePath() async {
    // Get the directory to store the recorded audio
    Directory directory = await getApplicationDocumentsDirectory();
    String path =
        '${directory.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a';
    return path;
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

    /// this delay tp give the container the chance to get enlarged..
    Future.delayed(const Duration(milliseconds: 80), () {
      startRecordingAnimation = true;
    });
  }

  void closeRecordingView() {
    isRecording = false;
    startRecordingAnimation = false;

    emit(RecorderViewClose());
  }
}
