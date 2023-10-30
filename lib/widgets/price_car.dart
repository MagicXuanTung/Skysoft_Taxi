import 'dart:developer';

import 'package:flutter/material.dart';

class PriceCar extends StatefulWidget {
  const PriceCar({
    Key? key,
  }) : super(key: key);

  @override
  State<PriceCar> createState() => _PriceCarState();
}

class _PriceCarState extends State<PriceCar> {
  int selectedIdx = -1;

  // Define the data for the list items
  final List<String> assetNames = [
    'economy',
    'electric',
    'plus',
    'premium',
    'luxury',
    'sport',
  ];
  final List<String> itemNames = [
    'Economy',
    'Electric',
    'Plus',
    'Premium',
    'Luxury',
    'Sport',
  ];
  final List<String> subtitles = [
    '3 seats',
    '3 seats',
    '3 seats + luggage',
    '5 seats + luggage',
    '4 seats + small luggage',
    '1 seat',
  ];
  final List<String> prices = [
    '\$25.12',
    '\$26.10',
    '\$30.50',
    '\$40.00',
    '\$55.00',
    '\$60.00',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
          child: Icon(
            Icons.horizontal_rule,
            color: Colors.grey,
          ),
        ),
        GestureDetector(
          onTap: () {
            log("List Cars and Prices"); // Log the text when tapped
          },
          child: Container(
            height: 70,
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
                    horizontal: 20.0,
                  ),
                  child: Text(
                    'List Cars and Prices',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: assetNames.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  log("Selected item: ${itemNames[index]}"); // Log the selected item
                  setState(() {
                    selectedIdx = index;
                  });
                },
                child: Container(
                  color: selectedIdx == index
                      ? const Color(0xFFE2E4E9)
                      : Colors.white,
                  child: ListTile(
                    leading: Image.asset(
                      'assets/images/${assetNames[index]}.png',
                      width: 90,
                      height: 90,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          itemNames[index],
                          style: const TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          subtitles[index],
                          style: const TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      prices[index],
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        GestureDetector(
          onTap: () {
            log("Coupon Code");
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.sell,
                  color: Colors.lightBlueAccent,
                  size: 16,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                    5,
                    5,
                    15,
                    1,
                  ),
                  child: Text(
                    'Coupon Code',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(0.00, 0.00),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  20,
                  15,
                  20,
                  10,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    log('Book Now');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE2E4E9),
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      90,
                      15,
                      90,
                      15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'Book Now',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    log("Calendar");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE2E4E9),
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      16,
                      11,
                      16,
                      11,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.calendar_month,
                        size: 30,
                        color: Colors.black,
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
