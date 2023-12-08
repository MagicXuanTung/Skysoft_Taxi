import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:skysoft_taxi/audiochat_widget/audio_message.dart';
import 'package:skysoft_taxi/audiochat_widget/input_voice.dart';
import 'package:skysoft_taxi/global/global.dart';
import 'package:skysoft_taxi/screen_test/globaltest.dart';
import 'package:skysoft_taxi/services/ChatService.dart';
import 'package:skysoft_taxi/url/contants.dart';
import 'package:skysoft_taxi/view/message_view.dart';

import 'package:web_socket_channel/io.dart';

class UserChatAll extends StatefulWidget {
  const UserChatAll({Key? key}) : super(key: key);
  @override
  State createState() => ChatScreenState();
}

class ChatScreenState extends State<UserChatAll>
    with SingleTickerProviderStateMixin {
  DateTime? time;
  final List<MessageView> messages = [];

  ScrollController? controller = ScrollController();

  @override
  void initState() {
    super.initState();

    getAll().then((value) {
      for (var element in value) {
        //log("message: $element");
        // final Map<String, dynamic> model = jsonDecode(element);
        messages.add(MessageView(
            content: element["chatId"],
            rightSide: element["name"] == userModel.name));
      }

      setState(() {});

      // log("controller!.position.maxScrollExtent: ${controller!.position.maxScrollExtent}");

      controller!.animateTo(
        messages.length * 200,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
    });

    // subscription?.cancel();
    // channelWS?.sink.close(status.goingAway);

    channelWS = null;
    subscription = null;

    channelWS ??= IOWebSocketChannel.connect(
        "$URL_WS${userModel.role}_${userModel.name}");

    subscription ??= channelWS!.stream.listen((message) {
      final Map<String, dynamic> messageData = jsonDecode(message);
      log(message);

      final String receivedMessage = messageData['message'];
      if (messageData["sender"] == userModel.name) {
        return;
      }

      MessageView mes = MessageView(
          content: receivedMessage, rightSide: false, autoPlay: true);

      messages.add(mes);
      setState(() {});

      controller!.animateTo(
        controller!.position.maxScrollExtent + 200,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );

      // log("messages: ${messages.toList()}");
    });

    log("initState");
  }

  @override
  void dispose() {
    // channelWS!.sink.close(status.goingAway);
    // subscription?.cancel();
    log("dispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Colors.blue[400],
        title: Text(
          driverModel.name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(
                'https://yt3.googleusercontent.com/-CFTJHU7fEWb7BYEb6Jh9gm1EpetvVGQqtof0Rbh-VQRIznYYKJxCaqv_9HeBcmJmIsp2vOO9JU=s900-c-k-c0x00ffffff-no-rj',
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              controller: controller,
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                final message = messages[index];
                return AudioMessageWidget(
                  audioURL: message.content,
                  favorite: message.favorite,
                  rightSide: message.rightSide,
                  tag: message.tag,
                  autoPlay: message.autoPlay,
                  time: DateTime.now(),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          const Divider(height: 1.0),
          const SizedBox(height: 10),
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: InputVoice(
              onDone: (isDone, chatId) {
                // if (isDone) {
                //   messages.insert(
                //       0,
                //       MessageView(
                //           content: chatId, rightSide: true, autoPlay: true));
                //   setState(() {});
                // }
              },
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
