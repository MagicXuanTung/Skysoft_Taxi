import 'package:flutter/material.dart';

class LogoImage extends StatelessWidget {
  final String imageUrl;
  const LogoImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Image.asset(
        imageUrl,
        width: 120,
        height: 120,
      ),
    );
  }
}
