import 'package:flutter/material.dart';

class PriceCar extends StatefulWidget {
  const PriceCar({
    Key? key,
  }) : super(key: key);

  @override
  State<PriceCar> createState() => _PriceCarState();
}

class _PriceCarState extends State<PriceCar> with TickerProviderStateMixin {
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
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 13.0),
                child: GestureDetector(
                    onTap: () async {},
                    child: const Text("List Cars and Prices")),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Align(
                      alignment: const AlignmentDirectional(0.00, 0.00),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ListTile(
                            leading: Image.asset(
                              'assets/images/economy.png', // Replace with your online image URL
                              width:
                                  90, // Adjust the width of the image as needed
                              height:
                                  90, // Adjust the height of the image as needed
                            ),
                            title: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Economy',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '3 seats',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    fontSize: 16, // Adjust the font size
                                    color: Colors.grey, // Adjust the color
                                  ),
                                ),
                              ],
                            ),
                            subtitle: const Text(
                              '\$25.12',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            tileColor: Colors.grey, // Replace with your color
                            dense: false,
                          ),
                          ListTile(
                            leading: Image.asset(
                              'assets/images/electric.png', // Replace with your online image URL
                              width:
                                  90, // Adjust the width of the image as needed
                              height:
                                  90, // Adjust the height of the image as needed
                            ),
                            title: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Electric',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '3 seats',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    fontSize: 16, // Adjust the font size
                                    color: Colors.grey, // Adjust the color
                                  ),
                                ),
                              ],
                            ),
                            subtitle: const Text(
                              '\$26.10',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            tileColor: Colors.grey, // Replace with your color
                            dense: false,
                          ),
                          ListTile(
                            leading: Image.asset(
                              'assets/images/plus.png', // Replace with your online image URL
                              width:
                                  90, // Adjust the width of the image as needed
                              height:
                                  90, // Adjust the height of the image as needed
                            ),
                            title: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Plus',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '3 seats + luggage',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    fontSize: 16, // Adjust the font size
                                    color: Colors.grey, // Adjust the color
                                  ),
                                ),
                              ],
                            ),
                            subtitle: const Text(
                              '\$30.50',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            tileColor: Colors.grey, // Replace with your color
                            dense: false,
                          ),
                          ListTile(
                            leading: Image.asset(
                              'assets/images/premium.png', // Replace with your online image URL
                              width:
                                  90, // Adjust the width of the image as needed
                              height:
                                  90, // Adjust the height of the image as needed
                            ),
                            title: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Premium',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '5 seats + luggage',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    fontSize: 16, // Adjust the font size
                                    color: Colors.grey, // Adjust the color
                                  ),
                                ),
                              ],
                            ),
                            subtitle: const Text(
                              '\$40.00',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            tileColor: Colors.grey, // Replace with your color
                            dense: false,
                          ),
                          ListTile(
                            leading: Image.asset(
                              'assets/images/luxury.png', // Replace with your online image URL
                              width:
                                  90, // Adjust the width of the image as needed
                              height:
                                  90, // Adjust the height of the image as needed
                            ),
                            title: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Luxury',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '4 seats + small luggage',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    fontSize: 16, // Adjust the font size
                                    color: Colors.grey, // Adjust the color
                                  ),
                                ),
                              ],
                            ),
                            subtitle: const Text(
                              '\$55.00',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            tileColor: Colors.grey, // Replace with your color
                            dense: false,
                          ),
                          ListTile(
                            leading: Image.asset(
                              'assets/images/sport.png', // Replace with your online image URL
                              width:
                                  90, // Adjust the width of the image as needed
                              height:
                                  90, // Adjust the height of the image as needed
                            ),
                            title: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sport',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '1 seats',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    fontSize: 16, // Adjust the font size
                                    color: Colors.grey, // Adjust the color
                                  ),
                                ),
                              ],
                            ),
                            subtitle: const Text(
                              '\$60.00',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            tileColor: Colors.grey, // Replace with your color
                            dense: false,
                          ),
                          Align(
                            alignment: const AlignmentDirectional(0.00, 0.00),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                  alignment:
                                      const AlignmentDirectional(0.00, 0.00),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                      50,
                                      0,
                                      0,
                                      0,
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                            0xFFE2E4E9), // Replace with your color
                                        padding: const EdgeInsets.all(
                                            20), // Increase the padding
                                      ),
                                      child: const Text(
                                        'Button',
                                        style: TextStyle(
                                          fontSize: 30, // Increase font size
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                    50,
                                    0,
                                    0,
                                    0,
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.calendar_today,
                                      color: Color(0xFF9FA6B5),
                                      size: 24,
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
