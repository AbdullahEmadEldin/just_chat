import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/colors/colors_manager.dart';
import '../../agora_service_cubit/agora_service_cubit.dart';

class ToggleMicButton extends StatelessWidget {
  const ToggleMicButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgoraServiceCubit, AgoraServiceState>(
      buildWhen: (previous, current) => current is MicToggle,
      builder: (context, state) {
        final bool mute = state is MicToggle ? state.isMuted : false;
        return Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: mute ? Colors.white : ColorsManager().colorScheme.grey50,
          ),
          child: Icon(
            Icons.mic_off_outlined,
            color:  mute ? ColorsManager().colorScheme.fillRed : null,
          ),
        );
       
      },
    );
  }
}
