import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_chat/modules/add_friends/logic/cubit/add_friends_cubit.dart';
import 'package:just_chat/modules/add_friends/view/widgets/search_result_tile.dart';

class SearchBlocBuilder extends StatelessWidget {
  const SearchBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddFriendsCubit, AddFriendsState>(
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
            itemBuilder: (context, index) => SearchResultTile(
              user: results[index],
            ),
          ),
        );
      } else if (state is SearchForFriendsFailure) {
        return Center(
          child: Text(state.errorMsg),
        );
      } else {
        return Center(
          child: Text(state.toString()),
        );
      }
    });
  }
}
