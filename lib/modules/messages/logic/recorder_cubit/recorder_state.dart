part of 'recorder_cubit.dart';

@immutable
sealed class RecorderState {}

final class RecorderInitial extends RecorderState {}

final class RecorderViewTrigger extends RecorderState {}
final class RecorderViewClose extends RecorderState {}
