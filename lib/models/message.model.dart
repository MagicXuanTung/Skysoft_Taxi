enum Type { public, private }

class MessageModel {
  bool isServer;
  String content;
  String sender;
  String receiver;
  Type type;

  MessageModel({
    required this.content,
    required this.sender,
    required this.receiver,
    this.type = Type.public,
    this.isServer = false,
  });
}
