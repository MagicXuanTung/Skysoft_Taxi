import 'package:flutter/material.dart';

class ButtonSaveMaker extends StatefulWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  const ButtonSaveMaker({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });

  @override
  State<ButtonSaveMaker> createState() => _ButtonSaveMakerState();
}

class _ButtonSaveMakerState extends State<ButtonSaveMaker> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Icon(
              widget.icon,
              size: 12,
              color: Colors.blue,
            ),
            const SizedBox(width: 5.0),
            Text(
              widget.text,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
