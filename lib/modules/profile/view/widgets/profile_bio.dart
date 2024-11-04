import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/modules/auth/data/models/user_model.dart';
import 'package:just_chat/modules/auth/logic/user_data_cubit/user_data_cubit.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../../core/theme/colors/colors_manager.dart';
import '../../../../core/widgets/input_feild.dart';

class ProfileBio extends StatefulWidget {
  final UserModel user;
  final bool loading;
  const ProfileBio({
    super.key,
    required this.user,
    required this.loading,
  });

  @override
  State<ProfileBio> createState() => _ProfileBioState();
}

class _ProfileBioState extends State<ProfileBio> {
  final FocusNode bioFocusNode = FocusNode();
  late TextEditingController bioController =
      TextEditingController(text: widget.user.bio);
  bool readOnly = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Bio',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: ColorsManager().colorScheme.grey60,
                  ),
            ),
            IconButton(
              onPressed: () {
                bioFocusNode.requestFocus();
                setState(() {
                  if (!readOnly) {
                    BlocProvider.of<UserDataCubit>(context).updateUserData(
                      widget.user.copyWith(
                        bio: bioController.text,
                      ),
                    );
                  }
                  readOnly = !readOnly;
                });
              },
              icon: Shimmer(
                duration: const Duration(seconds: 2),
                enabled: widget.loading,
                child: Icon(
                  readOnly ? Icons.edit : Icons.check,
                  color: readOnly
                      ? ColorsManager().colorScheme.grey60
                      : ColorsManager().colorScheme.fillGreen,
                  size: 20.r,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        InputField(
          focusNode: bioFocusNode,
          backgroundColor: ColorsManager().colorScheme.background,
          controller: bioController,
          hintText: 'Enter your bio...',
          maxLines: 4,
        ),
      ],
    );
  }
}
