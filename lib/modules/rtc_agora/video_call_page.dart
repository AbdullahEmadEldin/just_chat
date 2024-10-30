import 'dart:ui';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/helpers/extensions.dart';
import 'package:just_chat/modules/rtc_agora/view/widgets/switch_camera_button.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../core/theme/colors/colors_manager.dart';
import '../messages/view/pages/messaging_page.dart';
import 'agora_service_cubit/agora_service_cubit.dart';
import 'view/widgets/toggle_mic_button.dart';

class VideoCallPage extends StatefulWidget {
  static const String routeName = '${MessagingPage.routeName}/video_call_page';
  final String channelId;
  const VideoCallPage({
    super.key,
    required this.channelId,
  });

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  late AgoraServiceCubit _agoraServiceCubit;

  @override
  void initState() {
    super.initState();
    _agoraServiceCubit = context.read<AgoraServiceCubit>();
    _agoraServiceCubit.requestVideoCalPermission();
    _agoraServiceCubit.initAgoraEngine();
  }

  @override
  void dispose() {
    _agoraServiceCubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager().colorScheme.primary20,
      body: Stack(
        children: [
          _remoteVideo(),
          _localVideo(),
          _toolbar(context),
        ],
      ),
    );
  }

  Widget _localVideo() {
    return BlocBuilder<AgoraServiceCubit, AgoraServiceState>(
      buildWhen: (previous, current) => current is LocalUserJoined,
      builder: (context, state) {
        return Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: 100.w,
            height: 150.h,
            child: Center(
              child: state is LocalUserJoined
                  ? AgoraVideoView(
                      controller: VideoViewController(
                        rtcEngine: _agoraServiceCubit.agoraEngine,
                        canvas: const VideoCanvas(uid: 0),
                      ),
                    )
                  : Shimmer(
                      duration: const Duration(milliseconds: 900),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: ColorsManager().colorScheme.grey70,
                        ),
                        width: 100.w,
                        height: 150.h,
                      )),
            ),
          ),
        );
      },
    );
  }

  // Display remote user's video
  Widget _remoteVideo() {
    return Center(
      child: BlocBuilder<AgoraServiceCubit, AgoraServiceState>(
        buildWhen: (previous, current) =>
            current is RemoteUserJoined || current is RemoteUserOffline,
        builder: (context, state) {
          int? remoteUid;
          if (state is RemoteUserOffline) {
            remoteUid = state.remoteUid;
            return Text(
              'User Has left the Call',
              style: Theme.of(context).textTheme.bodyLarge,
            );
          }
          if (state is RemoteUserJoined) {
            remoteUid = state.remoteUid;
          }
          return remoteUid != null
              ? AgoraVideoView(
                  controller: VideoViewController.remote(
                    rtcEngine: _agoraServiceCubit.agoraEngine,
                    canvas: VideoCanvas(uid: remoteUid),
                    connection:
                        RtcConnection(channelId: _agoraServiceCubit.channelId),
                  ),
                )
              : Text(
                  'Please wait for remote user to join',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                );
        },
      ),
    );
  }

  Widget _toolbar(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        margin: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 20,
              sigmaY: 20,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () => _agoraServiceCubit.switchCamera(),
                      child: const SwitchCameraButton()),
                  InkWell(
                      onTap: () => _agoraServiceCubit.toggleMic(),
                      child: const ToggleMicButton()),
                  _endCallButton(
                    onTap: () => context.pop(),
                    containerColor: ColorsManager().colorScheme.fillRed,
                    icon: Icons.call_end_rounded,
                    iconColors: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _endCallButton({
    required Color containerColor,
    required IconData icon,
    Color? iconColors,
    required Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: containerColor,
        ),
        child: Icon(
          icon,
          color: iconColors,
        ),
      ),
    );
  }
}
