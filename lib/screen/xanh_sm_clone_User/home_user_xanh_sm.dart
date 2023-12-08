import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:skysoft_taxi/global/global.dart';
import 'package:skysoft_taxi/models/user.model.dart';
import 'package:skysoft_taxi/screen/xanh_sm_clone_User/goi_xe.dart';
import 'package:skysoft_taxi/screen/xanh_sm_clone_User/hoat_dong.dart';
import 'package:skysoft_taxi/screen/xanh_sm_clone_User/tai_khoan.dart';
import 'package:skysoft_taxi/screen/xanh_sm_clone_User/thong_bao.dart';
import 'package:skysoft_taxi/screen/xanh_sm_clone_User/user_chat_all.dart';
import 'package:skysoft_taxi/url/contants.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class HomeUserXanhSm extends StatefulWidget {
  const HomeUserXanhSm({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeUserXanhSmState createState() => _HomeUserXanhSmState();
}

class _HomeUserXanhSmState extends State<HomeUserXanhSm> {
  int _currentIndex = 0;
  // late IOWebSocketChannel channel;
  bool isRequested = false;
  bool isDriverInfo = false;
  bool isReviews = false;

  final List<Widget> _pages = [
    const BookingCar(),
    const ActivityDaily(),
    const UserChatAll(),
    const NotificationPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    // channel.sink.add(jsonEncode({
    //   "message": "Booking",
    //   "sender": "Phạm Đức Đông",
    //   "receiver": "" //người nhận
    //   //"points": "[21.03735349640734, 105.78897826869654]",
    // }));
    // channel = IOWebSocketChannel.connect(
    //     "$URL_WS${userModel.role}_${userModel.name}");
    // channel.stream.listen((message) {
    //   // print("ChatScreen: " + message);
    //   final Map<String, dynamic> messageData = jsonDecode(message);
    //   final String receivedMessage = messageData['message'];
    //   driverModel.name = messageData['sender'];
    //   if (receivedMessage == "ACPECT") {
    //     if (userModel.status == Status.NORMAL) {
    //       isRequested = false;
    //       isDriverInfo = true;
    //       userModel.changeStatusWithMessage("ACPECT");
    //       print("${userModel.status}_user");
    //       channel.sink.add(jsonEncode({
    //         "message": "OK",
    //         "sender": userModel.name,
    //         "receiver": driverModel.name, //người nhận
    //         "type": "private",
    //         //"points": "[21.03735349640734, 105.78897826869654]",
    //       }));
    //       setState(() {});
    //     }
    //   } else if (receivedMessage == "KETTHUC") {
    //     if (userModel.status == Status.BUSY) {
    //       isDriverInfo = false;
    //       isReviews = true;
    //       userModel.changeStatusWithMessage("ENDTRIP");
    //       print("${userModel.status}_user");
    //       setState(() {});
    //     }
    //   }
    // });
  }

  @override
  void dispose() {
    // channel.sink.close(status.goingAway);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: _pages[_currentIndex]),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
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
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: _currentIndex,
                  onTap: (index) {
                    _currentIndex = index;
                    setState(() {});
                  },
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  iconSize: 25,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.local_taxi,
                          color: _currentIndex == 0
                              ? Colors.blue.shade700
                              : Colors.grey),
                      label: 'Gọi xe',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.schedule,
                          color: _currentIndex == 1
                              ? Colors.blue.shade700
                              : Colors.grey),
                      label: 'Hoạt động',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.group,
                          color: _currentIndex == 2
                              ? Colors.blue.shade700
                              : Colors.grey),
                      label: 'Trò chuyện',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.notifications_active,
                          color: _currentIndex == 3
                              ? Colors.blue.shade700
                              : Colors.grey),
                      label: 'Thông báo',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.account_circle,
                          color: _currentIndex == 4
                              ? Colors.blue.shade700
                              : Colors.grey),
                      label: 'Tài Khoản',
                    ),
                  ],
                  selectedItemColor: Colors.blue.shade700,
                  unselectedItemColor: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
