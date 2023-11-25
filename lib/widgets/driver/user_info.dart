import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:skysoft_taxi/global/global.dart';

import '../driver/chat_with_user.dart';

class UserInfo extends StatefulWidget {
  final VoidCallback arrivedToUser;

  const UserInfo({Key? key, required this.arrivedToUser}) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Icon(
          Icons.horizontal_rule,
          color: Colors.grey,
          size: 30,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey[300]!,
                width: 1.0,
              ),
            ),
          ),
          child: const ListTile(
            title: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'User will be notified once you tap Arrived',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey[300]!,
                      width: 1.0,
                    ),
                  ),
                ),
                child: SizedBox(
                  height: 130,
                  child: GestureDetector(
                    onTap: () {
                      log("Tapped John Doe");
                    },
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                              'https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper-thumbnail.png',
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userModel.name,
                                    style: const TextStyle(
                                      fontFamily: 'Outfit',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  const Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                      child: Text(
                                        "User Expect you in a moment",
                                        style: TextStyle(
                                          fontFamily: 'Outfit',
                                          color: Colors.grey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: ListView(
                              scrollDirection: Axis
                                  .horizontal, // Đảm bảo có thể cuộn nếu nội dung quá dài
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    log("Tapped Mail Icon");
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ChatWithUserScreen(),
                                      ),
                                    ); // Add your mail icon's onTap functionality here
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blueGrey.shade100,
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Icon(
                                        Icons.mail,
                                        size: 30,
                                        color: Colors.blueGrey,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    log("Tapped Phone Icon");
                                    // Add your phone icon's onTap functionality here
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blueGrey.shade100,
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Icon(
                                        Icons.phone,
                                        size: 30,
                                        color: Colors.blueGrey,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                log("Tapped Ride Options");
                // Handle the "Ride Options" onTap event
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.list,
                    color: Colors.blueAccent,
                    size: 16,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 5, 15, 1),
                    child: Text(
                      'Ride Options',
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                log("Tapped Ride Safety");
                // Handle the "Ride Safety" onTap event
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.shield,
                    color: Colors.blueAccent,
                    size: 16,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 5, 15, 1),
                    child: Text(
                      'Ride Safety',
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 10, 10),
          child: ElevatedButton(
            onPressed: () {
              log("Tapped Arrived");
              widget.arrivedToUser();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 13, 93, 240),
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text(
              'Arrived',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
