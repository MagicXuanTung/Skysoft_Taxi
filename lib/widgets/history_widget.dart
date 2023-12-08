import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryWidget extends StatefulWidget {
  final IconData iconLeft;
  final String text;
  final VoidCallback onTap;
  final bool isLast;

  const HistoryWidget({
    required this.iconLeft,
    required this.text,
    required this.onTap,
    this.isLast = false,
    Key? key,
  }) : super(key: key);

  @override
  State<HistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  String getCurrentTime() {
    return DateFormat('HH:mm').format(DateTime.now());
  }

  String getCurrentDate() {
    return DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.all(5),
              leading: Icon(
                widget.iconLeft,
                size: 25,
                color: Colors.blueGrey,
              ),
              title: Text(
                widget.text,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              subtitle: Text(
                '${getCurrentTime()} - ${getCurrentDate()}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              onTap: widget.onTap,
            ),
          ],
        ),
      ),
    );
  }
}
