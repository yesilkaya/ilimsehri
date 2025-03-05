import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant/color_styles.dart';
import '../constant/list_type.dart';
import '../constant/route_constants.dart';
import '../providers/font_size_provider.dart'; // Font size provider
import '../view/models/sahifeyi_seccadiye.dart';
import 'platform_helper.dart';
import 'url_launcher_helper.dart';
import 'whatsAppHelper.dart';

class ListHelper {
  final List<dynamic> list;
  String listType;
  String title;

  ListHelper({required this.list, required this.listType, required this.title});

  // GlobalKey'ler ve item yüksekliklerini saklayacak olan listeler
  final Map<int, GlobalKey> itemKeys = {}; // Her öğe için GlobalKey
  final List<double> itemHeights = []; // Öğelerin yüksekliklerini saklayacak liste

  Widget getList() {
    String arapca = "";
    String turkce = "";

    if (listType == ListType.sahife) {
      for (var dua in list) {
        arapca += " " + dua.arapca;
        turkce += " " + dua.turkce;
      }
      list.clear();
      list.add(SahifeiSeccadiye(0, 0, turkce, arapca));
    }

    return Consumer(builder: (context, ref, _) {
      final fontSize = ref.watch(fontSizeProvider);

      return Container(
        color: ColorStyles.sepya,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: list.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            String? turkce = listType == ListType.sure ? list[index].meal as String : list[index].turkce as String;

            itemKeys[index] = GlobalKey();

            return InkWell(
              onTap: () {
                String arapca = listType == ListType.sure ? list[index].ayet_arapca ?? '' : list[index].arapca ?? '';
                String turkceText = (listType != ListType.sure) ? turkce : '';
                String meal = (!(listType == ListType.sahife || listType == ListType.munacat)) ? list[index].meal : '';
                String fullText = '$turkceText\n\n$arapca\n\n$meal\n\n$title-${index + 1}';

                _showShareDialog(context, fullText, '$title - ${index + 1}');
              },
              child: Stack(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20, left: 30, bottom: 25, top: 10),
                        child: Column(
                          children: [
                            Text(
                              listType == ListType.sure
                                  ? list[index].ayet_arapca.replaceAll('<br>', ' \n') ?? ''
                                  : list[index].arapca.replaceAll('<br>', ' \n') ?? '',
                              textAlign: TextAlign.justify,
                              textDirection: TextDirection.rtl,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(color: ColorStyles.kahveRengi, height: 1.6, fontSize: fontSize + 10),
                            ),
                            if (listType != ListType.sure) _getDivider(list[index].turkce),
                            if (listType != ListType.sure)
                              Align(
                                alignment: Alignment.centerLeft,
                                child: SelectableText(
                                  turkce.replaceAll('<br>', ' \n'),
                                  style: GoogleFonts.lora(
                                    textStyle: TextStyle(fontSize: fontSize, color: Colors.black),
                                  ),
                                ),
                              ),
                            if (!(listType == ListType.sahife || listType == ListType.munacat))
                              _getDivider(list[index].meal),
                            if (!(listType == ListType.sahife || listType == ListType.munacat))
                              SelectableText(
                                list[index].meal ?? '',
                                style: GoogleFonts.lora(
                                  textStyle: TextStyle(fontSize: fontSize, color: Colors.black),
                                ),
                                textAlign: TextAlign.justify,
                              ),
                          ],
                        ),
                      ),
                      if (list.length > 1) _getPageDivider(context, index),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }

  void _showShareDialog(BuildContext context, String text, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Text(
            'WhatsApp ile Paylaş',
            style: GoogleFonts.lora(
              textStyle: const TextStyle(
                fontSize: 18,
                color: ColorStyles.kahveRengi,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
          content: Text(
            "Paylaşmak ister misiniz? \n\n$title",
            textAlign: TextAlign.center,
            style: GoogleFonts.lora(
              textStyle: const TextStyle(fontSize: 16, color: ColorStyles.kahveRengi),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('İptal',
                  style: TextStyle(
                    color: ColorStyles.kahveRengi,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            TextButton(
              onPressed: () async {
                if (await WhatsAppHelper.isWhatsAppInstalled(Routes.whatsappUrlWithoutNumber(text))) {
                  await launchUrl(Uri.parse(Routes.whatsappUrlWithoutNumber(text)));
                } else {
                  UrlLauncherHelper.openUrl(
                      PlatformHelper.isIos ? Routes.appStoreWhatsappUrl : Routes.playStoreWhatsappUrl);
                }
                if (context.mounted) Navigator.of(context).pop();
              },
              child: const Text('Paylaş',
                  style: TextStyle(
                    color: ColorStyles.kahveRengi,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ],
        );
      },
    );
  }

  Widget _getPageDivider(BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 2 - 12,
          child: const Divider(thickness: 1.5, color: ColorStyles.kahveRengi),
        ),
        CircleAvatar(
            radius: 8,
            backgroundColor: ColorStyles.kahveRengi,
            child: Text(
              (index + 1).toString(),
              style: TextStyle(color: Colors.grey.shade200, fontSize: index > 98 ? 8 : 10),
            )),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2 - 12,
          child: const Divider(thickness: 1.5, color: ColorStyles.kahveRengi),
        ),
      ],
    );
  }

  StatelessWidget _getDivider(String? text) {
    return text != null && text.isNotEmpty && text != ' '
        ? const Divider(color: ColorStyles.kahveRengi, height: 30, thickness: 0.2)
        : Container();
  }
}
