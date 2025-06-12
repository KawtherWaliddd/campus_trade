import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'chat_card.dart';

class ChatCardList extends StatelessWidget {
  const ChatCardList({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserEmail = FirebaseAuth.instance.currentUser!.email!;
    final messages = FirebaseFirestore.instance.collection('messages');

    return StreamBuilder<QuerySnapshot>(
      stream: messages.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final docs = snapshot.data!.docs;

          final Set<String> usersChattedWith = {};

          for (var doc in docs) {
            final data = doc.data() as Map<String, dynamic>;
            if (data['id'] == currentUserEmail) {
              usersChattedWith.add(data['receiverId']);
            } else if (data['receiverId'] == currentUserEmail) {
              usersChattedWith.add(data['id']);
            }
          }

          if (usersChattedWith.isEmpty) {
            return const Center(child: Text("No chats yet"));
          }

          return ListView(
            children: usersChattedWith.map((email) {
              return ChatCard(email: email); 
            }).toList(),
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text("Something went wrong"));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
