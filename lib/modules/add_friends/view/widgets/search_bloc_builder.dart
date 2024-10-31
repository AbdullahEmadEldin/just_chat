import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/di/dependency_injection.dart';
import 'package:just_chat/modules/add_friends/logic/cubit/search_for_friends_cubit.dart';
import 'package:just_chat/modules/add_friends/view/widgets/search_result_tile.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/loties_assets.dart';

class SearchBlocBuilder extends StatelessWidget {
  const SearchBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchForFriendsCubit, AddFriendsState>(
        builder: (context, state) {
      if (state is SearchForFriendsLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is SearchForFriendsSuccess) {
        final results = state.usersResults;
        if (results.isEmpty) {
          return const Center(
            child: Text('No Results Found'),
          );
        }
        return Expanded(
          child: ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final isMyPhone = _myPhoneBool(results[index].uid);
              return SearchResultTile(
                user: results[index],
                isMyPhone: isMyPhone,
              );
            },
          ),
        );
      } else if (state is SearchForFriendsFailure) {
        return Center(
          child: Text(state.errorMsg),
        );
      } else {
        return _initialStateUI(context);
      }
    });
  }

  Center _initialStateUI(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 64.h),
          LottieBuilder.asset(LottiesAssets.chatBubble),
          SizedBox(height: 16.h),
          Text(
            'Start a new chat...',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  bool _myPhoneBool(String searchResultId) {
    if (getIt<FirebaseAuth>().currentUser!.uid == searchResultId) return true;
    return false;
  }
}
