import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:bluetooth_connector/bluetooth_connector.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:audio_session/audio_session.dart' as a_s;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:logger/logger.dart' show Level;
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:skysoft_taxi/global/global.dart';
import 'package:skysoft_taxi/url/contants.dart';

class InputVoice extends StatefulWidget {
  Function(bool, String) onDone;
  InputVoice({super.key, required this.onDone});

  @override
  State<InputVoice> createState() => _InputVoiceState();
}

class ChatMessage {
  String text;
  bool isUser;
  int type;

  ChatMessage({required this.text, required this.isUser, this.type = 1});
}

typedef Fn = void Function();

class _InputVoiceState extends State<InputVoice> {
  final List<ChatMessage> messages = [];
  final FlutterSoundRecorder _mRecorder =
      FlutterSoundRecorder(logLevel: Level.nothing);
  final Codec _codec = Codec.aacMP4;
  String _mPath = 'temp.mp4';
  bool _mRecorderIsInited = false;
  double mSubscriptionDuration = 0;
  StreamSubscription? _recorderSubscription;
  int pos = 0;
  Timer? timer;
  double dbLevel = 0;
  String _tempDirectory = "";
  //DND
  bool isRecord = false;
  bool isDelete = false;
  bool isHold = false;
  bool isActiveHold = false;

  bool isConnectBlueToothLoudspeaker = false;

  Icon holdButton = const Icon(Icons.lock, color: Colors.green);
  Icon delelteButton = const Icon(Icons.delete, color: Colors.red);
  Icon recordButton = const Icon(Icons.mic, color: Colors.blue, size: 30);
  Icon sendButton = const Icon(Icons.send, color: Colors.blue);
  Icon tempButton = const Icon(Icons.mic, color: Colors.blue, size: 30);

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

    session.devicesChangedEventStream.listen((event) {
      log('Devices added: ${event.devicesAdded}');
      log('Devices removed: ${event.devicesRemoved}');
    });

    Set<a_s.AudioDevice> listDeviceLoudspeaker = await session.getDevices();
    for (var element in listDeviceLoudspeaker) {
      if (element.type.toString().contains("bluetooth")) {
        isConnectBlueToothLoudspeaker = true;
        break;
      }
    }

