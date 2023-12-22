import 'package:just_audio/just_audio.dart';

class MyAudioPlayer {
  final AudioPlayer player = AudioPlayer();

  MyAudioPlayer();

  Stream<PlayerState> statePlayer() {
    return player.playerStateStream;
  }

  void playUrl(String url) async {
    stop();
    // Play without waiting for completion, if need waiting then add await
    try {
      await player.setUrl(url); // Schemes: (https: | file: | asset: )
    } catch (e) {
      print(e);
      return;
    }
    player.play();
  }

  void pause() async {
    await player.pause(); // Pause but remain ready to play
  }

  void stop() async {
    await player.stop();
  }

  void seekTo(int time) async {
    await player.seek(Duration(seconds: time));
  }

  void setSpeed(double speed) async {
    await player.setSpeed(speed);
  }

  void setVolume(double value) async {
    await player.setVolume(value);
  }
}
