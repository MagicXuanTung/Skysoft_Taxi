// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:screen_state/screen_state.dart';
import '../../util/connectivity_handler.dart';
import 'goi_xe.dart';
import 'hoat_dong.dart';
import 'tai_khoan.dart';
import 'thong_bao.dart';
// import 'user_chat_all.dart';

class HomeUserXanhSm extends StatefulWidget {
  const HomeUserXanhSm({Key? key}) : super(key: key);

  @override
  _HomeUserXanhSmState createState() => _HomeUserXanhSmState();
}

class _HomeUserXanhSmState extends State<HomeUserXanhSm> {
  int selectedIndex = 0;
  bool isRequested = false;
  bool isDriverInfo = false;
  bool isReviews = false;
  late ConnectivityHandler _connectivityHandler;
  final _pageController = PageController(initialPage: 0);

  final List<Widget> _pages = [
    const BookingCar(),
    const ActivityDaily(),
    const NotificationPage(),
    const ProfilePage(),
  ];

  ReceivePort? _receivePort;
  Screen? _screen;
  StreamSubscription<ScreenStateEvent>? screenSubscription;

  // ignore: non_constant_identifier_names
  HomeUserXanhSm() {
    _screen = Screen();
    // Kiểm tra _screen có phải là null hay không
    if (_screen != null) {
      // Kiểm tra _screenSubscription có phải là null hay không
      screenSubscription = _screen!.screenStateStream?.listen((event) {
        if (event == ScreenStateEvent.SCREEN_OFF) {
          _startForegroundTask();
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // _connectivityHandler = ConnectivityHandler();
    // _connectivityHandler.startListening(context);

    // webSocketService.connectToServer();

    //ví dụ send
    // webSocketService.sendMessage(jsonEncode({
    //   "message": "ping",
    //   "sender": "Duong ga",
    //   "receiver": "Tung ga",
    //   "type": "public",
    //   "received": "received"
    // }));
    // WidgetsBinding.instance.addPostFrameCallback(
    //   (_) async {
    //     await _requestPermissionForAndroid();
    //     _initForegroundTask();
    //     _startForegroundTask();

    //     // You can get the previous ReceivePort without restarting the service.
    //     if (await FlutterForegroundTask.isRunningService) {
    //       final newReceivePort = FlutterForegroundTask.receivePort;
    //       _registerReceivePort(newReceivePort);
    //     }
    //   },
    // );
  }

  @override
  void dispose() {
    //channel.sink.close(status.goingAway);
    // _closeReceivePort();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _requestPermissionForAndroid() async {
    if (!Platform.isAndroid) {
      return;
    }
    if (!await FlutterForegroundTask.canDrawOverlays) {
      // This function requires `android.permission.SYSTEM_ALERT_WINDOW` permission.
      await FlutterForegroundTask.openSystemAlertWindowSettings();
    }
    // Android 12 or higher, there are restrictions on starting a foreground service.
    if (!await FlutterForegroundTask.isIgnoringBatteryOptimizations) {
      // This function requires `android.permission.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS` permission.
      await FlutterForegroundTask.requestIgnoreBatteryOptimization();
    }
    // Android 13 and higher, you need to allow notification permission to expose foreground service notification.
    final NotificationPermission notificationPermissionStatus =
        await FlutterForegroundTask.checkNotificationPermission();
    if (notificationPermissionStatus != NotificationPermission.granted) {
      await FlutterForegroundTask.requestNotificationPermission();
    }
  }

  void _initForegroundTask() {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        id: 500,
        channelId: 'foreground_service',
        channelName: 'Foreground Service Notification',
        channelDescription:
            'This notification appears when the foreground service is running.',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.LOW,
        iconData: const NotificationIconData(
          resType: ResourceType.mipmap,
          resPrefix: ResourcePrefix.ic,
          name: 'launcher',
          backgroundColor: Colors.orange,
        ),
        buttons: [
          const NotificationButton(
            id: 'sendButton',
            text: 'Send',
            textColor: Colors.orange,
          ),
          const NotificationButton(
            id: 'testButton',
            text: 'Test',
            textColor: Colors.grey,
          ),
        ],
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: true,
        playSound: false,
      ),
      foregroundTaskOptions: const ForegroundTaskOptions(
        interval: 5000,
        isOnceEvent: false,
        autoRunOnBoot: true,
        allowWakeLock: true,
        allowWifiLock: true,
      ),
    );
  }

  Future<bool> _startForegroundTask() async {
    // You can save data using the saveData function.
    await FlutterForegroundTask.saveData(key: 'customData', value: 'hello');

    // Register the receivePort before starting the service.
    final ReceivePort? receivePort = FlutterForegroundTask.receivePort;
    final bool isRegistered = _registerReceivePort(receivePort);
    if (!isRegistered) {
      print('Failed to register receivePort!');
      return false;
    }
    if (await FlutterForegroundTask.isRunningService) {
      return FlutterForegroundTask.restartService();
    } else {
      return FlutterForegroundTask.startService(
        notificationTitle: 'Foreground Service is running',
        notificationText: 'Tap to return to the app',
        callback: startCallback,
      );
    }
  }

  Future<bool> _stopForegroundTask() {
    return FlutterForegroundTask.stopService();
  }

  bool _registerReceivePort(ReceivePort? newReceivePort) {
    if (newReceivePort == null) {
      return false;
    }

    _closeReceivePort();

    _receivePort = newReceivePort;
    _receivePort?.listen((data) {
      if (data is int) {
        print('eventCount: $data');
      } else if (data is String) {
        if (data == 'onNotificationPressed') {
          Navigator.of(context).pushNamed('/resume-route');
        }
      } else if (data is DateTime) {
        print('timestamp: ${data.toString()}');
      }
    });

    return _receivePort != null;
  }

  void _closeReceivePort() {
    _receivePort?.close();
    _receivePort = null;
  }

  void onConnectivityChanged(ConnectivityResult result) {
    if (result != ConnectivityResult.none &&
        _connectivityHandler.isShowingLoadingScreen()) {
      Navigator.pop(context);
      _connectivityHandler.setLoadingScreen(false);
    }
  }

  void getNavigateTab(int index) {
    if (selectedIndex != index) {
      selectedIndex = index;
      setState(() {
        _pageController.jumpToPage(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0.1,
              blurRadius: 20,
              offset: const Offset(0, -10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedIndex,
            onTap: getNavigateTab,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            iconSize: 25,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.local_taxi,
                ),
                label: 'Gọi xe',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.schedule,
                ),
                label: 'Hoạt động',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications_active,
                ),
                label: 'Thông báo',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: 'Tài Khoản',
              ),
            ],
            selectedItemColor: Colors.deepOrange,
            unselectedItemColor: Colors.grey,
          ),
        ),
      ),
    );
  }
}

