import 'package:flutter/material.dart';

import '../../constant/color_styles.dart';
import '../../constant/constants.dart';
import 'banner_m.dart';

class BannerMStyle1 extends StatelessWidget {
  const BannerMStyle1({
    super.key,
    this.imageUrl,
    required this.text,
    required this.title,
    this.footnote,
    required this.press,
  });
  final String? imageUrl;
  final String text;
  final String title;
  final String? footnote;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    List<Shadow> textShadow = [
      const Shadow(
          offset: Offset(2.0, 2.0), // Gölgenin konumu
          blurRadius: 6.0, // Gölgenin bulanıklık derecesi
          color: Colors.black),
      const Shadow(
          offset: Offset(-2.0, -2.0), // Gölgenin konumu
          blurRadius: 6.0, // Gölgenin bulanıklık derecesi
          color: Colors.black),
    ];

    return BannerM(
      image: imageUrl ?? "https://i.imgur.com/WiZRAZC.jpeg",
      press: press,
      children: [
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
                child: Stack(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: ColorStyles.textWhite,
                          fontFamily: 'Montserrat',
                          shadows: textShadow),
                    ),
                    Positioned(
                      top: 22, // Alt çizgi ile metin arasındaki boşluk
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 1, // Alt çizginin kalınlığı
                        color: ColorStyles.textWhite, // Alt çizginin rengi
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 1),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: SizedBox(
                  height: 100,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          text,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: ColorStyles.textWhite,
                              fontFamily: 'Montserrat',
                              shadows: textShadow),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(flex: 1),
              if (footnote != null)
                Text(
                  footnote!,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: ColorStyles.textWhite,
                      fontFamily: 'Montserrat',
                      shadows: textShadow),
                  /*
                  style: TextStyle(
                      color: ColorStyles.appTextColor,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                      shadows: textShadow),*/
                ),
            ],
          ),
        ),
      ],
    );
  }
}
