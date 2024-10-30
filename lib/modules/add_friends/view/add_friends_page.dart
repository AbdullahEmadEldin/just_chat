import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/widgets/input_feild.dart';
import 'package:just_chat/modules/add_friends/logic/cubit/add_friends_cubit.dart';
import 'package:just_chat/modules/add_friends/view/widgets/search_bloc_builder.dart';

import '../../../core/theme/colors/colors_manager.dart';

class SearchForFriendsPage extends StatelessWidget {
  static const String routeName = '/search_for_friends_page';
  const SearchForFriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager().colorScheme.primary80,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(42.r),
            bottomRight: Radius.circular(42.r),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 28.h),
            InputField(
              hintText: 'Search by phone number',
              suffixIcon: const Icon(Icons.search),
              onChanged: (p0) {
                context
                    .read<SearchForFriendsCubit>()
                    .searchForFriendByPhoneNumber(phoneNumber: p0);
              },
            ),
            const SearchBlocBuilder()
          ],
        ),
      ),
    );
  }
}
