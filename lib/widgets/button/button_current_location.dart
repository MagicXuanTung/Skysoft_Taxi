import 'package:flutter/material.dart';

class CurrentLocationButton extends StatefulWidget {
  const CurrentLocationButton({super.key});

  @override
  _CurrentLocationButtonState createState() => _CurrentLocationButtonState();
}

class _CurrentLocationButtonState extends State<CurrentLocationButton> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 630,
      left: 340,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.location_searching,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
