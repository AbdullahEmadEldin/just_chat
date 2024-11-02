import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_chat/core/constants/loties_assets.dart';
import 'package:just_chat/core/widgets/shimmers/chat_tile_shimmer.dart';
import 'package:just_chat/modules/chat/logic/friend_chat_cubit/friend_chat_cubit.dart';
import 'package:just_chat/modules/chat/view/widgets/chat_tile.dart';
import 'package:lottie/lottie.dart';

class FriendsChatBody extends StatefulWidget {
  const FriendsChatBody({super.key});

  @override
  State<FriendsChatBody> createState() => _FriendsChatBodyState();
}

class _FriendsChatBodyState extends State<FriendsChatBody> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendsChatCubit, FriendsChatState>(
      buildWhen: (previous, current) =>
          current is GetChatsSuccess ||
          current is GetChatsFailure ||
          current is GetChatsLoading,
      builder: (context, state) {
        if (state is GetChatsLoading) {
          return _handleLoadingChats();
        } else if (state is GetChatsSuccess) {
          if (state.chats.isEmpty) return _handleEmptySnapshot();
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: ListView.builder(
              itemCount: state.chats.length,
              itemBuilder: (context, index) {
                return ChatTile(
                  chat: state.chats[index],
                  opponentUser: state.opponentUsers[index],
                  unreadMsgsCount: state.unreadMsgsCount[index],
                );
              },
            ),
          );
        } else if (state is GetChatsFailure) {
          return _handleErrorSnapshot(state.error);
        }
        return Text('WHAT THE FUCK===> ${state.runtimeType}');
      },
    );
  }

  Widget _handleLoadingChats() {
    return const ChatTileShimmerList();
  }

  Widget _handleEmptySnapshot() {
    return Center(child: Lottie.asset(LottiesAssets.chatBubble));
  }

  Widget _handleErrorSnapshot(String error) {
    return Center(child: Text('Error: $error'));
  }
}
