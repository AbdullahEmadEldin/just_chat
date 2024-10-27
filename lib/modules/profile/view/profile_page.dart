import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_chat/core/widgets/shimmers/uploading_audio_shimmer.dart';

import '../../../core/services/firestore_service.dart';
import '../../../core/theme/colors/colors_manager.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager().colorScheme.primary20,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(child: UploadingAudioShimmer()),
          ElevatedButton(
              onPressed: () {
                FirebaseGeneralServices.logout();
              },
              child: const Text('Logout'))
        ],
      ),
    );
  }
}
