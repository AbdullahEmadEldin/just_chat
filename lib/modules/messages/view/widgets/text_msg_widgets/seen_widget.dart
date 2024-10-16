import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_chat/core/constants/image_assets.dart';

import '../../../../../core/theme/colors/colors_manager.dart';

class SeenWidget extends StatelessWidget {
  final bool isSeen;
  const SeenWidget({
    super.key,
    required this.isSeen,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      isSeen ? ImagesAssets.seenSvg : ImagesAssets.checkMrkSvg,
      color: isSeen
          ? ColorsManager().colorScheme.fillGreen
          : ColorsManager().colorScheme.grey40,
    );
  }
}
