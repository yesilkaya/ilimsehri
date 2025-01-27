import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../view/screens/gaybin_dili_screen.dart';

class LoadingCardAnimation extends StatefulWidget {
  const LoadingCardAnimation({super.key});

  @override
  LoadingCardAnimationState createState() => LoadingCardAnimationState();
}

class LoadingCardAnimationState extends State<LoadingCardAnimation> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: PageView.builder(
        controller: _pageController,
        itemCount: gaybinDiliImages.length,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[200],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: gaybinDiliImages[Random().nextInt(gaybinDiliImages.length - 1) + 1],
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}
