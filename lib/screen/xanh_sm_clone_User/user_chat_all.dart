import 'dart:developer';
import 'package:flutter/material.dart';

import '../../audiochat_widget/audio_message.dart';
import '../../audiochat_widget/input_voice.dart';
import '../../global/global.dart';
import '../../models/user.model.dart';
import '../../services/ChatService.dart';
import '../../view/message_view.dart';

class UserChatAll extends StatefulWidget {
  const UserChatAll({Key? key}) : super(key: key);
  @override
  State createState() => UserChatAllState();
}

class UserChatAllState extends State<UserChatAll>
    with SingleTickerProviderStateMixin {
  DateTime? time;
  final List<MessageView> messages = [];
  ScrollController? controller = ScrollController();

  @override
  void initState() {
    super.initState();

    getAll().then((List<dynamic>? value) {
      if (value != null) {
        for (var element in value) {
          //log("message: $element");
          messages.add(MessageView(
              content: element["chatId"],
              rightSide: element["name"] == userModel.name));
        }
        setState(() {});

        // log("controller!.position.maxScrollExtent: ${controller!.position.maxScrollExtent}");

        controller!.animateTo(
          messages.length * 200,
          duration: Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
        );
      }
    });
  }

  @override
  void dispose() {
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
            Navigator.of(context).pop({
              if (driverModel.status == Status.BUSY)
                {
                  {driverModel.name = driverModel.name}
                }
            });
          },
        ),
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
          SizedBox(height: 5),
        ],
      ),
    );
  }
}
