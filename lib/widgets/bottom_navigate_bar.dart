// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:skysoft_taxi/screen/xanh_sm_clone/goi_xe.dart';
import 'package:skysoft_taxi/screen/xanh_sm_clone/hoat_dong.dart';
import 'package:skysoft_taxi/screen/xanh_sm_clone/tai_khoan.dart';
import 'package:skysoft_taxi/screen/xanh_sm_clone/thong_bao.dart';

class BottomNavigateBar extends StatefulWidget {
  const BottomNavigateBar({Key? key}) : super(key: key);

  @override
  _BottomNavigateBarState createState() => _BottomNavigateBarState();
}

class _BottomNavigateBarState extends State<BottomNavigateBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const BookingCar(),
    const ActivityDaily(),
    const NotificationPage(),
    const ProfilePage()
  ];

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
                  currentIndex: _currentIndex,
                  onTap: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
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
                      icon: Icon(Icons.notifications_active,
                          color: _currentIndex == 2
                              ? Colors.blue.shade700
                              : Colors.grey),
                      label: 'Thông báo',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.account_circle,
                          color: _currentIndex == 3
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

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Explore Screen'),
    );
  }
}
