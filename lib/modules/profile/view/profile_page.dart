import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/widgets/shimmers/uploading_audio_shimmer.dart';
import 'package:just_chat/modules/messages/view/widgets/sending_widgets/messaging_field.dart';
import 'package:ripple_wave/ripple_wave.dart';

import '../../../core/theme/colors/colors_manager.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double width = 70, height = 70;

  bool showRipple = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager().colorScheme.primary20,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: UploadingAudioShimmer()),
        ],
      ),
    );
  }
}
