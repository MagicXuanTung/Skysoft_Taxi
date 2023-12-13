import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;
import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:skysoft_taxi/url/contants.dart';

// ignore: must_be_immutable
class AudioMessageWidget extends StatefulWidget {
  String audioURL;
  bool favorite;
  bool tag;
  bool rightSide;
  DateTime time;
  bool autoPlay;
  AudioMessageWidget(
      {Key? key,
      required this.audioURL,
      this.favorite = false,
      this.tag = false,
      this.rightSide = true,
      this.autoPlay = false,
      required this.time})
      : super(key: key);
  @override
  _AudioMessageWidgetState createState() => _AudioMessageWidgetState();
}

class _AudioMessageWidgetState extends State<AudioMessageWidget> {
  bool isPlay = false;
  bool isStarred = false;
  bool isTag = false;
  bool isRight = true;

  int timeDuration = 0;
  int timePosition = 0;

  AudioPlayer player = AudioPlayer();
  final String imageURL =
      "https://image.winudf.com/v2/image1/Y29tLnNreXNvZnQuZ3BzX2ljb25fMTU1OTE4NzY5NF8wMjQ/icon.png?w=184&fakeurl=1";
  final String rightImage =
      "https://inkythuatso.com/uploads/thumbnails/800/2023/03/9-anh-dai-dien-trang-inkythuatso-03-15-27-03.jpg";
  final String leftImage =
      "https://cdn.sforum.vn/sforum/wp-content/uploads/2023/10/avatar-trang-3.jpg";

