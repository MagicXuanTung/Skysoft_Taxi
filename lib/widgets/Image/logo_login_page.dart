import 'package:flutter/material.dart';

class LogoImage extends StatefulWidget {
  final String imageUrl;
  const LogoImage({super.key, required this.imageUrl});

  @override
  // ignore: library_private_types_in_public_api
  _LogoImageState createState() => _LogoImageState();
}

class _LogoImageState extends State<LogoImage> {
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Image.network(
        widget.imageUrl,
        width: 120,
        height: 120,
      ),
    );
  }
}
