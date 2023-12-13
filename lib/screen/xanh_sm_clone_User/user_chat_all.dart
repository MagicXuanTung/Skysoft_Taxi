import 'package:flutter/material.dart';
import 'package:skysoft_taxi/view/message_view.dart';

import '../../audiochat_widget/audio_message.dart';
import '../../audiochat_widget/input_voice.dart';
import '../../global/global.dart';
import '../../models/circular_image_widget_model.dart';
import '../../services/ChatService.dart';
import '../../widgets/imageWidget/circular_image_widget.dart';

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
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();

    getAll().then(
      (List<dynamic>? value) {
        if (value != null) {
          for (var element in value) {
            messages.add(MessageView(
                content: element["chatId"],
                rightSide: element["name"] == userModel.name));
          }
          setState(() {});

          controller!.animateTo(
            messages.length * 200,
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
          );
        }
      },
    );
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: MediaQuery.of(context).size.height * 0.10,
        backgroundColor: Colors.blue.shade600,
        title: Text(
          driverModel.name,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(
                'https://yt3.googleusercontent.com/-CFTJHU7fEWb7BYEb6Jh9gm1EpetvVGQqtof0Rbh-VQRIznYYKJxCaqv_9HeBcmJmIsp2vOO9JU=s900-c-k-c0x00ffffff-no-rj',
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 55),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
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
            _buildMessageInputField(),
            InputVoice(
              onDone: (bool, String) {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInputField() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.mic,
              color: Colors.redAccent,
            ),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: const InputDecoration(
                hintText: 'Tin nhắn của bạn...',
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.send,
              color: Colors.blueAccent,
            ),
            onPressed: () {
              // Handle send button press
              String message = messageController.text;
              // Process and send the message
              // ...
              messageController.clear();
            },
          ),
        ],
      ),
    );
  }
}
