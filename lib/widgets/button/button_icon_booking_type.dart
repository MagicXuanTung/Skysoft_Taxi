import 'package:flutter/material.dart';

class ButtonIconBookingType extends StatefulWidget {
  final String imagePath;
  final String text;

  final VoidCallback? onTap;

  const ButtonIconBookingType(
      {Key? key, required this.imagePath, required this.text, this.onTap})
      : super(key: key);

  @override
  State<ButtonIconBookingType> createState() => _ButtonIconBookingTypeState();
}

class _ButtonIconBookingTypeState extends State<ButtonIconBookingType> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  widget.imagePath,
                  width: 20,
                  height: 20,
                  fit: BoxFit.fill,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            widget.text,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
