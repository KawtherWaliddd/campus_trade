import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/resources/color_manager.dart';
import 'package:flutter_application_1/core/utils/resources/text_styles.dart';
import 'package:flutter_application_1/features/chat/data/models/message_model.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.messageModel});
  final MessageModel messageModel;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: ColorManager.SecondaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: Text(messageModel.message, style: TextStyles.White16Meduim),
      ),
    );
  }
}
