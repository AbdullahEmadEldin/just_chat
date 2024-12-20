import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_chat/core/constants/app_strings.dart';
import 'package:just_chat/core/constants/image_assets.dart';
import 'package:just_chat/core/di/dependency_injection.dart';
import 'package:just_chat/core/helpers/extensions.dart';
import 'package:just_chat/core/helpers/network_helper.dart';
import 'package:just_chat/core/widgets/input_feild.dart';
import 'package:just_chat/core/widgets/main_button.dart';
import 'package:just_chat/modules/auth/data/models/user_model.dart';
import 'package:just_chat/modules/auth/logic/user_data_cubit/user_data_cubit.dart';
import 'package:just_chat/modules/auth/view/page/phone_auth_page.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/loties_assets.dart';
import '../../../../core/services/firebase_notifiaction/firebase_cloud_msgs.dart';
import '../../../../core/theme/colors/colors_manager.dart';
import '../../../../core/widgets/app_logo.dart';
import '../../../nav_bar/custom_nav_bar.dart';
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
                AppStrings.name.tr(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: ColorsManager().colorScheme.grey60,
                    ),
              ),
              SizedBox(height: 8.h),
              InputField(
                hintText: AppStrings.enterYourName.tr(),
                controller: nameController,
                validator: (p0) {
                  if (p0.isNullOrEmpty()) {
                    return AppStrings.requiredField.tr();
                  }
                  return null;
                },
              ),
              SizedBox(height: 12.h),
              Text(
                AppStrings.phone.tr(),
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
                AppStrings.bio.tr(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: ColorsManager().colorScheme.grey60,
                    ),
              ),
              SizedBox(height: 8.h),
              InputField(
                controller: bioController,
                hintText: AppStrings.enterYourBio.tr(),
                maxLines: 4,
              ),
              SizedBox(height: 42.h),
              //! Upload Data to firebase button

              BlocConsumer<UserDataCubit, UserDataState>(
                listener: (context, state) {
                  if (state is SetUserDataLoading) {
                    print('**************************');
                    showDialog(
                      context: context,
                      builder: (context) => Center(
                        child: Lottie.asset(LottiesAssets.loadingChat,
                            width: 250.w),
                      ),
                    );
                  } else if (state is SetUserDataSuccess) {
                    Navigator.pop(context);
                    context.pushReplacementNamed(CustomNavBar.routeName);
                  } else if (state is SetUserDataFailure) {
                    Navigator.pop(context);
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: AppStrings.errorOccurred.tr(),
                        desc: state.errorMsg,
                        btnOkOnPress: () {},
                      ).show();
                    });
                  }
                },
                builder: (context, state) => MainButton(
                  title: state is SetUserDataLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          AppStrings.continueText.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.white),
                        ),
                  onPressed: () async {
                    Stream.fromFutures([
                      _uploadUserData(context),
                      FcmService.setupInteractedMessage(),
                    ]);
                  },
                ),
              )
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
            isOnline: true,
            phoneNumber: getIt<PhoneAuthInfo>().phoneNumber!,
            bio: bioController.text,
            profilePicUrl:
                await NetworkHelper.uploadFileToFirebase(profilePic!.path),
          ),
        );
  }
}
