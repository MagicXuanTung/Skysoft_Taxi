import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {
  final double width;
  final double height;

  final String leftDescription;
  final String rightDescription;

  final Icon leftIcon; // Added icon parameter
  final Icon rightIcon; // Added icon parameter

  final Color toggleColor;
  final Color toggleBackgroundColor;
  final Color toggleBorderColor;

  final Color inactiveTextColor;
  final Color activeTextColor;

  final VoidCallback onLeftToggleActive;
  final VoidCallback onRightToggleActive;

  const ToggleButton({
    Key? key,
    required this.width,
    required this.height,
    required this.toggleBackgroundColor,
    required this.toggleBorderColor,
    required this.toggleColor,
    required this.activeTextColor,
    required this.inactiveTextColor,
    required this.leftDescription,
    required this.rightDescription,
    required this.leftIcon, // Added icon parameter
    required this.rightIcon, // Added icon parameter
    required this.onLeftToggleActive,
    required this.onRightToggleActive,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ToggleButtonState createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  double _toggleXAlign = -1;
  bool _isLeftActive = true;

  void setActive(bool isLeftActive) {
    setState(() {
      _isLeftActive = isLeftActive;
      _toggleXAlign = isLeftActive ? -1 : 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.toggleBackgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(50.0),
        ),
        border: Border.all(color: widget.toggleBorderColor),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            alignment: Alignment(_toggleXAlign, 0),
            duration: const Duration(milliseconds: 300),
            child: Container(
              width: widget.width * 0.5,
              height: widget.height,
              decoration: BoxDecoration(
                color: widget.toggleColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(50.0),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (!_isLeftActive) {
                setState(() {
                  _toggleXAlign = -1;
                  _isLeftActive = true;
                });
                widget.onLeftToggleActive();
              }
            },
            child: Align(
              alignment: const Alignment(-1, 0),
              child: Container(
                width: widget.width * 0.5,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.leftIcon, // Display the left icon
                    const SizedBox(width: 8),
                    Text(
                      widget.leftDescription,
                      style: TextStyle(
                          fontSize: 12,
                          color: _isLeftActive
                              ? widget.activeTextColor
                              : widget.inactiveTextColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (_isLeftActive) {
                setState(() {
                  _toggleXAlign = 1;
                  _isLeftActive = false;
                });
                widget.onRightToggleActive();
              }
            },
            child: Align(
              alignment: const Alignment(1, 0),
              child: Container(
                width: widget.width * 0.5,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.rightIcon, // Display the right icon
                    const SizedBox(width: 8),
                    Text(
                      widget.rightDescription,
                      style: TextStyle(
                          fontSize: 12,
                          color: !_isLeftActive
                              ? widget.activeTextColor
                              : widget.inactiveTextColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
