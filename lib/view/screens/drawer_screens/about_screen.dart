import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ilimsehri/constant/color_styles.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorStyles.appBackGroundColor,
        titleTextStyle: const TextStyle(color: ColorStyles.appTextColor),
        leading: const BackButton(color: ColorStyles.appTextColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 80,
              backgroundImage: AssetImage('assets/img/hekimane.png'), // Logo ekleyin
            ),
            const SizedBox(height: 16),
            Text(
              'Biz Kimiz?',
              style: GoogleFonts.lora(fontSize: 22, fontWeight: FontWeight.bold, color: ColorStyles.appTextColor),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Genelde toplumun tüm kesimlerinin, özelde çocuk ve gençlerin İslami ve ahlaki konularla ilgili ihtiyaç duyabileceği kitap, mobil uygulama ve video yayınları gibi sosyal ve kültürel içeriklerin üretilmesi için gönüllülük esasınca, hiçbir grup ve fraksiyona bağlı olmadan çalışmalar yürüten gençlerin bir araya geldiği çatı oluşumdur.",
                textAlign: TextAlign.center,
                style: TextStyle(color: ColorStyles.appTextColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
