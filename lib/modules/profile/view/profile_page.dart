import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/widgets/shimmers/uploading_audio_shimmer.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

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
      body: Stack(
        children: [
          const Center(child: UploadingAudioShimmer()),
          // ElevatedButton(
          //     onPressed: () {
          //       FirebaseGeneralServices.logout();
          //     },
          //     child: const Text('Logout')),
          Shimmer(
              duration: const Duration(milliseconds: 900),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: ColorsManager().colorScheme.grey70,
                ),
                width: 100.w,
                height: 150.h,
              )),
        ],
      ),
    );
  }
}
