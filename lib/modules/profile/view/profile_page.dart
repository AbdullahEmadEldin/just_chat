import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/widgets/shimmers/profile_page_shimmer.dart';
import 'package:just_chat/modules/auth/logic/user_data_cubit/user_data_cubit.dart';

import '../../../core/theme/colors/colors_manager.dart';
import 'widgets/profie_body.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsManager().colorScheme.primary80,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 36.h),
            height: MediaQuery.of(context).size.height * 0.91,
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorsManager().colorScheme.background,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(42.r),
                bottomRight: Radius.circular(42.r),
              ),
            ),
            child: BlocBuilder<UserDataCubit, UserDataState>(
                buildWhen: (previous, current) =>
                    current is GetUserDataSuccess ||
                    current is GetUserDataFailure ||
                    current is GetUserDataLoading,
                builder: (context, state) {
                  if (state is GetUserDataSuccess) {
                    return Column(
                      children: [
                        ProfileHeader(user: state.userModel),
                      ],
                    );
                  }
                  return const ProfileShimmer();
                }),
          ),
        ));
  }
}
