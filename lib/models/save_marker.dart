import 'package:flutter/material.dart';

class SaveMaker {
  IconData icon;
  String text;
  VoidCallback? onTap;

  SaveMaker({required this.icon, required this.text, this.onTap});
}