@pragma('vm:entry-point')
void startCallback() {
  // The setTaskHandler function must be called to handle the task in the background.
  FlutterForegroundTask.setTaskHandler(MyTaskHandler());
}

class MyTaskHandler extends TaskHandler {
  SendPort? sendPort;
  // Called when the task is started.
  @override
  void onStart(DateTime timestamp, SendPort? sendPort) async {
    sendPort = sendPort;

    // You can use the getData function to get the stored data.
    final customData =
        await FlutterForegroundTask.getData<String>(key: 'customData');
    print('customData: $customData');
  }

  // Called every [interval] milliseconds in [ForegroundTaskOptions].
  @override
  void onRepeatEvent(DateTime timestamp, SendPort? sendPort) async {
    // Không làm gì ở ForeGround
    // FlutterForegroundTask.updateService(
    //   notificationTitle: 'MyTaskHandler',
    //   notificationText: 'eventCount: $_eventCount',
    // );

    // // Send data to the main isolate.
    // sendPort?.send(_eventCount);

    // _eventCount++;
  }

  // Called when the notification button on the Android platform is pressed.
  @override
  void onDestroy(DateTime timestamp, SendPort? sendPort) async {
    print('onDestroy');
  }

  // Called when the notification button on the Android platform is pressed.
  @override
  void onNotificationButtonPressed(String id) {
    print('onNotificationButtonPressed >> $id');
  }

  // Called when the notification itself on the Android platform is pressed.
  //
  // "android.permission.SYSTEM_ALERT_WINDOW" permission must be granted for
  // this function to be called.
  @override
  void onNotificationPressed() {
    // Note that the app will only route to "/resume-route" when it is exited so
    // it will usually be necessary to send a message through the send port to
    // signal it to restore state when the app is already started.

    // FlutterForegroundTask.launchApp("/resume-route");
    // _sendPort?.send('onNotificationPressed');
  }
}
