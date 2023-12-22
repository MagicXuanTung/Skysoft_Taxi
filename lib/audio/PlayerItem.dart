import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter/material.dart';

class PlayerItem extends StatefulWidget {
  String audioURL;
  bool isStarred;
  bool isTag;
  bool isRight;
  DateTime time;
  bool autoPlay;
  Function(String) play;
  Function() stop;
  PlayerItem(
      {super.key,
      required this.audioURL,
      this.isStarred = false,
      this.isTag = false,
      this.isRight = true,
      this.autoPlay = false,
      required this.time,
      required this.play,
      required this.stop});

  @override
  State<PlayerItem> createState() => _PlayerItemState();
}

class _PlayerItemState extends State<PlayerItem> {
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
  void initState() {
    super.initState();
    // log("PlayerItem: ${widget.audioURL} - ${widget.autoPlay}");
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(30.0),
          child: Align(
            alignment:
                widget.isRight ? Alignment.centerRight : Alignment.centerLeft,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color:
                      colorBg(widget.isRight, widget.isTag, widget.isStarred),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: colorBorder(
                        widget.isRight, widget.isTag, widget.isStarred),
                    width: 2,
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          CircularIconButton(
                            icon: widget.isStarred
                                ? Icons.star
                                : Icons.star_border,
                            iconColor:
                                widget.isStarred ? Colors.yellow : Colors.black,
                            onPressed: () {
                              widget.isStarred = !widget.isStarred;
                              setState(() {});
                            },
                          ),
                          CircularIconButton(
                            icon: Icons.share,
                            iconColor: Colors.black,
                            onPressed: () {
                              // Chia sẻ link
                              log("Share link");
                            },
                          ),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: AudioWaveWidget(isPlaying: widget.autoPlay),
                          ),
                          SizedBox(width: 8.0),
                          CircularIconButton(
                            icon: widget.autoPlay
                                ? Icons.pause
                                : Icons.play_arrow,
                            iconColor: Colors.black,
                            onPressed: () {
                              widget.autoPlay = !widget.autoPlay;
                              widget.autoPlay
                                  ? widget.play(widget.audioURL)
                                  : widget.stop();
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
            right: widget.isRight
                ? 0.0
                : null, // Đặt right thành 0 khi widget.isRight là true
            left: widget.isRight
                ? null
                : 0.0, // Đặt left thành 0 khi widget.isRight là false
            child: CircleAvatar(
              radius: 15.0,
              child: Container(
                color: Colors.green,
              ),
            ))
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
  final bool isPlaying;
  // int time
  AudioWaveWidget({required this.isPlaying});

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
    final double waveHeight = widget.isPlaying ? _waveHeights[index] : 15.0;
    final double waveSpacing = 2.0;

    return Container(
      width: 4.0,
      margin: EdgeInsets.symmetric(horizontal: waveSpacing),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: waveHeight * (index + 1) / 10,
          decoration: BoxDecoration(
            color: widget.isPlaying ? Colors.red : Colors.black,
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
