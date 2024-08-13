import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RideRequested extends StatefulWidget {
  const RideRequested({super.key});

  @override
  _RideRequestedState createState() => _RideRequestedState();
}

class _RideRequestedState extends State<RideRequested> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const Text(
            'Tìm kiếm tài xế',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 18.0),
          const LinearProgressIndicator(
            color: Colors.blueAccent,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Đang tìm kiếm tài xế lân cận tại vị trí của bạn',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 18.0),
          ElevatedButton(
            onPressed: () {
              log('Dừng tìm kiếm');
              Navigator.of(context).pop();
            },
            style: ButtonStyle(
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              backgroundColor: WidgetStateProperty.all(Colors.grey[200]),
            ),
            child: const Text('Dừng tìm kiếm',
                style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
