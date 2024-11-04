import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_chat/core/helpers/network_helper.dart';
import 'package:just_chat/core/theme/colors/colors_manager.dart';
import 'package:just_chat/modules/auth/logic/user_data_cubit/user_data_cubit.dart';
import 'package:just_chat/modules/profile/view/widgets/profile_bio.dart';
import 'package:just_chat/modules/profile/view/widgets/profile_phone_number.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../../core/helpers/ui_helpers.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/view/widgets/fill_data/profile_pic_avatar.dart';

class ProfileHeader extends StatefulWidget {
  final UserModel user;
  const ProfileHeader({
    super.key,
    required this.user,
  });

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  XFile? newProfilePic;
  // edit name vars
  late TextEditingController nameController =
      TextEditingController(text: widget.user.name);
  final FocusNode nameFocusNode = FocusNode();
  //
  bool nameReadOnly = true;

  bool _picSelection = false;
  //
  late UserDataCubit userDataCubit;

  @override
  void initState() {
    userDataCubit = BlocProvider.of<UserDataCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserDataCubit, UserDataState>(
      listener: (context, state) {
        if (state is UpdateUserDataSuccess) {
          userDataCubit.getUserData();
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: UiHelper.getResponsiveDimension(
                  context,
                  baseDimension: 48.h,
                ),
              ),
              Center(
                child: ProfilePicAvatar(
                  isLoading: state is UpdateUserDataLoading,
                  checkIcon: _picSelection,
                  profileAvatar: _picSelection
                      ? FileImage(
                          File(newProfilePic!.path),
                        )
                      : NetworkImage(widget.user.profilePicUrl!),
                  onPressed: () async {
                    XFile? pic;

                    /// _picSelection is the action controller to avoid multiple actions on the same click
                    /// It act as a button switcher as it two button with two different actions and icons.
                    if (!_picSelection) {
                      pic = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      // this condition to avoid error if user didn't pick an image after opening the gallery.
                      if (pic == null) return;
                      _picSelection = true;

                      setState(() {
                        log('messages screen: Pic editing ');

                        newProfilePic = pic;
                      });

                      //
                    } else {
                      // upload the pic to backend
                      await userDataCubit.updateUserData(
                        widget.user.copyWith(
                          profilePicUrl:
                              await NetworkHelper.uploadProfileImageToFirebase(
                            newProfilePic!,
                          ),
                        ),
                      );
                      setState(() {
                        _picSelection = false;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: IntrinsicWidth(
                  child: _nameTextField(context, state),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Phone Number',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: ColorsManager().colorScheme.grey60,
                    ),
              ),
              SizedBox(height: 8.h),
              ProfilePhoneNumber(phoneNumber: widget.user.phoneNumber),
              SizedBox(height: 12.h),
              ProfileBio(
                user: widget.user,
                loading: state is UpdateUserDataLoading,
              ),
            ],
          ),
        );
      },
    );
  }

  TextField _nameTextField(BuildContext context, UserDataState state) {
    return TextField(
      readOnly: nameReadOnly,
      focusNode: nameFocusNode,
      controller: nameController,
      style: Theme.of(context).textTheme.headlineLarge,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              // focus the text field when user wants to edit the name
              nameFocusNode.requestFocus();

              if (!nameReadOnly) {
                log('messages screen: name editing done');
                userDataCubit.updateUserData(
                  widget.user.copyWith(
                    name: nameController.text,
                  ),
                );
              }
              nameReadOnly = !nameReadOnly;
            });
          },
          icon: Shimmer(
            duration: const Duration(seconds: 2),
            enabled: state is UpdateUserDataLoading,
            child: Icon(
              nameReadOnly ? Icons.edit : Icons.check,
              color: ColorsManager().colorScheme.grey60,
              size: 25.r,
            ),
          ),
        ),
        border: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
      ),
    );
  }
}
