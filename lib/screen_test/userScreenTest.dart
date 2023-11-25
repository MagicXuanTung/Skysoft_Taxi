import 'package:flutter/material.dart';
import 'package:skysoft_taxi/global/global.dart';
import 'package:skysoft_taxi/screen_test/globaltest.dart';
import 'package:skysoft_taxi/url/contants.dart';
import 'package:skysoft_taxi/widgets/user/car_info.dart';
import 'package:skysoft_taxi/widgets/user/side_bar.dart';
import 'package:skysoft_taxi/widgets/user/sidebar_toggle_button%20.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class HomeUserTest extends StatefulWidget {
  const HomeUserTest({super.key});

  @override
  State<HomeUserTest> createState() => HomeUserTestState();
}

class HomeUserTestState extends State<HomeUserTest>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey(); // hiển thị side_bar
  bool isDriverInfo = true;

  @override
  void initState() {
    super.initState();
    channel = IOWebSocketChannel.connect(
        URL_WS + userModel.role + "_" + userModel.name);
  }

  @override
  void dispose() {
    channel.sink.close(status.goingAway);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBar(),
      key: _scaffoldKey,
      body: GestureDetector(
        child: Stack(
          children: [
            SidebarToggleButton(
              scaffoldKey: _scaffoldKey, // Pass the scaffoldKey to the widget
            ),
            //màn hình DriverInfor
            Visibility(
              visible: isDriverInfo,
              child: SlidingUpPanel(
                minHeight: 500,
                maxHeight: 500,
                backdropEnabled: true,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                panel: Material(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  child: DriverInfo(
                    cancelTrip: () {},
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
