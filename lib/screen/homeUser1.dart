import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:audio_session/audio_session.dart' as a_s;
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:latlong2/latlong.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skysoft_taxi/global/global.dart';
import 'package:skysoft_taxi/models/user.model.dart';
import 'package:skysoft_taxi/url/contants.dart';
import 'package:skysoft_taxi/widgets/user/side_bar.dart';
import 'package:skysoft_taxi/widgets/user/sidebar_toggle_button%20.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:flutter/services.dart' show rootBundle;

class Home1 extends StatefulWidget {
  const Home1({super.key});

  @override
  State<Home1> createState() => HomeState();
}

typedef Fn = void Function();

class HomeState extends State<Home1> with TickerProviderStateMixin {
  late final _animatedMapController = AnimatedMapController(vsync: this);
  final TextEditingController _textFieldController = TextEditingController();
  final panelController = PanelController();

  bool isPanelVisible = false; // Hiển thị panal bar
  bool isPanelOpen = false; // kéo lên xuống panal bar
  bool isReviews = false; // hiển thị màn hình review
  bool isRequested = false; // hiển thị màn hình request
  bool isDriverInfo = false; // hiển thị màn hình carinfor
  bool isPriceCar = false; // hiển thị màn hình priceCar
  bool isSound = true;

  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey(); // hiển thị side_bar
  late IOWebSocketChannel channel;
  final player = AudioPlayer();
  String _tempDirectory = "";
  final FlutterSoundRecorder _mRecorder = FlutterSoundRecorder();
  Codec _codec = Codec.aacMP4;
  String _mPath = 'tau_file.mp4';
  bool _mRecorderIsInited = false;
  double _mSubscriptionDuration = 0;
  StreamSubscription? _recorderSubscription;
  int pos = 0;
  double dbLevel = 0;

  Future<Uint8List> getAssetData(String path) async {
    var asset = await rootBundle.load(path);
    return asset.buffer.asUint8List();
  }

  Future<void> openTheRecorder() async {
    await _mRecorder.openRecorder();
    final session = await a_s.AudioSession.instance;
    await session.configure(a_s.AudioSessionConfiguration(
      avAudioSessionCategory: a_s.AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          a_s.AVAudioSessionCategoryOptions.allowBluetooth |
              a_s.AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: a_s.AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
          a_s.AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: a_s.AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const a_s.AndroidAudioAttributes(
        contentType: a_s.AndroidAudioContentType.speech,
        flags: a_s.AndroidAudioFlags.none,
        usage: a_s.AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: a_s.AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));

    _mRecorderIsInited = true;
  }

  Future<void> init() async {
    PermissionStatus status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      log("Chưa cấp quyền microphone");
    }
    status = await Permission.storage.request();
    if (status != PermissionStatus.granted) {
      log("Chưa cấp quyền thư mục");
    }
    _mRecorder.closeRecorder();
    await openTheRecorder();
    log("init 1");
    _recorderSubscription = _mRecorder.onProgress!.listen((e) {
      log("init _recorderSubscription");
      setState(() {
        pos = e.duration.inMilliseconds;
        if (e.decibels != null) {
          dbLevel = e.decibels as double;
        }
      });
    });
  }

  void record(FlutterSoundRecorder? recorder) async {
    await recorder!.startRecorder(
      codec: Codec.aacMP4,
      toFile: _tempDirectory + "/" + _mPath,
      bitRate: 8000,
      numChannels: 1,
      sampleRate: 8000,
    );
    setState(() {});
  }

  Future<void> stopRecorder(FlutterSoundRecorder recorder) async {
    await recorder.stopRecorder().then((value) {
      log("record: ${value}");
    });
    ;
  }

  Future<void> setSubscriptionDuration(
      double d) async // v is between 0.0 and 2000 (milliseconds)
  {
    _mSubscriptionDuration = d;
    setState(() {});
    await _mRecorder.setSubscriptionDuration(
      Duration(milliseconds: d.floor()),
    );
  }

