import 'package:flutter/material.dart';

import '../../constant/color_styles.dart';

class ImsakiyeScreen extends StatelessWidget {
  const ImsakiyeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.appBackGroundColor,
      appBar: AppBar(
        title: Text(
          'Ramazan İmsakiyesi ${DateTime.now().year} (İstanbul)',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        centerTitle: true,
        leading: const BackButton(color: ColorStyles.appTextColor),
        backgroundColor: ColorStyles.appBackGroundColor,
        elevation: 0,
        actions: [
          IconButton(
            color: ColorStyles.appTextColor,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: const Duration(seconds: 8),
                backgroundColor: ColorStyles.appBackGroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                content: const Center(
                  child: Text(
                    "Ramazan ayı başlangıcı ve muhtemel kadir geceleri taklit ettiğiniz müçtehidin fetvasına göre farklılık gösterebilir. Lütfen taklit ettiğiniz  müçetihin fetvasını dikkate alınız.",
                    style: TextStyle(color: ColorStyles.appTextColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              ));
            },
            icon: const Icon(Icons.info_outline),
          )
        ],
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
