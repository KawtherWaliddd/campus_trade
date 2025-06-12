import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/chat/data/models/message_model.dart';
import 'package:flutter_application_1/features/chat/presentation/widgets/chat_app_bar.dart';
import 'package:flutter_application_1/features/chat/presentation/widgets/chat_bubble.dart';
import 'package:flutter_application_1/features/chat/presentation/widgets/chat_bubble_with_other.dart';
import 'package:flutter_application_1/features/chat/presentation/widgets/message_send.dart';

class ConversationScreen extends StatelessWidget {
  final String receiverEmail;
  ConversationScreen({super.key, required this.receiverEmail});

  final TextEditingController messageController = TextEditingController();
  final ScrollController listController = ScrollController();

  final CollectionReference messages = FirebaseFirestore.instance.collection(
    'messages',
  );

  @override
  Widget build(BuildContext context) {
    var myEmail = FirebaseAuth.instance.currentUser!.email!;

    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('timestamp', descending: false).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<MessageModel> messageList = snapshot.data!.docs
              .map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                return MessageModel.fromjson(data);
              })
              .where(
                (msg) =>
                    (msg.senderId == myEmail &&
                        msg.receiverId == receiverEmail) ||
                    (msg.senderId == receiverEmail &&
                        msg.receiverId == myEmail),
              )
              .toList();

          return Scaffold(
            appBar: ChatAppBar(title: receiverEmail),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: listController,
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      final message = messageList[index];
                      return myEmail == message.senderId
                          ? ChatBubble(messageModel: message)
                          : ChatBubbleWithOther(messageModel: message);
                    },
                  ),
                ),
                MessageSend(
                  messages: messages,
                  id: myEmail,
                  messageController: messageController,
                  listController: listController,
                  receiverId: receiverEmail,
                ),
              ],
            ),
          );
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Has Error'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
