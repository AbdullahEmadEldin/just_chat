part of 'agora_service_cubit.dart';

@immutable
sealed class AgoraServiceState {}

final class AgoraServiceInitial extends AgoraServiceState {}


final class UpdateCallTimer extends AgoraServiceState {

  final int callDurationInSeconds;
  UpdateCallTimer({required this.callDurationInSeconds});
}
final class RingingTimeOut extends AgoraServiceState {}

//!!!!

final class LocalUserJoined extends AgoraServiceState {}

final class RemoteUserJoined extends AgoraServiceState {
  final int remoteUid;
  RemoteUserJoined({required this.remoteUid});
}

final class RemoteUserOffline extends AgoraServiceState {
  final int remoteUid;
  RemoteUserOffline({required this.remoteUid});
}

final class TokenPrivilegeWillExpire extends AgoraServiceState {}

final class LeaveChannel extends AgoraServiceState {}

final class MicToggle extends AgoraServiceState {
  final bool isMuted;
  MicToggle({required this.isMuted});
}

final class SwitchCamera extends AgoraServiceState {
  final bool frontCamera;
  SwitchCamera({required this.frontCamera});
}
