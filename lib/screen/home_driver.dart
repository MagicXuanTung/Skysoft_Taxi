import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:latlong2/latlong.dart';
import 'package:skysoft_taxi/global/global.dart';
import 'package:skysoft_taxi/widgets/driver/driver_acpect.dart';
import 'package:skysoft_taxi/widgets/driver/payment_Info.dart';
import 'package:skysoft_taxi/widgets/driver/side_bar_driver.dart';
import 'package:skysoft_taxi/widgets/driver/user_info.dart';

import '../url/contants.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../widgets/button/button_counter.dart';
import '../widgets/button/button_current_location.dart';
import '../widgets/user/sidebar_toggle_button .dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class HomeDriver extends StatefulWidget {
  const HomeDriver({super.key});

  @override
  State<HomeDriver> createState() => HomeDriverState();
}

class HomeDriverState extends State<HomeDriver> with TickerProviderStateMixin {
  late final _animatedMapController = AnimatedMapController(vsync: this);
  final TextEditingController _textFieldController = TextEditingController();

  bool isReviews = false; // hiển thị màn hình review
  bool isAcpect = false; // hiển thị màn hình Acpect
  bool isUserInfo = false; //Màn userInfo
  bool isPaymentInfor = false; //man hinh paymenInfor

  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey(); // hiển thị side_bar
  late IOWebSocketChannel channel;

  @override
  void initState() {
    super.initState();
    channel = IOWebSocketChannel.connect(
        "$URL_CHAT${driverModel.role}_${driverModel.name}");

    channel.stream.listen((message) {
      //log("ChatScreen: " + message);
      final Map<String, dynamic> messageData = jsonDecode(message);
      final String receivedMessage = messageData['message'];
      userModel.name = messageData['sender'];
      if (receivedMessage == "BOOKING") {
        isAcpect = true;
        setState(() {});
        driverModel.changeStatusWithMessage("ACPECT");
        log("${driverModel.status}_driver");
      } else if (receivedMessage == "CANCELREQUEST") {
        isAcpect = false;
        setState(() {});
        driverModel.changeStatusWithMessage("ENDTRIP");
        log("${driverModel.status}_driver");
      }
    });
  }

  @override
  void dispose() {
    channel.sink.close(status.goingAway);
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBarDriver(),
      key: _scaffoldKey,
      body: GestureDetector(
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
            const ButtonCounter(),
            const CurrentLocationButton(),
            //Acpect
            Visibility(
              visible: isAcpect,
              child: DriverAcpect(
                onAcpectBooking: () {
                  isAcpect = false;
                  isUserInfo = true;
                  channel.sink.add(jsonEncode({
                    "message": "ACPECT",
                    "sender": driverModel.name,
                    "receiver": userModel.name //người nhận
                    //"points": "[21.03735349640734, 105.78897826869654]",
                  }));
                  driverModel.changeStatusWithMessage("ACPECT");
                  log("${driverModel.status}_user");
                  setState(() {});
                },
              ),
            ),
            //màn hình userInfor
            Visibility(
              visible: isUserInfo,
              child: SlidingUpPanel(
                minHeight: 400,
                maxHeight: 400,
                backdropEnabled: true,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20.0)),
                panel: Material(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  child: UserInfo(
                    Arrived: () {
                      isUserInfo = false;
                      isPaymentInfor = true;
                      setState(() {});
                    },
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isPaymentInfor,
              child: SlidingUpPanel(
                minHeight: 450,
                maxHeight: 450,
                backdropEnabled: true,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20.0)),
                panel: Material(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  child: PaymentInfo(
                    cashPaymentReceived: () {
                      channel.sink.add(jsonEncode({
                        "message": "KETTHUC",
                        "sender": driverModel.name,
                        "receiver": userModel.name //người nhận
                      }));
                      isPaymentInfor = false;
                      setState(() {});
                      driverModel.changeStatusWithMessage("ENDTRIP");
                      log("${driverModel.status}_driver");
                    },
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
