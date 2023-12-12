import 'package:flutter/material.dart';

class SaveMakerModel {
  IconData icon;
  String text;
  VoidCallback? onTap;

  SaveMakerModel({required this.icon, required this.text, this.onTap});
}
