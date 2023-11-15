// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DestinationInformation extends StatefulWidget {
  final PanelController panelController;
  final VoidCallback bookCar;
  const DestinationInformation(
      {Key? key, required this.panelController, required this.bookCar})
      : super(key: key);

  @override
  _DestinationInformationState createState() => _DestinationInformationState();
}

class _DestinationInformationState extends State<DestinationInformation> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.pixels > 0) {
        widget.panelController.open();
      } else {
        widget.panelController.close();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
            child: Icon(
              Icons.horizontal_rule,
              color: Colors.grey,
              size: 30,
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              controller: controller,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  margin: const EdgeInsets.only(bottom: 5, left: 5),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey[300]!,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Hà Nội',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 16.0, top: 16),
                  child: const Text('Thời gian: 150 phút',
                      style: TextStyle(fontSize: 18)),
                ),
                Container(
                  padding:
                      const EdgeInsets.only(left: 16.0, top: 10, bottom: 16),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey[300]!,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: const Text('Quãng đường: 117 km',
                      style: TextStyle(fontSize: 18)),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          log('instruction');
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.directions, size: 24),
                            Text(' Đường đi'),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          log('start');
                          widget.bookCar();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.assistant_navigation, size: 24),
                            Text(' Đặt xe'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
