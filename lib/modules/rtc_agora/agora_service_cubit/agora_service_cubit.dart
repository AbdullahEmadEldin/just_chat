import 'dart:async';
import 'dart:developer';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';

part 'agora_service_state.dart';

class AgoraServiceCubit extends Cubit<AgoraServiceState> {
  AgoraServiceCubit() : super(AgoraServiceInitial());
  //! =============================== CONST Values ===============================
  static const _appId = "2b564bfe6e274d9f911baab06c6c9031"; //from agora console
  // for testing purpose only as well as channel
  // in production level you will use token generator for each channel from server.
  static const _tempTokenServer =
      '007eJxTYEgNnaOYdEgm9evVNSuT2wvP2XxbcupSrj+rj5Dkyf1HfykqMBglmZqZJKWlmqUamZukWKZZGhomJSYmGZglmyVbGhgbrgxXSm8IZGRoPbSClZEBAkF8NoaS1OKSkhIGBgDc5CF1';
  String channelId = "testtt"; // you set it in agora console
  ///
  ///

  late RtcEngine agoraEngine;

  //! 111111
  Future<void> requestVideoCalPermission() async {
    log('1111111111111');
    await [Permission.camera, Permission.microphone].request();
  }

  //! 222222
  Future<void> initAgoraEngine() async {
    log('2222222222');

    //create the engine
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize(
      const RtcEngineContext(
        appId: _appId,
      ),
    );

    /// ensure the client role is broadcaster not audience.
    await agoraEngine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await agoraEngine.setupLocalVideo(const VideoCanvas(uid: 0));

    registerEventHandler();
    joinChannel();
  }

  //! 333333
  void registerEventHandler() {
    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          log("local user ${connection.localUid} joined");
          emit(LocalUserJoined());
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          log("remote user $remoteUid joined");
          emit(RemoteUserJoined(remoteUid: remoteUid));
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          log("remote user $remoteUid left channel");
          emit(RemoteUserOffline(remoteUid: remoteUid));
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          log('[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
          emit(TokenPrivilegeWillExpire());
        },
        onLeaveChannel: (RtcConnection connection, RtcStats stats) {
          log('[onLeaveChannel] connection: ${connection.toJson()}, stats: ${stats.toJson()}');
        },
      ),
    );
  }

  //! 444444
  Future<void> joinChannel() async {
    log('444444444444');

    await agoraEngine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await agoraEngine.enableVideo();
    await agoraEngine.startPreview();

    await agoraEngine.joinChannel(
      token: _tempTokenServer,
      channelId: channelId, // static for testing level..
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  bool _frontCamera = true;
  Future<void> switchCamera() async {
    _frontCamera = !_frontCamera;
    await agoraEngine.switchCamera();
    emit(SwitchCamera(frontCamera: _frontCamera));
  }

  bool _mute = false;
  Future<void> toggleMic() async {
    _mute = !_mute;
    await agoraEngine.muteLocalAudioStream(_mute);
    emit(MicToggle(isMuted: _mute));
  }

  Future<void> leaveChannel() async {
    await agoraEngine.leaveChannel();
    await agoraEngine.stopPreview();
  }

  void dispose() async {
    await leaveChannel();
    await agoraEngine.release();
  }

  
}
