import '../../../widgets/Banner/banner_m_style_1.dart';

class AyetHadis {
  List<String>? ayetler;
  List<String>? hadisler;
  List<BannerMStyle1>? banners;
  final bool isPageReady;

  AyetHadis({
    this.ayetler,
    this.hadisler,
    this.banners,
    required this.isPageReady,
  });

  AyetHadis copyWith({
    List<String>? ayetler,
    List<String>? hadisler,
    List<BannerMStyle1>? banners,
    bool? isPageReady,
  }) {
    return AyetHadis(
      ayetler: ayetler ?? this.ayetler,
      hadisler: hadisler ?? this.hadisler,
      banners: banners ?? this.banners,
      isPageReady: isPageReady ?? this.isPageReady,
    );
  }

  factory AyetHadis.fromJson(Map<String, dynamic> json) {
    return AyetHadis(
      ayetler: json['ayetler'],
      hadisler: json['hadisler'],
      isPageReady: false,
    );
  }

  static AyetHadis defaultAyetHaids = AyetHadis(
    ayetler: [],
    hadisler: [],
    banners: [],
    isPageReady: false,
  );
}
