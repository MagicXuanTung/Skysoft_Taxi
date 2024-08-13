import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PriceCar extends StatefulWidget {
  final PanelController panelController;

  const PriceCar({super.key, required this.panelController});

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
      opacity = 1.0;
      setState(() {});
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
    'Tiết Kiệm',
    'Xe Điện',
    'Bình Thường',
    'Cao Cấp',
    'Thương Gia',
    'Đặc biệt',
  ];
  final List<String> subtitles = [
    '3 chỗ',
    '3 chỗ',
    '3 chỗ + hành lý',
    '5 chỗ + hành lý',
    '4 chỗ + hành lý nhỏ gọn',
    '1 chỗ',
  ];
  final List<String> prices = [
    '25.000đ',
    '26.000đ',
    '30.500đ',
    '40.000đ',
    '55.000đ',
    '60.000đ',
  ];

  // 1: cash, 2: NH
  void choosePayment(IconData icon, String name) {
    paymentMethod = icon;
    paymentName = name;
    setState(() {});
  }

  void _togglePanel() {
    if (widget.panelController.isPanelOpen) {
      widget.panelController.close();
    } else {
      widget.panelController.open();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 500),
      child: Column(
        children: [
          GestureDetector(
            onTap: _togglePanel,
            child: const SizedBox(
              height: 30,
              child: Icon(
                Icons.horizontal_rule,
                color: Colors.grey,
              ),
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
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  buildTextItem("Ôtô"),
                  buildTextItem("Xe máy"),
                  buildTextItem("Thuê xe theo giờ"),
                  buildTextItem("Sân bay"),
                  buildTextItem("Đặt xe cho bạn bè"),
                  buildTextItem("Giao hàng"),
                  buildTextItem("Đồ ăn"),
                  buildTextItem("Giao hàng oto"),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: assetNames.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    log("Selected item: ${itemNames[index]}");
                    selectedIdx = index;
                    setState(() {});
                  },
                  child: Container(
                    color: selectedIdx == index
                        ? const Color(0xFFE2E4E9)
                        : Colors.white,
                    child: ListTile(
                      leading: Image.asset(
                        'assets/images/${assetNames[index]}.png',
                        width: 65,
                        height: 56,
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            itemNames[index],
                            style: const TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            subtitles[index],
                            style: const TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 16,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Text(
                        prices[index],
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          color: Colors.green,
                          fontFamily: 'Readex Pro',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextItem(String text) {
    return GestureDetector(
      onTap: () {
        log(text);
        selectedText = text;
        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: selectedText == text ? Colors.blueAccent : Colors.transparent,
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
