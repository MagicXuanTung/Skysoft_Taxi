import 'package:flutter/material.dart';

class RideRequested extends StatefulWidget {
  const RideRequested({super.key});

  @override
  _RideRequestedState createState() => _RideRequestedState();
}

class _RideRequestedState extends State<RideRequested> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const Text(
                'Ride Requested',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 18.0),
              const LinearProgressIndicator(),
              const SizedBox(height: 18.0),
              const Text(
                'We are looking for the nearest driver for you',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 18.0),
              ElevatedButton(
                onPressed: () {
                  print('cancel requested');
                },
                style: ButtonStyle(
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  backgroundColor: WidgetStateProperty.all(Colors.grey[200]),
                ),
                child: const Text('Cancel Request',
                    style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
