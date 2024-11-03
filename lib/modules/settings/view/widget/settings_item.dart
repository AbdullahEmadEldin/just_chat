import 'package:flutter/material.dart';


class SettingsItem extends StatelessWidget {
  final String title;
  final IconData suffixIconData;
  final Widget actionIcon;
  const SettingsItem({
    super.key,
    required this.title,
    required this.suffixIconData,
    required this.actionIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Icon(
                suffixIconData,
                color: Colors.white,
              ),
              const SizedBox(width: 4),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
            ],
          ),
        ),
        actionIcon,
      ],
    );
  }
}
