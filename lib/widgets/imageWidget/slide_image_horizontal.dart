import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HorizontalImageSlider extends StatefulWidget {
  final List<String> imageUrls;

  const HorizontalImageSlider({super.key, required this.imageUrls});

  @override
  _HorizontalImageSliderState createState() => _HorizontalImageSliderState();
}

class _HorizontalImageSliderState extends State<HorizontalImageSlider> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return CarouselSlider(
      items: widget.imageUrls.map(
        (e) {
          return Padding(
            padding: const EdgeInsets.all(5),
            child: GestureDetector(
              onTap: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25), // Border radius
                      border: Border.all(
                        color: Colors.transparent, // Border color
                        width: 2, // Border width
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image(
                        image: NetworkImage(e),
                        height: height * 0.25, // Adjusted height
                        width:
                            double.infinity, // Adjusted width to fill the space
                        fit: BoxFit.fill, // Ensures full image is shown
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ).toList(),
      options: CarouselOptions(
        height: height * 0.5, // Adjusted height to make the image rectangular
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        enlargeCenterPage: true,
        viewportFraction:
            0.9, // Adjusted to show a portion of the next/previous image
      ),
    );
  }
}
