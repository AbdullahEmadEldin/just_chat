import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_chat/modules/chat/data/models/chat_model.dart';
import 'package:just_chat/modules/chat/logic/all_chats_cubit/all_chats_cubit.dart';
import 'package:just_chat/modules/chat/view/widgets/all_chats_widgets/chat_tile.dart';


//! Close the stream...............................................
class AllChatsBody extends StatelessWidget {
  const AllChatsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      //? Why not using BlocBuilder instead of StreamBuilder?
      // Using blocBuilder will be more expensive as it will load all chats each time a new chat is added.
      stream: context.read<AllChatsCubit>().getAllChats(),
      builder: (context, snapshot) {
        //TODO Handle loading, empty and error states with lotties.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _handleWaitingSnapshot();
        }
        if (snapshot.hasError) {
          _handleErrorSnapshot(snapshot.error.toString());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          _handleEmptySnapshot();
        }

        var chats = snapshot.data!;
        return Expanded(
          child: ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              _getOpponentUserInfoForChatTile(context,
                  chatMembers: chats[index].members);
              return _chatTileBlocBuilder(chats, index);
            },
          ),
        );
      },
    );
  }

  BlocBuilder<AllChatsCubit, AllChatsState> _chatTileBlocBuilder(
    List<ChatModel> chats,
    int index,
  ) {
    return BlocBuilder<AllChatsCubit, AllChatsState>(
      builder: (context, state) {
        if (state is GettingOppUserInfoLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GettingOppUserInfoSuccess) {
          return ChatTile(
            chat: chats[index],
            opponentUser: context.read<AllChatsCubit>().opponentUser!,
          );
        } else if (state is GettingOppUserInfoFailure) {
          return Center(child: Text(state.toString()));
        } else {
          return Center(child: Text(state.toString()));
        }
      },
    );
  }

  _getOpponentUserInfoForChatTile(
    BuildContext context, {
    required List<String> chatMembers,
  }) {
    context
        .read<AllChatsCubit>()
        .getOpponentUserInfoForChatTile(chatMembers: chatMembers);
  }

  Widget _handleWaitingSnapshot() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _handleEmptySnapshot() {
    return const Center(child: Text('No Chats found.'));
  }

  Widget _handleErrorSnapshot(String error) {
    return Center(child: Text('Error: $error'));
  }
}
