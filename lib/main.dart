import 'package:flutter/material.dart';
import 'package:skysoft_taxi/widgets/bottom_navigate_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SKYSOFT Map',
        home: BottomNavigateBar());
  }
}
