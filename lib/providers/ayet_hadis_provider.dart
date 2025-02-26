import 'dart:convert';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../view/models/carousel_slider_model/centences_of_days.dart';
import '../widgets/Banner/banner_m_style_1.dart';

final ayethadisProvider = StateNotifierProvider.autoDispose<AyetHadisNotifier, AyetHadis>((ref) => AyetHadisNotifier());

class AyetHadisNotifier extends StateNotifier<AyetHadis> {
  AyetHadisNotifier() : super(AyetHadis.defaultAyetHaids);

  set _setAyetler(List<String> value) => state = state.copyWith(ayetler: value);
  set _setHadisler(List<String> value) => state = state.copyWith(hadisler: value);
  set _setBanners(List<BannerMStyle1> value) => state = state.copyWith(banners: value);
  set _setIsPageReady(bool value) => state = state.copyWith(isPageReady: value);

  void init() async {
    if (!state.isPageReady) {
      await fetchAyetHadis();
    }
    _setIsPageReady = true;
    print('Ayet ve Hadisler yüklendi mi : ${state.isPageReady}');
  }

  int getBannersLength() {
    return state.banners?.length ?? 0;
  }

  Future<void> fetchAyetHadis() async {
    try {
      final response =
          await http.get(Uri.parse('https://hekimane.com/ayet-hadis.json')).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes)); // utf8 ile decode işlemi yapıldı
        List<dynamic> citiesData = data['data'];

        List<String> ayetler = [];
        List<String> ayetFootnotes = [];
        List<String> hadisler = [];
        List<String> hadisFootnotes = [];

        for (var city in citiesData) {
          // Ayet ve footnote ayrıştırma
          List<String> ayetParts = city['ayet'].toString().split(r'\n');
          ayetler.add(ayetParts[0]);
          ayetFootnotes.add(ayetParts.length > 1 ? ayetParts[1] : '');

          // Hadis ve footnote ayrıştırma
          List<String> hadisParts = city['hadis'].toString().split(r'\n');
          hadisler.add(hadisParts[0]);
          hadisFootnotes.add(hadisParts.length > 1 ? hadisParts[1] : '');
        }

        List<BannerMStyle1> banners = [];
        int? random = Random().nextInt(ayetler.length);

        banners.add(
          BannerMStyle1(
            title: "Günün Ayeti",
            text: ayetler[random],
            press: () {},
            footnote: ayetFootnotes[random], // Footnote burada kullanılıyor
            imageUrl: "https://i.imgur.com/WiZRAZC.jpeg",
          ),
        );
        banners.add(
          BannerMStyle1(
            title: "Günün Hadisi",
            text: hadisler[random],
            press: () {},
            footnote: hadisFootnotes[random], // Footnote burada kullanılıyor
            imageUrl: "https://i.imgur.com/WiZRAZC.jpeg",
          ),
        );

        /*
      banners.add(
        BannerMStyle1(
          title: "Günün Sözü",
          text: 'Söz ' + hadisler[random],
          press: () {},
          footnote: "Sehit Dr. Mustafa Çamran",
          imageUrl: "https://i.imgur.com/WiZRAZC.jpeg",
        ),
      );*/

        _setAyetler = ayetler;
        _setHadisler = hadisler;
        _setBanners = banners;
      }
    } catch (e) {
      print('Hata oluştu : $e');
    }
  }
}
