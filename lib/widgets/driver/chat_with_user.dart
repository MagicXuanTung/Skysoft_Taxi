import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:skysoft_taxi/global/global.dart';
import 'package:skysoft_taxi/url/contants.dart';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class ChatWithUserScreen extends StatefulWidget {
  const ChatWithUserScreen({Key? key}) : super(key: key);
  @override
  State createState() => ChatScreenState();
}

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

class ChatScreenState extends State<ChatWithUserScreen> {
  final FocusNode textFocus = FocusNode();
  final List<ChatMessage> messages = [];
  String formattedDate = DateTime.now().toString();
  final TextEditingController textController = TextEditingController();
  final channel = IOWebSocketChannel.connect("${URL_CHAT}TX_Duong");

  @override
  void initState() {
    super.initState();

    // // Gửi tin nhắn lên server khi màn hình được khởi tạo
    // channel.sink.add(jsonEncode(
    //     {"message": "Bắt đầu chat", "sender": "Guest", "received": ""}));

    channel.stream.listen((message) {
      // print("ChatScreen: " + message);

      final Map<String, dynamic> messageData = jsonDecode(message);
      final String receivedMessage = messageData['message'];

      // Thêm tin nhắn từ máy chủ vào danh sách messages
      messages.insert(0, ChatMessage(text: receivedMessage, isUser: false));
      setState(() {});
    });
  }

  @override
  void dispose() {
    channel.sink.close(status.goingAway);
    super.dispose();
  }

  // ignore: non_constant_identifier_names
  void SubmittedMessage(String text) {
    if (text.isNotEmpty) {
      messages.insert(0, ChatMessage(text: text, isUser: true));
      channel.sink.add(jsonEncode({
        "message": text,
        "sender": "Nguyễn Đức Dương",
        "received": formattedDate
      }));
      textController.clear();
      //test
      // Future.delayed(Duration(seconds: 1), () {
      //   setState(() {
      //     messages.insert(
      //         0, ChatMessage(text: 'Server response: $text', isUser: false));
      //   });
      // });
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: const Color.fromARGB(255, 57, 56, 56),
        title: Text(
          userModel.name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQm3RFDZM21teuCMFYx_AROjt-AzUwDBROFww&usqp=CAU',
              ),
            ),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            textFocus.unfocus();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                final message = messages[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: message.isUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: message.isUser
                              ? const Color.fromARGB(255, 57, 56, 56)
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          message.text,
                          style: TextStyle(
                              color: message.isUser
                                  ? Colors.grey[300]
                                  : const Color.fromARGB(255, 57, 56, 56)),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1.0),
          const SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      focusNode: textFocus,
                      controller: textController,
                      onSubmitted: SubmittedMessage,
                      decoration: InputDecoration(
                        hintText: 'Nhập tin nhắn...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  color: const Color.fromARGB(255, 57, 56, 56),
                  iconSize: 40,
                  icon: const Icon(Icons.send),
                  onPressed: () => SubmittedMessage(textController.text),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
