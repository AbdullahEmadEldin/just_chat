import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_chat/core/constants/loties_assets.dart';
import 'package:just_chat/core/widgets/shimmers/chat_tile_shimmer.dart';
import 'package:just_chat/modules/chat/logic/all_chats_cubit/all_chats_cubit.dart';
import 'package:just_chat/modules/chat/view/widgets/chat_tile.dart';
import 'package:lottie/lottie.dart';

class AllChatsBody extends StatefulWidget {
  const AllChatsBody({super.key});

  @override
  State<AllChatsBody> createState() => _AllChatsBodyState();
}

class _AllChatsBodyState extends State<AllChatsBody> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllChatsCubit, AllChatsState>(
      builder: (context, state) {
        if (state is GetChatsLoading) {
          return _handleLoadingChats();
        } else if (state is GetChatsSuccess) {
          if (state.chats.isEmpty) return _handleEmptySnapshot();
          return Expanded(
            child: ListView.builder(
              itemCount: state.chats.length,
              itemBuilder: (context, index) {
                print('index ::: ${index}');
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
        return Text('WHAT THE FUCK');
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
