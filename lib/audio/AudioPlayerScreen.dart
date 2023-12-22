import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:just_audio/just_audio.dart';
import 'PlayerItem.dart';
import 'audio_player.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key, required this.title});
  final String title;
  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  MyAudioPlayer player = MyAudioPlayer();
  ValueNotifier<String> currentUrl = ValueNotifier<String>("");
  List<String> listUrl = [
    "http://192.168.1.75:8081/product/rest/chat/310.mp3",
    "http://192.168.1.75:8081/product/rest/chat/312.mp3",
    "http://192.168.1.75:8081/product/rest/chat/313.mp3",
    "http://192.168.1.75:8081/product/rest/chat/316.mp3",
    "http://192.168.1.75:8081/product/rest/chat/317.mp3",
    "http://192.168.1.75:8081/product/rest/chat/318.mp3",
    "http://192.168.1.75:8081/product/rest/chat/319.mp3",
  ];
  List<Widget> buildList() {
    log("buildList: ${currentUrl.value}");

    List<Widget> list = [];
    listUrl.forEach((element) {
      list.add(PlayerItem(
        audioURL: element,
        time: DateTime.now(),
        play: (url) {
          currentUrl.value = url;
          player.playUrl(url);
        },
        stop: () => player.stop(),
        autoPlay: element == currentUrl.value,
      ));
    });
    return list;
  }

  @override
  void initState() {
    super.initState();
    player.statePlayer().listen((event) {
      log("State: ${event.processingState}");
      if (event.processingState == ProcessingState.completed) {
        // Khi âm thanh kết thúc, dừng và đặt lại vị trí 0
        player.stop();
        player.seekTo(0);
        currentUrl.value = "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    log("REBUILD");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ValueListenableBuilder(
          valueListenable: currentUrl,
          builder: (BuildContext context, String url, Widget? child) {
            return ListView.builder(
              itemCount: listUrl.length,
              itemBuilder: (BuildContext context, int index) {
                String url = listUrl.elementAt(index);
                bool play = url == currentUrl.value;
                log("ListView: $url - $play");
                return PlayerItem(
                  audioURL: url,
                  time: DateTime.now(),
                  play: (url) {
                    currentUrl.value = url;
                    player.playUrl(url);
                  },
                  stop: () => player.stop(),
                  autoPlay: play,
                );
              },
            );
          }),
    );
  }
}
