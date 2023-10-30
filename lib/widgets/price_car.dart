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
          height: 30, // Adjust the size of the icon as needed
          child: Icon(
            Icons.horizontal_rule,
            color: Colors.grey,
          ),
        ),
        GestureDetector(
          onTap: () {
            // Add your tap action here
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
                      horizontal: 20.0), // Add your desired padding
                  child: Text(
                    'List Cars and Prices',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 25, // Increase the font size as needed
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: assetNames.length, // Number of items
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Update the selected index when an item is tapped
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.sell, // Replace with your desired icon
                  color: Colors.lightBlueAccent,
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
        GestureDetector(
          onTap: () {
            // not used anything
          },
          child: Align(
            alignment: const AlignmentDirectional(0.00, 0.00),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: const AlignmentDirectional(0.00, 0.00),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      20,
                      15,
                      20,
                      10,
                    ),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFFE2E4E9), // Replace with your color
                        padding: const EdgeInsetsDirectional.fromSTEB(
                          90,
                          15,
                          90,
                          15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              15), // Adjust the radius as needed
                        ), // Increase the padding
                      ),
                      child: const Text(
                        'Book Now',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontStyle: FontStyle.normal, // Increase font size
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                          0xFFE2E4E9), // Change the background color to gray
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        16,
                        11,
                        16,
                        11,
                      ), // Increase the padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            15), // Adjust the radius as needed
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.calendar_month,
                          size: 30,
                          color: Colors.black, // Increase the size of the icon
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
