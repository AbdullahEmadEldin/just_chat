import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/constants/loties_assets.dart';

class ImageMsgTile extends StatelessWidget {
  final String imageUrl;
  final bool inReply;
  const ImageMsgTile({
    super.key,
    required this.imageUrl,
    this.inReply = false,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Padding(
        padding: EdgeInsets.only(top: 4.h),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Image(
            height: inReply ? 100.h : null,
            width: inReply ? 100.w : null,
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      progressIndicatorBuilder: (context, url, progress) => Center(
        child: Lottie.asset(LottiesAssets.loadingChat,
            width: 100.w, height: 100.h),
      ),
    );
  }
}
