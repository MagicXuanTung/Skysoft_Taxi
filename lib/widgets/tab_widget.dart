import 'package:flutter/material.dart';

class TabWidget extends StatefulWidget {
  final Icon icon;
  final String title;
  const TabWidget({Key? key, required this.icon, required this.title})
      : super(key: key);

  @override
  State<TabWidget> createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
