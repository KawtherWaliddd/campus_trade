class MessageModel {
  final String message;
  final String senderId;
  final String receiverId;

  MessageModel({required this.message, required this.senderId, required this.receiverId});

 factory  MessageModel.fromjson(Map<String, dynamic> json) {
    return MessageModel(
      message: json['message'],
      senderId: json['id'],
      receiverId: json['receiverId'],
    );
  }
}
