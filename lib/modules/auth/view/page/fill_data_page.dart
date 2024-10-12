import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_chat/core/constants/image_assets.dart';
import 'package:just_chat/core/di/dependency_injection.dart';
import 'package:just_chat/core/helpers/extensions.dart';
import 'package:just_chat/core/helpers/network_helper.dart';
import 'package:just_chat/core/widgets/input_feild.dart';
import 'package:just_chat/core/widgets/main_button.dart';
import 'package:just_chat/modules/auth/data/models/user_model.dart';
import 'package:just_chat/modules/auth/logic/user_data_cubit/user_data_cubit.dart';
import 'package:just_chat/modules/auth/view/page/phone_auth_page.dart';
import 'package:just_chat/modules/auth/view/widgets/fill_data/fill_data_bloc_listener.dart';

import '../../../../core/theme/colors/colors_manager.dart';
import '../../../../core/widgets/app_logo.dart';
import '../widgets/fill_data/profile_pic_avatar.dart';

class FillDataPage extends StatefulWidget {
  static const String routeName = '${PhoneAuthPage.routeName}/fill_data_page';
  const FillDataPage({super.key});

  @override
  State<FillDataPage> createState() => _FillDataPageState();
}

class _FillDataPageState extends State<FillDataPage> {
  bool isImageSelected = false;
  XFile? profilePic;

  //
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              const AppLogo(),
              Center(
                child: ProfilePicAvatar(
                  profileAvatar: profilePic == null
                      ? const AssetImage(ImagesAssets.profileHolder)
                      : FileImage(File(profilePic!.path)),
                  onPressed: () async {
                    final pic = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    profilePic = pic;
                    setState(() {});
                    // this condition to avoid error if user didn't pick an image after opening the gallery.
                    if (pic == null) return;
                  },
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Name',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: ColorsManager().colorScheme.grey60,
                    ),
              ),
              SizedBox(height: 8.h),
              InputField(
                hintText: 'Enter your name',
                controller: nameController,
                validator: (p0) {
                  if (p0.isNullOrEmpty()) {
                    return 'required field';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12.h),
              Text(
                'Phone',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: ColorsManager().colorScheme.grey60,
                    ),
              ),
              SizedBox(height: 8.h),
              InputField(
                hintText: getIt<PhoneAuthInfo>().phoneNumber!,
                readOnly: true,
              ),
              SizedBox(height: 12.h),
              Text(
                'Bio',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: ColorsManager().colorScheme.grey60,
                    ),
              ),
              SizedBox(height: 8.h),
              InputField(
                controller: bioController,
                hintText: 'Enter your bio...',
                maxLines: 4,
              ),
              SizedBox(height: 42.h),
              //! Upload Data to firebase button
              MainButton(
                title: Text(
                  'Continue',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white),
                ),
                onPressed: () async {
                  await _uploadUserData(context);
                },
              ),
              const FillDataBlocListener()
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _uploadUserData(BuildContext context) async {
    context.read<UserDataCubit>().setUserData(
          UserModel(
            uid: getIt<FirebaseAuth>().currentUser!.uid,
            name: nameController.text,
            phoneNumber: getIt<PhoneAuthInfo>().phoneNumber!,
            bio: bioController.text,
            profilePicUrl:
                await NetworkHelper.uploadProfileImageToFirebase(profilePic),
          ),
        );
  }
}
