import 'package:flutter/material.dart';
import 'package:just_chat/core/theme/colors/colors_manager.dart';

class PopMenuComponent extends StatelessWidget {
  final Object? initialValue;
  final List<PopupMenuEntry<Object?>> items;
  const PopMenuComponent({
    super.key,
    required this.initialValue,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: ColorsManager().colorScheme.background,
      padding: EdgeInsets.zero,
      initialValue: initialValue,
      icon: Icon(
        Icons.keyboard_arrow_down_outlined,
        color: ColorsManager().colorScheme.grey40,
      ),
      iconSize: 30,
      itemBuilder: (context) => items,
    );
  }
}