import 'package:flutter/material.dart';

import '../widgets/chat_card_list.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ChatCardList(),
    );
  }
}
