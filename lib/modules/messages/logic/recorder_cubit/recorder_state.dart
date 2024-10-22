part of 'recorder_cubit.dart';

@immutable
sealed class RecorderState {}

final class RecorderInitial extends RecorderState {}

final class RecordTimerUpdate extends RecorderState {
  final Duration timer;

  RecordTimerUpdate({required this.timer});
}

//! states of Trigger Record UI view...
final class RecorderViewTrigger extends RecorderState {}

final class RecorderViewClose extends RecorderState {}

//
//! This state will make some components loading and make other components not in function. when uploading record.
final class UploadRecordUiTrigger extends RecorderState {}
