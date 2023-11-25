import 'package:flutter/material.dart';

class AudioMessageWidget extends StatefulWidget {
  @override
  _AudioMessageWidgetState createState() => _AudioMessageWidgetState();
}

class _AudioMessageWidgetState extends State<AudioMessageWidget> {
  bool isRecording = false;
  bool isStarred = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Row(
        children: <Widget>[
          CircularIconButton(
            icon: isStarred ? Icons.star : Icons.star_border,
            iconColor: isStarred ? Colors.yellow : Colors.grey,
            onPressed: () {
              isStarred = !isStarred;
              setState(() {});
              // Xử lý sự kiện khi nhấn nút star
            },
          ),
          CircularIconButton(
            icon: Icons.share,
            iconColor: Colors.grey,
            onPressed: () {},
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: AudioWaveWidget(isRecording: isRecording),
          ),
          SizedBox(width: 8.0),
          CircularIconButton(
            icon: Icons.play_arrow,
            iconColor: Colors.grey,
            onPressed: () {},
          ),
        ],
      ),
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

  AudioWaveWidget({required this.isRecording});

  @override
  _AudioWaveWidgetState createState() => _AudioWaveWidgetState();
}

class _AudioWaveWidgetState extends State<AudioWaveWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
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
    final double waveHeight = widget.isRecording ? 20.0 : 10.0;
    final double waveSpacing = 2.0;

    return Container(
      width: 4.0,
      height: waveHeight * (index + 1) / 10,
      margin: EdgeInsets.symmetric(horizontal: waveSpacing),
      decoration: BoxDecoration(
        color: widget.isRecording ? Colors.red : Colors.blue,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(2.0),
          bottom: Radius.circular(2.0),
        ),
      ),
    );
  }
}
