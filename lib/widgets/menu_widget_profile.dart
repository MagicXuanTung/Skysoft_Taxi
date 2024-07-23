import 'package:flutter/material.dart';

class MenuWidget extends StatefulWidget {
  final IconData iconLeft;
  final String text;
  final IconData iconRight;
  final VoidCallback onTap;
  final bool isLast;

  const MenuWidget({
    required this.iconLeft,
    required this.text,
    required this.iconRight,
    required this.onTap,
    this.isLast = false,
    Key? key,
  }) : super(key: key);

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsetsDirectional.all(15),
        decoration: BoxDecoration(
          border: widget.isLast
              ? null
              : Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade200,
                    width: 0.5,
                  ),
                ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      widget.iconLeft,
                      size: 20,
                      color: Colors.blueGrey,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      widget.text,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                Icon(
                  widget.iconRight,
                  size: 20,
                  color: Colors.black,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
