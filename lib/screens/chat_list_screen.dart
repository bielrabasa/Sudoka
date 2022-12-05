import 'package:flutter/material.dart';
import 'package:nodefirstproj/widgets/chat_list.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chats"),
      ),
      body: const ChatList(),
    );
  }
}