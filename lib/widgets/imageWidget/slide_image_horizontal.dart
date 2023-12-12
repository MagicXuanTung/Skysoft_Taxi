import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HorizontalImageSlider extends StatefulWidget {
  final List<String> imageUrls;

  const HorizontalImageSlider({super.key, required this.imageUrls});

  @override
  // ignore: library_private_types_in_public_api
  _HorizontalImageSliderState createState() => _HorizontalImageSliderState();
}

class _HorizontalImageSliderState extends State<HorizontalImageSlider> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoSlide();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    Timer.periodic(
      const Duration(seconds: 2),
      (timer) {
        if (_currentPage < widget.imageUrls.length - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }

        if (_pageController.hasClients) {
          _pageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.0,
      child: PageView.builder(
        physics: const BouncingScrollPhysics(),
        controller: _pageController,
        itemCount: widget.imageUrls.length,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: CachedNetworkImage(
                imageUrl: widget.imageUrls[index],
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
