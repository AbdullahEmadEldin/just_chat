import 'package:flutter/material.dart';

class AllChatsPage extends StatelessWidget {
  static const routeName = '/all_chats_page';
  const AllChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text('All Chats Page'),
    ));
  }
}
