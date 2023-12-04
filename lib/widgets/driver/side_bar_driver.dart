// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:skysoft_taxi/global/global.dart';
import '../../screen/login_screen.dart';

class SideBarDriver extends StatefulWidget {
  const SideBarDriver({super.key});

  @override
  _SideBarDriverState createState() => _SideBarDriverState();
}

class _SideBarDriverState extends State<SideBarDriver> {
  int selectedIndex = 0; // Add your initial state logic here

  void onItemTapped(int index) {
    selectedIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(25),
        bottomRight: Radius.circular(25),
      ),
      child: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _buildHeader(),
            _buildListTile(Icons.home, 'Home', Colors.blueGrey, 0),
            _buildListTile(Icons.account_circle, 'Profile', Colors.blueGrey, 3),
            _buildListTile(
                Icons.notifications, 'Announcement', Colors.blueGrey, 4),
            _buildListTile(Icons.wallet, 'Wallet', Colors.blueGrey, 5),
            _buildListTile(
                Icons.location_on, 'Save Locations', Colors.blueGrey, 6),
            _buildListTile(
                Icons.directions_car, 'Reserved Rides', Colors.blueGrey, 7),
            _buildListTile(Icons.history, 'Trip History', Colors.blueGrey, 8),
            _buildListTile(Icons.language, 'Website', Colors.blueGrey, 9),
            _buildListTile(Icons.settings, 'Settings', Colors.blueGrey, 10),
            _buildListTile(Icons.info, 'About', Colors.blueGrey, 11),
            _buildListTile(Icons.exit_to_app, 'Logout', Colors.blueGrey, 12),
          ],
        ),
      ),
    );
  }

  ListTile _buildListTile(
      IconData icon, String title, Color textColor, int index) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Padding(
        padding: const EdgeInsets.only(left: 35),
        child: Icon(icon, color: Colors.blueGrey),
      ),
      title: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Text(
          title,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
      tileColor: selectedIndex == index ? const Color(0xFFE2E4E9) : null,
      onTap: () {
        onItemTapped(index);
        _navigateToPage(index);
      },
    );
  }

// THAY ĐỔI HOME THÀNH WIDGET MUỐN ĐIỀU HƯỚNG Home()
  void _navigateToPage(int index) {
    switch (index) {
      case 0:
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => const Home()));
        break;
      case 3:
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => const HomeDriver()));
        break;
      case 4:
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => const Home()));
        break;
      case 5:
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => const Home()));
        break;
      case 6:
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => const Home()));
        break;
      case 7:
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => const Home()));
        break;
      case 8:
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => const Home()));
        break;
      case 9:
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => const Home()));
        break;
      case 10:
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => const Home()));
        break;
      case 11:
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => const Home()));
        break;
      case 12:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
        break;
    }
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(50),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(
                'https://cdn0.iconfinder.com/data/icons/taxi-12/500/SingleCartoonTaxiYulia_10-512.png'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  driverModel.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
