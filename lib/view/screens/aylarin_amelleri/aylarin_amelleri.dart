import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:html/parser.dart' as html_parser; // html paketini import ediyoruz
import 'package:http/http.dart' as http;
import 'package:ilimsehri/view/screens/aylarin_amelleri/aylarin_amelleri_detail_page.dart';
import 'package:xml/xml.dart' as xml;

import '../../../constant/color_styles.dart';

class AylarinAmelleri extends StatefulWidget {
  const AylarinAmelleri({super.key});

  @override
  AylarinAmelleriState createState() => AylarinAmelleriState();
}

class AylarinAmelleriState extends State<AylarinAmelleri> {
  List<AylarinAmelleriJsonModel> aylarinAmelleri = [];

  @override
  void initState() {
    super.initState();
    // _fetchAylarinAmelleri();
    _fetchBooks();
  }

  Future<void> _fetchAylarinAmelleri() async {
    const url = 'https://hekimane.com/jsons/aylarin_amelleri.json';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // JSON verisini düzgün bir şekilde çözümle
        String decodedBody = utf8.decode(response.bodyBytes); // Bozulmuş karakterleri düzeltmek için
        print("Gelen JSON Verisi: $decodedBody");

        // JSON verisini çözümle
        Map<String, dynamic> jsonData = jsonDecode(decodedBody);

        // 'items' anahtarını al
        List<dynamic> items = jsonData['rss']['items'] ?? [];

        print("Verilen items: $items");

        List<AylarinAmelleriJsonModel> bookList = [];

        // 'items' listesini işleyerek her bir öğe için model oluştur
        for (var item in items) {
          final title = item['title'] ?? 'Başlık bulunamadı';
          final description = item['description'] ?? 'Açıklama bulunamadı';
          final content = item['content'] ?? 'İçerik bulunamadı';
          final imageUrl = item['imageUrl'];

          bookList.add(AylarinAmelleriJsonModel(
            title: title,
            description: description,
            content: content,
            imageUrl: imageUrl,
          ));
        }

        // State güncellemesi yap
        setState(() {
          aylarinAmelleri = bookList;
        });

        print("Veriler başarıyla yüklendi: ${aylarinAmelleri.length} öğe.");
      } else {
        throw Exception('JSON verisi alınamadı: ${response.statusCode}');
      }
    } catch (e) {
      print('Hata: $e');
      setState(() {
        aylarinAmelleri = [];
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veri yüklenemedi, lütfen tekrar deneyin!")),
      );
    }
  }

  Future<void> _fetchBooks() async {
    const url = 'https://www.caferilik.com/dualar/aylarin-ozel-amelleri/feed';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final document = xml.XmlDocument.parse(response.body);

        final items = document.findAllElements('item');
        List<AylarinAmelleriJsonModel> tempList = [];

        for (var item in items) {
          final title = item.findElements('title').single.innerText;
          final description = item.findElements('description').single.innerText;
          final content = item.findElements('content:encoded').single.innerText;
          final imageUrl = item.findElements('image').isNotEmpty ? item.findElements('image').single.innerText : null;

          final decodedDescription = _decodeHtml(description);
          final decodedContent = _decodeHtml(content);

          tempList.add(AylarinAmelleriJsonModel(
            title: title,
            description: decodedDescription,
            content: decodedContent,
            imageUrl: imageUrl,
          ));
        }
        tempList.removeAt(1);

        setState(() {
          aylarinAmelleri = tempList;
        });
      } else {
        throw Exception('XML verisi alınamadı.');
      }
    } catch (e) {
      print('Hata: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.appBackGroundColor,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              "Ayların Amelleri",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            centerTitle: true,
            pinned: true,
            backgroundColor: ColorStyles.appBackGroundColor,
            leading: const BackButton(
              color: ColorStyles.appTextColor,
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(top: 30)),
          SliverAppBar(
            backgroundColor: ColorStyles.appBackGroundColor,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                color: ColorStyles.appBackGroundColor,
                image: DecorationImage(
                  alignment: Alignment.center,
                  image: AssetImage("assets/img/bismillah.jpg"),
                ),
              ),
            ),
            leading: Container(),
          ),
          SliverList(
              delegate: SliverChildListDelegate(
            _buildListView(),
          )),
        ],
      ),
    );
  }

  _buildListView() {
    return <Widget>[
      aylarinAmelleri.isEmpty
          ? const Padding(
              padding: EdgeInsets.only(top: 150),
              child: Center(
                child: CircularProgressIndicator(
                  color: ColorStyles.appTextColor,
                ),
              ),
            )
          : Container(
              margin: const EdgeInsets.all(10),
              color: ColorStyles.color,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: aylarinAmelleri.length,
                itemBuilder: (context, index) {
                  final book = aylarinAmelleri[index];

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AylarinAmelleriDetailPage(ayinAmelleri: book),
                        ),
                      );
                    },
                    child: Card(
                      color: ColorStyles.cardColor,
                      elevation: 2,
                      margin: const EdgeInsets.all(10),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        side: BorderSide(
                          color: ColorStyles.appTextColor, // Burada border rengini seçebilirsiniz
                          width: 0.5, // Border kalınlığını belirleyebilirsiniz
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          book.title,
                          style: const TextStyle(color: ColorStyles.color2),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    ];
  }

  // HTML entity'lerini çözümleyen fonksiyon
  String _decodeHtml(String htmlString) {
    final document = html_parser.parse(htmlString);
    return document.body?.text ?? htmlString; // HTML özel karakterlerini düz metne çevirir
  }
}

class AylarinAmelleriJsonModel {
  final String title;
  final String description;
  final String content;
  final String? imageUrl;

  AylarinAmelleriJsonModel({
    required this.title,
    required this.description,
    required this.content,
    this.imageUrl,
  });

  /// JSON'dan Model'e dönüşüm
  factory AylarinAmelleriJsonModel.fromJson(Map<String, dynamic> json) {
    return AylarinAmelleriJsonModel(
      title: json['title'] as String,
      description: json['description'] as String,
      content: json['content'] as String,
      imageUrl: json['imageUrl'] as String?,
    );
  }
}
