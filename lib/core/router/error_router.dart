import 'package:flutter/material.dart';

import '../theme/colors/colors_manager.dart';

class ErrorRouter extends StatelessWidget {
  const ErrorRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager().colorScheme.fillRed,
      body: const Center(
        child: Text('HIIIII, There is no router like this '),
      ),
    );
  }
}
