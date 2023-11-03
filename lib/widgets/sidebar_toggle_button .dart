// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class SidebarToggleButton extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function? onPressed;

  const SidebarToggleButton({
    required this.scaffoldKey,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  _SidebarToggleButtonState createState() => _SidebarToggleButtonState();
}

class _SidebarToggleButtonState extends State<SidebarToggleButton> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40.0,
      left: 15.0,
      child: GestureDetector(
        onTap: () {
          if (widget.onPressed != null) {
            widget.onPressed!();
          } else {
            widget.scaffoldKey.currentState!.openDrawer();
          }
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
