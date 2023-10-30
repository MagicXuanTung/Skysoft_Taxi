import 'package:flutter/material.dart';

class CarInfo extends StatefulWidget {
  const CarInfo({super.key}); // Add this constructor

  @override
  State<CarInfo> createState() => _CarInfoState();
}

class _CarInfoState extends State<CarInfo> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Column(
            children: [
              const Row(
                children: [
                  Expanded(
                    child: Icon(
                      Icons.horizontal_rule,
                      color: Colors.grey,
                      size: 30, // Adjust the size of the icon as desired
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  // Add your tap action here
                },
                child: Container(
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0), // Add your desired padding
                        child: Text(
                          'Arring in 2 minutes from now',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20, // Increase the font size as needed
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    GestureDetector(
                      onTap: () {
                        // not used anything
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey[300]!,
                              width: 1.0,
                            ),
                          ),
                        ),
                        height: 130,
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .start, // Align text to the right
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Toyota Corolla",
                                    style: TextStyle(
                                      fontFamily: 'Outfit',
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Economy:",
                                        style: TextStyle(
                                          fontFamily: 'Outfit',
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            8, // Add spacing between the text
                                      ),
                                      Text(
                                        '\$25.12',
                                        style: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 25, // Add spacing between the text
                                  ),
                                  Text(
                                    "66C-038.27",
                                    style: TextStyle(
                                      fontFamily: 'Outfit',
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width:
                                    85, // Add spacing between the text and the image
                              ),
                              Image.asset(
                                'assets/images/economy.png',
                                width:
                                    150, // Increase the width to make the image more eye-catching
                                height:
                                    150, // Increase the height to make the image more eye-catching
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 130,
                      child: GestureDetector(
                        onTap: () {
                          // Handle the onTap event for the entire content
                        },
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.account_circle,
                                        size: 120,
                                        color: Colors.blueGrey,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 30),
                                            child: Text(
                                              "John Doe",
                                              style: TextStyle(
                                                fontFamily: 'Outfit',
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                                size: 20,
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                "5",
                                                style: TextStyle(
                                                  fontFamily: 'Outfit',
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // Add your mail icon's onTap functionality here
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
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
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // Add your phone icon's onTap functionality here
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
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
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  // not used anything
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey[300]!,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.list, // Replace with your desired icon
                            color: Colors.blueAccent,
                            size: 16, // Set the icon color
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                              5,
                              5,
                              15,
                              1,
                            ),
                            child: Text(
                              'Ride Options',
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 15,
                                fontWeight:
                                    FontWeight.w400, // Make the text bold
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.shield, // Replace with your desired icon
                            color: Colors.blueAccent,
                            size: 16, // Set the icon color
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                              5,
                              5,
                              15,
                              1,
                            ),
                            child: Text(
                              'Ride Safety',
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 15,
                                fontWeight:
                                    FontWeight.w400, // Make the text bold
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // not used anything
                },
                child: Align(
                  alignment: const AlignmentDirectional(0.00, 0.00),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                          30,
                          20,
                          30,
                          10,
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                                255, 13, 93, 240), // Replace with your color
                            padding: const EdgeInsets.symmetric(
                                horizontal: 85, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  15), // Adjust the radius as needed
                            ),
                          ),
                          child: const Text(
                            'Pay for a ride',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontStyle: FontStyle.normal, // Increase font size
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
