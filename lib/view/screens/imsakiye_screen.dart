import 'package:flutter/material.dart';

import '../../constant/color_styles.dart';

class FullScreenImagePage extends StatelessWidget {
  const FullScreenImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.appBackGroundColor,
      appBar: AppBar(
        title: Text(
          '2025 Ramazan İmsakiyesi',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        leading: const BackButton(color: ColorStyles.appTextColor),
        backgroundColor: ColorStyles.appBackGroundColor,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 40),
            child: Center(
              child: InteractiveViewer(
                panEnabled: true,
                boundaryMargin: EdgeInsets.zero,
                minScale: 0.5,
                maxScale: 3.0,
                child: Image.asset(
                  'assets/img/png/imsakiye.png',
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