  @override
  void initState() {
    super.initState();
    isStarred = widget.favorite;
    isTag = widget.tag;
    isRight = widget.rightSide;

    //log("widget.audioURL before: ${widget.audioURL} - ${player.playerState} - ${widget.autoPlay}");

    if ((player.playerState == ProcessingState.idle ||
            player.playerState == ProcessingState.completed) &&
        widget.autoPlay) {
      //log("widget.audioURL: ${widget.audioURL} - ${player.playerState} - ${widget.autoPlay}");
      playAudioFromURL();
    }
    player.durationStream.listen((event) {
      timeDuration = event!.inSeconds;
      //log("timeDuration: $timeDuration");
    });
    player.positionStream.listen((event) {
      timePosition = event.inSeconds;
      //log("timePosition: $timePosition");
    });
    // kết thúc âm thanh
    player.playerStateStream.listen((event) {
      if (event.processingState == ProcessingState.completed) {
        // Khi âm thanh kết thúc, dừng và đặt lại vị trí 0
        player.stop();
        player.seek(Duration.zero);
        isPlay = false;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void playAudioFromURL() async {
    try {
      final url = '$URL_CHAT${widget.audioURL}.mp3';
      final mediaItem = MediaItem(
        id: widget.audioURL,
        album: widget.audioURL,
        title: 'Audio Message',
        artUri: Uri.parse(imageURL),
      );

      // Chọn chế độ loa ngoài
      final session = await AudioSession.instance;
      await session.configure(const AudioSessionConfiguration.speech());

      // Tạo audioSource và đặt tag là MediaItem
      final audioSource = AudioSource.uri(
        Uri.parse(url),
        tag: mediaItem,
      );

      // Đặt audioSource cho player
      await player.setAudioSource(audioSource);
      if (player.sequenceState?.currentSource != null) {
        final currentMediaItem =
            player.sequenceState!.currentSource!.tag as MediaItem;
        log('Current MediaItem: $currentMediaItem');
        player.play();
      } else {
        log('Error loading audio: currentSource is null');
      }
    } catch (e) {
      log('Error loading audio: $e');
    }
  }

  Color? colorBg(bool isRight, bool isTag, bool isStarred) {
    if (isTag) {
      return Colors.red[300];
    }

    if (isStarred) {
      return Colors.green[300];
    }

    if (!isRight) {
      return Colors.grey[300];
    }

    return Colors.blue[300];
  }

  Color colorBorder(bool isRight, bool isTag, bool isStarred) {
    if (isTag) {
      return Colors.red;
    }

    if (isStarred) {
      return Colors.green;
    }

    if (!isRight) {
      return Colors.grey;
    }

    return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(30.0),
          child: Align(
            alignment: isRight ? Alignment.centerRight : Alignment.centerLeft,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: colorBg(isRight, isTag, isStarred),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: colorBorder(isRight, isTag, isStarred),
                    width: 2,
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          CircularIconButton(
                            icon: isStarred ? Icons.star : Icons.star_border,
                            iconColor: isStarred ? Colors.yellow : Colors.black,
                            onPressed: () {
                              isStarred = !isStarred;
                              setState(() {});
                            },
                          ),
                          CircularIconButton(
                            icon: Icons.share,
                            iconColor: Colors.black,
                            onPressed: () {
                              Share.share(URL_CHAT + '${widget.audioURL}.mp3');
                            },
                          ),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: AudioWaveWidget(isRecording: isPlay),
                          ),
                          SizedBox(width: 8.0),
                          CircularIconButton(
                            icon: isPlay ? Icons.pause : Icons.play_arrow,
                            iconColor: Colors.black,
                            onPressed: () {
                              isPlay = !isPlay;
                              if (isPlay) {
                                playAudioFromURL();
                              } else {
                                player.stop();
                              }
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      Text(
                        '${widget.time.hour}:${widget.time.minute}',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        // Ảnh avatar
        Positioned(
            bottom: 0.0, // Đặt bottom thành 0 để nằm ở góc dưới
            right:
                isRight ? 0.0 : null, // Đặt right thành 0 khi isRight là true
            left: isRight ? null : 0.0, // Đặt left thành 0 khi isRight là false
            child: isRight
                ? CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://inkythuatso.com/uploads/thumbnails/800/2023/03/9-anh-dai-dien-trang-inkythuatso-03-15-27-03.jpg'),
                    radius: 15.0,
                  )
                : CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://cdn.sforum.vn/sforum/wp-content/uploads/2023/10/avatar-trang-3.jpg'),
                    radius: 15.0,
                  )),
      ],
    );
  }
}

class CircularIconButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final VoidCallback? onPressed;

  CircularIconButton({
    required this.icon,
    required this.iconColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: IconButton(
        icon: Icon(icon, color: iconColor),
        onPressed: onPressed,
      ),
    );
  }
}

class AudioWaveWidget extends StatefulWidget {
  final bool isRecording;
  // int time
  AudioWaveWidget({required this.isRecording});

  @override
  _AudioWaveWidgetState createState() => _AudioWaveWidgetState();
}

class _AudioWaveWidgetState extends State<AudioWaveWidget> {
  late Timer _timer;
  late List<double> _waveHeights;
  @override
  void initState() {
    super.initState();
    _waveHeights = List.generate(10, (index) => _generateRandomHeight());
    _startWaveAnimation();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startWaveAnimation() {
    const Duration interval =
        Duration(milliseconds: 300); // Đặt khoảng thời gian cập nhật
    _timer = Timer.periodic(interval, (Timer timer) {
      _waveHeights = List.generate(10, (index) => _generateRandomHeight());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          10,
          (index) => _buildWaveBar(index),
        ),
      ),
    );
  }

  Widget _buildWaveBar(int index) {
    final double waveHeight = widget.isRecording ? _waveHeights[index] : 15.0;
    final double waveSpacing = 2.0;

    return Container(
      width: 4.0,
      margin: EdgeInsets.symmetric(horizontal: waveSpacing),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: waveHeight * (index + 1) / 10,
          decoration: BoxDecoration(
            color: widget.isRecording ? Colors.red : Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(2.0),
              topRight: Radius.circular(2.0),
            ),
          ),
        ),
      ),
    );
  }

  double _generateRandomHeight() {
    final random = math.Random();
    return (random.nextDouble() * 20.0) +
        5.0; // Tạo ra giá trị ngẫu nhiên từ 5.0 đến 25.0
  }
}
