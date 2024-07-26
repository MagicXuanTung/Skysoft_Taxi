import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skysoft_taxi/screen/user_ui/home_user_xanh_sm.dart';
// import 'package:just_audio_background/just_audio_background.dart';
import 'package:skysoft_taxi/util/notification_controller.dart';

import 'screen/user_ui/tim_diem_den_nhanh.dart';
import 'util/api_.dart';

void main() async {
  await NotificationController.initializeLocalNotifications();
  // await JustAudioBackground.init(
  //   androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
  //   androidNotificationChannelName: 'Audio playback',
  //   androidNotificationOngoing: true,
  // );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    NotificationController.startListeningNotificationEvents();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    return MaterialApp(
      navigatorKey: MyApp.navigatorKey,
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: QuickFindPlaces(),
      ),
    );
  }
}
