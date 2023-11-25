import 'package:flutter/material.dart';

class ButtonCounter extends StatefulWidget {
  const ButtonCounter({Key? key}) : super(key: key);

  @override
  _ButtonCounterState createState() => _ButtonCounterState();
}

class _ButtonCounterState extends State<ButtonCounter> {
  int counter = 1; // Set initial value to 1

  void _incrementCounter() {
    if (counter < 5) {
      counter++;
    }
    setState(() {});
  }

  void _decrementCounter() {
    if (counter > 1) {
      counter--;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double topPosition = screenHeight * 0.7; // Adjust the multiplier as needed

    return Positioned(
      top: topPosition,
      left: 0,
      right: 0,
      child: GestureDetector(
        onTap: () => {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              child: ElevatedButton(
                onPressed: _decrementCounter,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                  backgroundColor: Colors.orangeAccent,
                ),
                child: const Icon(Icons.remove, size: 18),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(13),
              decoration: const BoxDecoration(
                color: Colors.white, // White background for the text
              ),
              child: Text(
                '$counter K/M',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: ElevatedButton(
                onPressed: _incrementCounter,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 14),
                  backgroundColor: Colors.orangeAccent, // Remove the shadow
                ),
                child: const Icon(Icons.add, size: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
