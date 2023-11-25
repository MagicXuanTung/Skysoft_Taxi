import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:latlong2/latlong.dart';
import 'package:skysoft_taxi/global/global.dart';
import 'package:skysoft_taxi/models/user.model.dart';
import 'package:skysoft_taxi/widgets/button/button_counter.dart';
import 'package:skysoft_taxi/widgets/driver/driver_acpect.dart';
import 'package:skysoft_taxi/widgets/driver/payment_Info.dart';
import 'package:skysoft_taxi/widgets/driver/user_info.dart';

import '../url/contants.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../widgets/user/side_bar.dart';
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
  bool isButtonCounter = true; //man hinh chinh

  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey(); // hiển thị side_bar
  late IOWebSocketChannel channel;

  @override
  void initState() {
    super.initState();
    channel = IOWebSocketChannel.connect(
        URL_WS + driverModel.role + "_" + driverModel.name);

    channel.stream.listen((message) {
      //print("ChatScreen: " + message);
      final Map<String, dynamic> messageData = jsonDecode(message);
      final String receivedMessage = messageData['message'];
      userModel.name = messageData['sender'];
      if (receivedMessage == "BOOKING") {
        if (driverModel.status == Status.NORMAL) {
          isButtonCounter = false;
          isAcpect = true;
          setState(() {});
        }
      } else if (receivedMessage == "CANCELREQUEST") {
        if (driverModel.status == Status.NORMAL) {
          isAcpect = false;
          isButtonCounter = true;
          driverModel.changeStatusWithMessage("ENDTRIP");
          print(driverModel.status.toString() + "_" + "driver");
          print(userModel.status.toString() + "_" + "user");
          setState(() {});
        }
      } else if (receivedMessage == "CANCELTRIP") {
        if (driverModel.status == Status.BUSY) {
          isUserInfo = false;
          isButtonCounter = true;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Khách hàng đã hủy chuyến'),
              duration: Duration(seconds: 3),
            ),
          );
          driverModel.changeStatusWithMessage("ENDTRIP");
          print(driverModel.status.toString() + "_" + "driver");
          print(userModel.status.toString() + "_" + "user");
          setState(() {});
        }
      } else if (receivedMessage == "OK") {
        channel.sink.add(jsonEncode({
          "message": "OK",
          "sender": driverModel.name,
          "receiver": userModel.name, //người nhận
          "type": "private",
          //"points": "[21.03735349640734, 105.78897826869654]",
        }));
        isAcpect = false;
        isUserInfo = true;
        driverModel.changeStatusWithMessage("ACPECT");
        print(driverModel.status.toString() + "_" + "driver");
        print(userModel.status.toString() + "_" + "user");
        setState(() {});
      } else if (receivedMessage == "BUSY") {
        isAcpect = false;
        isButtonCounter = true;
        driverModel.changeStatusWithMessage("ENDTRIP");
        print(driverModel.status.toString() + "_" + "driver");
        print(userModel.status.toString() + "_" + "user");
        setState(() {});
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
      drawer: const SideBar(),
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
            //Màn chính
            Visibility(
              visible: isButtonCounter,
              child: ButtonCounter(),
            ),

            //Acpect
            Visibility(
              visible: isAcpect,
              child: DriverAcpect(
                onAcpectBooking: () {
                  channel.sink.add(jsonEncode({
                    "message": "ACPECT",
                    "sender": driverModel.name,
                    "receiver": userModel.name, //người nhận
                    "type": "private",
                    //"points": "[21.03735349640734, 105.78897826869654]",
                  }));
                  driverModel.changeStatusWithMessage("ACPECT");
                  print(driverModel.status.toString() + "_" + "driver");
                  print(userModel.status.toString() + "_" + "user");
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
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                panel: Material(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  child: UserInfo(
                    arrivedToUser: () {
                      isUserInfo = false;
                      isPaymentInfor = true;
                      setState(() {});
                      print(driverModel.status.toString() + "_" + "driver");
                      print(userModel.status.toString() + "_" + "user");
                    },
                  ),
                ),
              ),
            ),
            //payment
            Visibility(
              visible: isPaymentInfor,
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
                  child: PaymentInfo(
                    CashPaymentReceived: () {
                      channel.sink.add(jsonEncode({
                        "message": "KETTHUC",
                        "sender": driverModel.name,
                        "receiver": userModel.name, //người nhận
                        "type": "private",
                      }));
                      isPaymentInfor = false;
                      isButtonCounter = true;
                      driverModel.changeStatusWithMessage("ENDTRIP");
                      print(driverModel.status.toString() + "_" + "driver");
                      setState(() {});
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
