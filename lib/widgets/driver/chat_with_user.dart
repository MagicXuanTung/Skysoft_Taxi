import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:skysoft_taxi/audiochat_widget/audio_message.dart';
import 'package:skysoft_taxi/audiochat_widget/input_voice.dart';
import 'package:skysoft_taxi/global/global.dart';
import 'package:skysoft_taxi/models/user.model.dart';
import 'package:skysoft_taxi/screen_test/globaltest.dart';
import 'package:skysoft_taxi/services/ChatService.dart';
import 'package:skysoft_taxi/view/message_view.dart';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class ChatWithUserScreen extends StatefulWidget {
  const ChatWithUserScreen({Key? key}) : super(key: key);
  @override
  State createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatWithUserScreen>
    with SingleTickerProviderStateMixin {
  final player = AudioPlayer();
  DateTime? time;
  final List<MessageView> messages = [];
  StreamSubscription<dynamic>? subscription;
  // final channel = IOWebSocketChannel.connect(
  //     URL_WS + driverModel.role + "_" + driverModel.name);

  @override
  void initState() {
    super.initState();
    getAll().then((value) {
      final resver = value.reversed;
      for (var element in resver) {
        messages.add(MessageView(
            content: element["chatId"],
            rightSide: element["name"] == userModel.name));
      }
      setState(() {});
    });
    if (subscription != null) {
      subscription = channel.stream.listen((message) {
        final Map<String, dynamic> messageData = jsonDecode(message);
        print(message);
        final String receivedMessage = messageData['message'];
        if (messageData["sender"] == driverModel.name) {
          return;
        }
        MessageView mes =
            MessageView(content: receivedMessage, rightSide: false);
        messages.insert(0, mes);
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    channel.sink.close(status.goingAway);
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Colors.blue[400],
        title: Text(
          userModel.name,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(
                'https://cdn.thuvienphapluat.vn/uploads/Hoidapphapluat/2023/MDV/Thang-1/van-chuyen-hanh-khach.jpg',
              ),
            ),
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            if (userModel.status == Status.BUSY) {
              userModel.name = userModel.name;
            }

            Navigator.of(context).pop(userModel.name);
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

                return AudioMessageWidget(
                  audioURL: message.content,
                  player: player,
                  favorite: message.favorite,
                  rightSide: message.rightSide,
                  tag: message.tag,
                  time: DateTime.now(),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          Divider(height: 1.0),
          SizedBox(height: 10),
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: InputVoice(
              onDone: (isDone, chatId) {
                if (isDone) {
                  MessageView mes =
                      MessageView(content: chatId, rightSide: true);
                  messages.insert(0, mes);
                  setState(() {});
                }
              },
            ),
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}
