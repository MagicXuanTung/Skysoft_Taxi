import 'package:flutter/material.dart';

class StarsWidget extends StatelessWidget {
  const StarsWidget(
      {super.key,
      required this.numberOfStars,
      required this.size,
      required this.onClick});

  final int numberOfStars;
  final double size;
  final Function(int index) onClick;

  @override
  Widget build(BuildContext context) {
    return buildNumberStar(numberOfStars, size, onClick);
  }

  Row buildNumberStar(numberOfStars, size, onClick) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (index) {
          Color color = Colors.grey.withOpacity(0.4);
          if (index < numberOfStars) {
            color = Colors.amber;
          }

          return IconButton(
              onPressed: (() => onClick(index + 1)),
              icon: Icon(
                Icons.star,
                color: color,
                size: size,
              ));
        }));
  }
}
