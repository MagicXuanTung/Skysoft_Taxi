import 'package:flutter/material.dart';

class CircularImageWidget extends StatefulWidget {
  final String imageUrl;

  const CircularImageWidget({Key? key, required this.imageUrl})
      : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _CircularImageWidgetState createState() => _CircularImageWidgetState();
}

class _CircularImageWidgetState extends State<CircularImageWidget> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight / 12,
      child: ClipOval(
        child: Image.network(
          widget.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
