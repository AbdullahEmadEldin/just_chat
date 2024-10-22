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
        ],
      ),
    );
  }
}

