//enum contentUser { OK, BOOKING, CANCELREQUEST, CANCELTRIP }

// enum ContentDriver { OK, ACPECT, KETTHUC }

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

  void changeMessage(String content) {
    // if (content == ContentDriver.ACPECT || content == ContentDriver.OK) {
    //   type = Type.private;
    //   driverModel.changeStatusWithMessage("ACPECT");
    // }
    // if (content == ContentDriver.KETTHUC) {
    //   type = Type.public;
    //   driverModel.changeStatusWithMessage("ENDTRIP");
    // }
  }
}