  @override
  void initState() {
    super.initState();
    channel = IOWebSocketChannel.connect(
        URL_CHAT + userModel.role + "_" + userModel.name);
    channel.stream.listen((message) {
      // print("ChatScreen: " + message);
      final Map<String, dynamic> messageData = jsonDecode(message);
      final String receivedMessage = messageData['message'];
      driverModel.name = messageData['sender'];
      if (receivedMessage == "ACPECT") {
        if (userModel.status == Status.NORMAL) {
          isRequested = false;
          isDriverInfo = true;
          userModel.changeStatusWithMessage("ACPECT");
          print(userModel.status.toString() + "_" + "user");
          channel.sink.add(jsonEncode({
            "message": "OK",
            "sender": userModel.name,
            "receiver": driverModel.name, //người nhận
            "type": "private",
            //"points": "[21.03735349640734, 105.78897826869654]",
          }));
          setState(() {});
        }
      } else if (receivedMessage == "KETTHUC") {
        if (userModel.status == Status.BUSY) {
          isDriverInfo = false;
          isReviews = true;
          userModel.changeStatusWithMessage("ENDTRIP");
          print(userModel.status.toString() + "_" + "user");
          setState(() {});
        }
      }
    });
    getApplicationDocumentsDirectory().then((value) {
      log("Path: ${value}");
      _tempDirectory = value.path;
    });

    init().then((value) {
      setState(() {
        _mRecorderIsInited = true;
      });
    });
  }

  @override
  void dispose() {
    channel.sink.close(status.goingAway);
    _textFieldController.dispose();
    player.dispose();
    stopRecorder(_mRecorder);
    cancelRecorderSubscriptions();

    // Be careful : you must `close` the audio session when you have finished with it.
    _mRecorder.closeRecorder();

    super.dispose();
  }

  void cancelRecorderSubscriptions() {
    if (_recorderSubscription != null) {
      _recorderSubscription!.cancel();
      _recorderSubscription = null;
    }
  }

  Fn? getPlaybackFn(FlutterSoundRecorder? recorder) {
    if (!_mRecorderIsInited) {
      log("getPlaybackFn: ${_mRecorderIsInited}");
      return null;
    }
    return recorder!.isStopped
        ? () {
            record(recorder);
          }
        : () {
            stopRecorder(recorder).then((value) => setState(() {}));
          };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBar(),
      key: _scaffoldKey,
      body: GestureDetector(
        onTap: () {
          if (isPanelVisible) {
            if (isPanelOpen) {
              panelController.close();
            } else {
              panelController.open();
            }
            setState(() {
              isPanelOpen = !isPanelOpen;
            });
          }
        },
        child: Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                onTap: (tapPosition, point) {},
                zoom: 15,
                maxZoom: 18,
                minZoom: 3,
                center: const LatLng(21.053306461723658, 105.77996412889881),
              ),
              mapController: _animatedMapController.mapController,
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'],
                  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                ),
              ],
            ),
            SidebarToggleButton(
              scaffoldKey: _scaffoldKey, // Pass the scaffoldKey to the widget
            ),
            Visibility(
              visible: isSound,
              child: SlidingUpPanel(
                minHeight: 110,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20.0)),
                backdropEnabled: true,
                controller: panelController,
                panel: Material(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20.0)),
                    child: Column(
                      children: [
                        ElevatedButton(
                            onPressed: getPlaybackFn(_mRecorder),
                            child: Text(
                                _mRecorder.isRecording ? 'Stop' : 'Record')),
                        ElevatedButton(
                            onPressed: () async {
                              try {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles();

                                if (result != null) {
                                  log(result.files.single.path!);
                                  // File file = File(result.files.single.path!);
                                } else {
                                  // User canceled the picker
                                }
                              } catch (e) {
                                print(e);
                              }
                            },
                            child: Text("Choose file")),
                        ElevatedButton(
                            onPressed: () async {
                              try {
                                await player.play(UrlSource(
                                    'http://192.168.1.75:8080/devxelo/rest/chat/1.mp3'));
                              } catch (e) {
                                print(e);
                              }
                            },
                            child: Text("Play sound")),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
