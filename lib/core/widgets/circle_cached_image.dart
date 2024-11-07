import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/constants/image_assets.dart';
import 'package:just_chat/core/helpers/extensions.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../theme/colors/colors_manager.dart';

class CircleCachedImage extends StatelessWidget {
  final String? imageUrl;
  const CircleCachedImage({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isNullOrEmpty()) {
      // Display a placeholder directly if URL is empty
      return CircleAvatar(
        radius: 28.r,
        backgroundImage: const AssetImage(ImagesAssets.profileHolder),
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl!,
      height: 56.h,
      width: 56.w,
      imageBuilder: (context, imageProvider) => Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          backgroundImage: imageProvider,
        ),
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) => Shimmer(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32.r),
            color: ColorsManager().colorScheme.primary20,
          ),
        ),
      ),
      errorWidget: (context, url, error) =>
          Image.asset(ImagesAssets.profileHolder),
    );
  }
}
