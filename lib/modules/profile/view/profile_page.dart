import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/widgets/shimmers/uploading_audio_shimmer.dart';
import 'package:just_chat/modules/messages/view/widgets/sending_widgets/messaging_field.dart';
import 'package:ripple_wave/ripple_wave.dart';

import '../../../core/theme/colors/colors_manager.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager().colorScheme.primary20,
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: UploadingAudioShimmer()),
          //IconSwitcherButton(),
          PlayPauseButtons(audioPlay: false, audioUrl: ''),
        ],
      ),
    );
  }
}

class PlayPauseButtons extends StatefulWidget {
  final bool audioPlay;
  final String audioUrl;
  const PlayPauseButtons({
    super.key,
    required this.audioPlay,
    required this.audioUrl,
  });

  @override
  State<PlayPauseButtons> createState() => _PlayPauseButtonsState();
}

class _PlayPauseButtonsState extends State<PlayPauseButtons> {
  bool switchToPause = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          switchToPause = !switchToPause;
        });
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        child: switchToPause
            ? Icon(
                key: const ValueKey('pause'),
                Icons.pause,
                color: ColorsManager().colorScheme.fillPrimary,
                size: 24.r,
              )
            : Icon(
                key: const ValueKey('playIcon'),
                Icons.play_arrow,
                color: ColorsManager().colorScheme.fillPrimary,
                size: 24.r,
              ),
      ),
    );
  }
}
