import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_chat/modules/chat/logic/all_chats_cubit/all_chats_cubit.dart';
import 'package:just_chat/modules/chat/view/widgets/all_chats_widgets/chat_tile.dart';

class AllChatsBody extends StatelessWidget {
  const AllChatsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      //? Why not using BlocBuilder instead of StreamBuilder?
      // Using blocBuilder will be more expensive as it will load all chats each time a new chat is added.
      stream: context.read<AllChatsCubit>().getAllChats(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No Chats found.'));
        }

        var chats = snapshot.data!;

        return Expanded(
          child: ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {

              return ChatTile(
                chat: chats[index],
            
              );
            },
          ),
        );
      },
    );
  }


}
