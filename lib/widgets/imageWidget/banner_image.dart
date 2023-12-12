import 'package:flutter/material.dart';

class BannerImage extends StatefulWidget {
  final String imageUrl;

  const BannerImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  State<BannerImage> createState() => _BannerImageState();
}

class _BannerImageState extends State<BannerImage> {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.network(
        widget.imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
