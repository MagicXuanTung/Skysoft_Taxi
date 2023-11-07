import 'package:flutter/material.dart';
import 'package:skysoft_taxi/screens/login_sign_up.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Skysoft taxi ',
        home: LoginScreen());
  }
}
