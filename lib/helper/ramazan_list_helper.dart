import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:url_launcher/url_launcher.dart';

import '../constant/color_styles.dart';
import '../constant/route_constants.dart';
import '../providers/font_size_provider.dart'; // Font size provider
import 'platform_helper.dart';
import 'url_launcher_helper.dart';
import 'whatsAppHelper.dart';

class RamazanListHelper {
  final List<dynamic> list;
  String title;

  RamazanListHelper({required this.list, required this.title});

  // GlobalKey'ler ve item yüksekliklerini saklayacak olan listeler
  final Map<int, GlobalKey> itemKeys = {}; // Her öğe için GlobalKey
  final List<double> itemHeights = []; // Öğelerin yüksekliklerini saklayacak liste
  final ScrollController _scrollController = ScrollController();

  Widget getList(int listIndex) {
    return Consumer(builder: (context, ref, _) {
      final fontSize = ref.watch(fontSizeProvider);
      String arapca = "";
      String turkce = "";
      String meal = "";

      return Container(
        color: ColorStyles.sepya,
        child: ListView.builder(
          controller: _scrollController, // ScrollController'ı burada bağlıyoruz
          physics: const NeverScrollableScrollPhysics(),
          itemCount: list.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            itemKeys[index] = GlobalKey();
            arapca = list[index].arapca ?? '';
            turkce = list[index].turkce ?? '';
            meal = list[index].meal ?? '';
            return InkWell(
              onTap: () {
                String fullText =
                    '${list[index].turkce ?? ''}\n\n${list[index].arapca ?? ''}\n\n${list[index].meal ?? ''}\n\n$title-${index + 1}';
                print('fullText: $fullText');
                _showShareDialog(context, fullText, '$title - ${index + 1}');
              },
              child: listIndex == 2
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          Text(
                            turkce,
                            style: GoogleFonts.lora(
                              textStyle: TextStyle(
                                  fontSize: fontSize + 6, color: ColorStyles.kahveRengi, fontWeight: FontWeight.bold),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          HtmlWidget(
                            meal, //cleanHtml(meal),
                            textStyle: TextStyle(
                                color: ColorStyles.kahveRengi,
                                fontSize: fontSize,
                                height: 1.6), // Metin rengini kırmızı yapar
                          ),
                        ],
                      ),
                    )
                  : listIndex == 3 &&
                          (index == 5 ||
                              index == 6 ||
                              index == 7 ||
                              index == 8 ||
                              index == 9 ||
                              index == 10 ||
                              index == 11 ||
                              index == 12 ||
                              index == 13 ||
                              index == 14)
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: HtmlWidget(
                                arapca, //cleanHtml(meal),
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: fontSize,
                                    height: 1.6), // Metin rengini kırmızı yapar
                              ),
                            ),
                            _getDivider(arapca),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: HtmlWidget(
                                meal, //cleanHtml(meal),
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: fontSize,
                                    height: 1.6), // Metin rengini kırmızı yapar
                              ),
                            ),
                            _getDivider(meal),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: HtmlWidget(
                                turkce, //cleanHtml(meal),
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: fontSize,
                                    height: 1.6), // Metin rengini kırmızı yapar
                              ),
                            ),
                            _getPageDivider(context, index)
                          ],
                        )
                      : Stack(
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 20, left: 30, bottom: 25, top: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      if (listIndex == 0)
                                        Center(
                                          child: Text('${index + 1}. Günün Duası',
                                              style: GoogleFonts.lora(
                                                  textStyle: const TextStyle(
                                                      color: ColorStyles.kahveRengi,
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold))),
                                        ),
                                      if (listIndex == 1)
                                        Center(
                                          child: Text('${index + 1}. Gecenin Namazı',
                                              style: GoogleFonts.lora(
                                                  textStyle: const TextStyle(
                                                      color: ColorStyles.kahveRengi,
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold))),
                                        ),
                                      const SizedBox(height: 10),
                                      Text(
                                        arapca.replaceAll('<br>', ' \n'),
                                        textAlign: TextAlign.justify,
                                        textDirection: listIndex == 1 ? TextDirection.ltr : TextDirection.rtl,
                                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                            color: ColorStyles.kahveRengi,
                                            height: 1.6,
                                            fontSize: listIndex == 1 ? fontSize : fontSize + 6),
                                      ),
                                      if (turkce.isNotEmpty) _getDivider(list[index].turkce),
                                      if (turkce.isNotEmpty)
                                        SelectableText(
                                          turkce.replaceAll('<br>', ' \n'),
                                          style: GoogleFonts.lora(
                                            textStyle: TextStyle(
                                              fontSize: fontSize,
                                              color: ColorStyles.kahveRengi,
                                            ),
                                          ),
                                          textAlign: TextAlign.justify,
                                        ),
                                      if (meal.isNotEmpty) _getDivider(list[index].meal),
                                      if (meal.isNotEmpty)
                                        SelectableText(
                                          list[index].meal ?? '',
                                          style: GoogleFonts.lora(
                                            textStyle: TextStyle(
                                              fontSize: fontSize,
                                              color: ColorStyles.kahveRengi,
                                            ),
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

  String cleanHtml(String rawHtml) {
    var document = htmlParser.parse(rawHtml);
    return document.body?.text ?? "";
  }

  // Belirli öğeye kaydırma işlemi
  void scrollToIndex(int index) {
    if (itemHeights.length > index) {
      double scrollOffset = itemHeights.sublist(0, index).fold(0, (sum, height) => sum + height);

      _scrollController.animateTo(
        scrollOffset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
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
