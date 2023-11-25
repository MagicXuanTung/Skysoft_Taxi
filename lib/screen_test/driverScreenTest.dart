import 'package:flutter/material.dart';
import 'package:skysoft_taxi/global/global.dart';
import 'package:skysoft_taxi/screen_test/globaltest.dart';
import 'package:skysoft_taxi/url/contants.dart';
import 'package:skysoft_taxi/widgets/driver/user_info.dart';
import 'package:skysoft_taxi/widgets/user/side_bar.dart';
import 'package:skysoft_taxi/widgets/user/sidebar_toggle_button%20.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class HomeDriverTest extends StatefulWidget {
  const HomeDriverTest({super.key});

  @override
  State<HomeDriverTest> createState() => HomeDriverTestState();
}

class HomeDriverTestState extends State<HomeDriverTest>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey(); // hiển thị side_bar
  bool isUserInfo = true;
  @override
  void initState() {
    super.initState();
    channel = IOWebSocketChannel.connect(
        URL_WS + driverModel.role + "_" + driverModel.name);
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
            //màn hình userInfor
            Visibility(
              visible: isUserInfo,
              child: SlidingUpPanel(
                minHeight: 400,
                maxHeight: 400,
                backdropEnabled: true,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                panel: Material(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  child: UserInfo(
                    arrivedToUser: () {},
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
