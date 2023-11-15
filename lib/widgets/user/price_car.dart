import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:skysoft_taxi/widgets/user/paymentMethod.dart';

class PriceCar extends StatefulWidget {
  final VoidCallback onBookNow;
  const PriceCar({Key? key, required this.onBookNow}) : super(key: key);
  @override
  State<PriceCar> createState() => _PriceCarState();
}

class _PriceCarState extends State<PriceCar> {
  double opacity = 0.0;
  int selectedIdx = -1;
  String selectedText = "Regular"; // Initialize with "Regular"

  IconData paymentMethod = Icons.account_balance; // mặc định
  String paymentName = "Payment";

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        opacity = 1.0;
      });
    });
  }

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

  // 1: cash, 2: NH
  void choosePayment(IconData icon, String name) {
    paymentMethod = icon;
    paymentName = name;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 500),
      child: Column(
        children: [
          const SizedBox(
            height: 30,
            child: Icon(
              Icons.horizontal_rule,
              color: Colors.grey,
            ),
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
            child: SizedBox(
              height: 70,
              child: Center(
                child: IntrinsicWidth(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildTextItem("Regular"),
                      buildTextItem("Delivery"),
                      buildTextItem("Trucks"),
                      buildTextItem("Taxi"),
                      buildTextItem("Bikes"),
                    ],
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
                    log("Selected item: ${itemNames[index]}");
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
          SizedBox(
            height: 40,
            child: GestureDetector(
              onTap: () {
                log("Payment");
                setState(() {
                  selectedText = "Payment";
                });
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
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        log("Payment");
                        // setState(() {
                        //   selectedText = "Payment";
                        // });
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PaymentScreen(
                                onDone: (method, name) =>
                                    choosePayment(method, name)),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(width: 20),
                          Icon(
                            paymentMethod,
                            color: selectedText == "Payment"
                                ? Colors.blue
                                : Colors.blueGrey,
                            size: 16,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              5,
                              5,
                              10,
                              1,
                            ),
                            child: Text(
                              paymentName,
                              style: TextStyle(
                                color: selectedText == "Payment"
                                    ? Colors.blue
                                    : Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        log("Coupon Code");
                        setState(() {
                          selectedText = "Coupon Code";
                        });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.local_offer,
                            color: selectedText == "Coupon Code"
                                ? Colors.blue
                                : Colors.blueGrey,
                            size: 16,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              5,
                              5,
                              30,
                              1,
                            ),
                            child: Text(
                              'Coupon Code',
                              style: TextStyle(
                                color: selectedText == "Coupon Code"
                                    ? Colors.blue
                                    : Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
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
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
            ),
            child: SizedBox(
              height: 55.0,
              child: Center(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        start: 20,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          log('Book Now');
                          if (selectedIdx != -1) {
                            widget.onBookNow();
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Thông báo'),
                                  content: const Text('Vui lòng chọn xe'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE2E4E9),
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              85, 10, 85, 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          'Book Now',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        log("Calendar");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffe2e4e9),
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            20, 11, 20, 11),
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
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget buildTextItem(String text) {
    return GestureDetector(
      onTap: () {
        log(text);
        setState(() {
          selectedText = text;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: selectedText == text ? Colors.grey : Colors.transparent,
        ),
        padding: const EdgeInsets.all(10),
        child: Text(
          text,
          style: TextStyle(
            color: selectedText == text ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
