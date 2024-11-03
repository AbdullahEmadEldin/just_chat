import 'package:flutter/material.dart';
import 'package:just_chat/core/theme/colors/colors_manager.dart';

import '../../../../core/constants/image_assets.dart';

class ValueSwitcher extends StatefulWidget {
  final Function(bool)? onChanged;
  final bool value;
  const ValueSwitcher({
    super.key,
    required this.onChanged,
    required this.value,
  });

  @override
  State<ValueSwitcher> createState() => _ValueSwitcherState();
}

class _ValueSwitcherState extends State<ValueSwitcher> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Transform.scale(
        scale: 1.4,
        child: Switch(
          splashRadius: 40,
          activeTrackColor: ColorsManager().colorScheme.black,
          inactiveTrackColor:
              ColorsManager().colorScheme.fillRed.withOpacity(0.2),
          thumbColor: WidgetStateProperty.all(Colors.redAccent
              .withOpacity(0.8)), 
          trackOutlineColor:
              WidgetStateProperty.resolveWith((final Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return null;
            } else {
              return Colors.transparent;
            }
          }),
          value: widget.value,
          activeThumbImage: const AssetImage(ImagesAssets.nightMode),
          inactiveThumbImage: const AssetImage(ImagesAssets.lightMode),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