    if (isConnectBlueToothLoudspeaker) {
      BluetoothConnector flutterbluetoothconnector = BluetoothConnector();
      List<BtDevice> listDevice = await flutterbluetoothconnector.getDevices();
      bool started = await flutterbluetoothconnector.startServer();
      String address = "";
      if (started) {
        // for (var element in listDevice) {
        //   if (element.name == "B02PTT-080F" || element.name == "B02PTT-03DD") {
        //     address = element.address!;
        //     break;
        //   }

        // bool connected = await flutterbluetoothconnector.startClient(
        //     listDevice.indexOf(element), false);
        // log("${element.address} - ${element.name}: $connected");
        // }
        BluetoothDevice? selectedDevice =
            await _showBluetoothDeviceSelectionDialog(listDevice);
        if (selectedDevice != null) {
          log("address: ${selectedDevice.address}");
          bluetoothConnect(selectedDevice.address);
        } else {
          log("Mic được lấy từ điện thoại");
        }
      }
    }
  }

  Future<BluetoothDevice?> _showBluetoothDeviceSelectionDialog(
      List<BtDevice> listDevice) async {
    BluetoothDevice? selectedDevice = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Chọn Thiết Bị Bluetooth"),
          content: Container(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children:
                  listDevice.map((device) => _buildDeviceItem(device)).toList(),
            ),
          ),
        );
      },
    );

    return selectedDevice;
  }

  Widget _buildDeviceItem(BtDevice device) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(
            context,
            BluetoothDevice(
                name: device.name, address: device.address.toString()));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey)),
        ),
        child: Text(
          device.name.toString(),
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }

  void turnOnOffSco(bool start) {
    if (start) {
      a_s.AndroidAudioManager().startBluetoothSco();
    } else {
      a_s.AndroidAudioManager().stopBluetoothSco();
    }
    a_s.AndroidAudioManager().setBluetoothScoOn(start);
  }

  Future<void> bluetoothConnect(String address) async {
    //08:21:05:05:08:0F
    // Some simplest connection :F
    try {
      if (connection != null) {
        connection!.finish();
        connection = null;
      }

      if (connection == null) {
        connection = await BluetoothConnection.toAddress(address);

        print('Connected to the device');

        connection!.input!.listen((Uint8List data) {
          String command = ascii.decode(data);
          print('Data incoming: ${command} - ${data.toList()}');

          connection!.output.add(data); // Sending data
          if (command == "+PTT=P") {
            turnOnOffSco(true);
            isRecord = true;
            startRecord();
            setState(() {});
          }

          if (command == "+PTT=R") {
            turnOnOffSco(false);
            uploadRecord(_mRecorder);
            isRecord = false;
            setState(() {});
          }

          if (ascii.decode(data).contains('!')) {
            connection!.finish(); // Closing connection
            print('Disconnecting by local host');
          }
        }).onDone(() {
          print('Disconnected by remote request');
        });
      }
    } catch (exception) {
      print('Cannot connect, exception occured');
    }
  }

  Future<void> init() async {
    PermissionStatus status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      log("Chưa cấp quyền microphone");
    }
    PermissionStatus storageStatus = await Permission.storage.request();
    if (storageStatus != PermissionStatus.granted) {
      log("Chưa cấp quyền thư mục");
    }
    PermissionStatus bluetoothStatus = await Permission.bluetooth.request();
    if (bluetoothStatus != PermissionStatus.granted) {
      log("Chưa cấp quyền Bluetooth");
    }

    await openTheRecorder();

    _recorderSubscription = _mRecorder.onProgress!.listen((e) {
      setState(() {
        pos = e.duration.inMilliseconds;
        if (e.decibels != null) {
          dbLevel = e.decibels as double;
        }
      });
    });
  }

  void record(FlutterSoundRecorder? recorder) async {
    if (recorder!.isRecording) return;
    recorder.startRecorder(
        codec: _codec,
        toFile: _tempDirectory + "/" + _mPath,
        bitRate: 8000,
        numChannels: 1,
        sampleRate: 8000,
        audioSource: AudioSource.microphone);
    // timer?.cancel();
    // pos = 0;
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      pos += 1000;
      setState(() {});
    });
  }

  Future<void> uploadRecord(FlutterSoundRecorder recorder) async {
    if (pos < 1000) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Cảnh báo'),
            content: Text('Thời lượng âm thanh quá ngắn.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      cancelRecording(recorder);
      return;
    } else {
      String? pathFile = await recorder.stopRecorder();
      if (pathFile == null || pathFile == "") {
        log("uploadRecord fail");
        return;
      }

      File file = File(pathFile);
      if (!file.existsSync()) {
        log("File not exists: $pathFile");
        return;
      }
      // Upload file
      String? chatId = await uploadAudioFile(file);

      // Delete file
      await file.delete();
      log("Recording file deleted");

      if (chatId == null) return;
      widget.onDone(true, chatId);
    }
  }

  Future<void> cancelRecording(FlutterSoundRecorder recorder) async {
    String? pathFile = await recorder.stopRecorder();
    if (pathFile == null) {
      log("CancelRecording fail");
      return;
    }

    log("Recording canceled");

    // xóa file khi cần
    // String audioFilePath = '$_tempDirectory/$_mPath';
    // File audioFile = File(audioFilePath);

    // if (audioFile.existsSync()) {
    //   await audioFile.delete();
    //   log("Recording file deleted");
    // }
  }

  Future<String?> uploadAudioFile(File audioFile) async {
    try {
      List<int> fileBytes = await audioFile.readAsBytes();

      String base64Data = base64Encode(fileBytes);

      Map<String, String> body = {
        "name": userModel.name,
        "data": base64Data,
      };

      Response response = await post(
        Uri.parse(URL_CHAT_UPLOAD),
        body: body,
      );

      if (response.statusCode == 200) {
        print('Upload thành công');
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData["chatId"].toString();
      } else {
        print('Upload thất bại. Mã lỗi: ${response.statusCode}');
      }
    } catch (e) {
      print('Lỗi: $e');
    }
  }

  Future<void> setSubscriptionDuration(double d) async {
    mSubscriptionDuration = d;
    setState(() {});
    await _mRecorder.setSubscriptionDuration(
      Duration(milliseconds: d.floor()),
    );
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
            uploadRecord(recorder).then((value) => setState(() {}));
          };
  }

  Widget setTile(bool isRecord, bool isDelete, bool isHold) {
    if (isRecord && isDelete) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(5),
            child: Text("${pos ~/ 1000}s"),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text("Xóa tệp ghi âm"),
          )
        ],
      );
    }

    if (isRecord && isHold) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.all(5), child: Text("${pos ~/ 1000}s")),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text("Chế độ rảnh tay"),
          )
        ],
      );
    }

    if (isRecord) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.all(5), child: Text("${pos ~/ 1000}s")),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text("Sang trái để xóa, sang phải để rảnh tay"),
          )
        ],
      );
    }

    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text("Nhấn và giữ để ghi âm"),
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory()
        .then((value) => _tempDirectory = value.path);

    init().then((value) {
      _mRecorderIsInited = true;
      setState(() {});
    });
    isRecord = false;
  }

  @override
  void dispose() {
    cancelRecording(_mRecorder);
    cancelRecorderSubscriptions();
    connection?.finish();
    timer?.cancel();
    // Be careful : you must `close` the audio session when you have finished with it.
    _mRecorder.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          setTile(isRecord, isDelete, isHold),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DragTarget(
                      onAccept: (data) {
                        log("onAccept Delete");
                        cancelRecording(_mRecorder);
                        isDelete = false;
                        isRecord = false;
                        isActiveHold = false;
                        tempButton = recordButton;
                        setState(() {});
                      },
                      onWillAccept: (data) {
                        tempButton = delelteButton;
                        isDelete = true;
                        setState(() {});
                        return true;
                      },
                      onLeave: (data) {
                        log("onLeave");
                        tempButton = recordButton;
                        isDelete = false;
                        setState(() {});
                      },
                      builder: (context, candidateData, rejectedData) {
                        return isRecord && !isHold
                            ? Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.red, width: 2),
                                    borderRadius: BorderRadius.circular(50)),
                                child: const Icon(Icons.delete,
                                    color: Colors.red, size: 30))
                            : isActiveHold
                                ? Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.red, width: 2),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: GestureDetector(
                                      child: IconButton(
                                          onPressed: () async {
                                            await cancelRecording(_mRecorder);
                                            log("onclick Delete");
                                            isDelete = false;
                                            isRecord = false;
                                            isActiveHold = false;
                                            isHold = false;
                                            tempButton = recordButton;
                                            setState(() {});
                                          },
                                          icon: const Icon(Icons.delete,
                                              color: Colors.red, size: 30)),
                                    ))
                                : Container();
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Draggable<int>(
                      data: 1,
                      feedback: Container(),
                      childWhenDragging: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(50)),
                          child: tempButton),
                      onDragEnd: (details) {
                        if (isHold) {
                          log("isHold: $isHold");
                          tempButton = sendButton;
                          setState(() {});
                        }
                      },
                      child: GestureDetector(
                        onTapDown: (data) async {
                          if (isActiveHold && isRecord) {
                            await uploadRecord(_mRecorder);
                            isActiveHold = false;
                            isRecord = false;
                            isDelete = false;
                            isHold = false;
                            tempButton = recordButton;
                            setState(() {});
                            return;
                          }

                          log("onTapDown:");
                          startRecord();
                          setState(() {});
                        },
                        onTapUp: (details) async {
                          if (!isActiveHold) {
                            // pos = 0;
                            //timer?.cancel;
                            await uploadRecord(_mRecorder);
                            log("onTapUp:");
                            isRecord = false;
                            setState(() {});
                          }
                        },
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(50)),
                          child: tempButton,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: !isActiveHold
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DragTarget(
                            onAccept: (data) {
                              log("onAccept Hold");
                              isHold = true;
                              isActiveHold = true;
                              setState(() {});
                            },
                            onWillAccept: (data) {
                              tempButton = holdButton;
                              isHold = true;
                              setState(() {});
                              return true;
                            },
                            onLeave: (data) {
                              log("onLeave");
                              tempButton = recordButton;
                              isHold = false;
                              setState(() {});
                            },
                            builder: (context, candidateData, rejectedData) {
                              return isRecord && !isDelete
                                  ? Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.green, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: const Icon(Icons.lock_open,
                                          color: Colors.green, size: 30))
                                  : Container();
                            },
                          ),
                        ],
                      )
                    : Container(),
              ),
            ],
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }

  void startRecord() {
    pos = 0;
    timer?.cancel();
    record(_mRecorder);
    isRecord = true;
  }
}
