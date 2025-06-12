import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/resources/color_manager.dart';
import 'package:flutter_application_1/core/utils/resources/image_manager.dart';
import 'package:flutter_application_1/core/utils/resources/text_styles.dart';
import 'package:flutter_application_1/features/chat/presentation/view/conversation_screen.dart';

class ChatCard extends StatelessWidget {
  final String email;

  const ChatCard({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConversationScreen(receiverEmail: email),
          ),
        );
      },
      child: ListTile(
        leading: const CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(ImageManager.ellipse),
        ),
        title: Text(email, style: TextStyles.black16Regular),
        subtitle: Text(
          'Tap to continue chat...',
          style: TextStyles.white14regulare.copyWith(
            overflow: TextOverflow.ellipsis,
            color: ColorManager.blackColor,
          ),
        ),
        trailing: Text(DateTime.now().toString()),
      ),
    );
  }
}
