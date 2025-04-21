import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ilimsehri/constant/color_styles.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constant/route_constants.dart';
import '../../../helper/platform_helper.dart';
import '../../../helper/url_launcher_helper.dart';
import '../../../helper/whatsAppHelper.dart';

class OurSupportersScreen extends StatelessWidget {
  final List<String> destekciler = [
    'Ayşe Yıldız',
    'Mehmet Kara',
    'Zeynep Güneş',
    'Ali Demir',
    'Elif Toprak',
    'Hasan Taş',
    'Fatma Nur',
  ];
  final String iban = "TR12 3456 7890 1234 5678 9012 34";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorStyles.appBackGroundColor,
        titleTextStyle: const TextStyle(color: ColorStyles.appTextColor),
        title: Text(
          'Katkı Sunanlar',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: ColorStyles.appTextColor, fontSize: 16),
        ),
        leading: const BackButton(color: ColorStyles.appTextColor),
      ),
      backgroundColor: ColorStyles.appBackGroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: destekciler.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 4,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 18,
                          backgroundColor: ColorStyles.appTextColor,
                          child: Icon(Icons.woman, color: ColorStyles.appBackGroundColor),
                        ),
                        const SizedBox(width: 12),
                        Flexible(
                          child: Text(
                            destekciler[index],
                            style: const TextStyle(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      iban,
                      style: const TextStyle(
                        color: ColorStyles.appTextColor,
                        fontSize: 14,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy, color: ColorStyles.appTextColor),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: iban));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: ColorStyles.appBackGroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // Köşeleri yumuşat
                        ),
                        content: const Center(
                          child: Text(
                            "İban kopyalandı",
                            style: TextStyle(color: ColorStyles.appTextColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ));
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorStyles.appTextColor,
                textStyle: const TextStyle(color: ColorStyles.appBackGroundColor),
              ),
              onPressed: () => _whatsAppOnTap(),
              child: const Text(
                'Destek Ol',
                style: TextStyle(color: ColorStyles.appBackGroundColor, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<void> _whatsAppOnTap() async {
    String contact = '+905523465337';
    String url = Routes.whatsappUrl(contact);

    if (await WhatsAppHelper.isWhatsAppInstalled(url)) {
      await launchUrl(Uri.parse(Routes.whatsappHelpUrlSupportUs(contact)));
    } else {
      UrlLauncherHelper.openUrl(PlatformHelper.isIos ? Routes.appStoreWhatsappUrl : Routes.playStoreWhatsappUrl);
    }
  }
}
