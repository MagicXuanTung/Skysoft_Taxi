import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:latlong2/latlong.dart';
import 'package:skysoft_taxi/global/global.dart';
import 'package:skysoft_taxi/models/user.model.dart';
import 'package:skysoft_taxi/widgets/bottom_navigate_bar.dart';

import '../url/contants.dart';
import '../widgets/user/reviews.dart';
//import '../widgets/destination_information.dart';
import '../widgets/user/searchOnPanalBar.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../widgets/user/panel_bar.dart';
import '../widgets/user/ride_requested.dart';
import '../widgets/user/car_info.dart';
import '../widgets/user/price_car.dart';
import '../widgets/user/side_bar.dart';
import '../widgets/user/sidebar_toggle_button .dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  late final _animatedMapController = AnimatedMapController(vsync: this);
  final TextEditingController _textFieldController = TextEditingController();
  final panelController = PanelController();

  bool isPanelVisible = true; // Hiển thị panal bar
  bool isPanelOpen = false; // kéo lên xuống panal bar
  //bool isDestination = false; // hiển thị màn hình destinatiion_information
  bool isReviews = false; // hiển thị màn hình review
  bool isRequested = false; // hiển thị màn hình request
  bool isDriverInfo = false; // hiển thị màn hình carinfor
  bool isPriceCar = false; // hiển thị màn hình priceCar
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey(); // hiển thị side_bar
  late IOWebSocketChannel channel;

  @override
  void initState() {
    super.initState();
    // channel.sink.add(jsonEncode({
    //   "message": "Booking",
    //   "sender": "Phạm Đức Đông",
    //   "receiver": "" //người nhận
    //   //"points": "[21.03735349640734, 105.78897826869654]",
    // }));
    channel = IOWebSocketChannel.connect(
        URL_CHAT + userModel.role + "_" + userModel.name);
    channel.stream.listen((message) {
      print("ChatScreen: " + message);
      final Map<String, dynamic> messageData = jsonDecode(message);
      final String receivedMessage = messageData['message'];
      driverModel.name = messageData['sender'];
      if (receivedMessage == "ACPECT") {
        if (userModel.status == Status.BUSY) {
          isRequested = false;
          isDriverInfo = true;
          setState(() {});
          userModel.changeStatusWithMessage("ACPECT");
          print(userModel.status.toString() + "user");
        }
      } else if (receivedMessage == "KETTHUC") {
        if (userModel.status != Status.NORMAL) {
          isDriverInfo = false;
          isReviews = true;
          setState(() {});
        }
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

            //search_onpanlbar
            Visibility(
              visible: isPanelVisible,
              child: SlidingUpPanel(
                minHeight: 110,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20.0)),
                backdropEnabled: true,
                controller: panelController,
                panel: Material(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20.0)),
                  child: PanelBar(
                    panelController: panelController,
                    onTextFieldPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Material(
                            child: SearchOnPanalBar(),
                          ),
                        ),
                      ).then((value) {
                        if (value == 'startButtonPressed') {
                          isPanelVisible = false;
                          isPriceCar = true;
                          setState(() {});
                          userModel.changeStatusWithMessage("ACPECT");
                          print(userModel.status.toString() + "user");
                        }
                      });
                    },
                  ),
                ),
              ),
            ),
            //màn hình reviews
            Visibility(
              visible: isReviews,
              child: SlidingUpPanel(
                minHeight: 300,
                maxHeight: 600,
                backdropEnabled: true,
                controller: panelController,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                panel: Material(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  child: Reviews(
                    panelController: panelController,
                    onClose: () {
                      isReviews = false;
                      isPanelVisible = true;
                      setState(() {});
                      userModel.changeStatusWithMessage("ENDTRIP");
                      print(driverModel.status.toString() + "user");
                    },
                  ),
                ),
              ),
            ),
            //màn hình price car
            Visibility(
              visible: isPriceCar,
              child: GestureDetector(
                child: Stack(
                  children: [
                    Positioned(
                      top: 40.0,
                      left: 16.0,
                      right: 16.0,
                      child: TextField(
                        readOnly: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Material(
                                child: SearchOnPanalBar(),
                              ),
                            ),
                          );
                        },
                        controller: _textFieldController,
                        decoration: InputDecoration(
                          hintText: 'Hà Nội',
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              _textFieldController.clear();
                              //isReviews = true; //test man reviews.
                              //isRequested = true; //test man ride request
                              isPriceCar = false;
                              //isCarInfo = true;
                              isPanelVisible = true;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ),
                    SlidingUpPanel(
                      minHeight: 550,
                      maxHeight: 550,
                      isDraggable: false,
                      backdropEnabled: true,
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20.0)),
                      panel: Material(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                        child: PriceCar(
                          //panelController: panelController,
                          onBookNow: () {
                            channel.sink.add(jsonEncode({
                              "message": "BOOKING",
                              "sender": userModel.name,
                              "receiver": driverModel.name //người nhận
                              //"points": "[21.03735349640734, 105.78897826869654]",
                            }));

                            isPriceCar = false;
                            isRequested = true;

                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //màn hình ride requested
            Visibility(
              visible: isRequested,
              child: SlidingUpPanel(
                minHeight: 250,
                maxHeight: 250,
                isDraggable: false,
                backdropEnabled: true,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20.0)),
                panel: Material(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  child: RideRequested(
                    onCancelRequest: () {
                      channel.sink.add(jsonEncode({
                        "message": "CANCELREQUEST",
                        "sender": userModel.name,
                        "receiver": driverModel.name //người nhận
                        //"points": "[21.03735349640734, 105.78897826869654]",
                      }));
                      isRequested = false;
                      isPriceCar = true;
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
